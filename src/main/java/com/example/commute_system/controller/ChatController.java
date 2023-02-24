package com.example.commute_system.controller;

import com.example.commute_system.domain.Room;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class ChatController {
    List<Room> roomList = new ArrayList<Room>();    //roolist를 메모리에 저장?
    static int roomNumber = 0;                   //


    @RequestMapping("/chat")
    public ModelAndView chat() {
        //ModelAndView클래스
        ModelAndView mv = new ModelAndView();
        mv.setViewName("chat");
        return mv;
    }

    //방 페이지
    @RequestMapping("/room")
    public ModelAndView room() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("room");//어디 페이지로 보낼것인지 set
        return mv;
    }

    //방 생성하기
    @RequestMapping("/createRoom")
    public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){ //@ResponseBody가 붙어 있음 스트링값을 그대로 반환합니다.
        String roomName = (String) params.get("roomName");
        if(roomName != null && !roomName.trim().equals("")) {
            Room room = new Room();
            room.setRoomNumber(++roomNumber);
            room.setRoomName(roomName);
            roomList.add(room);
        }
        return roomList;
    }

    //방 정보 가져오기
    @RequestMapping("/getRoom")
    public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
        return roomList;
    }

    //채팅방
    @RequestMapping("/moveChating")
    public ModelAndView chating(@RequestParam HashMap<Object ,Object> params) {
        ModelAndView mv = new ModelAndView();
        int roomNumber = Integer.parseInt((String) params.get("roomNumber"));

        List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
        if(new_list != null && new_list.size() > 0) {
            mv.addObject("roomName", params.get("roomName"));
            mv.addObject("roomNumber", params.get("roomNumber"));
            mv.setViewName("chat");
        }else {
            mv.setViewName("room");
        }
        return mv;
    }
}
