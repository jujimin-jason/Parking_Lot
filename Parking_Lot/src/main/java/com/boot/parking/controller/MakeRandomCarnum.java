package com.boot.parking.controller;

import java.util.Random;

//싱글톤 패턴을 통해 객체 생성 + 무작위로 번호판을 생성해주는 메서드
public class MakeRandomCarnum {
	
	private static MakeRandomCarnum instance = null;
	
	// 외부에서 기본생성자의 접근 막는 과정.
	private MakeRandomCarnum() { }
	
	public static MakeRandomCarnum getInstance() {
		if(instance == null) {
			instance = new MakeRandomCarnum();
		}
		return instance;
	}

	public String mrc() {
		// 입차 비지니스 로직.		// 입차번호 생성후 중복인 경우를 위한 예외처리 필요
		// 1. 랜덤으로 차량번호를 만들자.
		
		// 난수 발생을 위한 클래스 객체 생성.
		Random rand = new Random();
		
		// 랜덤으로 생성시킬 차량 가운데 한글자. (32개)
		String[] kor= {"가","나","다","라","마","거","너","더","러","머","버","서","어","저","고","노","도","로","모",
								"보","소","오","조","구","누","두","루","무","부","수","우","주"};
		
		// 문자열로 변환시킬 차량 번호
		String bun;
		
		
		// 1-1. 앞번호 - 01 ~ 699
		int ran1 = (int)(Math.random() * 699) + 1;
		
		String num = Integer.toString(ran1);
		String string1 = num.replaceFirst("^0+", "");
		int num1 = Integer.parseInt(string1);
		
		// System.out.println(num1);
	
		// 1-2. 중간 한글
		String kor1 = kor[rand.nextInt(kor.length)];
	
		// 1-3. 뒷번호 - 0100 ~ 9999
		int num2 = (int) (Math.random() * 9900) + 100;
		
		if(num1 > 100) {
			bun = String.format("%03d", num1) + kor1 + " " + String.format("%04d", num2);
		}else {
			bun = String.format("%02d", num1) + kor1 + " " + String.format("%04d", num2);	
		}
		
		return bun;
	}
	
}
