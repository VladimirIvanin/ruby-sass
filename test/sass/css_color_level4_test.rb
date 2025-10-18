#!/usr/bin/env ruby

# Тесты для CSS Color Level 4 поддержки в Ruby Sass
# - Поддержка special numbers: var(), calc(), env(), attr(), clamp(), min(), max()
# - Новый space-separated и slash-separated синтаксис: rgb(255 128 0 / 0.5)
# - Обратная совместимость со старым синтаксисом

require_relative '../../lib/sass'

class CssColorLevel4Test
  # ============================================================================
  # Тесты для RGB с special numbers
  # ============================================================================

  def test_rgb_with_var
    scss = ".test { color: rgb(var(--r), var(--g), var(--b)); }"
    expected = ".test{color:rgb(var(--r), var(--g), var(--b))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_calc
    scss = ".test { color: rgb(calc(200 + 55), 100, 50); }"
    expected = ".test{color:rgb(calc(200 + 55), 100, 50)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_new_syntax_with_var_alpha
    scss = ".test { color: rgb(255 128 0 / var(--alpha)); }"
    expected = ".test{color:rgb(255 128 0 / var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_new_syntax_with_calc_alpha
    scss = ".test { color: rgb(255 128 0 / calc(0.5 * 2)); }"
    expected = ".test{color:rgb(255 128 0 / calc(0.5 * 2))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_env
    scss = ".test { color: rgb(env(--r), 128, 0); }"
    expected = ".test{color:rgb(env(--r), 128, 0)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_clamp
    scss = ".test { color: rgb(clamp(0, 255, 300), 128, 0); }"
    expected = ".test{color:rgb(clamp(0, 255, 300), 128, 0)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_min_max
    scss = ".test { color: rgb(min(200, 255), max(100, 128), 0); }"
    expected = ".test{color:rgb(min(200, 255), max(100, 128), 0)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_new_syntax_mixed_special_numbers
    scss = ".test { color: rgb(var(--r) calc(100 + 28) env(--b)); }"
    expected = ".test{color:rgb(var(--r) calc(100 + 28) env(--b))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты для RGBA с special numbers
  # ============================================================================

  def test_rgba_with_var_all_channels
    scss = ".test { color: rgba(var(--r), var(--g), var(--b), 0.5); }"
    expected = ".test{color:rgba(var(--r), var(--g), var(--b), 0.5)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgba_with_calc_alpha
    scss = ".test { color: rgba(255, 128, 0, calc(0.5 * 2)); }"
    expected = ".test{color:rgba(255, 128, 0, calc(0.5 * 2))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgba_with_color_and_var_alpha
    scss = "$c: #ff8000; .test { color: rgba($c, var(--alpha)); }"
    expected = ".test{color:rgba(255, 128, 0, var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgba_new_syntax_with_special_alpha
    scss = ".test { color: rgba(255 128 0 / var(--alpha)); }"
    expected = ".test{color:rgba(255 128 0 / var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты для HSL с special numbers
  # ============================================================================

  def test_hsl_with_var
    scss = ".test { color: hsl(var(--hue), 50%, 50%); }"
    expected = ".test{color:hsl(var(--hue), 50%, 50%)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsl_with_calc
    scss = ".test { color: hsl(calc(180deg + 10deg), 50%, 50%); }"
    expected = ".test{color:hsl(calc(180deg + 10deg), 50%, 50%)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsl_new_syntax_with_var
    scss = ".test { color: hsl(var(--hue) 50% 50%); }"
    expected = ".test{color:hsl(var(--hue) 50% 50%)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsl_new_syntax_with_calc_alpha
    scss = ".test { color: hsl(180 50% 50% / calc(0.5 + 0.3)); }"
    expected = ".test{color:hsl(180 50% 50% / calc(0.5 + 0.3))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты для HSLA с special numbers
  # ============================================================================

  def test_hsla_with_var_alpha
    scss = ".test { color: hsla(180, 50%, 50%, var(--alpha)); }"
    expected = ".test{color:hsla(180, 50%, 50%, var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsla_with_env
    scss = ".test { color: hsla(env(--hue), 50%, 50%, 0.8); }"
    expected = ".test{color:hsla(env(--hue), 50%, 50%, 0.8)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsla_new_syntax_with_special_alpha
    scss = ".test { color: hsla(180 50% 50% / var(--alpha)); }"
    expected = ".test{color:hsla(180 50% 50% / var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты обратной совместимости - обычные цвета должны работать
  # ============================================================================

  def test_normal_rgb_still_works
    scss = ".test { color: rgb(255, 128, 0); }"
    expected = ".test{color:#ff8000}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_normal_rgba_still_works
    scss = ".test { color: rgba(255, 128, 0, 0.5); }"
    # Ruby Sass убирает пробелы после запятых в compressed mode
    expected = ".test{color:rgba(255,128,0,0.5)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_normal_hsl_still_works
    scss = ".test { color: hsl(180, 50%, 50%); }"
    expected = ".test{color:#40bfbf}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_normal_hsla_still_works
    scss = ".test { color: hsla(180, 50%, 50%, 0.8); }"
    expected = ".test{color:rgba(64,191,191,0.8)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты нового CSS Color Level 4 синтаксиса без special numbers
  # ============================================================================

  def test_rgb_new_syntax_without_special_numbers
    scss = ".test { color: rgb(255 128 0); }"
    expected = ".test{color:#ff8000}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_new_syntax_with_alpha_without_special_numbers
    scss = ".test { color: rgb(255 128 0 / 0.5); }"
    expected = ".test{color:rgba(255,128,0,0.5)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsl_new_syntax_without_special_numbers
    scss = ".test { color: hsl(180 50% 50%); }"
    expected = ".test{color:#40bfbf}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsl_new_syntax_with_alpha_without_special_numbers
    scss = ".test { color: hsl(180 50% 50% / 0.8); }"
    expected = ".test{color:rgba(64,191,191,0.8)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты процентов в RGB и альфа-канале (CSS Color Level 4)
  # ============================================================================

  def test_rgb_with_percentage_channels
    # 100% = 255, 0% = 0
    scss = ".test { color: rgb(100% 0% 0%); }"
    expected = ".test{color:red}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_percentage_channels_and_alpha
    # 100% red, 0% green, 0% blue, 50% alpha
    scss = ".test { color: rgb(100% 0% 0% / 50%); }"
    expected = ".test{color:rgba(255,0,0,0.5)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_mixed_percentage_and_number
    # По спецификации нельзя смешивать проценты и числа в RGB каналах
    # но можно использовать проценты для альфы с числами для RGB
    scss = ".test { color: rgb(255 128 0 / 50%); }"
    expected = ".test{color:rgba(255,128,0,0.5)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_with_percentage_channels_various_values
    # 50% = 127.5 ≈ 127, 25% = 63.75 ≈ 63, 75% = 191.25 ≈ 191
    scss = ".test { color: rgb(50% 25% 75%); }"
    # 50% of 255 = 127.5, 25% of 255 = 63.75, 75% of 255 = 191.25
    expected = ".test{color:#7f3fbf}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgba_with_percentage_alpha
    # Альфа-канал может быть процентом: 80% = 0.8
    scss = ".test { color: rgba(255, 128, 0, 80%); }"
    expected = ".test{color:rgba(255,128,0,0.8)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_new_syntax_percentage_with_zero_alpha
    # 0% alpha = полностью прозрачный, 50% = 127.5 ≈ 127
    scss = ".test { color: rgb(100% 50% 0% / 0%); }"
    expected = ".test{color:rgba(255,127,0,0)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_new_syntax_percentage_with_full_alpha
    # 100% alpha = полностью непрозрачный, 50% = 127.5 ≈ 127
    scss = ".test { color: rgb(100% 50% 0% / 100%); }"
    expected = ".test{color:#ff7f00}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_hsl_with_percentage_alpha
    # HSL уже использует проценты для S и L, тест для альфы в процентах
    scss = ".test { color: hsl(180 50% 50% / 75%); }"
    expected = ".test{color:rgba(64,191,191,0.75)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_percentage_with_var_in_alpha
    # Проценты в каналах + var() в альфе
    scss = ".test { color: rgb(100% 0% 0% / var(--alpha)); }"
    expected = ".test{color:rgb(100% 0% 0% / var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgb_percentage_with_calc_in_alpha
    # Проценты в каналах + calc() в альфе
    scss = ".test { color: rgb(100% 50% 0% / calc(50% + 25%)); }"
    expected = ".test{color:rgb(100% 50% 0% / calc(50% + 25%))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  def test_rgba_legacy_syntax_percentage_alpha
    # Legacy запятой-разделенный синтаксис с процентной альфой
    scss = ".test { color: rgba(255, 128, 0, 50%); }"
    expected = ".test{color:rgba(255,128,0,0.5)}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Тесты смешанных случаев
  # ============================================================================

  def test_multiple_special_functions_in_one_rule
    scss = <<~SCSS
      .test {
        color1: rgb(var(--r) var(--g) var(--b));
        color2: hsl(calc(var(--base) + 30deg) 50% 50%);
        color3: rgba(255 128 0 / var(--opacity));
      }
    SCSS
    result = render(scss, :style => :compressed).strip
    assert result.include?("rgb(var(--r) var(--g) var(--b))")
    assert result.include?("hsl(calc(var(--base) + 30deg) 50% 50%)")
    assert result.include?("rgba(255 128 0 / var(--opacity))")
  end

  def test_sass_variables_with_special_numbers
    scss = <<~SCSS
      $alpha: var(--alpha);
      .test {
        color: rgba(255, 128, 0, $alpha);
      }
    SCSS
    expected = ".test{color:rgba(255, 128, 0, var(--alpha))}"
    assert_equal expected, render(scss, :style => :compressed).strip
  end

  # ============================================================================
  # Test Runner
  # ============================================================================

  def run_all_tests
    puts "Запуск тестов CSS Color Level 4..."
    puts "=" * 70
    
    test_methods = methods.grep(/^test_/).sort
    passed = 0
    failed = 0
    
    test_methods.each do |test_method|
      begin
        print "#{test_method}... "
        send(test_method)
        puts "✅"
        passed += 1
      rescue => e
        puts "❌"
        puts "  Ошибка: #{e.message}"
        puts "  #{e.backtrace.first}"
        failed += 1
      end
    end
    
    puts "=" * 70
    puts "Результаты: #{passed} прошли, #{failed} провалились из #{test_methods.size} тестов"
    puts "=" * 70
    
    failed == 0
  end

  def assert_equal(expected, actual, message = nil)
    unless expected == actual
      raise "#{message || 'Assertion failed'}: expected '#{expected}', got '#{actual}'"
    end
  end

  def assert(condition, message = "Assertion failed")
    raise message unless condition
  end

  private

  def render(scss, options = {})
    Sass::Engine.new(scss, options.merge(:syntax => :scss)).render
  end
end

# Запуск тестов, если файл выполняется напрямую
if __FILE__ == $0
  test = CssColorLevel4Test.new
  success = test.run_all_tests
  exit(success ? 0 : 1)
end

