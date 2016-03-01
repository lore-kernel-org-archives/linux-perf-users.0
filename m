From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: Multi-PMU groups with the perf tool
Date: Tue, 01 Mar 2016 17:22:07 +0000
Message-ID: <1456852927.22102.88.camel@arm.com>
References: <1441722612.2212.109.camel@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52763 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbcCARWO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2016 12:22:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC44749
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Mar 2016 09:21:14 -0800 (PST)
Received: from hornet (hornet.cambridge.arm.com [10.2.206.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3793F25E
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Mar 2016 09:22:09 -0800 (PST)
In-Reply-To: <1441722612.2212.109.camel@arm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm sure there's a medical name for answering own questions,
particularly after 6 months, but hey, it may help someone else :-)

On Tue, 2015-09-08 at 15:30 +0100, Pawel Moll wrote:
> My initial answer was: create a group with a 1ms cpu-clock (so
> hrtimer)
> as a leader and, with PERF_SAMPLE_READ, attach "uncore" children to
> it.
> That way, you'll get uncore counters read every ms.
> 
> I know that this works from the kernel point of view, because my
> custom
> tool does exactly this, but I wanted to provide an example using the
> standard perf tool (the user, obviously, already had it). So I spent
> some time trying to create such a group with the perf tool and, after
> going as far as reading the code :-) must admit defeat. What I would
> like to do is something along the lines of (with the parenthesis
> group
> syntax being just a product of my imagination ;-)
> 
> # perf record -F 1000 -a \
> 	-e cpu
> -clock(ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/) \
> 	sleep 1 
> 
> Have I missed something (very likely, given the number of
> "not-really-obvious" features of the tool ;-), or is there no way of
> creating such a custom group with the perf tool today? It's not a
> critique, merely a question.

By pure accident I finally realised it is - in principle - possible
with the existing tool. The incantation would look like this (skipped
the "ccn/xp_valid_flit.../" event for the sake of line length):


# perf record -a -e '{cpu-clock,ccn/cycles/}:S' sleep 1


only it still doesn't work, failing -EINVAL. After some digging I've
realised the reason - the tool tries to create such a group on each of
the CPUs, because I've asked for it with -a, right? Only that "uncore"
events like "ccn/cycles/" are to be pinned to a single CPU and to
communicate this they export "cpumask" sysfs attribute. Let's have a
look:


# cat /sys/bus/event_source/devices/ccn/cpumask
3


And now, if we try to run the command above with some verbosity:

# perf record -vv -a -e '{cpu-clock,ccn/cycles/}:S' sleep 1
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|ID|CPU|PERIOD
  read_format                      ID|GROUP
  disabled                         1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             112
  config                           0xff00
  sample_type                      IP|TID|TIME|READ|ID|CPU|PERIOD
  read_format                      ID|GROUP
  freq                             1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 3  group_fd 4  flags 0x8
sys_perf_event_open failed, error -22


The tool seemingly did the right thing and requested the "ccn" event on
CPU3 for group 4, being the "cpu-clock" event on CPU0, only it's not
allowed. The perf core has this check:


			/*
			 * Make sure we're both events for the same CPU;
			 * grouping events for different CPUs is broken; since
			 * you can never concurrently schedule them anyhow.
			 */
			if (group_leader->cpu != event->cpu)
				goto err_context;


If I now, instead of doing "-a" request two CPUs in the right order, I
get the proof:


# perf record -vv -C3,0 -e '{cpu-clock,ccn/cycles/}:S' sleep 1
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|ID|CPU|PERIOD
  read_format                      ID|GROUP
  disabled                         1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             112
  config                           0xff00
  sample_type                      IP|TID|TIME|READ|ID|CPU|PERIOD
  read_format                      ID|GROUP
  freq                             1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 3  group_fd 4  flags 0x8
sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
sys_perf_event_open failed, error -22


Everything works fine for the first group, created on CPU3 and then
fails for the second one. Interestingly it seems that in this case the
tool ignores "cpumask" and tries to create the "ccn" event on CPU0. The
thing is that the "cpu" argument gets overridden by the driver to match
the "cpumask" value and we're back in square one.

So finally, if I only run record on the single, correct CPU, it works:


# perf record -C3 -e '{cpu-clock,ccn/cycles/}:S' sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.330 MB perf.data (1874 samples) ]


Only it's not exactly what I wanted (I want system wide CPU data - with
other events in the list - with the uncore events included in it at
regular intervals)... The obvious "fix" for it would be making sure the
tool does not create "cpumask"ed events in group belonging to a "wrong"
CPU, but whether it's the correct solution, I'm not sure yet.

Comments welcome, silence won't be taken as an offence ;-)

Pawel
