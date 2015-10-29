From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf script branch stack output
Date: Thu, 29 Oct 2015 12:35:25 -0300
Message-ID: <20151029153525.GD2923@kernel.org>
References: <CAJh9x3ocJtpNf7+ZNcRkB4=68im0mr-aYmZ=jTnWqrcsnu=7Vg@mail.gmail.com>
 <20151029153307.GC2923@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41430 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756855AbbJ2Pf3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Oct 2015 11:35:29 -0400
Content-Disposition: inline
In-Reply-To: <20151029153307.GC2923@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: Stephane Eranian <eranian@google.com>, linux-perf-users@vger.kernel.org

Em Thu, Oct 29, 2015 at 12:33:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Oct 29, 2015 at 10:14:49AM -0400, Yuanfang Chen escreveu:
> > There is a patch to output branch stack here.
> > https://lkml.org/lkml/2015/8/31/315. Any reason it is still not
> > committed? I'm going to use the patch on my machine. Just want to make
> > sure. Thank you.
> 
> Read the thread, Stephane said he would send a v2, probably I saw that I
> refrained from applying it, waiting for such v2, I'm checking if it
> applies cleanly now, if it does I'll apply it as-is.

It does, applied to my perf/core branch, will go upstream in my next
pull request to Ingo, thanks for pointing this out!

- Arnaldo
