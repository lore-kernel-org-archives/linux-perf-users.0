From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Tue, 24 Feb 2015 00:46:05 +0000
Message-ID: <CAAk6P0U_tg+LEVPOoVf4h1y9n-Vt3FXV8hb+B-kk4iW-8WRxkw@mail.gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
	<54E7D3B3.7020108@gmail.com>
	<CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
	<alpine.DEB.2.11.1502211758120.24085@vincent-weaver-1.umelst.maine.edu>
	<CAAk6P0V0QyCtBTi+zULhK_wwSQLN3xsLZq0uXWaBFkjar3BmWQ@mail.gmail.com>
	<alpine.DEB.2.11.1502221530290.26008@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41583 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbBXAqH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Feb 2015 19:46:07 -0500
Received: by iecrd18 with SMTP id rd18so28086280iec.8
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2015 16:46:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1502221530290.26008@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

> If you can come up with a coherent explanation of what the inherit_stat
> bit does I'll be glad to add it to the manpage.
>
> From what I vaguely understand it has to do with when a read() happens
> whether you bother to iterate all children and get updated event counts
> from them rather than just using the value from the last time they context
> switched.  I probably have that all mixed up though.

Sorry, I can't make sense of it either.

This must be the thread I was thinking of (I see you're the original author):
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg01014.html

> It's true perf doesn't use that bit, but I thought we already established
> that your code doesn't start a process the same way that perf does.

True.  But if inherit_stat is necessary in order to get accurate
results in some circumstances, then perhaps perf should be using it as
well.


I'm starting to see where the problem might be with my original
understanding of the event counter system.  I was thinking of an event
counter as a thing that could be turned on and off on a per-process
basis, so it made sense to think that 'enable_on_exec' would enable
the counter for only the processes that were descended from the one
that did the exec.  But that's not really the right model, is it?
PERF_EVENT_IOC_ENABLE and PERF_EVENT_IOC_DISABLE seem to apply to the
entire set of processes that have inherited the counter.  So if
"enabled" and "disabled" are global states associated with the
counter, rather than with individual processes, then it's silly to
think of using enable_on_exec to limit by process.  The fact that it
seems to work in many cases, then, may be an accident.

Or I could be talking complete nonsense here.

Benjamin
