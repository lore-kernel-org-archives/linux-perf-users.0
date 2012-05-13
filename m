From: "Hailong Yang" <hailong.yang1115@gmail.com>
Subject: perf stat: how to capture the output when it is running in the backgroud
Date: Sun, 13 May 2012 23:47:37 +0800
Message-ID: <4fafd79d.6586440a.2edc.ffffb185@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47091 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab2EMPrm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 13 May 2012 11:47:42 -0400
Received: by pbbrp8 with SMTP id rp8so5146994pbb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 13 May 2012 08:47:42 -0700 (PDT)
Content-Language: zh-cn
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear all,

I am running perf stat to collect the performance statistics of a already
running process. And I have a shell script to execute the perf stat as a
daemon process. But when I use the 'kill' command to stop the perf stat,
there is no output redirected to a file.

[root@dell06 ~]# (perf stat -p 7473 -x ,) 2> perftest &
[1] 15086
[root@dell06 ~]# kill 15086
[root@dell06 ~]# 
[1]+  Terminated              ( perf stat -p 7473 -x , ) 2> perftest
[root@dell06 ~]# cat perftest
[root@dell06 ~]#

Any clue?

Best Regards

Hailong
