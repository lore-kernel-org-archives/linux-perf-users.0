From: OSDepend <osdepend@gmail.com>
Subject: perf script timestamp
Date: Wed, 24 Apr 2013 16:22:05 +0800
Message-ID: <201304241622032855179@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:40683 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab3DXIWJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Apr 2013 04:22:09 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so385882pbc.9
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2013 01:22:08 -0700 (PDT)
Received: from zhengchen-Gucas ([159.226.43.30])
        by mx.google.com with ESMTPSA id ad7sm2142764pbd.14.2013.04.24.01.22.05
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 01:22:07 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi guys,
I just try to use perf script, and get some thing like below:
            java 15893 [015] 96380.588871: timer_cancel: timer=0xffff8804379d6698
            java 15721 [010] 96380.588872: timer_cancel: timer=0xffff8800be3d6698
            java 15893 [015] 96380.588875: timer_expire_entry: timer=0xffff8804379d6698 function=delayed_work_timer_fn now=4391194790
            java 15721 [010] 96380.588876: timer_expire_entry: timer=0xffff8800be3d6698 function=delayed_work_timer_fn now=4391194790

I want to know exactly about the time units of the events, such as 96380.588871, and 96380.588872.
The number befor "." is second or millisecond? and  Is the number after "." nanoseconds or microseconds?
I'm a little confused about the documation for ktime_t, please help me out!
 
Best,
Chen


2013-04-24
