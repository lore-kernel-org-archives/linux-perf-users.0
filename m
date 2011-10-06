From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Thu, 6 Oct 2011 14:56:39 -0700
Message-ID: <4E8E2417.2000903@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>  <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59882 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751411Ab1JFV47 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Oct 2011 17:56:59 -0400
In-Reply-To: <1317717291.25926.13.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Vagin <avagin@gmail.com>

On 10/4/11 1:34 AM, Peter Zijlstra wrote:

>> # cat foo.c
>> #include<unistd.h>
>> #include<time.h>
>> #include<sys/select.h>
>>
>> main()
>> {
>>           struct timespec ts1;
>>           struct timeval tv1;
>>           int i;
>>
>>
>>           for (i = 0; i<  1000; i++) {
>>                   ts1.tv_sec = 0;
>>                   ts1.tv_nsec = 1000000;
>>                   nanosleep(&ts1, NULL);
>>
>>                   tv1.tv_sec = 0;
>>                   tv1.tv_usec = 4000;
>>                   select(0, NULL, NULL, NULL,&tv1);
>>           }
>> }
>>

> Would you per-chance be suffering from this:
>
> http://lkml.kernel.org/r/1317052535-1765247-2-git-send-email-avagin@openvz.org
>

Thanks for the pointer. Yes - Andrew's patches help. But looks like we 
need more user space plumbing like Frederic noted.

perf record -ge sched:sched_stat_sleep -- ./foo

doesn't quite work.

perf record -age sched:sched_stat_sleep -- ./foo

gives me:

    58.62%              foo  [unknown]          [k] 0
                        |
                        --- schedule
                           |
                           |--54.99%-- schedule_hrtimeout_range_clock
                           |          schedule_hrtimeout_range
                           |          poll_schedule_timeout
                           |          do_select
                           |          core_sys_select
                           |          sys_select
                           |          system_call_fastpath
                           |
                           |--44.81%-- do_nanosleep
                           |          hrtimer_nanosleep
                           |          sys_nanosleep
                           |          system_call_fastpath
                            --0.20%-- [...]

i.e. select() should be weighted by 4x vs nanosleep() as confirmed via:

perf script | grep comm=foo

           foo 15516 [006]  2291.187831: sched_stat_sleep: comm=foo 
pid=15516 delay=4054262 [ns]
              foo 15516 [006]  2291.187832: sched_stat_sleep: comm=foo 
pid=15516 delay=4054262 [ns]
              foo 15516 [006]  2291.188895: sched_stat_sleep: comm=foo 
pid=15516 delay=1053565 [ns]
              foo 15516 [006]  2291.188896: sched_stat_sleep: comm=foo 
pid=15516 delay=1053565 [ns]
              foo 15516 [006]  2291.188897: sched_stat_sleep: comm=foo 
pid=15516 delay=1053565 [ns]

Andrew, are you already working on user space patches?

  -Arun
