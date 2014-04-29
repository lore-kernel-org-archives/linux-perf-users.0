From: Milian Wolff <mail@milianw.de>
Subject: Re: access function parameters with DWARF-less perf probing
Date: Tue, 29 Apr 2014 17:48:48 +0200
Message-ID: <1580318.2NC4tQu7qN@milian-kdab2>
References: <CANHDG4btxwQxGme+TwWYhPVEKSwyHA_C3fVxNuaFJOrzGYOyCA@mail.gmail.com> <87iopzb8vw.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:52798 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbaD2P6n (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Apr 2014 11:58:43 -0400
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id C52F96280566
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2014 17:48:48 +0200 (CEST)
In-Reply-To: <87iopzb8vw.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Wednesday 23 April 2014 22:21:07 Andi Kleen wrote:
> Jun Wang <junwang123@gmail.com> writes:
> > Hi Everyone,
> > 
> > With systemTap, in the absence of debugging information (DWARF), one
> > can access function parameters using (positional) numbers. Can the
> > same be done with `perf`?
> > Why? I'm trying to capture variables in a kernel function but I don't
> > have an good perf with DWARF support and there is are significant
> > challenges to build one due to the relatively old distro.
> 
> You can specify the registers according to the ABI.
> di = 1. arg, si = 2nd arg etc.

As I did not directly figure out how one can make use of this, here's what I 
found out:

You'll have to define a tracepoint which catches the function callback:

perf probe -x /usr/lib/libc.so.6 --add malloc="malloc size=%di"

Then, you can access the argument, e.g. perf script -g for a perf.data 
generated with the above tracepoint will contain something like this:

def probe_libc__malloc(event_name, context, common_cpu,
        common_secs, common_nsecs, common_pid, common_comm,
        __probe_ip, size):

Note the "size" argument. Similarly, you could catch the return value like 
this:

perf probe -x /usr/lib/libc.so.6 --add malloc_return="malloc%return 
ret=\$retval"

leading to:

def probe_libc__malloc_return(event_name, context, common_cpu,
        common_secs, common_nsecs, common_pid, common_comm,
        __probe_func, __probe_ret_ip, ret):

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
