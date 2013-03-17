From: OSDepend <osdepend@gmail.com>
Subject: software event latency or duration
Date: Mon, 18 Mar 2013 01:06:34 +0800
Message-ID: <201303180106326608998@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46744 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3CQRGg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 17 Mar 2013 13:06:36 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so5837198pbc.28
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Mar 2013 10:06:36 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi all,
 
I'm wandering how to use perf tool to get the event latency of SW event.
just like the commond "perf sched latency" does, shows the time cost by the context-switch.
Is there some commond like that i can measure the interrupt latency, or pagefault latency?
Is it possible to show all the individual event's time cost?
Any reply is much appreciated!
 
Best,
Chen

 				
--------------
OSDepend
2013-03-18
