Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5230A95C;
	Wed, 11 Jun 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654379; cv=none; b=iiCa3522pixpbsaICZQ+9UMIA0NBmHUqVaa/yDEsPuqfEUokMzerCfq4kR/7uXKzZCG6T/glm6RKryKmCMM1cq4fwFkoEsARtd9uNUD+j6qogSdmnUWPFGJFk4NbOtb/aPwBrr5pozjoh9qCzgfiVENpc12VYq4RVvmI8RkdBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654379; c=relaxed/simple;
	bh=aCkGDuI3v8qqrSp/lgc7mwahaXmCdy/S1VGipRF8Wjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo4re0qTztKaW4vpeF7WYJoe0yUIRDsdA2OtQNojEkPjX21jmlSkAMP/qdb3DphRNHPUJJKhZgA5tOe9E/3DtV1uVQwoC6DlJO6d/Ka7Y0RQ0EHS0Y3r0HOaxRIShhFoBPtcP+hBK3z/g+S+BFKGtww6dOjwWoCNSXuNELK74YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdgNGd4N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvLTiNMX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdgNGd4N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvLTiNMX"
Date: Wed, 11 Jun 2025 17:06:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749654376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjvHM+RNwqsHkW9Rr7fWxpTn4Yk9ccBYDYjbQTaoxoE=;
	b=SdgNGd4NoenkJU0zTfISKg+r4GdlotOifbGfmThZm7iV4vu6631Gpux2LHGXmGV2Nk+yMy
	WN6om+l59PK0lK7a06k9wltbA+7hgQ7dyegODxm2gk/dTCtxKq+Cav037KCA8Kpc6gFZvV
	nG5IKnT5PLFbHMRaeTvL2j/sUjgTiQgMTVrPQY02yez5q/L57T6HxkQbRRe32KFCtOShg4
	Bqvjg0HXyHYD+5OaaS6gl1RHMAisqo51+QLHajmT402t1m/pAUtRC56+sYiq/38nATQGxQ
	0P3iAdHtuNxl5bm/2ihUc31VpCZXBk1u7ctT618EeE++WBR3R5dAfdNuDGErnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749654376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjvHM+RNwqsHkW9Rr7fWxpTn4Yk9ccBYDYjbQTaoxoE=;
	b=kvLTiNMXDmgiDh2qQ5KrRSD1PvbALQP7GHjr08YoOBL4x4djSk5rYljZ33UB798KTf7b5k
	VwkJjEMeXMGAAlCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <20250611150615.FcVIIhgA@linutronix.de>
References: <aEh6xO14wDSCFUDr@google.com>
 <20250611092542.F4ooE2FL@linutronix.de>
 <aEmBOO0bSJYSvX2i@x1>
 <aEmY259Mx92D60KG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEmY259Mx92D60KG@x1>

On 2025-06-11 11:55:23 [-0300], Arnaldo Carvalho de Melo wrote:
> commit 8386dc356158fc50c55831c96b1248e01d112ebc
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Wed Jun 11 11:25:42 2025 +0200
> 
>     perf bench futex: Fix prctl include in musl libc
>     
>     Namhyung Kim reported:
>     
>       I've updated the perf-tools-next to v6.16-rc1 and found a build error
>       like below on alpine linux 3.18.
>     
>         In file included from bench/futex.c:6:
>         /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
>            88 | struct prctl_mm_map {
>               |        ^~~~~~~~~~~~
>         In file included from bench/futex.c:5:
>         /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
>           134 | struct prctl_mm_map {
>               |        ^~~~~~~~~~~~
>         make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
>     
>       git bisect says it's the first commit introduced the failure.
>     
>     So your /usr/include/sys/prctl.h and
>     /linux/tools/include/uapi/linux/prctl.h both provide struct prctl_mm_map
>     but their include guard must be different.
>     
>     My /usr/include/sys/prctl.h is provided by glibc and contains the
>     prctl() declaration. It includes also linux/prctl.h.  The
>     tools/include/uapi/linux/prctl.h is the same as
>     /usr/include/linux/prctl.h.
>     
>     The /usr/include/sys/prctl.h on alpine linux is different. This is
>     probably coming from musl. It contains the PR_* definition and the
>     prctl() declaration.  So it clashes here because now the one struct is
>     available twice.
>     
>     The man page for prctl(2) says:
>     
>     |       #include <linux/prctl.h>  /* Definition of PR_* constants */
>     |       #include <sys/prctl.h>
>     
>     so musl doesn't follow this.
>     
>     So align with the other builds.
>     
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Reported-by: Namhyung Kim <namhyung@kernel.org>
>     Link: https://lore.kernel.org/r/20250611092542.F4ooE2FL@linutronix.de

s/Link/Closes/

>     [ Remove one more in tools/perf/bench/futex-hash.c and conditionally define PR_FUTEX_HASH and friends ]
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index fdf133c9520f73a4..d2d6d7f3ea331c84 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -18,7 +18,6 @@
>  #include <stdlib.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
> -#include <linux/prctl.h>
>  #include <linux/zalloc.h>
>  #include <sys/time.h>
>  #include <sys/mman.h>
> diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
> index 26382e4d8d4ce2ff..4c4fee107e5912d5 100644
> --- a/tools/perf/bench/futex.c
> +++ b/tools/perf/bench/futex.c
> @@ -2,11 +2,18 @@
>  #include <err.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <linux/prctl.h>
>  #include <sys/prctl.h>
>  
This is what I had locally and was waiting for confirmation.

>  #include "futex.h"
>  
> +#ifndef PR_FUTEX_HASH
> +#define PR_FUTEX_HASH                   78
> +# define PR_FUTEX_HASH_SET_SLOTS        1
> +# define FH_FLAG_IMMUTABLE              (1ULL << 0)
> +# define PR_FUTEX_HASH_GET_SLOTS        2
> +# define PR_FUTEX_HASH_GET_IMMUTABLE    3
> +#endif // PR_FUTEX_HASH

Is this needed? Aren't these defines coming from that local copy?

>  void futex_set_nbuckets_param(struct bench_futex_parameters *params)
>  {
>  	unsigned long flags;

Sebastian
