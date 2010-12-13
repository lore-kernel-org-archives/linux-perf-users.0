From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 12:25:03 -0200
Message-ID: <20101213142503.GG5407@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m2wrnernw3.fsf@gmail.com>
 <20101213125837.GB5407@ghostprotocols.net>
 <m2sjy1stuf.fsf@gmail.com>
 <4D0627F4.1030605@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44224 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0LMOZK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 09:25:10 -0500
Received: by yxt3 with SMTP id 3so3271353yxt.19
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 06:25:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0627F4.1030605@hitachi.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

Em Mon, Dec 13, 2010 at 11:04:36PM +0900, Masami Hiramatsu escreveu:
> (2010/12/13 22:08), Francis Moreau wrote:
> > Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> > 
> >> Em Mon, Dec 13, 2010 at 11:02:52AM +0100, Francis Moreau escreveu:
> >>> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> >>>> Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
> >>>>> I'm trying to use perf-probe(1) with the latest F14 kernel
> >>>>> (2.6.35.9-64.fc14.x86_64).
> >>
> >>>>> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
> >>>>> contains the running vmlinux image AFAICT.

> > The primarily concern here, is that the running kernel has a different
> > build-id than the debug image installed by the corresponding debug
> > package.
> > 
> > I think it's a distrib issue, hence my question about Fedora report.
> 
> Yes, that is just for fedora people who can easily check
> how to reproduce and make sure the problem is here.
> Then they can try to solve the problem until the issue
> is resolved.

I just tried it, works for me.

I added the sequence of commands, perhaps he can find where the problem
lies following them.

- Arnaldo
