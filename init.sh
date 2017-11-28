## Init GIT
echo "Init GIT ..."
git init

## Init gitignore

## Create Folders
echo "Create Folders ..."
mkdir assets
mkdir assets/icons
mkdir assets/images
mkdir assets/scripts
mkdir assets/styles

mkdir src
mkdir src/icons
mkdir src/images
mkdir src/scripts
mkdir src/styles

mkdir src/styles/base
mkdir src/styles/general

mkdir templates

## Create Files
echo "Create Files ..."

echo '
* 
	margin: 0;
	padding: 0;
' > src/styles/base/_base.sass

touch src/styles/main.sass

echo '@import "base/_base.sass"' > src/styles/main.sass

touch src/scripts/main.js

# Create gulpfile.js
touch gulpfile.js

echo "
'use strict';

const gulp        = require('gulp')
	, sass        = require('gulp-sass')
	, image       = require('gulp-image')
	, uglify      = require('gulp-uglify')
	, notify      = require('gulp-notify')
	, browserify  = require('browserify')
	, babelify    = require('babelify')
	, source      = require('vinyl-source-stream')
	, buffer      = require('vinyl-buffer')

gulp.task('sass', function(){
	return gulp.src('src/styles/main.sass')
		.pipe(sass({
			outputStyle: 'compressed'
		}).on('error', sass.logError))
		.pipe(gulp.dest('assets/styles/'))
		.pipe(notify({message: 'sass: Styles Compilados!'}));
});

gulp.task('image', function(){
	return gulp.src('src/images/*')
		.pipe(image())
		.pipe(gulp.dest('assets/images/'));
});

gulp.task('icons', function(){
	return gulp.src('src/icons/*')
		.pipe(gulp.dest('assets/icons/'));
});

gulp.task('babel', function () {
    return browserify({ entries: 'src/scripts/main.js', debug: true })
        .transform(\"babelify\", { presets: [\"es2015\"] })
        .bundle()
        .on('error', function (err) {
        	console.log(err.toString());
        	this.emit('end');
        })
        .pipe(source('main.min.js'))
        .pipe(buffer())
        .pipe(uglify())
        .pipe(gulp.dest('assets/scripts/'))
        .pipe(notify({message: 'babel: Scripts Compilados!'}))
});

gulp.task('babel:watch', function () {
    return gulp.watch('src/scripts/**/*.js', ['babel']);
});

gulp.task('sass:watch', function () {
    return gulp.watch('src/styles/**/*.sass', ['sass']);
});

gulp.task('image:watch', function () {
    return gulp.watch('src/images/*', ['image']);
});

gulp.task('icons:watch', function () {
    return gulp.watch('src/icons/*', ['icons']);
});

gulp.task('watch',['sass:watch','babel:watch','image:watch', 'icons:watch']);
gulp.task('default',['sass','image','babel', 'watch']);
" > gulpfile.js

# Create .babelrc
touch .babelrc

echo '{
  "presets": ["es2015"]
}
' > .babelrc

## Init npm
echo "Init npm ..."
npm init -y

## NPM plugins 
echo "Install npm plugins ..."
npm i gulp gulp-sass gulp-image gulp-uglify gulp-notify gulp-babel babel-core babel-cli babel-preset-env vinyl-source-stream vinyl-buffer babelify babel-preset-es2015 browserify vinyl-source-stream --save
