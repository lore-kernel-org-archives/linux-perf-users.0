From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Thu, 19 Mar 2015 10:14:55 -0300
Message-ID: <20150319131455.GE2983@kernel.org>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
 <1426720316-7470-1-git-send-email-vlee@twopensource.com>
 <20150319101304.GC6363@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53923 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbbCSNO7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 Mar 2015 09:14:59 -0400
Content-Disposition: inline
In-Reply-To: <20150319101304.GC6363@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Vinson Lee <vlee@twopensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>

Em Thu, Mar 19, 2015 at 11:13:04AM +0100, Jiri Olsa escreveu:
> On Wed, Mar 18, 2015 at 04:11:52PM -0700, Vinson Lee wrote:
> > This patch fixes this build error with glibc < 2.6.

> > +#ifdef __GLIBC_PREREQ
> > +#if !__GLIBC_PREREQ(2, 6)
> > +static int sched_getcpu(void)
> > +{
> > +	errno = ENOSYS;
> > +	return -1;
> > +}
> > +#endif
> > +#endif
 
> you could mark it as __weak and get rid of those ifdef's
> like we do for strlcpy in utilpath.c

Agreed.

- Arnaldo
