From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Interrupt caused by software events
Date: Sat, 12 Jul 2014 20:34:15 -0700
Message-ID: <871ttque2w.fsf@tassilo.jf.intel.com>
References: <20140709135418.GB5767@krava.redhat.com>
	<20140711142058.GA27580@gamayun>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25257 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaGMDeP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 12 Jul 2014 23:34:15 -0400
In-Reply-To: <20140711142058.GA27580@gamayun> (Martin Ichilevici de Oliveira's
	message of "Fri, 11 Jul 2014 11:20:58 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org

Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com> writes:
>
> /*******************/
> /* Gets called whenever my program generates a cache-miss */
> void my_func()
> {
>     unsigned long addr = get_ip_that_generated_event();
>     printf("A cache-miss occurred at IP: %x!\n", addr);
> }

This will almost certainly not work with any useful workload.
Just compare the overhead of the instrumentation with the total
run time. The program will be doing nothing but such interrupts
and perf will eventually throttle the interrupts. Besides
PEBS is not designed to catch every event anyways.

If you really want to instrument all cache misses you most likely
want to use some memory trace mechanism and a offline cache model
or a simulator.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
