From: Mauro Andreolini <mauro.andreolini@unimore.it>
Subject: Re: Two questions on perf dwarf callchains
Date: Sat, 18 Jan 2014 00:42:52 +0100
Message-ID: <1390002172.9768.1.camel@nb-andreolini>
Reply-To: mauro.andreolini@unimore.it
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp7.sms.unimo.it ([155.185.44.150]:54042 "EHLO
	smtp7.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbaARAIu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jan 2014 19:08:50 -0500
Received: from host50-39-dynamic.1-87-r.retail.telecomitalia.it ([87.1.39.50]:55101 helo=[192.168.1.5])
	by smtp7.sms.unimo.it with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mauro.andreolini@unimore.it>)
	id 1W4J3t-0000DT-SY
	for linux-perf-users@vger.kernel.org; Sat, 18 Jan 2014 00:42:54 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

[Sorry for the repost, I can't see my reply in the gmane interface]

Il giorno ven, 17/01/2014 alle 12.11 -0800, Andi Kleen ha scritto:
> Mauro Andreolini <mauro.andreolini@gmail.com> writes:
> > file to get perf report to print the function names.
> > Is this expected behaviour? How do I get perf to automatically
extract
> > symbols from compressed files?
> 
> Someone would need to write the code to do that I guess.
OK.

> >
> > To which function would 0x7facc1df12a0 match? It does not even seem
to
> > be in the mapped address space of "ls". I am clueless.
> 
> The unwinder got confused. A common cause is incomplete or partially
> broken dwarf unwind information. May be a compiler problem.
Thanks for your time. Right now I am using gcc 4.8.2 20131219
(prerelease) and libunwind 1.1. I noticed the following
compile flags: "-O2 -g -fvar-tracking-assignments". I thought that
maybe optimizations like function inlining and the like would not play
together with debugging info, so I changed them to "-Og -g3
-fvar-tracking-assignments" and recompiled anything, albeit with no
luck. I must be missing something big here. How can I be sure to give
correct dwarf unwind information?

Mauro
