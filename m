From: cee1 <fykcee1@gmail.com>
Subject: perf: can I record in one devce, and analyze in another device
Date: Sun, 28 May 2017 21:21:31 +0800
Message-ID: <CAGXxSxWW8TSNOTDW5oNuLtr4MmxueCkQxQyBQRRnqNugvBSbGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36707 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdE1NVw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 May 2017 09:21:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id h64so3732757pge.3
        for <linux-perf-users@vger.kernel.org>; Sun, 28 May 2017 06:21:52 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I have a perf.data recored in an ARM device with a kernel of old
version. And 'perf script' in my PC, and I noticed following lines:

"""
            perf  7952 [001]  5118.977020: sched:sched_stat_runtime:
comm=perf pid=7952 runtime=3659688 [ns] vruntime=1394034874931 [ns]
            perf  7952 [001]  5118.977037:       sched:sched_switch:
perf:7952 [120] R ==> nanohub:414 [50]
...
         nanohub   414 [001]  5118.977116:       sched:sched_switch:
nanohub:414 [50] S ==> perf:7952 [120]
...
 .mobileqq:video  7908 [002]  5118.977172: sched:sched_stat_runtime:
comm=.mobileqq:video pid=7908 runtime=81563 [ns] vruntime=842128189897
[ns]
 .mobileqq:video  7908 [002]  5118.977194: sched:sched_stat_runtime:
comm=perf pid=7952 runtime=97031 [ns] vruntime=1394034971962 [ns]
"""

The last line, pid=7908 on CPU 002 "sched_stat_runtime" of pid=7952 on CPU 001?

IIUC sched_stat_runtime is invoked in update_curr, which will stat the
"current task" of the rq. How can task 7952 on CPU 001 be "stated" by
the current task on CPU 002?
Or it is wrong to analyze perf.data in a different device?



-- 
Regards,

- cee1
