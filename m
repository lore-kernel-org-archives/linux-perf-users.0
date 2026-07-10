Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EF431E6B;
	Fri, 10 Jul 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722271; cv=none; b=mI6iirq+czn1v+5J11RZO3Im8wHLJMsk0TtDkjjQw2XBZcWcZZzTyDnZFrm3qYv1Unoe/h0hDswHIbn8aJf6t6AgpnM69Ehm02BybCTw6YKKYOrcpsEbAEegxIniZVYaLqwlmhZCto1X+4QqNAPOK+KxU2EHZjDvhXCKIexpBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722271; c=relaxed/simple;
	bh=2rj7dHUIkNbVT0lWrogyknBfkEtkmPdr/DEXKjK8+sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJs/k01sN29bfqHt5z7SdIsB19SLrOjKGgGzbCuhq3WkKueqXHw4/nUF+o2+a7Igmp+jX3kxhxWqoJfEJ8Hc5b9wtFV/ElCONiAYry41v56glA3zn6pXn2u+L95eWYCdIRN9AYHBMxEnYZPBal5CyvPO8rEMKQAnx4Zp8xwr/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw7Nv4Qi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw7Nv4Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5371F000E9;
	Fri, 10 Jul 2026 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783722269;
	bh=yjG6AjtLNcbZOeO7vqkQSQcQNWKqeiL7W846xPJ4oRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hw7Nv4QiuzXvpz6I2zgo/BRocfbAIXDg2Io9+lXxAQH0zcCSJi9MQRSz5/Wm+vCQH
	 KzhIk4Lv/zSxtZgg7qy8uxlL/UXTmmlofm3I6O5PiecmWg1TIn9YWaSjmIUUhJLnnC
	 KtOxF5sFjwydq3Knad1oy8NalFvlWMveFp2Ez1AkKgS5LySROngzaztREtwsm4ac25
	 hEujYv7kt67Hr/UEs//uAo8/SapZrG6CpQn8cchNX0TtiVArWIOf+RIbGIgCEtsCTp
	 87HIf5vOEZR0pOvFS2DwOg0y0BlV7Dxtl7WbFzXCMB4WeCHo/n8MxuaSiie2zGbQ9m
	 seocIbhjSYLzg==
Date: Fri, 10 Jul 2026 15:24:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf cap: If capability is missing still perform
 root test
Message-ID: <alFxHPCouXNWkLie@google.com>
References: <20260710053927.1864021-1-irogers@google.com>
 <20260710053927.1864021-2-irogers@google.com>
 <20260710054711.5FF731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710054711.5FF731F000E9@smtp.kernel.org>

On Fri, Jul 10, 2026 at 05:47:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The capability fallback logic overrides valid capability checks for root users and incorrectly short-circuits sequential capability checks for non-root users by improperly setting the `used_root` flag.
> --
> 
> --- Patch [2]: [PATCH v1 2/2] perf cap: If capability is missing still perform root test ---
> commit 8515c6747c6ffb6d27af14829f03c002334e5c67
> Author: Ian Rogers <irogers@google.com>
> 
> perf cap: If capability is missing still perform root test
> 
> This commit refines the capability checking logic in perf_cap__capable() to
> fallback to the used_root test if a capability is missing, rather than only
> doing so when the capget syscall fails.

I think we can process this independently.  It's not related to patch 1,
right?

> 
> > diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> > --- a/tools/perf/util/cap.c
> > +++ b/tools/perf/util/cap.c
> 
> [ ... ]
> 
> > @@ -37,12 +38,21 @@ bool perf_cap__capable(int cap, bool *used_root)
> >  	if (cap >= 32) {
> >  		if (header.version == _LINUX_CAPABILITY_VERSION_3) {
> >  			cap_val = data[1].effective;
> > +			has_cap = (cap_val & (1U << (cap & 0x1f))) != 0;
> >  		} else {
> >  			/* Capability beyond 32 is requested but only 32 are supported. */
> > -			return false;
> > +			has_cap = false;
> >  		}
> >  	} else {
> >  		cap_val = data[0].effective;
> > +		has_cap = (cap_val & (1U << (cap & 0x1f))) != 0;
> >  	}
> > -	return (cap_val & (1 << (cap & 0x1f))) != 0;
> > +
> > +	if (has_cap) {
> > +		*used_root = false;
> > +		return true;
> > +	}
> > +
> > +	*used_root = true;
> > +	return geteuid() == 0;
> >  }
> 
> [Severity: High]
> Does setting *used_root = true unconditionally here when a capability is
> missing break sequential capability checks for non-root users?
> 
> For example, if an unprivileged user lacks CAP_SYS_ADMIN, this will return
> false but set used_root to true. In callers like perf_event_paranoid_check():
> 
> tools/perf/util/util.c:perf_event_paranoid_check() {
>     ...
>     if (!used_root && perf_cap__capable(CAP_PERFMON, &used_root))
>     ...
> }
> 
> If a previous check for CAP_SYS_ADMIN failed and poisoned the used_root
> flag, won't it cause the subsequent check for CAP_PERFMON to be skipped
> entirely?
> 
> This pattern appears in other locations as well, such as
> check_bpf_filter_capable() where a failed CAP_BPF check might skip the
> fallback for non-root users to access root-pinned BPF filters because
> !used_root evaluates to false.
> 
> Additionally, could this override valid capability drops for root users
> in containers? Because geteuid() == 0 evaluates to true, it seems this might
> falsely claim root users still possess the capability even if it was
> explicitly dropped, potentially leading to later failures instead of
> graceful fallbacks.

Can we simply remove the used_root parameter from perf_cap__capable()?
Normally I think root would have the capability.  If not, maybe we need
to reject the operation as it may happen in a container setup.

Thanks,
Namhyung

