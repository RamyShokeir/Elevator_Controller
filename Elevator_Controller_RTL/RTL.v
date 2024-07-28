module Elevator_Controller 
(
    input wire Enable,
    input wire [1:0] Up_Down,
    input wire CLK,RST,
    output wire LED_A,LED_B,LED_C
);
reg [1:0] current_state,next_state;
localparam [1:0] FLOOR_1='b01 ,
                 FLOOR_2='b11 ,
                 FLOOR_3='b10 ;

always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        current_state <= FLOOR_1;
    end
    else
    begin
        if(Enable)
        begin
        current_state <=next_state;
        end
        else
        begin
        current_state <= current_state;
        end
    end
end
always @(*)
begin
    LED_A = 1'b0;
    LED_B = 1'b0;
    LED_C = 1'b0;
 case(current_state)
     FLOOR_1: 
     begin
        LED_A =1'b1;
        case(Up_Down)
        2'b01:
        begin
            next_state=FLOOR_2;
        end
        2'b10:
        begin
            next_state=FLOOR_1;
        end
        default:
        begin
            next_state=FLOOR_1;
        end

        endcase
     end
    FLOOR_2:
     begin
        LED_B=1'b1;
        case(Up_Down)
        2'b01:
        begin
            next_state=FLOOR_3;
        end
        2'b10:
        begin
            next_state=FLOOR_1;
        end
        default:
        begin
            next_state=FLOOR_2;
        end
        endcase
     end
    FLOOR_3:
     begin
        LED_C=1'b1;
        case(Up_Down)
        2'b01:
        begin
            next_state=FLOOR_3;
        end
        2'b10:
        begin
            next_state=FLOOR_2;
        end
        default:
        begin
            next_state=FLOOR_3;
        end
        endcase

     end
    default:
    begin
        LED_A = 1'b0;
        LED_B = 1'b0;
        LED_C = 1'b0;
    end
 endcase
end
endmodule