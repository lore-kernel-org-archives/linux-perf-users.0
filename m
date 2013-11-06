From: Amit Tomer <amittomer25@gmail.com>
Subject: Fwd: Perf support for stalled-cycles-frontend and stalled-cycles-backend
 event
Date: Wed, 6 Nov 2013 19:15:54 +0530
Message-ID: <CABHD4K_yTAeL=JrMSD8ui9xRzN9z53h+tW-L_exzQHK7+qeQnQ@mail.gmail.com>
References: <CABHD4K9uYYx3ga=joDid71YUWT7o93Cg8hDSQgX=dDy156vAsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:64144 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab3KFNpz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Nov 2013 08:45:55 -0500
Received: by mail-wi0-f182.google.com with SMTP id ez12so3698569wid.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2013 05:45:54 -0800 (PST)
In-Reply-To: <CABHD4K9uYYx3ga=joDid71YUWT7o93Cg8hDSQgX=dDy156vAsQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

---------- Forwarded message ----------
From: Amit Tomer <amittomer25@gmail.com>
Date: Wed, Nov 6, 2013 at 7:03 PM
Subject: Perf support for stalled-cycles-frontend and
stalled-cycles-backend event
To: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>


We recently installed Perf tool on our platform based on Cortex A-15
cores and Linux kerenl 3.4.8.

We enabled the Hardware Performance counter(PMU) and can see below
message in dmeg log .

[    2.292157] hw perfevents: enabled with ARMv7 Cortex-A15 PMU
driver, 7 counters available

This message suggests there are 7 counter avaiable here.

But when we run the below command ,we find two counters named
stalled-cycles-frontend and stalled-cycles-backend are not suported

#########################################

root@fzm-k2:~# perf stat -v ./helloworld

Warning: stalled-cycles-frontend event is not supported by the kernel.

Warning: stalled-cycles-backend event is not supported by the kernel.



This is helloworld

pRet: 0

pRet: 0

pRet: 0

cg_rc,: 0

pRet: 0

pRet: 0

pRet: 110

pthread timeout done

task-clock: 4510376 4510376 4510376

context-switches: 1 4510376 4510376

cpu-migrations: 0 4510376 4510376

page-faults: 124 4510376 4510376

cycles: 5524151 4516123 4516123

stalled-cycles-frontend: 0 0 0

stalled-cycles-backend: 0 0 0

instructions: 1470222 4516123 4516123

branches: 432570 4516123 4516123

branch-misses: 14388 4516123 4516123



Performance counter stats for './helloworld':



          4.510376 task-clock                #    0.000 CPUs utilized

                 1 context-switches          #    0.222 K/sec

                 0 cpu-migrations            #    0.000 K/sec

               124 page-faults               #    0.027 M/sec

           5524151 cycles                    #    1.225 GHz

   <not supported> stalled-cycles-frontend

   <not supported> stalled-cycles-backend

           1470222 instructions              #    0.27  insns per cycle

            432570 branches                  #   95.906 M/sec

             14388 branch-misses             #    3.33% of all branches



      60.005505884 seconds time elapsed

 Now as we can see that these two counter are not supported here,can
anybody let us know how do we provide support for both them.

Also, why CPU's utilization is showing Zero here??

Thanks
Amit.
