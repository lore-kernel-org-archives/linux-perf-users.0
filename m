From: Pawel Moll <pawel.moll@arm.com>
Subject: Multi-PMU groups with the perf tool
Date: Tue, 08 Sep 2015 15:30:12 +0100
Message-ID: <1441722612.2212.109.camel@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54732 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618AbbIHOaO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Sep 2015 10:30:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2AF675
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2015 07:30:23 -0700 (PDT)
Received: from hornet (hornet.cambridge.arm.com [10.2.207.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FE9C3F23A
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2015 07:30:14 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Greetings,

I've been recently asked about using "uncore-like" PMUs with "perf
record" command. The issue is that those PMUs are generally
non-sampling, so one can not simply do

# perf record -a -e ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/ sleep 1

as the event_init function will return -EINVAL. In most cases, stat
provides a valid equivalent:

# perf stat -a -e ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/ sleep 1 

providing diff between counter values "before" and "after", but what if
you're looking at something more complex than "sleep 1" and you want to
observe memory system behaviour over time? Of course no one expects the
samples to be correlated with a particular PC, but sampling and
visualising the data with, say, 1ms period can be useful for certain use
cases.

My initial answer was: create a group with a 1ms cpu-clock (so hrtimer)
as a leader and, with PERF_SAMPLE_READ, attach "uncore" children to it.
That way, you'll get uncore counters read every ms.

I know that this works from the kernel point of view, because my custom
tool does exactly this, but I wanted to provide an example using the
standard perf tool (the user, obviously, already had it). So I spent
some time trying to create such a group with the perf tool and, after
going as far as reading the code :-) must admit defeat. What I would
like to do is something along the lines of (with the parenthesis group
syntax being just a product of my imagination ;-)

# perf record -F 1000 -a \
	-e cpu-clock(ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/) \
	sleep 1 

Have I missed something (very likely, given the number of
"not-really-obvious" features of the tool ;-), or is there no way of
creating such a custom group with the perf tool today? It's not a
critique, merely a question.

Cheers!

Pawel
