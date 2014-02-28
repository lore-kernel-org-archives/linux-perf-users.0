From: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: Profile the waiting time for lock or lock stats for one
 application
Date: Fri, 28 Feb 2014 18:43:43 +0000
Message-ID: <20140228184343.GD10080@sdfg.com.ar>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:49830 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbaB1TIy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 14:08:54 -0500
Content-Disposition: inline
In-Reply-To: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Junjie Qian <junjie.qian@yahoo.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Tue, Feb 25, 2014 at 10:13:11AM -0800, Junjie Qian wrote:
> Dear all,
> 
> I am working on one project, which tries to profile the lock stats for one application, such as total waiting time for locks or how many locks happens during the execution.

perf lock wouldn't help with that, IIUC. perf lock is for locks inside the
kernel.

There are ways (not sure if the patch is in) to track for lock contension using
perf, but not sure (I think not easy at least) if the lock is not contended. As,
if using glibc, lot of locks are implemented using futex and then solved
entirely in userspace lot of times (at least without contention).

Also, about stats such as the total waiting time, take into account that if you
have more threads than cores, there WILL be waiting time you can't reduce. For
some experiments I did (with #threads >> #cores) trying to measure waiting time
was pointeless, as that didn't help us in any way. And in some scenarios (cpu
hungry tasks, for example), it's not important to have threads waiting if all
your cores are active "most of the time".

So, for me (for my workloads), the waiting time was pointless and it was WAY
more useful trying to see "wasted" time. As I was trying to optimize a library,
I did some instrumentation on it to get the CPU time used by the library and
compare it against #cores * elapsed_time.





Hope it helps,
Rodrigo
