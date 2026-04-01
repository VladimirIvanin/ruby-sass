#!/usr/bin/env ruby

# Простой тест для CSS Level 4 селекторов без использования minitest/autorun
# чтобы избежать конфликтов с Rails

require_relative '../../lib/sass'

class CssLevel4SelectorsTest
  def test_nth_child_with_of_compressed
    # Тест для CSS Level 4 селектора :nth-child с 'of'
    scss = <<~SCSS
      .someclass:nth-child(1 of .due-today) {
        color: red;
      }
    SCSS
    
    expected_compressed = ".someclass:nth-child(1 of .due-today){color:red}"
    result = render(scss, :style => :compressed)
    
    assert_equal expected_compressed, result.strip
  end

  def test_nth_last_child_with_of_compressed
    # Тест для CSS Level 4 селектора :nth-last-child с 'of'
    scss = <<~SCSS
      .item:nth-last-child(2n+1 of .highlight) {
        color: blue;
      }
    SCSS
    
    expected_compressed = ".item:nth-last-child(2n+1 of .highlight){color:blue}"
    result = render(scss, :style => :compressed)
    
    assert_equal expected_compressed, result.strip
  end

  def test_nth_of_type_with_of_compressed
    # Тест для CSS Level 4 селектора :nth-of-type с 'of'
    scss = <<~SCSS
      p:nth-of-type(3n+1 of .special) {
        font-weight: bold;
      }
    SCSS
    
    expected_compressed = "p:nth-of-type(3n+1 of .special){font-weight:bold}"
    result = render(scss, :style => :compressed)
    
    assert_equal expected_compressed, result.strip
  end

  def test_nth_last_of_type_with_of_compressed
    # Тест для CSS Level 4 селектора :nth-last-of-type с 'of'
    scss = <<~SCSS
      div:nth-last-of-type(odd of .important) {
        background: yellow;
      }
    SCSS
    
    expected_compressed = "div:nth-last-of-type(odd of .important){background:yellow}"
    result = render(scss, :style => :compressed)
    
    assert_equal expected_compressed, result.strip
  end

  def test_regular_nth_child_compressed
    # Тест для обычного :nth-child без 'of' - должен работать как раньше
    scss = <<~SCSS
      .item:nth-child(2n+1) {
        color: green;
      }
    SCSS
    
    expected_compressed = ".item:nth-child(2n+1){color:green}"
    result = render(scss, :style => :compressed)
    
    assert_equal expected_compressed, result.strip
  end

  def test_nth_child_with_of_expanded
    # Тест для CSS Level 4 селектора в expanded стиле
    scss = <<~SCSS
      .someclass:nth-child(1 of .due-today) {
        color: red;
      }
    SCSS
    
    expected_expanded = <<~CSS
      .someclass:nth-child(1 of .due-today) {
        color: red;
      }
    CSS
    
    result = render(scss, :style => :expanded)
    
    assert_equal expected_expanded.strip, result.strip
  end

  def test_multiple_css_level4_selectors
    # Тест для нескольких CSS Level 4 селекторов в одном правиле
    scss = <<~SCSS
      .container:nth-child(1 of .highlight):nth-last-child(2 of .special) {
        background: red;
      }
    SCSS
    
    expected_compressed = ".container:nth-child(1 of .highlight):nth-last-child(2 of .special){background:red}"
    result = render(scss, :style => :compressed)
    
    assert_equal expected_compressed, result.strip
  end

  def run_all_tests
    puts "Запуск тестов CSS Level 4 селекторов..."
    puts "=" * 50
    
    test_methods = methods.grep(/^test_/)
    passed = 0
    failed = 0
    
    test_methods.each do |test_method|
      begin
        puts "\nЗапуск #{test_method}..."
        send(test_method)
        puts "✅ #{test_method} - ПРОШЕЛ"
        passed += 1
      rescue => e
        puts "❌ #{test_method} - ПРОВАЛЕН: #{e.message}"
        puts e.backtrace.first(3).join("\n")
        failed += 1
      end
    end
    
    puts "\n" + "=" * 50
    puts "Результаты: #{passed} прошли, #{failed} провалились"
    puts "=" * 50
    
    failed == 0
  end

  def assert_equal(expected, actual, message = nil)
    unless expected == actual
      raise "#{message || 'Assertion failed'}: expected '#{expected}', got '#{actual}'"
    end
  end

  private

  def render(scss, options = {})
    Sass::Engine.new(scss, options.merge(:syntax => :scss)).render
  end
end

# Запуск тестов, если файл выполняется напрямую
if __FILE__ == $0
  test = CssLevel4SelectorsTest.new
  success = test.run_all_tests
  exit(success ? 0 : 1)
end
