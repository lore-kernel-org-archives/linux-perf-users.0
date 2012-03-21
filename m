From: Yipeng Huang <yipeng@gmail.com>
Subject: perf stat: Doubt about stall cycle support
Date: Wed, 21 Mar 2012 04:42:20 +0000 (UTC)
Message-ID: <loom.20120321T054053-857@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37184 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab2CUEpG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Mar 2012 00:45:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SADPz-0005Ew-K0
	for linux-perf-users@vger.kernel.org; Wed, 21 Mar 2012 05:45:04 +0100
Received: from cm231.omega17.maxonline.com.sg ([218.186.17.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Mar 2012 05:45:03 +0100
Received: from yipeng by cm231.omega17.maxonline.com.sg with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Mar 2012 05:45:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am running perf stat to count hardware counters but am confused about stall 
cycle support. 

On running the command perf stat ./progname, I am told that stalled-cycles-
frontend and stalled-cycles-backend are not counted, but when on running perf 
stat -v ./progname, I am told that stall cycles are not supported by the kernel. 
So which is it? 

I am running kernel 3.0.0-17 on a Core 2 Duo T9600. 

Output of perf stat -v ./progname below.
-------------------------------------------------------------------------

stalled-cycles-frontend event is not supported by the kernel.
stalled-cycles-backend event is not supported by the kernel.
task-clock: 10721725 10721725 10721725
context-switches: 21 10721725 10721725
CPU-migrations: 7 10721725 10721725
page-faults: 307 10721725 10721725
cycles: 8448552 10786438 10786438
stalled-cycles-frontend: 0 0 0
stalled-cycles-backend: 0 0 0
instructions: 9441906 10786438 10786438
branches: 2248426 10786438 10786438
branch-misses: 78571 10786438 10786438

 Performance counter stats for './dd-exp1-papiex 10':

         10.721725 task-clock                #    0.232 CPUs utilized          
                21 context-switches          #    0.002 M/sec                  
                 7 CPU-migrations            #    0.001 M/sec                  
               307 page-faults               #    0.029 M/sec                  
         8,448,552 cycles                    #    0.788 GHz                    
     <not counted> stalled-cycles-frontend 
     <not counted> stalled-cycles-backend  
         9,441,906 instructions              #    1.12  insns per cycle        
         2,248,426 branches                  #  209.707 M/sec                  
            78,571 branch-misses             #    3.49% of all branches        

       0.046307919 seconds time elapsed

Thanks and Regards, 

Yipeng 
