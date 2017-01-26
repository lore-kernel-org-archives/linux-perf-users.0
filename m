From: Taeung Song <treeze.taeung@gmail.com>
Subject: [Question] perf ftrace: regarding thread ID
Date: Thu, 26 Jan 2017 21:19:04 +0900
Message-ID: <7c637f38-9b46-07a1-1ff4-42c7e568a531@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32927 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdAZMTI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2017 07:19:08 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so22310195pgd.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2017 04:19:07 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

Hi, Namhyung :)

I saw new 'ftrace' tool that was applied yesterday.
If running perf ftrace as below..

1) current tracer : function_graph

   # perf ftrace -t function_graph /usr/toybox/bin/usleep 123456 | head -5
  2)   0.171 us    |  finish_task_switch();
  2)   0.070 us    |  finish_wait();
  2)               |  mutex_lock() {
  2)   0.035 us    |    _cond_resched();
  2)   0.423 us    |  }


2) current tracer : function

   # perf ftrace -t function /usr/toybox/bin/usleep 123456 | head -5
            <...>-24384 [002] d... 14170.310700: finish_task_switch 
<-__schedule
            <...>-24384 [002] .... 14170.310701: finish_wait <-pipe_wait
            <...>-24384 [002] .... 14170.310702: mutex_lock <-pipe_wait
            <...>-24384 [002] .... 14170.310702: _cond_resched <-mutex_lock
            <...>-24384 [002] .... 14170.310702: 
generic_pipe_buf_confirm <-pipe_read


If tracer is 'function', we can see tids.
But if tracer is 'function_graph', they aren't appeared.

So, I think tids should be printed both 'function' and 'function_graph' 
like below.
(such as uftrace :) )

   # perf ftrace -t function_graph /usr/toybox/bin/usleep 123456 | head -5
  2)   0.171 us [24384] |  finish_task_switch();
  2)   0.070 us [24384] |  finish_wait();
  2)                    |  mutex_lock() {
  2)   0.035 us [24384] |    _cond_resched();
  2)   0.423 us [24384] |  }

What do you think about this ?
How about this ?


Thanks,
Taeung
