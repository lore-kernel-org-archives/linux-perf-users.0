From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: More details about submitting pull requests to upstream was: Re:
 [PATCH] perf trace: add total time column to summary.
Date: Thu, 6 Aug 2015 23:05:59 -0300
Message-ID: <20150807020559.GB21348@kernel.org>
References: <1438853069-5902-1-git-send-email-milian.wolff@kdab.com>
 <1825374.qTnqrC8ilh@milian-kdab2>
 <20150806131723.GD32553@kernel.org>
 <55C40A7D.40506@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49501 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755363AbbHGCGE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Aug 2015 22:06:04 -0400
Content-Disposition: inline
In-Reply-To: <55C40A7D.40506@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>

Em Fri, Aug 07, 2015 at 09:31:41AM +0800, Wangnan (F) escreveu:
> On 2015/8/6 21:17, Arnaldo Carvalho de Melo wrote:
> >Em Thu, Aug 06, 2015 at 11:53:42AM +0200, Milian Wolff escreveu:
> >>On Thursday 06 August 2015 11:24:29 Milian Wolff wrote:
> >><snip>
> >>>Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >>>Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> >>I hope this patch is OK. I have some more questions:
> >It is. I did just minor reflowing, consistency changes to the commit log
> >message, things I do while reading the patch description, added a
> >Tested-by: me, as I did more than just compile test and cursory review,
> >actually taking the time to run it and see the results, etc.
> >
> >Here it is:
> >
> >https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=237f0f8d473c6bc1952c649267b8b3be5dbaa5d9
> >>a) Should I always send to linux-kernel and CC linux-perf-users, or is it OK
> >>to send it only to linux-perf-users?
> >So far, the mailing list for development is
> >linux-kernel@vger.kernel.org, so please keep it on the CC list.
> >
> >Keeping linux-perf-users@vger.kernel.org may reach people that can't
> >stand the volume of lkml tho.
> >>b) Should I put you explicitly into the CC, I recon you also read the mailing
> >>lists?
> >Yes, you should, that way it'll go to my main inbox, in addition to the
> >list folder.
> >
> >No need to put me, or Ingo or PeterZ on the patch description CC list,
> >just on the e-mail CC list.
> >
> >There are people who work on each tool from time to time, so sometimes
> >its a good idea to do a 'git blame' in the parts of the code you change
> >to add them to the CC list, both in the e-mail and in the patch
> >description.
> >
> >In the e-mail because we want them to straight away receive a
> >notification that changes are being made in areas they worked on, and in
> >the CC list in the description message because we want to have that
> >documented in the source code repository (hey, they were warned!).
> >
> >My scripts will pick whoever is in the CC list in the e-mail to add them
> >to the CC list in the commit log, but this only when I process directly
> >from e-mail.
> >
> >Preferably those rules are followed by whoever asks me to apply patches,
> >so that, for frequent contributors we can eventually work on a 'git
> >pull' way.
> >
> >I.e. you post patches to the mailing list together with a "git
> >request-pull" generated cover letter that provides instructions for me
> >to do a 'git pull' from some publicly accessible git server, preferably
> >hosted at git.kernel.org, but that, again, for frequent patch submitters
> >that follow these rules.
> 
> Thank you to CC-ing me this mail. I have a further question: shall I keep
> Cc list in commit log in my git tree commits, and remove then when
> I send them to mailing list?

Keep the CC list, as it will be used when you do:

  git format-patch -n --cover-letter tip/perf/core..

Then you'll create a signed tag with:

git tag -u 5352AA40 perf-core-for-mingo

Edit 0000-cover-letter, to include the output of:

  git request-pull tip/perf/core git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-core-for-mingo >> 0000-cover-letter.patch

Replace 'perf-core-for-mingo' with a suitable name, perhaps
'perf-bpf-for-acme', or something to that effect.

You will use that gpg key that you created to get access to the
kernel.org account.

- Arnaldo
