From: Milian Wolff <milian.wolff@kdab.com>
Subject: measuring system wide CPU usage ignoring idle process
Date: Mon, 20 Nov 2017 15:00:46 +0100
Message-ID: <3344812.IFj9h2T05j@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:41342 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdKTOAs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Nov 2017 09:00:48 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, Jiri Olsa <jolsa@redhat.com>

Hey all,

colleagues of mine just brought this inconvenient perf stat behavior to my 
attention:

$ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1

 Performance counter stats for 'system wide':

       4004.501439      cpu-clock (msec)          #    4.000 CPUs utilized          
       4004.526474      task-clock (msec)         #    4.000 CPUs utilized          
       945,906,029      cycles                    #    0.236 GHz                    
       461,861,241      instructions              #    0.49  insn per cycle         

       1.001247082 seconds time elapsed

This shows that cpu-clock and task-clock are incremented also for the idle 
processes. Is there some trick to exclude that time, such that the CPU 
utilization drops below 100% when doing `perf stat -a`?

Or should one ignore these clock measurements for system wide stats and only 
look at the cycles/instructions etc.? This does go somewhat in the direction 
of http://www.brendangregg.com/blog/2017-05-09/cpu-utilization-is-wrong.html 
anyways, so I'm not opposed to this.

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
