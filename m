From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 01/12] tools include: Adopt linux/bits.h
Date: Tue, 9 Oct 2018 11:01:53 -0300
Message-ID: <20181009140152.GA2486@redhat.com>
References: <20181009005427.6607-1-acme@kernel.org>
 <20181009005427.6607-2-acme@kernel.org>
 <f40d9bab-dd39-5a88-6e85-36f4c6069668@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f40d9bab-dd39-5a88-6e85-36f4c6069668@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 09, 2018 at 10:47:35AM +0200, Alexander Sverdlin escreveu:
> Hello Arnaldo,
> 
> On 09/10/2018 02:54, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > So that we reduce the difference of tools/include/linux/bitops.h to the
> > original kernel file, include/linux/bitops.h, trying to remove the need
> > to define BITS_PER_LONG, to avoid clashes with asm/bitsperlong.h.
> 
> thanks for looking into this, but I don't quite get your plan here,
> you neither remove redefinition of BITS_PER_LONG in this patch, nor
> in any following patch in the series.

I tried looking into this, got these patches as preparatory, but then
got sidetracked, pushed what I had, have to continue working on it. But
I'm busy with other stuff right now, again.

- Arnaldo

> Have you forgot to include another patch or shall I try to come up with
> a patch removing BITS_PER_LONG from bitops.h? 
> 
> > And the things removed from tools/include/linux/bitops.h are really in
> > linux/bits.h, so that we can have a copy and then
> > tools/perf/check_headers.sh will tell us when new stuff gets added to
> > linux/bits.h so that we can check if it is useful and if any adjustment
> > needs to be done to the tools/{include,arch}/ copies.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: https://lkml.kernel.org/n/tip-y1sqyydvfzo0bjjoj4zsl562@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/include/linux/bitops.h |  7 ++-----
> >  tools/include/linux/bits.h   | 26 ++++++++++++++++++++++++++
> >  tools/perf/check-headers.sh  |  1 +
> >  3 files changed, 29 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/include/linux/bits.h
> > 
> > diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
> > index acc704bd3998..0b0ef3abc966 100644
> > --- a/tools/include/linux/bitops.h
> > +++ b/tools/include/linux/bitops.h
> > @@ -3,8 +3,6 @@
> >  #define _TOOLS_LINUX_BITOPS_H_
> >  
> >  #include <asm/types.h>
> > -#include <linux/compiler.h>
> > -
> >  #ifndef __WORDSIZE
> >  #define __WORDSIZE (__SIZEOF_LONG__ * 8)
> >  #endif
> > @@ -12,10 +10,9 @@
> >  #ifndef BITS_PER_LONG
> >  # define BITS_PER_LONG __WORDSIZE
> >  #endif
> > +#include <linux/bits.h>
> > +#include <linux/compiler.h>
> >  
> > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > -#define BITS_PER_BYTE		8
> >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> >  #define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
> >  #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
> > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > new file mode 100644
> > index 000000000000..2b7b532c1d51
> > --- /dev/null
> > +++ b/tools/include/linux/bits.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_BITS_H
> > +#define __LINUX_BITS_H
> > +#include <asm/bitsperlong.h>
> > +
> > +#define BIT(nr)			(1UL << (nr))
> > +#define BIT_ULL(nr)		(1ULL << (nr))
> > +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > +#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > +#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > +#define BITS_PER_BYTE		8
> > +
> > +/*
> > + * Create a contiguous bitmask starting at bit position @l and ending at
> > + * position @h. For example
> > + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > + */
> > +#define GENMASK(h, l) \
> > +	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> > +
> > +#define GENMASK_ULL(h, l) \
> > +	(((~0ULL) - (1ULL << (l)) + 1) & \
> > +	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
> > +
> > +#endif	/* __LINUX_BITS_H */
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index 466540ee8ea7..c72cc73a6b09 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -14,6 +14,7 @@ include/uapi/linux/sched.h
> >  include/uapi/linux/stat.h
> >  include/uapi/linux/vhost.h
> >  include/uapi/sound/asound.h
> > +include/linux/bits.h
> >  include/linux/hash.h
> >  include/uapi/linux/hw_breakpoint.h
> >  arch/x86/include/asm/disabled-features.h
> > 
> 
> -- 
> Best regards,
> Alexander Sverdlin.
