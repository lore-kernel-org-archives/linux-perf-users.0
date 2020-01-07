From: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH 20/20] tools lib: Fix builds when glibc contains strlcpy()
Date: Tue, 7 Jan 2020 23:48:04 +0300
Message-ID: <20200107204803.yuunleopt7pnq5dw@altlinux.org>
References: <20200106160705.10899-1-acme@kernel.org>
 <20200106160705.10899-21-acme@kernel.org>
 <bd755ddc840a485098f9e51d2692f39d@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd755ddc840a485098f9e51d2692f39d@AcuMS.aculab.com>
Sender: stable-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Arnaldo Carvalho de Melo' <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Dmitry Levin <ldv@altlinux.org>, Josh Poimboeuf <jpoimboe@redhat.com>, kbuild test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

David,

On Mon, Jan 06, 2020 at 05:03:26PM +0000, David Laight wrote:
> From: Arnaldo Carvalho de Melo
> > Sent: 06 January 2020 16:07
> > 
> > From: Vitaly Chikunov <vt@altlinux.org>
> > 
> > Disable a couple of compilation warnings (which are treated as errors)
> > on strlcpy() definition and declaration, allowing users to compile perf
> > and kernel (objtool) when:
> > 
> > 1. glibc have strlcpy() (such as in ALT Linux since 2004) objtool and
> >    perf build fails with this (in gcc):
> > 
> >   In file included from exec-cmd.c:3:
> >   tools/include/linux/string.h:20:15: error: redundant redeclaration of ‘strlcpy’ [-Werror=redundant-decls]
> >      20 | extern size_t strlcpy(char *dest, const char *src, size_t size);
> > 
> > 2. clang ignores `-Wredundant-decls', but produces another warning when
> >    building perf:
> > 
> >     CC       util/string.o
> >   ../lib/string.c:99:8: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
> >   size_t __weak strlcpy(char *dest, const char *src, size_t size)
> >   ../../tools/include/linux/compiler.h:66:34: note: expanded from macro '__weak'
> >   # define __weak                 __attribute__((weak))
> >   /usr/include/bits/string_fortified.h:151:8: note: previous definition is here
> >   __NTH (strlcpy (char *__restrict __dest, const char *__restrict __src,
> 
> Why not just always use the local version by renaming it?

I believe that was the initial approach, which is changed some time ago
to using weak linking. Also, Dmitry Levin (as one of glibc maintainers)
claims that glibc implementation of strlcpy() is more correct and thus
better.

Thanks,

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
