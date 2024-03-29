# Generated on 2014-11-29 using generator-angular-fullstack 2.0.13

"use strict"

module.exports = (grunt) ->
  localConfig = undefined

  try
    localConfig = require("./server/config/local.env")
  catch e
    localConfig = {}

  # Load grunt tasks automatically, when needed
  require("jit-grunt") grunt,
    express: "grunt-express-server"
    useminPrepare: "grunt-usemin"
    ngtemplates: "grunt-angular-templates"
    cdnify: "grunt-google-cdn"
    buildcontrol: "grunt-build-control"
    istanbul_check_coverage: "grunt-mocha-istanbul"


  # Time how long tasks take. Can help when optimizing build times
  require("time-grunt") grunt

  # Define the configuration for all the tasks
  grunt.initConfig

    # Project settings
    pkg: grunt.file.readJSON("package.json")
    yeoman:
      # configurable paths
      client: require("./bower.json").appPath or "client"
      dist: "dist"

    express:
      options:
        port: process.env.PORT or 9000
        opts: ['node_modules/coffee-script/bin/coffee']

      dev:
        options:
          script: "server/app.coffee"
          debug: true

      prod:
        options:
          script: "dist/server/app.coffee"

      cce:
        options:
          script: "tools/cce/app.coffee"

      cosmetic:
        options:
          script: "tools/cosmetic/app.coffee"

      names:
        options:
          script: "tools/names/app.coffee"

    open:
      server:
        url: "http://localhost:<%= express.options.port %>"

    watch:
      injectJS:
        files: [
          "<%= yeoman.client %>/{app,components}/**/*.js"
          "!<%= yeoman.client %>/{app,components}/**/*.spec.js"
          "!<%= yeoman.client %>/{app,components}/**/*.mock.js"
          "!<%= yeoman.client %>/app/app.js"
        ]
        tasks: ["injector:scripts"]

      injectCss:
        files: ["<%= yeoman.client %>/{app,components}/**/*.css"]
        tasks: ["injector:css"]

      mochaTest:
        files: ["server/**/*.spec.coffee"]
        tasks: [
          "env:test"
          "mochaTest"
        ]

      jsTest:
        files: [
          "<%= yeoman.client %>/{app,components}/**/*.spec.js"
          "<%= yeoman.client %>/{app,components}/**/*.mock.js"
        ]
        tasks: [
          "newer:jshint:all"
          "karma"
        ]

      injectStylus:
        files: ["<%= yeoman.client %>/{app,components}/**/*.styl"]
        tasks: ["injector:stylus"]

      stylus:
        files: ["<%= yeoman.client %>/{app,components}/**/*.styl"]
        tasks: [
          "stylus"
          "autoprefixer"
        ]

      jade:
        files: [
          "<%= yeoman.client %>/{app,components}/*"
          "<%= yeoman.client %>/{app,components}/**/*.jade"
        ]
        tasks: ["jade"]

      coffee:
        files: [
          "<%= yeoman.client %>/{app,components}/**/*.{coffee,litcoffee,coffee.md}"
          "!<%= yeoman.client %>/{app,components}/**/*.spec.{coffee,litcoffee,coffee.md}"
        ]
        tasks: [
          "newer:coffee"
          "injector:scripts"
        ]

      coffeeTest:
        files: ["<%= yeoman.client %>/{app,components}/**/*.spec.{coffee,litcoffee,coffee.md}"]
        tasks: ["karma"]

      gruntfile:
        files: ["Gruntfile.coffee"]

      livereload:
        files: [
          "{.tmp,<%= yeoman.client %>}/{app,components}/**/*.css"
          "{.tmp,<%= yeoman.client %>}/{app,components}/**/*.html"
          "{.tmp,<%= yeoman.client %>}/{app,components}/**/*.js"
          "!{.tmp,<%= yeoman.client %>}{app,components}/**/*.spec.js"
          "!{.tmp,<%= yeoman.client %>}/{app,components}/**/*.mock.js"
          "<%= yeoman.client %>/assets/images/{,*//*}*.{png,jpg,jpeg,gif,webp,svg}"
        ]
        options:
          livereload: true

      express:
        files: ["server/**/*.{js,json,coffee}"]
        tasks: [
          "express:dev"
          "wait"
        ]
        options:
          livereload: true
          nospawn: true #Without this option specified express won't be reloaded


    # Make sure code styles are up to par and there are no obvious mistakes
    jshint:
      options:
        jshintrc: "<%= yeoman.client %>/.jshintrc"
        reporter: require("jshint-stylish")

      server:
        options:
          jshintrc: "server/.jshintrc"

        src: [
          "server/**/*.js"
          "!server/**/*.{spec,integration}.js"
        ]

      serverTest:
        options:
          jshintrc: "server/.jshintrc-spec"

        src: ["server/**/*.{spec,integration}.coffee"]

      all: [
        "<%= yeoman.client %>/{app,components}/**/*.js"
        "!<%= yeoman.client %>/{app,components}/**/*.spec.js"
        "!<%= yeoman.client %>/{app,components}/**/*.mock.js"
      ]
      test:
        src: [
          "<%= yeoman.client %>/{app,components}/**/*.spec.js"
          "<%= yeoman.client %>/{app,components}/**/*.mock.js"
        ]


    jscs:
      options:
        config: ".jscs.json"
      main:
        files:
          src: [
            '<%= yeoman.client %>/app/**/*.coffee'
            '<%= yeoman.client %>/app/**/*.coffee'
            'server/**/*.coffee'
          ]


    # Empties folders to start fresh
    clean:
      dist:
        files: [
          dot: true
          src: [
            ".tmp"
            "<%= yeoman.dist %>/*"
            "!<%= yeoman.dist %>/.git*"
            "!<%= yeoman.dist %>/.openshift"
            "!<%= yeoman.dist %>/Procfile"
          ]
        ]

      server: ".tmp"


    # Add vendor prefixed styles
    autoprefixer:
      options:
        browsers: ["last 1 version"]

      dist:
        files: [
          expand: true
          cwd: ".tmp/"
          src: "{,*/}*.css"
          dest: ".tmp/"
        ]


    # Debugging with node inspector
    "node-inspector":
      custom:
        options:
          "web-host": "localhost"


    # Use nodemon to run server in debug mode with an initial breakpoint
    nodemon:
      debug:
        script: "server/app.js"
        options:
          nodeArgs: ["--debug-brk"]
          env:
            PORT: process.env.PORT or 9000

          callback: (nodemon) ->
            nodemon.on "log", (event) ->
              console.log event.colour
              return


            # opens browser on initial server start
            nodemon.on "config:update", ->
              setTimeout (->
                require("open") "http://localhost:8080/debug?port=5858"
                return
              ), 500
              return

            return


    # Automatically inject Bower components into the app
    wiredep:
      target:
        src: "<%= yeoman.client %>/index.html"
        ignorePath: "<%= yeoman.client %>/"
        exclude: [
          /bootstrap-sass-official/
          /bootstrap.js/
          "/json3/"
          "/es5-shim/"
          /bootstrap.css/
          /font-awesome.css/
        ]


    # Renames files for browser caching purposes
    rev:
      dist:
        files:
          src: [
            "<%= yeoman.dist %>/public/{,*/}*.js"
            "<%= yeoman.dist %>/public/{,*/}*.css"
            "<%= yeoman.dist %>/public/assets/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
            "<%= yeoman.dist %>/public/assets/fonts/*"
          ]


    # Reads HTML for usemin blocks to enable smart builds that automatically
    # concat, minify and revision files. Creates configurations in memory so
    # additional tasks can operate on them
    useminPrepare:
      html: ["<%= yeoman.client %>/index.html"]
      options:
        dest: "<%= yeoman.dist %>/public"


    # Performs rewrites based on rev and the useminPrepare configuration
    usemin:
      html: ["<%= yeoman.dist %>/public/{,*/}*.html"]
      css: ["<%= yeoman.dist %>/public/{,*/}*.css"]
      js: ["<%= yeoman.dist %>/public/{,*/}*.js"]
      options:
        assetsDirs: [
          "<%= yeoman.dist %>/public"
          "<%= yeoman.dist %>/public/assets/images"
        ]

        # This is so we update image references in our ng-templates
        patterns:
          js: [[
            /(assets\/images\/.*?\.(?:gif|jpeg|jpg|png|webp|svg))/g
            "Update the JS to reference our revved images"
          ]]


    # The following *-min tasks produce minified files in the dist folder
    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.client %>/assets/images"
          src: "{,*/}*.{png,jpg,jpeg,gif}"
          dest: "<%= yeoman.dist %>/public/assets/images"
        ]

    svgmin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.client %>/assets/images"
          src: "{,*/}*.svg"
          dest: "<%= yeoman.dist %>/public/assets/images"
        ]


    # Allow the use of non-minsafe AngularJS files. Automatically makes it
    # minsafe compatible so Uglify does not destroy the ng references
    ngAnnotate:
      dist:
        files: [
          expand: true
          cwd: ".tmp/concat"
          src: "*/**.js"
          dest: ".tmp/concat"
        ]


    # Package all the html partials into a single javascript payload
    ngtemplates:
      options:

        # This should be the name of your apps angular module
        module: "mirionlineApp"
        htmlmin:
          collapseBooleanAttributes: true
          collapseWhitespace: true
          removeAttributeQuotes: true
          removeEmptyAttributes: true
          removeRedundantAttributes: true
          removeScriptTypeAttributes: true
          removeStyleLinkTypeAttributes: true

        usemin: "app/app.js"

      main:
        cwd: "<%= yeoman.client %>"
        src: ["{app,components}/**/*.html"]
        dest: ".tmp/templates.js"

      tmp:
        cwd: ".tmp"
        src: ["{app,components}/**/*.html"]
        dest: ".tmp/tmp-templates.js"


    # Replace Google CDN references
    cdnify:
      dist:
        html: ["<%= yeoman.dist %>/public/*.html"]


    # Copies remaining files to places other tasks can use
    copy:
      dist:
        files: [
          {
            expand: true
            dot: true
            cwd: "<%= yeoman.client %>"
            dest: "<%= yeoman.dist %>/public"
            src: [
              "*.{ico,png,txt}"
              ".htaccess"
              "bower_components/**/*"
              "assets/images/{,*/}*.{webp}"
              "assets/fonts/**/*"
              "index.html"
            ]
          }
          {
            expand: true
            cwd: ".tmp/images"
            dest: "<%= yeoman.dist %>/public/assets/images"
            src: ["generated/*"]
          }
          {
            expand: true
            dest: "<%= yeoman.dist %>"
            src: [
              "package.json"
              "server/**/*"
            ]
          }
        ]

      styles:
        expand: true
        cwd: "<%= yeoman.client %>"
        dest: ".tmp/"
        src: ["{app,components}/**/*.css"]

    buildcontrol:
      options:
        dir: "dist"
        commit: true
        push: true
        connectCommits: false
        message: "Built %sourceName% from commit %sourceCommit% on branch %sourceBranch%"

      heroku:
        options:
          remote: "heroku"
          branch: "master"

      openshift:
        options:
          remote: "openshift"
          branch: "master"


    # Run some tasks in parallel to speed up the build process
    concurrent:
      server: [
        "coffee"
        "jade"
        "stylus"
      ]
      test: [
        "coffee"
        "jade"
        "stylus"
      ]
      debug:
        tasks: [
          "nodemon"
          "node-inspector"
        ]
        options:
          logConcurrentOutput: true

      dist: [
        "coffee"
        "jade"
        "stylus"
        "imagemin"
        "svgmin"
      ]


    # Test settings
    karma:
      unit:
        configFile: "karma.conf.js"
        singleRun: true

    mochaTest:
      options:
        reporter: "spec"
        require: ["mocha.conf.js"]
      unit:
        src: ["server/**/*.spec.coffee"]
      integration:
        src: ["server/**/*.integration.coffee"]

    mocha_istanbul:
      unit:
        options:
          excludes: [
            "**/*.spec.coffee"
            "**/*.mock.coffee"
            "**/*.integration.coffee"
          ]
          reporter: "spec"
          require: ["mocha.conf.js"]
          mask: "**/*.spec.coffee"
          coverageFolder: "coverage/server/unit"
        src: "server"
      integration:
        options:
          excludes: [
            "**/*.spec.coffee"
            "**/*.mock.coffee"
            "**/*.integration.coffee"
          ]
          reporter: "spec"
          require: ["mocha.conf.js"]
          mask: "**/*.integration.coffee"
          coverageFolder: "coverage/server/integration"
        src: "server"

    istanbul_check_coverage:
      default:
        options:
          coverageFolder: "coverage/**"
          check:
            lines: 80
            statements: 80
            branches: 80
            functions: 80

    env:
      test:
        NODE_ENV: "test"

      prod:
        NODE_ENV: "production"

      all: localConfig


    # Compiles Jade to html
    jade:
      compile:
        options:
          data:
            debug: false

        files: [
          expand: true
          cwd: "<%= yeoman.client %>"
          src: ["{app,components}/**/*.jade"]
          dest: ".tmp"
          ext: ".html"
        ]


    # Compiles CoffeeScript to JavaScript
    coffee:
      options:
        sourceMap: true
        sourceRoot: ""

      server:
        files: [
          expand: true
          cwd: "client"
          src: [
            "{app,components}/**/*.coffee"
            "!{app,components}/**/*.spec.coffee"
          ]
          dest: ".tmp"
          ext: ".js"
        ]


    # Compiles Stylus to CSS
    stylus:
      server:
        options:
          paths: [
            "<%= yeoman.client %>/bower_components"
            "<%= yeoman.client %>/app"
            "<%= yeoman.client %>/components"
          ]
          "include css": true

        files:
          ".tmp/app/app.css": "<%= yeoman.client %>/app/app.styl"

    injector:
      options: {}

      # Inject application script files into index.html (doesn't include bower)
      scripts:
        options:
          transform: (filePath) ->
            filePath = filePath.replace("/client/", "")
            filePath = filePath.replace("/.tmp/", "")
            "<script src=\"" + filePath + "\"></script>"

          starttag: "<!-- injector:js -->"
          endtag: "<!-- endinjector -->"

        files:
          "<%= yeoman.client %>/index.html": [[
            "{.tmp,<%= yeoman.client %>}/{app,components}/**/*.js"
            "!{.tmp,<%= yeoman.client %>}/app/app.js"
            "!{.tmp,<%= yeoman.client %>}/{app,components}/**/*.spec.js"
            "!{.tmp,<%= yeoman.client %>}/{app,components}/**/*.mock.js"
          ]]


      # Inject component styl into app.styl
      stylus:
        options:
          transform: (filePath) ->
            filePath = filePath.replace("/client/app/", "")
            filePath = filePath.replace("/client/components/", "")
            "@import '" + filePath + "';"

          starttag: "// injector"
          endtag: "// endinjector"

        files:
          "<%= yeoman.client %>/app/app.styl": [
            "<%= yeoman.client %>/{app,components}/**/*.styl"
            "!<%= yeoman.client %>/app/app.styl"
          ]


      # Inject component css into index.html
      css:
        options:
          transform: (filePath) ->
            filePath = filePath.replace("/client/", "")
            filePath = filePath.replace("/.tmp/", "")
            "<link rel=\"stylesheet\" href=\"" + filePath + "\">"

          starttag: "<!-- injector:css -->"
          endtag: "<!-- endinjector -->"

        files:
          "<%= yeoman.client %>/index.html": ["<%= yeoman.client %>/{app,components}/**/*.css"]


  # Used for delaying livereload until after server has restarted
  grunt.registerTask "wait", ->
    grunt.log.ok "Waiting for server reload..."
    done = @async()
    setTimeout (->
      grunt.log.writeln "Done waiting!"
      done()
    ), 1500

  grunt.registerTask "express-keepalive", "Keep grunt running", ->
    @async()

  grunt.registerTask "serve", (target) ->
    if target is "dist"
      return grunt.task.run([
        "build"
        "env:all"
        "env:prod"
        "express:prod"
        "wait"
        "open"
        "express-keepalive"
      ])

    if target is "debug"
      return grunt.task.run([
        "clean:server"
        "env:all"
        "injector:stylus"
        "concurrent:server"
        "injector"
        "wiredep"
        "autoprefixer"
        "concurrent:debug"
      ])

    grunt.task.run [
      "clean:server"
      "env:all"
      "injector:stylus"
      "concurrent:server"
      "injector"
      "wiredep"
      "autoprefixer"
      "express:dev"
      "wait"
      "open"
      "watch"
    ]

  grunt.registerTask "server", ->
    grunt.log.warn "The `server` task has been deprecated. Use `grunt serve` to start a server."
    grunt.task.run ["serve"]

  grunt.registerTask "test", (target, option) ->
    if target is "server"
      grunt.task.run [
        "env:all"
        "env:test"
        "mochaTest:unit"
        "mochaTest:integration"
      ]

    else if target is "client"
      grunt.task.run [
        "clean:server"
        "env:all"
        "injector:stylus"
        "concurrent:test"
        "injector"
        "autoprefixer"
        "karma"
      ]

    else if target is "coverage"
      if option is "unit"
        grunt.task.run [
          "env:all"
          "env:test"
          "mocha_istanbul:unit"
        ]

      else if option is "integration"
        grunt.task.run [
          "env:all"
          "env:test"
          "mocha_istanbul:integration"
        ]

      else if option is "check"
        grunt.task.run ["istanbul_check_coverage"]

      else
        grunt.task.run [
          "env:all"
          "env:test"
          "mocha_istanbul"
          "istanbul_check_coverage"
        ]

    else
      grunt.task.run [
        "test:server"
        "test:client"
      ]

  grunt.registerTask "build", [
    "clean:dist"
    "injector:stylus"
    "concurrent:dist"
    "injector"
    "wiredep"
    "useminPrepare"
    "autoprefixer"
    "ngtemplates"
    "concat"
    "ngAnnotate"
    "copy:dist"
    "cdnify"
    "cssmin"
    "uglify"
    "rev"
    "usemin"
  ]

  grunt.registerTask "default", [
    "newer:jshint"
    "test"
    "build"
  ]

  grunt.registerTask "tools", (target) ->
    if target in ["cce", "cc", "character-creation-editor"]
      grunt.task.run [
        "express:cce"
        "wait"
        "open"
        "express-keepalive"
      ]
    else if target in ["cosmetic", "aesthetic", "appearance"]
      grunt.task.run [
        "express:cosmetic"
        "wait"
        "open"
        "express-keepalive"
      ]
    else if target in ["name", "names", "name-editor", "ne"]
      grunt.task.run [
        "express:names"
        "wait"
        "open"
        "express-keepalive"
      ]
    else
      return

