From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: Missing stack symbols with perf_event's perf report, despite
 -fno-omit-frame-pointer compilation
Date: Tue, 19 Apr 2016 11:26:17 +0900
Message-ID: <57159749.9060705@gmail.com>
References: <loom.20160419T015612-712@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35730 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbcDSC0V (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2016 22:26:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so319080pfr.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Apr 2016 19:26:21 -0700 (PDT)
In-Reply-To: <loom.20160419T015612-712@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

On 04/19/2016 09:07 AM, Mark Davis wrote:
> I'm struggling getting perf_events to give me stack traces with symbols,
> despite reading many tutorials on the subject and doing (I think) all the
> necessary things. It's possible that my local install of perf (details on that
> below) is somehow botched? Anyway, here's what I did:
>
> main.cpp is a simple C++ program that calls a few functions defined in the same
> file, allocates some memory and frees it, and prints a few things out.
>
> compilation command:
>
>      gcc -std=c++11 -lstdc++ main.cpp -Og -fno-omit-frame-pointer -fno-inline -o
> arr_test
>
> profile command:
>
>      perf record -a -g -- ./arr_test && perf report --stdio
>
>
> I do get the following warnings about kernel symbols, but I don't think this
> should matter given that I only care about symbols in my application for now:
>

As a guide..
If you add ":u" to a event name, you can measure only at the user level e.g.

     perf record -ag -e cycles:u ./arr_test
