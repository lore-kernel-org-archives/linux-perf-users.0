From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Problem when profiling a process' running/sleeping/waiting time
Date: Mon, 17 Jun 2013 17:20:03 +1000
Message-ID: <1371453603.549.6.camel@concordia>
References: <50ED4CE0.7050201@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50453 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab3FQHUH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Jun 2013 03:20:07 -0400
In-Reply-To: <50ED4CE0.7050201@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Victor Jimenez <victor.javier@bsc.es>
Cc: linux-perf-users@vger.kernel.org

On Wed, 2013-01-09 at 11:56 +0100, Victor Jimenez wrote:
> I am trying to profile a process in terms of running, sleeping and 
> waiting time. I am using kernel 3.6.6 running on an IBM POWER7 machine. 
> Initially, I decided to use a toy example where I would expect that the 
> process remains in running state most of the time. This is the code for 
> such a simple example:
> 
> int main() {
>      for (int i = 0; i < 1000000; i++)
>          for (int j = 0; j < 1000; j++);
> }
> 
> I am using the following command line for reading kernel stats:
> 
> perf stat -e 
> "sched:sched_stat_runtime,sched:sched_stat_sleep,sched:sched_stat_wait, \
>      sched:sched_stat_iowait,sched:sched_stat_blocked" ./test
> 
> And these are the results that I obtain:
> 
>   Performance counter stats for './test':
> 
>      12,077,957,756 sched:sched_stat_runtime
>     169,892,740,990 sched:sched_stat_sleep
>           5,816,784 sched:sched_stat_wait
>                   0 sched:sched_stat_iowait
>                   0 sched:sched_stat_blocked
> 
>       12.084706279  seconds time elapsed
> 
> I cannot really understand why the counter for sched_stat_sleep is so 
> high (even higher than sched_stat_runtime), especially for such a 
> CPU-bound workload.
> 
> Am I missing anything, or there could be a problem with sched_stat_sleep 
> counter?

Hi Victor,

Did you ever work out what was going on here?

cheers
