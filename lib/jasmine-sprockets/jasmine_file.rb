require "rack"
require "sprockets"
require "sprockets/environment"

module Rack

  class JasmineFile < Rack::File
    def sprocket
      @sprocket ||= ::Sprockets::Environment.new.tap{|s| s.append_path @root}
    end

    def serving
      body = [sprocket[@path].to_s]
      size = Utils.bytesize(body.first)

      [200, {
        "Last-Modified"   => F.mtime(@path).httpdate,
        "Cache-Control"   => "must-revalidate",
        "Content-Type"    => Mime.mime_type(F.extname(@path), 'text/plain'),
        "Content-Length"  => size.to_s
      }, body]
    end

  end
end
