From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf trace: add total time column to summary.
Date: Thu, 6 Aug 2015 10:17:23 -0300
Message-ID: <20150806131723.GD32553@kernel.org>
References: <1438853069-5902-1-git-send-email-milian.wolff@kdab.com>
 <1825374.qTnqrC8ilh@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37333 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752820AbbHFNR0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Aug 2015 09:17:26 -0400
Content-Disposition: inline
In-Reply-To: <1825374.qTnqrC8ilh@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>

Em Thu, Aug 06, 2015 at 11:53:42AM +0200, Milian Wolff escreveu:
> On Thursday 06 August 2015 11:24:29 Milian Wolff wrote:
> <snip>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
 
> I hope this patch is OK. I have some more questions:

It is. I did just minor reflowing, consistency changes to the commit log
message, things I do while reading the patch description, added a
Tested-by: me, as I did more than just compile test and cursory review,
actually taking the time to run it and see the results, etc.

Here it is:

https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=237f0f8d473c6bc1952c649267b8b3be5dbaa5d9
 
> a) Should I always send to linux-kernel and CC linux-perf-users, or is it OK 
> to send it only to linux-perf-users? 

So far, the mailing list for development is
linux-kernel@vger.kernel.org, so please keep it on the CC list.

Keeping linux-perf-users@vger.kernel.org may reach people that can't
stand the volume of lkml tho.
 
> b) Should I put you explicitly into the CC, I recon you also read the mailing 
> lists?

Yes, you should, that way it'll go to my main inbox, in addition to the
list folder.

No need to put me, or Ingo or PeterZ on the patch description CC list,
just on the e-mail CC list.

There are people who work on each tool from time to time, so sometimes
its a good idea to do a 'git blame' in the parts of the code you change
to add them to the CC list, both in the e-mail and in the patch
description.

In the e-mail because we want them to straight away receive a
notification that changes are being made in areas they worked on, and in
the CC list in the description message because we want to have that
documented in the source code repository (hey, they were warned!).

My scripts will pick whoever is in the CC list in the e-mail to add them
to the CC list in the commit log, but this only when I process directly
from e-mail.

Preferably those rules are followed by whoever asks me to apply patches,
so that, for frequent contributors we can eventually work on a 'git
pull' way.

I.e. you post patches to the mailing list together with a "git
request-pull" generated cover letter that provides instructions for me
to do a 'git pull' from some publicly accessible git server, preferably
hosted at git.kernel.org, but that, again, for frequent patch submitters
that follow these rules.
 
> c) Should I add more people to the CC list? The get_maintainer script also 
> lists Ingo Molnar and Peter Zijlstra, but your recent patch set has them not 
> in the CC list.

Well, everything will go thru Ingo anyway, having them in the e-mail CC
list may get their attention before I send the patches to Ingo for
pulling, which may help speed up the process, if they have concerns or
suggestions.
 
> d) My patch has some warnings according to checkpatch, because some lines are 
> too long. Is this very frowned upon in the Kernel? It would make the table 

I don't care that much about this one, i.e. long lines. Avoid them when
you can, don't spend too much on it tho.

> much harder to read when I split it onto multiple lines, but of course I can 

Right, it is ok in this case.

> amend that if you want it.
> 
> If I messed up anything else, please tell me.

Nope, take a look at the stylistic stuff I did on the patch comment log,
adopt whatever you think is sensible, thanks for taking the time to ask
these questions and follow the coding style.

- Arnaldo
