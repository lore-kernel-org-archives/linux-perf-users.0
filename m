From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Some event modifiers missing from output and desire option to compute value based on measurements
Date: Thu, 13 Mar 2014 10:30:59 -0700
Message-ID: <87siqmf1kc.fsf@tassilo.jf.intel.com>
References: <5321E3AC.8050600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1109 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbaCMRbI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Mar 2014 13:31:08 -0400
In-Reply-To: <5321E3AC.8050600@redhat.com> (William Cohen's message of "Thu,
	13 Mar 2014 12:58:20 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org

William Cohen <wcohen@redhat.com> writes:

> When experimenting with perf I wanted to have separate counts for events in userspace and the kernel.  I used:
>
> $ perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e cache-misses:u -e cache-misses:k make
>
> The associated  output below includes the event modifiers for all the events, but the 3.06 and 0.37 insns per cycles look off.  Shouldn't that instructions:u/cycles:u and instructions:k/cycles:k be the values reported for "insns per cycle"?

Yes the event match code currently assumes there's only a single event
each and always uses the last.

> It appears that the output is listing the measurements in the same
> order they are specified on the command line, but it would be nice if
> the output was clearer on the events being measured.  If I am reading
> the output correctly, the L1-icache-load-misses per instruction is
> pretty poor for kernel-space.  Much of the time I am looking at ratios
> of events and it would be nice if "perf stat" had a way to have it
> compute the ratios directly. Maybe a "-m, --math" option allowing
> algebraic expressions where you could do:

Most people just use -x, and load the result into a spread sheet or
other script that does the compuations. At some point you usually want
to plot the data or do other more complex manipulations than your
simple facility would provide.

You may also find this script useful

https://github.com/andikleen/pmu-tools/blob/master/interval-normalize.py

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
