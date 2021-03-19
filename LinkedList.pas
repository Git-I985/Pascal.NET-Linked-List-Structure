unit LinkedList;


type
    /// Элемент связанного списка
    LListNode<T> = class
    public
        
        value: T;
        next: LListNode<T>;
        
        constructor(value: T; next: LListNode<T> := nil);
        begin
            self.value := value;
            self.next := next;
        end;
        
        function ToString: string; override;
        begin
            ToString := self.value.ToString();
        end;
    end;
    
    /// Связный список (Linked list)
    LList<T> = class
    
    public
        /// головной элемент списка
        head: LListNode<T>; 
        /// последний элемент списка
        tail: LListNode<T>; 
        /// размер списка
        length: integer; 
        
        constructor();
        begin
            self.length := 0;
            self.head := nil;
        end;
        
        /// добавляет элемент в список
        procedure add(value: T);
        begin
            
            var node: LListNode<T> := new LListNode<T>(value);
            
            if self.head = nil then self.head := node
            else self.tail.next := node; 
            
            self.tail := node;
            
            Inc(self.length); /// увеличивает размер списка после добавления элемента
        end;
        
        /// проверяет наличие в списке элемента с таким индексом
        /// если индекс за пределами списка, тогда вызывется исключение
        procedure checkIndexExists(index: integer);
        begin
            if (index < self.length) and (index >= 0) then exit;
            raise new System.IndexOutOfRangeException('Индекс находился вне границ списка');
        end;
        
        /// удаляет первый элемент  
        procedure removeFirst();
        begin
            self.head := self.head.next;
            /// уменьшает размер списка после удаления первого элемента
            Dec(self.length);
        end;
        
        /// Удаляет последний элемент
        procedure removeLast();
        begin
            self.removeElementByIndex(self.length - 1);
        end;
        
        
        /// Удаляет элемент по индексу
        procedure removeElementByIndex(index: integer);
        begin
            checkIndexExists(index);
            
            if index = 0 then 
                self.removeFirst()
            else begin
                var previous: LListNode<T> := self.head;
                
                for var i := 0 to index - 2 do 
                    previous := previous.next;
                
                var toDelete: LListNode<T> := previous.next;
                previous.next := toDelete.next;
                
                /// уменьшает размер списка после удаления элемента
                Dec(self.length); 
            end;
        end;
        
        /// Возвращает true если в списке есть такой элемент
        function contains(element: T): boolean;
        begin
            for var i := 0 to self.length - 1 do
              if self[i] = element then contains := True;
        end;
        
        /// Генерирует строковое представление списка (для вывода с помощью WriteLn итд)
        function ToString: string; override;
        begin
            var res := '';
            var current: LListNode<T> := self.head;
            
            while not (current = nil) do
            begin
                /// пустая строка если это конец
                res += current.value.toString() + (current.next = nil ? '' : ', ');
                current := current.next;
            end;
            
            ToString := $'[{res}]';
        end;
        
        /// ....................................
        
        /// РЕАЛИЗАЦИЯ ДОСТУПА ПО ИНДЕКСУ  
        /// позволяет использовать класс как массив
        
        /// ....................................
        
        
        /// Фунция получения элемента по индексному свойству
        /// Например: переменная := список[индекс элемента];
        function GetNode(index: integer): T;
        begin
            checkIndexExists(index);
            var current: LListNode<T> := self.head;
            var counter := 0;
            while not (current = nil) do
            begin
                if (counter = index) then 
                begin
                    GetNode := current.value;                            
                    exit;
                end;
                current := current.next;
                counter += 1;
            end;
        end;
        
        /// Функция присваивания элемента по индексному свойству 
        /// Например: список[индекс элемента] := значение;
        procedure SetNode(index: integer; value: T);
        begin
            checkIndexExists(index);
            var current: LListNode<T> := self.head;
            var counter := 0;
            while not (current = nil) do
            begin
                if (counter = index) then 
                begin
                    current.value := value;
                    exit;
                end;
                current := current.next;
                counter += 1;
            end;
        end;
        
            /// Назначение индексных свойств
        property Nodes[index: integer]: T read GetNode write SetNode;default;
    
    end;

end.