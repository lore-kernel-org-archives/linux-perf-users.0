From: Andi Kleen <andi@firstfloor.org>
Subject: Re: user-defined static trace points
Date: Tue, 01 Mar 2016 11:18:52 -0800
Message-ID: <871t7unh0j.fsf@tassilo.jf.intel.com>
References: <5632782.TcXtSY8oxg@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22299 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbcCATS4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2016 14:18:56 -0500
In-Reply-To: <5632782.TcXtSY8oxg@milian-kdab2> (Milian Wolff's message of
	"Tue, 01 Mar 2016 16:53:27 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>, Hemant Kumar <hkshaw@linux.vnet.ibm.com>

Milian Wolff <milian.wolff@kdab.com> writes:

> Hey all,
>
> I'm aware that we can add custum user-defined dynamic trace points using `perf 
> probe`. But this is unwieldy for some larger applications, esp. if we 
> recompile them often. Is there a public API (that I could not find so far), to 
> define static trace points in userspace code?
>
> I found
> http://www.brendangregg.com/blog/2015-07-03/hacking-linux-usdt-ftrace.html
> which references https://www.sourceware.org/systemtap/wiki/
> AddingUserSpaceProbingToApps for systemtap, but on my machine I don't have a 
> <sys/sdt.h> header.

You need to install systemtap-devel or similar.

> Would such trace points be useable by perf? https://
> lwn.net/Articles/570818/ doesn't seem to be included, i.e. I don't have `perf 
> probe --markers` with a recent build of perf.

There is a patch to teach perf about SDT probes, but so far it has not
been integrated. You can use them from systemtap or gdb though.

https://lwn.net/Articles/569622/

Perhaps Hemant needs to resubmit?


>
> If someone could point me into the right direction, that would be highly 
> appreciated. I would also like to know about the performance impact of adding 
> static trace points to code. If it is low, I'd then try to add such trace 
> points to Qt upstream in some GUI related areas, e.g. to investigate FPS or 
> similar.

When they are disabled they are just nops (so basically free)
When enabled it is an exception so not super cheap.

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only
