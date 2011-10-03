From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Mon, 3 Oct 2011 14:53:09 -0700
Message-ID: <4E8A2EC5.1030901@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60368 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751301Ab1JCVxY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Oct 2011 17:53:24 -0400
In-Reply-To: <1317673027.20367.41.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>

On 10/3/11 1:17 PM, Peter Zijlstra wrote:
> On Mon, 2011-10-03 at 12:38 -0700, Arun Sharma wrote:
>>                           trace_sched_stat_sleep(tsk, delta);
>
> That one should be accessible as a tracepoint and will add delay to
> count on each occurrence.

Right - the tracepoint seems to work. Was looking for the user stack 
trace as well. For eg:

# cat foo.c
#include <unistd.h>
#include <time.h>
#include <sys/select.h>

main()
{
         struct timespec ts1;
         struct timeval tv1;
         int i;


         for (i = 0; i < 1000; i++) {
                 ts1.tv_sec = 0;
                 ts1.tv_nsec = 1000000;
                 nanosleep(&ts1, NULL);

                 tv1.tv_sec = 0;
                 tv1.tv_usec = 4000;
                 select(0, NULL, NULL, NULL, &tv1);
         }
}

I want something that gives me 4 times as many samples on select() as 
nanosleep().

perf record -g -e sched:sched_stat_sleep -- ./foo

doesn't seem to do it. Additionally, if I have a burn_1us_cpu() loop in 
there, I'd expect to see as many samples as nanosleep() in the wall 
clock profile.

  -Arun
