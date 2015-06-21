From: "M.E. O'Neill" <oneill@cs.hmc.edu>
Subject: perf stat -T now giving "not counted" when it used to work (failed PMU event multiplexing?)
Date: Sun, 21 Jun 2015 13:31:02 -0700
Message-ID: <ECC506C0-01C8-4527-82CE-968D852D46B8@cs.hmc.edu>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ark.cs.hmc.edu ([134.173.42.130]:58726 "EHLO ark.cs.hmc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbbFUUis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Jun 2015 16:38:48 -0400
Received: from [192.168.0.31] (pool-108-0-27-213.lsanca.fios.verizon.net [108.0.27.213])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: oneill)
	by ark.cs.hmc.edu (Postfix) with ESMTPSA id 86DB9640868
	for <linux-perf-users@vger.kernel.org>; Sun, 21 Jun 2015 13:31:03 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Back in February, I could gather performance data and get results like this with perf stat -T:

 Performance counter stats for './ants-ocm':

       1653.846545 task-clock (msec)         #    3.318 CPUs utilized
     4,791,092,035 instructions              #    0.76  insns per cycle
     6,293,499,230 cycles                    #    3.805 GHz
       532,780,020 cpu/cycles-t/             #    8.47% transactional cycles
                 0 cpu/tx-start/             #    0.000 K/sec                  
         1,601,050 cpu/el-start/             #      333 cycles / elision
       532,427,121 cpu/cycles-ct/            #    0.01% aborted cycles

       0.498513995 seconds time elapsed

but today when I try the same thing on the same machine (modulo time, reboots, updates), I get:

 Performance counter stats for './ants-ocm':

       1594.655064 task-clock (msec)         #    3.325 CPUs utilized          
     <not counted> instructions            
     <not counted> cycles                  
     <not counted> cpu/cycles-t/           
     <not counted> cpu/tx-start/           
     <not counted> cpu/el-start/           
     <not counted> cpu/cycles-ct/          

       0.479534926 seconds time elapsed

If I select events by hand, with perf stat -e '{task-clock,instructions,cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}', I get similar results (except that even task-clock can't be counted), but if I switch to one fewer statistics (e.g., omitting tx-start), I get

 Performance counter stats for './ants-ocm':

       1316.494067 task-clock (msec)         #    3.969 CPUs utilized          
     4,486,382,012 instructions              #    0.92  insns per cycle        
     4,856,514,753 cycles                    #    3.689 GHz                    
       371,558,738 cpu/cycles-t/             #  282.234 M/sec                  
         1,600,709 cpu/el-start/             #    1.216 M/sec                  
       371,279,122 cpu/cycles-ct/            #  282.021 M/sec                  

       0.331677347 seconds time elapsed

It seems like I'm restricted to a fixed number of events (despite what it says in the docs about the kernel multiplexing between different kinds of events).  If we drop cycles and add cpu/el-abort/ and cpu/el-capacity/ it then claims that cpu/cycles-ct/ isn't supported.

 Performance counter stats for './ants-ocm':

       1316.258972 task-clock (msec)         #    3.972 CPUs utilized          
     4,485,569,487 instructions             
       371,931,292 cpu/cycles-t/             #  282.567 M/sec                  
         1,600,656 cpu/el-start/             #    1.216 M/sec                  
             2,068 cpu/el-abort/             #    0.002 M/sec                  
                 1 cpu/el-capacity/          #    0.001 K/sec                  
   <not supported> cpu/cycles-ct/          

       0.331412647 seconds time elapsed

What's odd to me is that this used to work.  The machine is currently running

	Linux common 3.13.0-55-generic #94-Ubuntu SMP Thu Jun 18 00:27:10 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux 

Any thoughts would be appreciated!

    M.E.O.
