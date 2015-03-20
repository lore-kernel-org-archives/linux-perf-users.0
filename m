From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Fri, 20 Mar 2015 10:03:13 -0300
Message-ID: <20150320130313.GB16485@kernel.org>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
 <1426720316-7470-1-git-send-email-vlee@twopensource.com>
 <20150319101304.GC6363@krava>
 <20150319131455.GE2983@kernel.org>
 <CAHTgTXUQVuxf5u_AZ9g-eLtwdrE4rGfiN5cCHA5ReMe0sObiBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHTgTXUQVuxf5u_AZ9g-eLtwdrE4rGfiN5cCHA5ReMe0sObiBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Mar 19, 2015 at 02:12:05PM -0700, Vinson Lee escreveu:
> On Thu, Mar 19, 2015 at 6:14 AM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Thu, Mar 19, 2015 at 11:13:04AM +0100, Jiri Olsa escreveu:
> >> On Wed, Mar 18, 2015 at 04:11:52PM -0700, Vinson Lee wrote:
> >> > This patch fixes this build error with glibc < 2.6.
> >
> >> > +#ifdef __GLIBC_PREREQ
> >> > +#if !__GLIBC_PREREQ(2, 6)
> >> > +static int sched_getcpu(void)
> >> > +{
> >> > +   errno = ENOSYS;
> >> > +   return -1;
> >> > +}
> >> > +#endif
> >> > +#endif
> >
> >> you could mark it as __weak and get rid of those ifdef's
> >> like we do for strlcpy in utilpath.c
> >
> > Agreed.
 
> I tried this approach but am having trouble getting a patch to compile
> with both older glibc and recent glibc.
 
> With older glibc I will get a "no previous prototype" compilation
> error. I can fix this error by adding a prototype but this results in
> a "redundant redeclaration" error with newer glibc.

So for strlcpy we have in tools/perf/util/cache.h:

#ifndef __UCLIBC__
/* Matches the libc/libbsd function attribute so we declare this
 * unconditionally: */
extern size_t strlcpy(char *dest, const char *src, size_t size);
#endif

I.e. have the ifdef just in the header file.

This way, if we end up needing to use sched_getcpu elsewhere, it will
work and the needed #ifdef will be constrained to the header file.

At some point we should try to move these functions to some
libc-compat.c file and move it to somewhere in tools/lib/.

- Arnaldo
