From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf tools: Work around lack of sched_getcpu in glibc <
 2.6.
Date: Wed, 18 Mar 2015 10:15:27 +0100
Message-ID: <20150318091527.GM23123@twins.programming.kicks-ass.net>
References: <1423879609-4373-1-git-send-email-vlee@twopensource.com>
 <1424119815.32606.14.camel@opteya.com>
 <CAHTgTXVQZDk4Eu8=aVU+fojFNNZ8Fm2aL0W5s0Rmd1aHNe76rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56837 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbbCRJPt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Mar 2015 05:15:49 -0400
Content-Disposition: inline
In-Reply-To: <CAHTgTXVQZDk4Eu8=aVU+fojFNNZ8Fm2aL0W5s0Rmd1aHNe76rQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vinson Lee <vlee@twopensource.com>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>, Yann Droneaud <ydroneaud@opteya.com>

On Tue, Mar 17, 2015 at 04:49:13PM -0700, Vinson Lee wrote:
> On Mon, Feb 16, 2015 at 12:50 PM, Yann Droneaud <ydroneaud@opteya.com> wrote:
> >> +#ifdef __GLIBC_PREREQ
> >> +#if __GLIBC_PREREQ(2, 6)
> >> +#define HAVE_SCHED_GETCPU
> >> +#endif
> >> +#endif

> >> @@ -21,9 +27,13 @@ static int perf_flag_probe(void)
> >>       pid_t pid = -1;
> >>       char sbuf[STRERR_BUFSIZE];
> >>
> >> +#ifdef HAVE_SCHED_GETCPU
> >>       cpu = sched_getcpu();
> >>       if (cpu < 0)
> >>               cpu = 0;
> >> +#else
> >> +     cpu = 0;
> >> +#endif
> >>
> >>       while (1) {
> >>               /* check cloexec flag */

Would it not be much nicer to implement a sched_getcpu() stub that
returns -1 and sets errno to -ENOSYS or something?

That avoids the magic #ifdef mushroom.
