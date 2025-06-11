Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870A271446;
	Wed, 11 Jun 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647675; cv=none; b=cL7iveEOBceFlIATgy3s9hLsuPv9yNiIt6+uo0ek7SyPPUF+18/PaO5OgZVhULaB7J6YjDAtIHg+HroRKcr7lCeSyLo7z561ldoUiQK/zhf90lZSjJOHf3u1s2hTAbn0uqnSr5fYb8gQi35IrCpAG6XSQa4Z6x3Q6uVBduHUi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647675; c=relaxed/simple;
	bh=oJLQqA4k8+yXhF2GFFpeYzG/tFeybxY9Tc9zzwO1iSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueQqOeUetxqjwucCUZJfKlx7zHRvjWDGdj2sXxgSsIWn/zpQ8AKAMYg5ti52jbKgkUmWc6GtpoxSer2YXho0aYecMecAY2vikK8uoDWXJep5AcEXNZ9+xnFf68Yw8VbiSVlXedX0mMlRAtD2yCpr7qNMnR7Mr9920mfy8ib3+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXYS+XIG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXYS+XIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE42DC4CEEE;
	Wed, 11 Jun 2025 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647675;
	bh=oJLQqA4k8+yXhF2GFFpeYzG/tFeybxY9Tc9zzwO1iSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXYS+XIGsoi6gVcrYZ/YPTbQj3Q/MtOMw/yLw6a9Le7/MrUrMRD9/JbeMQOcj8eWF
	 tUwr8qIy33t47AIpKR/QzGznZ5CARETGZoEQ3+VfoChvy3LNzLA9dfQe9RyzzvMHqc
	 XjAFE8nt8esinb1h0H38QOK0yDS1FVbQQnEsyuwm+X1CnoApJErNRl1yal7Uo9VCZE
	 NBprAdBScYDoGFjPSd3enk5TyYWxToDoBhkUq33wCPVM8zrrGuxCXyWpQ87lQnRP2y
	 KSlCcDdTtjWwRxmNWKjtXojlJgRi2Tkx/9BynTD0mFmlVfvRWFFnFVU3+ooTZrYstc
	 uWDPEzjidg+aA==
Date: Wed, 11 Jun 2025 10:14:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <aEmBOO0bSJYSvX2i@x1>
References: <aEh6xO14wDSCFUDr@google.com>
 <20250611092542.F4ooE2FL@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611092542.F4ooE2FL@linutronix.de>

On Wed, Jun 11, 2025 at 11:25:42AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-10 11:34:44 [-0700], Namhyung Kim wrote:
> > Hello,
> Hi,
> 
> > I've updated the perf-tools-next to v6.16-rc1 and found a build error
> > like below on alpine linux 3.18.
> > 
> >   In file included from bench/futex.c:6:
> >   /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
> >      88 | struct prctl_mm_map {
> >         |        ^~~~~~~~~~~~
> >   In file included from bench/futex.c:5:
> >   /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
> >     134 | struct prctl_mm_map {
> >         |        ^~~~~~~~~~~~
> >   make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
> > 
> > git bisect says it's the first commit introduced the failure.
> 
> Hmm. So your /usr/include/sys/prctl.h and
> /linux/tools/include/uapi/linux/prctl.h both provide struct
> prctl_mm_map but their include guard must be different.
> 
> My /usr/include/sys/prctl.h is provided by glibc and contains the
> prctl() declaration. It includes also linux/prctl.h.
> The tools/include/uapi/linux/prctl.h is the same as
> /usr/include/linux/prctl.h.
> 
> The /usr/include/sys/prctl.h on alpine linux is different. This is
> probably coming from musl. It contains the PR_* definition and the
> prctl() declaration. So it clashes here because now the one struct is
> available twice.
> 
> The man page for prctl(2) says:
> |       #include <linux/prctl.h>  /* Definition of PR_* constants */
> |       #include <sys/prctl.h>
> 
> so musl doesn't follow this.
> 
> To align with the other builds, I guess the following help:

So I noticed this as well in perf-tools/perf-tools, I'm trying with your
patch applied, lets see...

- Arnaldo
 
> diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
> index 26382e4d8d4ce..540261f299b1d 100644
> --- a/tools/perf/bench/futex.c
> +++ b/tools/perf/bench/futex.c
> @@ -2,7 +2,6 @@
>  #include <err.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <linux/prctl.h>
>  #include <sys/prctl.h>
>  
>  #include "futex.h"
> 
> Sebastian
