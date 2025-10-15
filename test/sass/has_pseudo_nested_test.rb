#!/usr/bin/env ruby

# Тест для исправления бага с :has() псевдоклассом при вложенности
# Использует Minitest::Test для совместимости с существующей тестовой инфраструктурой

require_relative '../test_helper'

class HasPseudoNestedTest < Minitest::Test
  def render(sass, options = {})
    Sass::Engine.new(sass, options).render
  end

  def test_has_pseudo_nested
    # Test case from the bug report: :has() pseudo-class doesn't compile correctly when nested
    # Source: https://www.sassmeister.com/gist/a3dc4d7d09c7434bffb7dce3078e7836
    
    scss_code = <<~SCSS
      .foo > p:not(:has(> img)) {
        max-width: 42rem;
      }

      .foo {
        > p:not(:has(> img)) {
          max-width: 42rem;
        }
      }
    SCSS

    expected_css = <<~CSS
      .foo > p:not(:has(> img)) {
        max-width: 42rem; }

      .foo > p:not(:has(> img)) {
        max-width: 42rem; }
    CSS

    assert_equal(expected_css, render(scss_code, syntax: :scss))
  end

  def test_has_pseudo_simple
    # Test that simple :has() pseudo-class works correctly
    scss_code = <<~SCSS
      .foo > p:not(:has(> img)) {
        max-width: 42rem;
      }
    SCSS

    expected_css = <<~CSS
      .foo > p:not(:has(> img)) {
        max-width: 42rem; }
    CSS

    assert_equal(expected_css, render(scss_code, syntax: :scss))
  end

  def test_has_pseudo_with_other_selectors
    # Test :has() with other pseudo-classes and selectors
    scss_code = <<~SCSS
      .container {
        .item:not(:has(.child)) {
          color: red;
        }
        
        .item:has(.child) {
          color: blue;
        }
      }
    SCSS

    expected_css = <<~CSS
      .container .item:not(:has(.child)) {
        color: red; }
      .container .item:has(.child) {
        color: blue; }
    CSS

    assert_equal(expected_css, render(scss_code, syntax: :scss))
  end

  def test_has_pseudo_with_complex_nesting
    # Test more complex nesting scenarios
    scss_code = <<~SCSS
      .parent {
        .child {
          &:not(:has(> .grandchild)) {
            display: none;
          }
          
          &:has(> .grandchild) {
            display: block;
          }
        }
      }
    SCSS

    expected_css = <<~CSS
      .parent .child:not(:has(> .grandchild)) {
        display: none; }
      .parent .child:has(> .grandchild) {
        display: block; }
    CSS

    assert_equal(expected_css, render(scss_code, syntax: :scss))
  end

  def test_has_pseudo_with_host_context
    # Test that other pseudo-classes like :host-context also work
    scss_code = <<~SCSS
      .component {
        :host-context(.theme-dark) {
          background: black;
        }
        
        :not(:host-context(.theme-light)) {
          color: white;
        }
      }
    SCSS

    expected_css = <<~CSS
      .component :host-context(.theme-dark) {
        background: black; }
      .component :not(:host-context(.theme-light)) {
        color: white; }
    CSS

    assert_equal(expected_css, render(scss_code, syntax: :scss))
  end

end
