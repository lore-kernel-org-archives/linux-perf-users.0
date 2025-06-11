Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FF213224;
	Wed, 11 Jun 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678646; cv=none; b=m9DJAFhODjHvmBFfs1IkcJXVXpgQ0Lrk2hrgJ1aZI9tsjV4sDrutVKbdNqDoSy8ihq5lLAgEqiqianLnCQUQbheCGRAYPVh95EetyJKKhS/CAIUlkDgxfahe/u7qQcSbmSKVlRUS4js7hunuvknI0AYbu6QY0qpyBggA3qfDUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678646; c=relaxed/simple;
	bh=RWVYRiPZVmtgySePvK9Fgk/us/xzILqK49c9tQBEmKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdoVgtmYBOgtkP1iLHWLp36WREh01Dr7AtultV91PMxTwmE8Y9ij8VPZgjJDi9gfLDzuHqIW6uaegM5G4dY4izhNbaY5W1WV+P05zLiaKW6BqBLijI3RTeFc5aWnZClPkuHIfdpza+t1Jj+KnFxW8cYMc17dpTRgKCpeGkxbAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcnJ7GRH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcnJ7GRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EAC4CEE3;
	Wed, 11 Jun 2025 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678645;
	bh=RWVYRiPZVmtgySePvK9Fgk/us/xzILqK49c9tQBEmKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcnJ7GRHk/Kwn8dcnC5nqRlP0OflMqeJ1nrPjz2f4GyiXhngjxoLt6f9DOnkeYnLQ
	 usw51rZIB0VUV6CO+0LmnkfJuNZx7mJ7BkJKHJP/7aLn7xa2XKurgYQN/fpek4EraY
	 6//0wsrEyfFn7eBmEw5Ng2VM5TDqHt1XXLc0HTaw2HKQrL9E/180ED4ZJ9GVCBghwx
	 2GgHZTAiPcWvoyTkh5fVEvFdlVISrsxTJrDUyaqWThYGBCYr9LRhseRLVJq2xDXRPR
	 VGiVatkdQVjOMK3NgPRWSqIlbHMp37jQnDhYszTB0sGE3f91h6SehWNCc2hKakkwDD
	 fkKQJBuRSDZAg==
Date: Wed, 11 Jun 2025 14:50:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <aEn6M_DTUHx9_hMS@google.com>
References: <aEh6xO14wDSCFUDr@google.com>
 <20250611092542.F4ooE2FL@linutronix.de>
 <aEmBOO0bSJYSvX2i@x1>
 <aEmY259Mx92D60KG@x1>
 <20250611150615.FcVIIhgA@linutronix.de>
 <aEnSbBaFYgd4Gr9u@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEnSbBaFYgd4Gr9u@x1>

On Wed, Jun 11, 2025 at 04:01:00PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jun 11, 2025 at 05:06:15PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-11 11:55:23 [-0300], Arnaldo Carvalho de Melo wrote:
> > > commit 8386dc356158fc50c55831c96b1248e01d112ebc
> > > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Date:   Wed Jun 11 11:25:42 2025 +0200
> > > 
> > >     perf bench futex: Fix prctl include in musl libc
> > >     
> > >     Namhyung Kim reported:
> > >     
> > >       I've updated the perf-tools-next to v6.16-rc1 and found a build error
> > >       like below on alpine linux 3.18.
> > >     
> > >         In file included from bench/futex.c:6:
> > >         /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
> > >            88 | struct prctl_mm_map {
> > >               |        ^~~~~~~~~~~~
> > >         In file included from bench/futex.c:5:
> > >         /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
> > >           134 | struct prctl_mm_map {
> > >               |        ^~~~~~~~~~~~
> > >         make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
> > >     
> > >       git bisect says it's the first commit introduced the failure.
> > >     
> > >     So your /usr/include/sys/prctl.h and
> > >     /linux/tools/include/uapi/linux/prctl.h both provide struct prctl_mm_map
> > >     but their include guard must be different.
> > >     
> > >     My /usr/include/sys/prctl.h is provided by glibc and contains the
> > >     prctl() declaration. It includes also linux/prctl.h.  The
> > >     tools/include/uapi/linux/prctl.h is the same as
> > >     /usr/include/linux/prctl.h.
> > >     
> > >     The /usr/include/sys/prctl.h on alpine linux is different. This is
> > >     probably coming from musl. It contains the PR_* definition and the
> > >     prctl() declaration.  So it clashes here because now the one struct is
> > >     available twice.
> > >     
> > >     The man page for prctl(2) says:
> > >     
> > >     |       #include <linux/prctl.h>  /* Definition of PR_* constants */
> > >     |       #include <sys/prctl.h>
> > >     
> > >     so musl doesn't follow this.
> > >     
> > >     So align with the other builds.
> > >     
> > >     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >     Reported-by: Namhyung Kim <namhyung@kernel.org>
> > >     Link: https://lore.kernel.org/r/20250611092542.F4ooE2FL@linutronix.de
>  
> > s/Link/Closes/
> 
> ok
>  
> > >     [ Remove one more in tools/perf/bench/futex-hash.c and conditionally define PR_FUTEX_HASH and friends ]
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> > > index fdf133c9520f73a4..d2d6d7f3ea331c84 100644
> > > --- a/tools/perf/bench/futex-hash.c
> > > +++ b/tools/perf/bench/futex-hash.c
> > > @@ -18,7 +18,6 @@
> > >  #include <stdlib.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/kernel.h>
> > > -#include <linux/prctl.h>
> > >  #include <linux/zalloc.h>
> > >  #include <sys/time.h>
> > >  #include <sys/mman.h>
> > > diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
> > > index 26382e4d8d4ce2ff..4c4fee107e5912d5 100644
> > > --- a/tools/perf/bench/futex.c
> > > +++ b/tools/perf/bench/futex.c
> > > @@ -2,11 +2,18 @@
> > >  #include <err.h>
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > > -#include <linux/prctl.h>
> > >  #include <sys/prctl.h>
> > >  
> > This is what I had locally and was waiting for confirmation.
> > 
> > >  #include "futex.h"
> > >  
> > > +#ifndef PR_FUTEX_HASH
> > > +#define PR_FUTEX_HASH                   78
> > > +# define PR_FUTEX_HASH_SET_SLOTS        1
> > > +# define FH_FLAG_IMMUTABLE              (1ULL << 0)
> > > +# define PR_FUTEX_HASH_GET_SLOTS        2
> > > +# define PR_FUTEX_HASH_GET_IMMUTABLE    3
> > > +#endif // PR_FUTEX_HASH
> > 
> > Is this needed? Aren't these defines coming from that local copy?
> 
> So, these are, as you say, in the copied linux/prctl.h, but in musl libc
> we have:
> 
> /tmp/perf-6.16.0-rc1 $ grep 'struct prctl_mm_map {' /usr/include/linux/prctl.h 
> struct prctl_mm_map {
> /tmp/perf-6.16.0-rc1 $ grep 'struct prctl_mm_map {' /usr/include/sys/prctl.h 
> struct prctl_mm_map {
> /tmp/perf-6.16.0-rc1 $
> 
> And sys/prctl.h doesn't include linux/prctl.h, if we do it, we get
> multiple definitions for 'struct prctl_mm_map'.
> 
> While in fedora (probably in all the others, haven't checked, but no
> failure on them from my last container set build tests):
> 
> ⬢ [acme@toolbx perf-tools]$ grep 'struct prctl_mm_map {' /usr/include/linux/prctl.h
> struct prctl_mm_map {
> ⬢ [acme@toolbx perf-tools]$ grep 'struct prctl_mm_map {' /usr/include/sys/prctl.h
> ⬢ [acme@toolbx perf-tools]$
> 
> furthermore fedora's sys/prctl.h includes linux/prctl.h, while musl libc
> doesn't.
> 
> I thought this would be something fixed in newer alpine versions, but
> no:
> 
> toolsbuilder@five:~$ grep FAIL dm.log.old/summary 
>    5    19.53 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
>    6    20.83 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
>    7    13.94 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10) 
>    8    16.60 alpine:3.19                   : FAIL gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
>    9    15.72 alpine:3.20                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
>   10    16.38 alpine:3.22                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
>   11    15.09 alpine:edge                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
> toolsbuilder@five:~$
> 
> So the easiest way out of this seems to be not to explicitely include
> linux/prctl.h and define the new stuff conditionally, as I did, right?

Yep, it fixes my build too.  Without the defines, I see

  bench/futex.c: In function 'futex_set_nbuckets_param':
  bench/futex.c:25:45: error: 'FH_FLAG_IMMUTABLE' undeclared (first use in this function)
     25 |         flags = params->buckets_immutable ? FH_FLAG_IMMUTABLE : 0;
        |                                             ^~~~~~~~~~~~~~~~~
  bench/futex.c:25:45: note: each undeclared identifier is reported only once for each function it appears in
  bench/futex.c:26:21: error: 'PR_FUTEX_HASH' undeclared (first use in this function)
     26 |         ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, flags);
        |                     ^~~~~~~~~~~~~
    CC      /build/ui/browsers/annotate-data.o
  bench/futex.c:26:36: error: 'PR_FUTEX_HASH_SET_SLOTS' undeclared (first use in this function)
     26 |         ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, flags);
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~
  bench/futex.c: In function 'futex_print_nbuckets':
  bench/futex.c:39:21: error: 'PR_FUTEX_HASH' undeclared (first use in this function)
     39 |         ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
        |                     ^~~~~~~~~~~~~
  bench/futex.c:39:36: error: 'PR_FUTEX_HASH_GET_SLOTS' undeclared (first use in this function)
     39 |         ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~
  bench/futex.c:53:52: error: 'PR_FUTEX_HASH_GET_IMMUTABLE' undeclared (first use in this function)
     53 |                         ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
        |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> - Arnaldo
>  
> > >  void futex_set_nbuckets_param(struct bench_futex_parameters *params)
> > >  {
> > >  	unsigned long flags;
> > 
> > Sebastian
