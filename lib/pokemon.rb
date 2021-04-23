class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize (id=nil, name=nil, type=nil, db)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save (name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?,?)
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find (id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id=?
            LIMIT 1
        SQL

        db.execute(sql, id).map do |row|
            Pokemon.new(row[0], row[1], row[2], row[3])
        end.first
    end
end
