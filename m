From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 0/5] perf trace: Introduce arch-specific errno
 code/name mappings
Date: Thu, 25 Jan 2018 06:28:09 -0300
Message-ID: <20180125092809.GB23548@kernel.org>
References: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <23f01b64-0584-bbaf-2418-e34c229bcce0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbeAYJ2N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Jan 2018 04:28:13 -0500
Content-Disposition: inline
In-Reply-To: <23f01b64-0584-bbaf-2418-e34c229bcce0@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org

Em Thu, Jan 25, 2018 at 01:30:13PM +0530, Ravi Bangoria escreveu:
> Hi Hendrik,
> 
> On 01/19/2018 02:26 PM, Hendrik Brueckner wrote:
> > Introduce an interface to perf to resolve errno codes to their names.
> > This is used by perf trace to display the errno name, for example, ENOENT,
> > for an system call.  The previous implementation used the errno_to_name()
> > function from the audit library.
> >
> > With this change, a table of errno codes and their names are created for
> > each architecture on which perf is supported (others can be easily added
> > if necessary).  The errno_to_name() function from the audit library is
> > replaced with an arch-specific one, arch_errno_to_name().
> >
> > The benefit is that perf trace does not longer have a direct dependency
> > for the audit library and the perf trace output can be displayed across
> > architectures.  For example, collect trace output on s390 and display it
> > on x86.
> 
> I haven't tested this but are you sure that we can do cross-arch perf-trace
> after this patch set?

This patch is a step in that direction
 
> Why I'm curious is because, we embed arch specific syscall table in the perf
> binary at compile time:
> 
>     $ cat tools/perf/util/syscalltbl.c
> 
>     #if defined(__x86_64__)
>     #include <asm/syscalls_64.c>
>     const int syscalltbl_native_max_id = SYSCALLTBL_x86_64_MAX_ID;
>     static const char **syscalltbl_native = syscalltbl_x86_64;
>     #elif defined(__s390x__)
>     #include <asm/syscalls_64.c>
>     const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
>     static const char **syscalltbl_native = syscalltbl_s390_64;
>     #endif
> 
> If we don't have, let's say, s390 syscall table in perf compiled on x86 machine,
> we won't be able to do perf-trace across architecture. Right ?

Right.
 
> Please let me know if I'm missing anything.

You are not, we need to start testing running 'perf trace record' for
some workloads on a, say, PowerPC machine, run perf trace -i on that
file to do the beautification, copy this formatted output file + its
perf.data file, copy that to x86_64 or s/390 and try to get the same
output.

We will not, and the differences will tell us what to work on :-)

- Arnaldo
 
> Thanks,
> Ravi
> 
> P.S.: Seems I can remove libaudit dependency for syscalls on PowerPC as well.
> Will prepare patches for that very soon.

Great!
