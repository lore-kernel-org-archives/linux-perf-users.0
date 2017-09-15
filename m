From: yuzhoujian <ufo19890607@gmail.com>
Subject: Port the period data column to centos6.7 for perf script
Date: Fri, 15 Sep 2017 10:37:58 +0800
Message-ID: <1505443078-13195-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:53464 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdIOCiL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2017 22:38:11 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, all.
I want to draw off-cpu flamegraph using perf script on centos6.7
(kernel version, 2.6.32-573), and I found perf script lacks the 
period data column on that version. I found two related patches, 
and modifed builin-script.c in reference to those patches.
perf script:Add period data column authorJiri Olsa 2014-08-25 16:45:42 +0200 
commit535aeaae7de821ba5d43ee2a204ee667ca95aae4
perf script: Add period as a default output column 
commite8564b710c6df2c3aeb56c507c22f4bcfa4c0b2d)


I used the new complied perf to record some hardware event, like cycles, 
and the result displays the period data column. But when I record some 
tracepoint events, like sched:sched_stat_sleep, sched:sched_switch, I 
found the period data column is always 1.  I checked the code(kernel/event/core.c), 
and found that the data->period is assigned nr in the function named perf_swevent_event.  
I tracked this function, and found the function call flow:
perf_trace_buf_submit--->perf_tp_event---->perf_swevent_event.

The function perf_trace_buf_submit is in the ftrace_event.h files, so the period data 
column  for tracepoint events is calulated in the frace subsystem?  What is the real 
meaning of the period field and how to calculate it ? Can you give me some tips for 
poring this field on the old kernel?

Thanks,
Wind Yu.
