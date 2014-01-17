From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Sat, 18 Jan 2014 00:37:32 +0100
Message-ID: <1390001852.8555.8.camel@nb-andreolini>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <87d2jq1i7q.fsf@tassilo.jf.intel.com>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:42415 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaAQXhi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jan 2014 18:37:38 -0500
Received: by mail-ea0-f178.google.com with SMTP id a15so880927eae.23
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2014 15:37:35 -0800 (PST)
In-Reply-To: <87d2jq1i7q.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Il giorno ven, 17/01/2014 alle 12.11 -0800, Andi Kleen ha scritto:
> Mauro Andreolini <mauro.andreolini@gmail.com> writes:
> > file to get perf report to print the function names.
> > Is this expected behaviour? How do I get perf to automatically extract
> > symbols from compressed files?
> 
> Someone would need to write the code to do that I guess.
OK.

> >
> > To which function would 0x7facc1df12a0 match? It does not even seem to
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
