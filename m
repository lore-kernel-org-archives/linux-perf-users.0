From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Fri, 20 Mar 2015 17:38:28 -0300
Message-ID: <20150320203828.GN16485@kernel.org>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
 <1426720316-7470-1-git-send-email-vlee@twopensource.com>
 <20150319101304.GC6363@krava>
 <20150319131455.GE2983@kernel.org>
 <CAHTgTXUQVuxf5u_AZ9g-eLtwdrE4rGfiN5cCHA5ReMe0sObiBA@mail.gmail.com>
 <20150320130313.GB16485@kernel.org>
 <CAHTgTXUqBj9rE8yXm=XtzhKC0G+H-ZYuhG5GZpk858p0=Egc2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44866 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbbCTUj4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Mar 2015 16:39:56 -0400
Content-Disposition: inline
In-Reply-To: <CAHTgTXUqBj9rE8yXm=XtzhKC0G+H-ZYuhG5GZpk858p0=Egc2g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vinson Lee <vlee@twopensource.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>

Em Fri, Mar 20, 2015 at 11:44:42AM -0700, Vinson Lee escreveu:
> On Fri, Mar 20, 2015 at 6:03 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > So for strlcpy we have in tools/perf/util/cache.h:

> > #ifndef __UCLIBC__
> > /* Matches the libc/libbsd function attribute so we declare this
> >  * unconditionally: */
> > extern size_t strlcpy(char *dest, const char *src, size_t size);
> > #endif

> > I.e. have the ifdef just in the header file.

This part you didn't take into account, the __weak marked part is ok,
the linker will DTRT with that, its just the redeclaration part that
needs to get out of the way, enclose that under appropriate ifdef, i.e.
one that is associated with the libc where that file first appeared and
that has been present since then.

- Arnaldo

> > This way, if we end up needing to use sched_getcpu elsewhere, it will
> > work and the needed #ifdef will be constrained to the header file.
 
> I tried moving the prototype to a header file and it does not compile
> with newer glibc for me either. I still get a "redundant
> redeclaration" compiler error.
 
> Here is the diff that I tried.
 
> diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
> @@ -7,6 +7,12 @@
> 
>  static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
> 
> +int __weak sched_getcpu(void)
> +{
> +       errno = ENOSYS;
> +       return -1;
> +}
> +
>  static int perf_flag_probe(void)
>  {
>         /* use 'safest' configuration as used in perf_evsel__fallback() */
> diff --git a/tools/perf/util/cloexec.h b/tools/perf/util/cloexec.h
> @@ -3,4 +3,6 @@
> 
>  unsigned long perf_event_open_cloexec_flag(void);
> 
> +extern int sched_getcpu(void) __THROW;
> +
>  #endif /* __PERF_CLOEXEC_H */
