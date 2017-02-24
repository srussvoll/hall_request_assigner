
import std.conv;
import std.getopt;
import std.stdio;

import optimal_hall_requests;
import elevator_state;
import jsonx;

struct Input {
    bool[][] hallRequests;
    LocalElevatorState[string] states;
}

void main(string[] args){

    string input_str;

    args.getopt(
        std.getopt.config.passThrough,
        "doorOpenDuration", &doorOpenDuration,
        "travelDuration", &travelDuration,
        "i|input", &input_str
    );

    if(input_str == string.init){
        input_str = readln;
        input_str = input_str[0..$-1];  // remove trailing newline
    }
    
    Input i = input_str.jsonDecode!Input;
    
    optimalHallRequests(i.hallRequests.to!(bool[2][]), i.states)
        .jsonEncode
        .writeln;
}

/+



{     "hallRequests" :         [[false,false],[true,false],[false,false],[false,true]],     "states" : {         "one" : {             "behaviour":"moving",             "floor":2,             "direction":"up",             "cabRequests":[false,false,true,true]         },         "two" : {             "behaviour":"idle",             "floor":0,             "direction":"stop",             "cabRequests":[false,false,false,false]         }     } }

+/

