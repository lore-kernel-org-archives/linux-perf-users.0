From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf script branch stack output
Date: Thu, 29 Oct 2015 17:33:13 -0300
Message-ID: <20151029203313.GG2923@kernel.org>
References: <CAJh9x3ocJtpNf7+ZNcRkB4=68im0mr-aYmZ=jTnWqrcsnu=7Vg@mail.gmail.com>
 <20151029153307.GC2923@kernel.org>
 <20151029153525.GD2923@kernel.org>
 <CABPqkBQ98pZATj9hgTT=-FRjSrGBGoT-4cgbDHk=M_9Gvc6H2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56755 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbbJ2UdR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Oct 2015 16:33:17 -0400
Content-Disposition: inline
In-Reply-To: <CABPqkBQ98pZATj9hgTT=-FRjSrGBGoT-4cgbDHk=M_9Gvc6H2g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org

Em Thu, Oct 29, 2015 at 10:59:40AM -0700, Stephane Eranian escreveu:
> On Thu, Oct 29, 2015 at 8:35 AM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Thu, Oct 29, 2015 at 12:33:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Oct 29, 2015 at 10:14:49AM -0400, Yuanfang Chen escreveu:
> >> > There is a patch to output branch stack here.
> >> > https://lkml.org/lkml/2015/8/31/315. Any reason it is still not
> >> > committed? I'm going to use the patch on my machine. Just want to make
> >> > sure. Thank you.
> >>
> >> Read the thread, Stephane said he would send a v2, probably I saw that I
> >> refrained from applying it, waiting for such v2, I'm checking if it
> >> applies cleanly now, if it does I'll apply it as-is.
> >
> > It does, applied to my perf/core branch, will go upstream in my next
> > pull request to Ingo, thanks for pointing this out!
> >
> I posted V2 a long time ago. Glad to see it eventually made it!

Ok, I checked that one and saw Andi made some questions about it, but
the thread died down, I am applying v2 then, this one, to make sure I
got the right one:

http://lkml.kernel.org/r/1441039273-16260-5-git-send-email-eranian@google.com

Thanks,

- Arnaldo
