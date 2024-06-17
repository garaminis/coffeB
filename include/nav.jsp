<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
    #searchArea {
        display: flex;
        align-items: center;
        margin: 10px 0; 
    }

    #search {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        outline: none;
    }

    #doSearch {
        padding: 8px 16px;
        background-color: peru;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-size: 90%;
        cursor: pointer;
        transition: background-color 0.3s ease;
        border-radius: 5px;
    	  margin-left: 10px;
        font-family: 'YeongdeokSea';

    }

    #doSearch:hover {
        background-color: #a58e7f;
    }
</style>

<div style="width: 90%; display: flex; margin: 0 auto; align-items: center;">
	<span id="categoryBar">
	  <a href="/itemView?id=0" class="categoryMenu" id="0">전체상품</a>
	  <a href="/itemView?id=1" class="categoryMenu" id="1">커피</a>
	  <a href="/itemView?id=2" class="categoryMenu" id="2">차(Tea)</a>
	  <a href="/itemView?id=3" class="categoryMenu" id="3">커피용품</a>
	  <a href="/itemView?id=4" class="categoryMenu" id="4">차용품</a>
	</span>
	<span id="searchArea">
	 <!--  <input type="text" id="serch">&nbsp;&nbsp;&nbsp;&nbsp;
	  <button id="doSerch">Serch</button> -->
	  <form method='get' action="/itemView" name="search">
	  <input type="text" id="search" name="id" minlength="2" required>&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="submit" id="doSearch" value="Search">
	</form>
	</span>
</div>