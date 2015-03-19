From: Vinson Lee <vlee@twopensource.com>
Subject: Re: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Thu, 19 Mar 2015 14:12:05 -0700
Message-ID: <CAHTgTXUQVuxf5u_AZ9g-eLtwdrE4rGfiN5cCHA5ReMe0sObiBA@mail.gmail.com>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
	<1426720316-7470-1-git-send-email-vlee@twopensource.com>
	<20150319101304.GC6363@krava>
	<20150319131455.GE2983@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319131455.GE2983@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Mar 19, 2015 at 6:14 AM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Thu, Mar 19, 2015 at 11:13:04AM +0100, Jiri Olsa escreveu:
>> On Wed, Mar 18, 2015 at 04:11:52PM -0700, Vinson Lee wrote:
>> > This patch fixes this build error with glibc < 2.6.
>
>> > +#ifdef __GLIBC_PREREQ
>> > +#if !__GLIBC_PREREQ(2, 6)
>> > +static int sched_getcpu(void)
>> > +{
>> > +   errno = ENOSYS;
>> > +   return -1;
>> > +}
>> > +#endif
>> > +#endif
>
>> you could mark it as __weak and get rid of those ifdef's
>> like we do for strlcpy in utilpath.c
>
> Agreed.
>
> - Arnaldo

I tried this approach but am having trouble getting a patch to compile
with both older glibc and recent glibc.

With older glibc I will get a "no previous prototype" compilation
error. I can fix this error by adding a prototype but this results in
a "redundant redeclaration" error with newer glibc.
