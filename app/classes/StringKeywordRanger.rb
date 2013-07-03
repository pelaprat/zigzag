class StringKeywordRanger
  attr_accessor :keywords, :pairings, :range, :source_as_array

  def initialize( s, k, r )
    @source     = s
    @range      = r
    @pairings   = []
    @segments   = []

    if k.kind_of? String
      @keywords = k.split( /\s+/ )
    end

    @source_as_array  = convert_string_to_array( @source )

    ## Call if ok.
    if @keywords.empty?
    else
      produce_pairings
      produce_segments
    end
  end

  def segments
    if @segments.empty?
      puts "Will get source"
      puts [@source].inspect
      [@source]
    else
      puts "Will get segments"
      puts @segments.inspect
      @segments
    end
  end

  private

  def produce_pairings
    @sanitized = @source_as_array.collect { |a|
      a.gsub(/[^0-9a-zA-Z]/i, '').downcase
    }

    @pairings = []
    @keywords.each do |keyword|
      keyword.downcase!
      x = find_index_ranges_for_keyword( @sanitized, keyword, @range )
      y = harmonize_index_pairs( x )

      unless y.kind_of? String
        @pairings = @pairings | y
      end
    end
  end

  def produce_segments
    @pairings.each do |pair|
      @segments.push( @source_as_array.slice( pair[0], pair[1] ).join(' ') )
    end
  end

  def convert_string_to_array( s )
    s.split(/\s+/)
  end

  def find_indices_in_array( a, k, o )

    if i = a.index(k)
      return find_indices_in_array( a.slice( i + 1, a.length), k, o + i + 1 ).push( o + i )
    else
      return []
    end
  end

  def sort_range_pairs( a )
    a.sort{ |x, y| 
      x[0] <=> y[0]
    }
    return a
  end

  def find_index_ranges_for_keyword( a, k, r )

    indices = find_indices_in_array( a, k, 0 ).sort!

    resulting = []
    indices.each do |index|
      b_low   = index - r < 0 ? 0 : index - r
      b_high  = index + r > a.length ? a.length : index + r
      resulting.push( [b_low, b_high] )
    end

    resulting = sort_range_pairs( resulting )

    return resulting
  end

  def harmonize_index_pairs( r )

    if r.length >= 2
      a = r[0]
      b = r[1]

      if a[1] >= b[0]
        x = [ a[0], b[1] ]
        r.delete_at( 0 )
        r.delete_at( 0 )
        return harmonize_index_pairs( r.unshift( x ) )
      else
        return [ a ] | harmonize_index_pairs( r.slice( 1, r.length ))
      end
    elsif r.length == 1
      return r
    else
      return ''
    end
  end
end