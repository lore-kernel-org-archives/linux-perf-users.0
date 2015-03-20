From: Vinson Lee <vlee@twopensource.com>
Subject: Re: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Fri, 20 Mar 2015 11:44:42 -0700
Message-ID: <CAHTgTXUqBj9rE8yXm=XtzhKC0G+H-ZYuhG5GZpk858p0=Egc2g@mail.gmail.com>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
	<1426720316-7470-1-git-send-email-vlee@twopensource.com>
	<20150319101304.GC6363@krava>
	<20150319131455.GE2983@kernel.org>
	<CAHTgTXUQVuxf5u_AZ9g-eLtwdrE4rGfiN5cCHA5ReMe0sObiBA@mail.gmail.com>
	<20150320130313.GB16485@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33756 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbCTSom (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Mar 2015 14:44:42 -0400
Received: by oifl3 with SMTP id l3so68478423oif.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2015 11:44:42 -0700 (PDT)
In-Reply-To: <20150320130313.GB16485@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>

On Fri, Mar 20, 2015 at 6:03 AM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Thu, Mar 19, 2015 at 02:12:05PM -0700, Vinson Lee escreveu:
>> On Thu, Mar 19, 2015 at 6:14 AM, Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> > Em Thu, Mar 19, 2015 at 11:13:04AM +0100, Jiri Olsa escreveu:
>> >> On Wed, Mar 18, 2015 at 04:11:52PM -0700, Vinson Lee wrote:
>> >> > This patch fixes this build error with glibc < 2.6.
>> >
>> >> > +#ifdef __GLIBC_PREREQ
>> >> > +#if !__GLIBC_PREREQ(2, 6)
>> >> > +static int sched_getcpu(void)
>> >> > +{
>> >> > +   errno = ENOSYS;
>> >> > +   return -1;
>> >> > +}
>> >> > +#endif
>> >> > +#endif
>> >
>> >> you could mark it as __weak and get rid of those ifdef's
>> >> like we do for strlcpy in utilpath.c
>> >
>> > Agreed.
>
>> I tried this approach but am having trouble getting a patch to compile
>> with both older glibc and recent glibc.
>
>> With older glibc I will get a "no previous prototype" compilation
>> error. I can fix this error by adding a prototype but this results in
>> a "redundant redeclaration" error with newer glibc.
>
> So for strlcpy we have in tools/perf/util/cache.h:
>
> #ifndef __UCLIBC__
> /* Matches the libc/libbsd function attribute so we declare this
>  * unconditionally: */
> extern size_t strlcpy(char *dest, const char *src, size_t size);
> #endif
>
> I.e. have the ifdef just in the header file.
>
> This way, if we end up needing to use sched_getcpu elsewhere, it will
> work and the needed #ifdef will be constrained to the header file.
>
> At some point we should try to move these functions to some
> libc-compat.c file and move it to somewhere in tools/lib/.
>
> - Arnaldo


I tried moving the prototype to a header file and it does not compile
with newer glibc for me either. I still get a "redundant
redeclaration" compiler error.

Here is the diff that I tried.

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 6da965b..85b5238 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,6 +7,12 @@

 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;

+int __weak sched_getcpu(void)
+{
+       errno = ENOSYS;
+       return -1;
+}
+
 static int perf_flag_probe(void)
 {
        /* use 'safest' configuration as used in perf_evsel__fallback() */
diff --git a/tools/perf/util/cloexec.h b/tools/perf/util/cloexec.h
index 94a5a7d..06904bc 100644
--- a/tools/perf/util/cloexec.h
+++ b/tools/perf/util/cloexec.h
@@ -3,4 +3,6 @@

 unsigned long perf_event_open_cloexec_flag(void);

+extern int sched_getcpu(void) __THROW;
+
 #endif /* __PERF_CLOEXEC_H */
