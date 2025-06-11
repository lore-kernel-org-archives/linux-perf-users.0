Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CC18D;
	Wed, 11 Jun 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668463; cv=none; b=fTUAs+IFkdo7Emkg26j7lFJVdw7mx2+LOyoyUNaL5jd3hjB4qNuWQqSsxVkjzTl4LeJv5RTHmLXxR4ktss1jfkz3kIwH9XH7rQetopS7fKTgc43QTucHWHN0gGBxDGsVXkqKZ6Yv0kHAh08PP5tdvCgMhgt2uqOsETskcUPvl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668463; c=relaxed/simple;
	bh=T20AKzyH88cJPUCj3BOJPy4j8u7rLv+QAbQ9fGnyO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOCbWV4iNbbmv4qVPI0WlQ0tER1ywGQ1dyB7j8lB/+jDfmH4fZ79bzTEcu2depbaRfd0WxwQ7E7V8ZH8xaF9tSoKPmgWfsVP+XtMBuK3xxiPgkgc/fS44ZHgXXvBVBcVyQb7oPDdfBrvrsxNmvVwr2Evv1nmV1xkpbWj6p7b3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoTMitiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoTMitiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28E8C4CEE3;
	Wed, 11 Jun 2025 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749668463;
	bh=T20AKzyH88cJPUCj3BOJPy4j8u7rLv+QAbQ9fGnyO8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoTMitivzFVvX1/SHbSqdBzz+PEQ3WhzD04HO6rbmaeqHm5g8nuhi/xmNzLNh+u/m
	 G+qSfYcmMvrblKJnRmsnRhI4XagFnmf3QqllUq6FeGnzVaoAw+2cD89NkeoYBmy5U8
	 uiLebT0uXk8OQgBzd39S1OYwowo1X/HwJDxhNXaBfDiUc1EosplND6jo90Ly99Mrim
	 W2nhNSevb87PoHM+2AZwva8gpLsldrTQuNI6ytC8A/fUCpc5TD1wq1TE+K3EMY97SK
	 EAnrYnc2VNqeaPPzjCrVUS+dYfu2vjoQVlYwXBZKJQ/qPo+Y1d3yw3AqTxrvLNPE9g
	 ybibgaHAR387w==
Date: Wed, 11 Jun 2025 16:01:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <aEnSbBaFYgd4Gr9u@x1>
References: <aEh6xO14wDSCFUDr@google.com>
 <20250611092542.F4ooE2FL@linutronix.de>
 <aEmBOO0bSJYSvX2i@x1>
 <aEmY259Mx92D60KG@x1>
 <20250611150615.FcVIIhgA@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611150615.FcVIIhgA@linutronix.de>

On Wed, Jun 11, 2025 at 05:06:15PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-11 11:55:23 [-0300], Arnaldo Carvalho de Melo wrote:
> > commit 8386dc356158fc50c55831c96b1248e01d112ebc
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Wed Jun 11 11:25:42 2025 +0200
> > 
> >     perf bench futex: Fix prctl include in musl libc
> >     
> >     Namhyung Kim reported:
> >     
> >       I've updated the perf-tools-next to v6.16-rc1 and found a build error
> >       like below on alpine linux 3.18.
> >     
> >         In file included from bench/futex.c:6:
> >         /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
> >            88 | struct prctl_mm_map {
> >               |        ^~~~~~~~~~~~
> >         In file included from bench/futex.c:5:
> >         /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
> >           134 | struct prctl_mm_map {
> >               |        ^~~~~~~~~~~~
> >         make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
> >     
> >       git bisect says it's the first commit introduced the failure.
> >     
> >     So your /usr/include/sys/prctl.h and
> >     /linux/tools/include/uapi/linux/prctl.h both provide struct prctl_mm_map
> >     but their include guard must be different.
> >     
> >     My /usr/include/sys/prctl.h is provided by glibc and contains the
> >     prctl() declaration. It includes also linux/prctl.h.  The
> >     tools/include/uapi/linux/prctl.h is the same as
> >     /usr/include/linux/prctl.h.
> >     
> >     The /usr/include/sys/prctl.h on alpine linux is different. This is
> >     probably coming from musl. It contains the PR_* definition and the
> >     prctl() declaration.  So it clashes here because now the one struct is
> >     available twice.
> >     
> >     The man page for prctl(2) says:
> >     
> >     |       #include <linux/prctl.h>  /* Definition of PR_* constants */
> >     |       #include <sys/prctl.h>
> >     
> >     so musl doesn't follow this.
> >     
> >     So align with the other builds.
> >     
> >     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >     Reported-by: Namhyung Kim <namhyung@kernel.org>
> >     Link: https://lore.kernel.org/r/20250611092542.F4ooE2FL@linutronix.de
 
> s/Link/Closes/

ok
 
> >     [ Remove one more in tools/perf/bench/futex-hash.c and conditionally define PR_FUTEX_HASH and friends ]
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> > index fdf133c9520f73a4..d2d6d7f3ea331c84 100644
> > --- a/tools/perf/bench/futex-hash.c
> > +++ b/tools/perf/bench/futex-hash.c
> > @@ -18,7 +18,6 @@
> >  #include <stdlib.h>
> >  #include <linux/compiler.h>
> >  #include <linux/kernel.h>
> > -#include <linux/prctl.h>
> >  #include <linux/zalloc.h>
> >  #include <sys/time.h>
> >  #include <sys/mman.h>
> > diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
> > index 26382e4d8d4ce2ff..4c4fee107e5912d5 100644
> > --- a/tools/perf/bench/futex.c
> > +++ b/tools/perf/bench/futex.c
> > @@ -2,11 +2,18 @@
> >  #include <err.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > -#include <linux/prctl.h>
> >  #include <sys/prctl.h>
> >  
> This is what I had locally and was waiting for confirmation.
> 
> >  #include "futex.h"
> >  
> > +#ifndef PR_FUTEX_HASH
> > +#define PR_FUTEX_HASH                   78
> > +# define PR_FUTEX_HASH_SET_SLOTS        1
> > +# define FH_FLAG_IMMUTABLE              (1ULL << 0)
> > +# define PR_FUTEX_HASH_GET_SLOTS        2
> > +# define PR_FUTEX_HASH_GET_IMMUTABLE    3
> > +#endif // PR_FUTEX_HASH
> 
> Is this needed? Aren't these defines coming from that local copy?

So, these are, as you say, in the copied linux/prctl.h, but in musl libc
we have:

/tmp/perf-6.16.0-rc1 $ grep 'struct prctl_mm_map {' /usr/include/linux/prctl.h 
struct prctl_mm_map {
/tmp/perf-6.16.0-rc1 $ grep 'struct prctl_mm_map {' /usr/include/sys/prctl.h 
struct prctl_mm_map {
/tmp/perf-6.16.0-rc1 $

And sys/prctl.h doesn't include linux/prctl.h, if we do it, we get
multiple definitions for 'struct prctl_mm_map'.

While in fedora (probably in all the others, haven't checked, but no
failure on them from my last container set build tests):

⬢ [acme@toolbx perf-tools]$ grep 'struct prctl_mm_map {' /usr/include/linux/prctl.h
struct prctl_mm_map {
⬢ [acme@toolbx perf-tools]$ grep 'struct prctl_mm_map {' /usr/include/sys/prctl.h
⬢ [acme@toolbx perf-tools]$

furthermore fedora's sys/prctl.h includes linux/prctl.h, while musl libc
doesn't.

I thought this would be something fixed in newer alpine versions, but
no:

toolsbuilder@five:~$ grep FAIL dm.log.old/summary 
   5    19.53 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
   6    20.83 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
   7    13.94 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10) 
   8    16.60 alpine:3.19                   : FAIL gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
   9    15.72 alpine:3.20                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
  10    16.38 alpine:3.22                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
  11    15.09 alpine:edge                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
toolsbuilder@five:~$

So the easiest way out of this seems to be not to explicitely include
linux/prctl.h and define the new stuff conditionally, as I did, right?

- Arnaldo
 
> >  void futex_set_nbuckets_param(struct bench_futex_parameters *params)
> >  {
> >  	unsigned long flags;
> 
> Sebastian
