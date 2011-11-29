require "rack"
require "sprockets"
require "sprockets/environment"

module Rack

  class JasmineFile < Rack::File
    @@cache = {}
    def sprocket
      @sprocket ||= ::Sprockets::Environment.new.tap{|s| s.append_path @root}
    end

    def serving
      unless @@cache[@path] && @@cache[@path][0] >= F.mtime(@path)
        @@cache[@path] = [F.mtime(@path), sprocket[@path]]
      end
      base  = @@cache[@path][1]
      ctype = base.content_type

      body = [base.to_s]
      size = Utils.bytesize(body.first)

      [200, {
        "Last-Modified"   => F.mtime(@path).httpdate,
        "Cache-Control"   => "must-revalidate",
        "Content-Type"    => ctype || Mime.mime_type(F.extname(@path), 'text/plain'),
        "Content-Length"  => size.to_s
      }, body]
    end

  end
end
