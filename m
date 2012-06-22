From: David Ahern <dsahern@gmail.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Fri, 22 Jun 2012 13:23:16 -0600
Message-ID: <4FE4C624.20908@gmail.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com> <4FE49663.7000908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57855 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2FVTXT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jun 2012 15:23:19 -0400
Received: by dady13 with SMTP id y13so2718964dad.19
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 12:23:19 -0700 (PDT)
In-Reply-To: <4FE49663.7000908@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org

On 6/22/12 9:59 AM, Maynard Johnson wrote:
> The 'perf record' tool can easily handle a sampling rate of one sample per 100,000 cycles *or* instructions (i.e., one at a time), so I would have expected it to be handle one sample per 500,000 events when profiling on both events?  Am I missing something?
>
> Another related issue is the number of samples being recorded varies wildly when profiling on multiple events.  For example, profiling on just cycles with --count=500000, 'perf report -n' reports ~87k samples.  And profiling on just instructions with the same rate, I get ~102k.  When profiling with both events, I get cycles/instruction sample counts ranging from a low of 6k/7k to a high of 88k/102k.  Usually, I get counts around 12k/15k.  The higher the count seen with 'perf report' (i.e., the closer to true values), the more likely that perf record fails with the "LOST" samples message.


It might well be a RHEL6 problem.

Host OS is 3.4.0
perf version 3.5.rc1.87.gcb9dd4.dirty

Using Peter Z's 1billion instruction, first up is instructions sampling:
$ perf record -fo /tmp/perf.data -e instructions -c 100000 
./loop_1b_instructions

$ perf report --stdio -i /tmp/perf.data -D | tail -12
Aggregated stats:
            TOTAL events:      10161
             MMAP events:        106
             COMM events:          2
             EXIT events:          2
           SAMPLE events:      10051
instructions stats:
            TOTAL events:      10161
             MMAP events:        106
             COMM events:          2
             EXIT events:          2
           SAMPLE events:      10051

1billion instructions sampled every 100,000 = ~10,000 samples which 
corresponds to the above (ish).

And now looking at cycles:

$ perf record -fo /tmp/perf.data -e cycles -c 100000 ./loop_1b_instructions
$ perf report --stdio -i /tmp/perf.data -D | tail -12
Aggregated stats:
            TOTAL events:       7961
             MMAP events:        106
             COMM events:          2
             EXIT events:          2
           SAMPLE events:       7851
cycles stats:
            TOTAL events:       7961
             MMAP events:        106
             COMM events:          2
             EXIT events:          2
           SAMPLE events:       7851


And both events combined:
$ perf record -fo /tmp/perf.data -e cycles -e instructions -c 100000 
./loop_1b_instructions

$ /tmp/pbuild/perf report --stdio -i /tmp/perf.data -D | tail -15
Aggregated stats:
            TOTAL events:      18078
             MMAP events:        106
             COMM events:          2
             EXIT events:          2
           SAMPLE events:      17968
cycles stats:
            TOTAL events:       7900
             MMAP events:          4
             COMM events:          1
             EXIT events:          2
           SAMPLE events:       7893
instructions stats:
            TOTAL events:      10075
           SAMPLE events:      10075

So we get ~10,000 samples due to the instructions event and ~7800 for 
the cycles event.

David
