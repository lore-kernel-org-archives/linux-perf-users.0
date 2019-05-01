From: Rich Felker <dalias@libc.org>
Subject: Re: Detecting libc in perf (was Re: perf tools build broken after
 v5.1-rc1)
Date: Tue, 30 Apr 2019 23:12:15 -0400
Message-ID: <20190501031215.GZ23599@brightrain.aerifal.cx>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <20190425214800.GC21829@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
 <20190430011818.GE7857@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250601B@us01wembx1.internal.synopsys.com>
 <20190430170404.GX23599@brightrain.aerifal.cx>
 <17a86bc7-c1f9-8c3c-8f1d-711e95dac49d@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17a86bc7-c1f9-8c3c-8f1d-711e95dac49d@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, "devel@uclibc-ng.org" <devel@uclibc-ng.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Apr 30, 2019 at 10:13:40AM -0700, Vineet Gupta wrote:
> On 4/30/19 10:04 AM, Rich Felker wrote:
> > On Tue, Apr 30, 2019 at 03:53:18PM +0000, Vineet Gupta wrote:
> >> On 4/29/19 6:18 PM, Arnaldo Carvalho de Melo wrote:
> >>>>> Auto-detecting system features:
> >>>>> ...                         dwarf: [ OFF ]
> >>>>> ...            dwarf_getlocations: [ OFF ]
> >>>>> ...                         glibc: [ on  ]
> >>>> Not related to current issue, this run uses a uClibc toolchain and yet it is
> >>>> detecting glibc - doesn't seem right to me.
> >>> Ok, I'll improve that, I think it just tries to detect a libc, yeah,
> >>> see:
> >>>
> >>> [acme@quaco linux]$ cat tools/build/feature/test-glibc.c
> >>> // SPDX-License-Identifier: GPL-2.0
> >>> #include <stdlib.h>
> >>>
> >>> #if !defined(__UCLIBC__)
> >>> #include <gnu/libc-version.h>
> >>> #else
> >>> #define XSTR(s) STR(s)
> >>> #define STR(s) #s
> >>> #endif
> >>>
> >>> int main(void)
> >>> {
> >>> #if !defined(__UCLIBC__)
> >>> 	const char *version = gnu_get_libc_version();
> >>> #else
> >>> 	const char *version = XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);
> >>> #endif
> >>>
> >>> 	return (long)version;
> >>> }
> >>> [acme@quaco linux]$
> >>>
> >>> [perfbuilder@59ca4b424ded /]$ grep __GLIBC__ /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/*.h
> >>> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:   The macros `__GNU_LIBRARY__', `__GLIBC__', and `__GLIBC_MINOR__' are
> >>> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:#define	__GLIBC__	2
> >>> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:	((__GLIBC__ << 16) + __GLIBC_MINOR__ >= ((maj) << 16) + (min))
> >>> [perfbuilder@59ca4b424ded /]$
> >>>
> >>> Isn't that part of uClibc?
> >>
> >> Right you are. Per the big fat comment right above that code, this gross hack in
> >> uclibc is unavoidable as applications tend to rely on that define.
> >> So a better fix would be to check for various !GLIBC libs explicitly.
> >>
> >> #ifdef __UCLIBC__
> >>
> >> #elseif defined __MUSL__
> >>
> >> ....
> >>
> >> Not pretty from app usage pov, but that seems to be the only sane way of doing it.
> > 
> > What are you trying to achieve? I was just CC'd and I'm missing the
> > context.
> 
> Sorry I added you as a subject matter expert but didn't provide enough context.
> 
> The original issue [1] was perf failing to build on ARC due to perf tools needing
> a copy of unistd.h but this thread [2] was a small side issue of auto-detecting
> libc variaint in perf tools where despite uClibc tools, glibc is declared to be
> detected, due to uClibc's historical hack of defining __GLIBC__. So __GLIBC__ is
> not sufficient (and probably not the right interface to begin wtih) to ensure glibc.
> 
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-April/005676.html
> [2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-April/005684.html

I think you misunderstood -- I'm asking what you're trying to achieve
by detecting whether the libc is glibc, rather than whether it has
some particular interface you want to conditionally use. This is a
major smell and is usually something wrong that shouldn't be done.

Rich
