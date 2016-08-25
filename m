From: William Cohen <wcohen@redhat.com>
Subject: Impact of perf_event_paranoid default to 2 on measurement accuracy
Date: Thu, 25 Aug 2016 11:42:27 -0400
Message-ID: <63c068ab-bfb5-1138-17cc-5a153ea183a7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755428AbcHYPn0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Aug 2016 11:43:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F14344E4E9
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2016 15:42:28 +0000 (UTC)
Received: from [10.13.129.38] (dhcp129-38.rdu.redhat.com [10.13.129.38])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7PFgSIe020165
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2016 11:42:28 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All,

Recent kernels have changed the default setting of /proc/sys/kernel/perf_event_paranoid from 1 to 2 which excludes kernel space measurements.  Has there been some review of the metrics and computation of derived metrics to make sure they are correct and reasonable?  Below are two runs on the same machine back-to-back with the only change being the perf_event_paranoid setting.  The stalled-cycles-fronend looks to be still be counting kernel events for the perf_event_paranoid=2.  The GHz calculation looks questionable (probably because task-clock is measuring total time rather than just user-space time).
 
$ uname -a
Linux santana 4.6.7-300.fc24.x86_64 #1 SMP Wed Aug 17 18:48:43 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

[wcohen@santana tmp]$ cat /proc/sys/kernel/perf_event_paranoid 
2
[wcohen@santana tmp]$ perf stat true

 Performance counter stats for 'true':

          0.585445      task-clock:u (msec)       #    0.546 CPUs utilized          
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
                43      page-faults:u             #    0.073 M/sec                  
           203,342      cycles:u                  #    0.347 GHz                    
           747,423      stalled-cycles-frontend:u #  367.57% frontend cycles idle   
           120,230      instructions:u            #    0.59  insn per cycle         
                                                  #    6.22  stalled cycles per insn
            20,197      branches:u                #   34.499 M/sec                  
             1,796      branch-misses:u           #    8.89% of all branches        

       0.001071608 seconds time elapsed

[wcohen@santana tmp]$ cat /proc/sys/kernel/perf_event_paranoid 
1
[wcohen@santana tmp]$ perf stat true

 Performance counter stats for 'true':

          0.505810      task-clock (msec)         #    0.478 CPUs utilized          
                 0      context-switches          #    0.000 K/sec                  
                 0      cpu-migrations            #    0.000 K/sec                  
                46      page-faults               #    0.091 M/sec                  
           799,143      cycles                    #    1.580 GHz                    
           549,326      stalled-cycles-frontend   #   68.74% frontend cycles idle   
           571,246      instructions              #    0.71  insn per cycle         
                                                  #    0.96  stalled cycles per insn
           105,510      branches                  #  208.596 M/sec                  
             4,958      branch-misses             #    4.70% of all branches        

       0.001058620 seconds time elapsed

Details on the processor below from /proc/cpu:

vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
stepping	: 9
microcode	: 0x1c
cpu MHz		: 1200.312
cache size	: 6144 KB


When events are explicitly specified it looks like user-space specifier is just pasted on rather than properly excluding kernel space specifiers even for events that this cannot be specified on:

$ perf stat -e task-clock:k -e task-clock:u -e page-faults:k -e page-faults:u -e cycles:k -e cycles:u true

 Performance counter stats for 'true':

          0.795325      task-clock:ku (msec)      #    0.498 CPUs utilized          
          0.795325      task-clock:u (msec)       #    0.498 CPUs utilized          
                 0      page-faults:ku            #    0.000 K/sec                  
                43      page-faults:u             #    0.054 M/sec                  
                 0      cycles:ku                 #    0.000 GHz                    
           245,909      cycles:u                  #    0.309 GHz                    

       0.001597513 seconds time elapsed


-Will
