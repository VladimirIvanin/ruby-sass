# -*- coding: utf-8 -*-
# Проверка, что значения кастомных свойств (--*) проходят как «сырой» CSS:
# ключевые слова, размеры, цвета, строки, url(), функции, списки, !important и т.д.
# (см. алгоритм declaration value в CSS Syntax; в Dart Sass — _interpolatedDeclarationValue.)
require File.expand_path('../test_helper', File.dirname(__FILE__))

class CustomPropertyCssTypesTest < Minitest::Test
  def render(scss, options = {})
    options[:syntax] = :scss
    options[:cache] = false
    munge_filename options
    Sass::Engine.new(scss, options).render
  end

  def test_custom_property_keywords_numbers_dimensions
    assert_equal(<<CSS, render(<<SCSS))
.t {
  --inherit: inherit;
  --initial: initial;
  --unset: unset;
  --none: none;
  --auto: auto;
  --cc: currentColor;
  --tr: transparent;
  --zero: 0;
  --float: 0.25;
  --neg: -12px;
  --len: 12.5px;
  --em: 1.5em;
  --pct: 33.3%;
  --rem: 2rem;
  --vw: 10vw;
  --ch: 40ch;
  --fr: 1fr 2fr;
  --deg: 45deg;
  --turn: 0.25turn;
  --ms: 200ms;
  --s: 3s;
  --hz: 440Hz;
  --dpi: 300dpi;
  --rep: repeat(2, 1fr);
  --fit: fit-content(10px);
  --slash: 1 / 2; }
CSS
.t {
  --inherit: inherit;
  --initial: initial;
  --unset: unset;
  --none: none;
  --auto: auto;
  --cc: currentColor;
  --tr: transparent;
  --zero: 0;
  --float: 0.25;
  --neg: -12px;
  --len: 12.5px;
  --em: 1.5em;
  --pct: 33.3%;
  --rem: 2rem;
  --vw: 10vw;
  --ch: 40ch;
  --fr: 1fr 2fr;
  --deg: 45deg;
  --turn: 0.25turn;
  --ms: 200ms;
  --s: 3s;
  --hz: 440Hz;
  --dpi: 300dpi;
  --rep: repeat(2, 1fr);
  --fit: fit-content(10px);
  --slash: 1 / 2;
}
SCSS
  end

  def test_custom_property_colors
    assert_equal(<<CSS, render(<<SCSS))
.t {
  --hex3: #abc;
  --hex6: #aabbcc;
  --named: tomato;
  --rgb: rgb(255 128 0 / 50%);
  --rgba: rgba(0, 0, 0, 0.25);
  --hsl: hsl(270 60% 50% / 0.9);
  --hsla: hsl(270, 60%, 50%); }
CSS
.t {
  --hex3: #abc;
  --hex6: #aabbcc;
  --named: tomato;
  --rgb: rgb(255 128 0 / 50%);
  --rgba: rgba(0, 0, 0, 0.25);
  --hsl: hsl(270 60% 50% / 0.9);
  --hsla: hsl(270, 60%, 50%);
}
SCSS
  end

  def test_custom_property_strings_urls
    assert_equal(<<CSS, render(<<SCSS))
.t {
  --str-dq: "hello world";
  --str-sq: 'single';
  --url-bare: url(icon.svg);
  --url-dq: url("data:image/svg+xml,x");
  --url-sq: url('data:image/png,');
  --comma-list: foo, bar, baz;
  --space-list: 10px 20px dimgray; }
CSS
.t {
  --str-dq: "hello world";
  --str-sq: 'single';
  --url-bare: url(icon.svg);
  --url-dq: url("data:image/svg+xml,x");
  --url-sq: url('data:image/png,');
  --comma-list: foo, bar, baz;
  --space-list: 10px 20px dimgray;
}
SCSS
  end

  def test_custom_property_functions
    assert_equal(<<CSS, render(<<SCSS))
.t {
  --calc: calc(100% - 2em);
  --var: var(--x, 10px);
  --min: min(10vw, 1rem);
  --max: max(1px, 2%);
  --clamp: clamp(1rem, 10vw, 100px);
  --attr: attr(href);
  --env: env(safe-area-inset-top);
  --grad: linear-gradient(90deg, red, blue);
  --bezier: cubic-bezier(0.4, 0, 0.2, 1);
  --matrix: matrix(1, 0, 0, 1, 0, 0); }
CSS
.t {
  --calc: calc(100% - 2em);
  --var: var(--x, 10px);
  --min: min(10vw, 1rem);
  --max: max(1px, 2%);
  --clamp: clamp(1rem, 10vw, 100px);
  --attr: attr(href);
  --env: env(safe-area-inset-top);
  --grad: linear-gradient(90deg, red, blue);
  --bezier: cubic-bezier(0.4, 0, 0.2, 1);
  --matrix: matrix(1, 0, 0, 1, 0, 0);
}
SCSS
  end

  def test_custom_property_important_brackets_and_maps
    assert_equal(<<CSS, render(<<SCSS))
.t {
  --imp: 1px !important;
  --paren: (1 2);
  --bracket: [1, 2];
  --brace: {a: 1}; }
CSS
.t {
  --imp: 1px !important;
  --paren: (1 2);
  --bracket: [1, 2];
  --brace: {a: 1};
}
SCSS
  end
end
