From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Bizarre results from perf event API
Date: Sun, 22 Feb 2015 15:37:13 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1502221530290.26008@vincent-weaver-1.umelst.maine.edu>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com> <54E7D3B3.7020108@gmail.com> <CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com> <alpine.DEB.2.11.1502211758120.24085@vincent-weaver-1.umelst.maine.edu>
 <CAAk6P0V0QyCtBTi+zULhK_wwSQLN3xsLZq0uXWaBFkjar3BmWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:38161 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbBVUdl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 22 Feb 2015 15:33:41 -0500
Received: by mail-qa0-f44.google.com with SMTP id n8so19609612qaq.3
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Feb 2015 12:33:40 -0800 (PST)
In-Reply-To: <CAAk6P0V0QyCtBTi+zULhK_wwSQLN3xsLZq0uXWaBFkjar3BmWQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On Sun, 22 Feb 2015, Benjamin Moody wrote:

> On 2/21/15, Vince Weaver <vincent.weaver@maine.edu> wrote:
> > On Sat, 21 Feb 2015, Benjamin Moody wrote:
> >
> >
> >> there are grandchild processes involved.  (And I can't help thinking
> >> the first version is a lot more elegant!)  Does the kernel somehow get
> >> confused because enable_on_exec is set and the original process hasn't
> >> actually exec'ed anything?
> >
> > Have you tried enabling the "inherit_stat" flag to see if that helps?
> 
> That does seem to help for the simple case I posted.  It doesn't work
> in all cases, though.  I'll have to experiment a bit to find a simple
> example.
> 
> My impression was that the inherit_stat bit shouldn't matter if we are
> only interested in aggregate event counts, as opposed to counting
> events per thread (found a ML thread about this a while ago but I
> can't find it right now.)  Please correct me if I'm wrong.  In any
> case, though, the perf tool doesn't use that bit.

If you can come up with a coherent explanation of what the inherit_stat 
bit does I'll be glad to add it to the manpage.

From what I vaguely understand it has to do with when a read() happens 
whether you bother to iterate all children and get updated event counts 
from them rather than just using the value from the last time they context 
switched.  I probably have that all mixed up though.

It's true perf doesn't use that bit, but I thought we already established 
that your code doesn't start a process the same way that perf does.

I am interesting in seeing if we can get to the bottom of this issue, as 
I've had users report issues when trying to measure OpenMP programs, 
though I'm not sure if they're seeing the exact same problem.

Vince
