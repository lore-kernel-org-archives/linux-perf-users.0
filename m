From: taeung <treeze.taeung@gmail.com>
Subject: What do zeroing of samples in 'perf top' mean ?
Date: Tue, 30 Sep 2014 12:19:41 +0900
Message-ID: <542A214D.1090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37235 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaI3DTu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Sep 2014 23:19:50 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so6785104pab.40
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2014 20:19:50 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>

Hi,

I have two questions about 'zeroing of samples' in 'perf top'.

I knew if I use 'perf top', I can see a performance counter profile in 
real time.
But I can't find a difference between 'perf top -a' and 'perf top --zero'.

After 'perf top' is run , I press key 'z' to toggle zeroing of samples.
But I don't know a difference between when I press key 'z' and before I 
did it.

1. What is 'Zero history' ?
(I saw it in Documentation/perf-top.txt that '--zero' option is 'Zero 
history across display updates.')

2. What do 'zeroing of samples' mean ?

Thanks,
Taeung
