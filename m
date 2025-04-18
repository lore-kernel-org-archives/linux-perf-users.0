Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51E1A2658;
	Fri, 18 Apr 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966747; cv=none; b=iQboN+GNVqcYXVhxc+Z+LnCN0Fe2HIlMCblmKqtgGimEusN3GMoAqmCNBi2LzCnx6WNDPWPCSI8rkOXHGPbOzdmKMopqT4Py+/s8Aokh1a+Iv4jOKfTP5yp7F6UFwpq/s2CCgdUKLO+eI1gFDrWPj7E7aiM03xqRdMKauErPiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966747; c=relaxed/simple;
	bh=aE+TolPpJytr2bw3ArY9+yrf8+LfS2HJO8eTc40Sjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh8FcqTyvlVHIgFKOkg8UMLGlsy9HSeFqGqPQHN1OebX4WffylBWJ8t/a63YEO+DCOgHp4Hql/zXkxvmHf+THjwfKUYXWhts3/+gAEa6QXWAtXDv/atxWELk2ybsYY5RvJOQusVxjGXGqPqTD+n0pksZ1Kmp0l8hMei0eMRed38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WYbfwUqq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYbfwUqq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QGIn3gg2dSpEZDpP3MpEJCGISaE8mMh3VrAkEfJj674=; b=WYbfwUqqSNrv/qSY0jjMdawH2e
	JIfhUbsbV4Gad4WhGnQqV5z563hDFi0QdB9/PBe+y2BqYnUtfiPC5ovxA+BEDDwXqSdAQtkjyk1YC
	stwUw8pSaGpiZlud6UiVNsRzxUDCoF3uNFwBMSTdCh1LCdhA4kE8A0kQsWpsryZ8+W+BGJi0AsO2p
	kLHVQhhfauHugr1HewzcBxsxzY39r5ssPH62L2CGfAww3xsjZz7OPXPYCKsRIVHEC3YW33wkae7gx
	aLoBns7p9Gh2CGaISqEKdXQvNDIjQDKGz9rZ0G9rXb9wQ0WzIrMwRlrneRI73AWTH97EYVMPZIM0K
	LjBMijnA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hXc-0000000CZza-2Wqf;
	Fri, 18 Apr 2025 08:58:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D5E4300619; Fri, 18 Apr 2025 10:57:44 +0200 (CEST)
Date: Fri, 18 Apr 2025 10:57:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wong <wangqing7171@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "perf/core: Fix hardlockup failure caused by
 perf throttle"
Message-ID: <20250418085743.GN38216@noisy.programming.kicks-ass.net>
References: <20250405141635.243786-1-wangqing7171@gmail.com>
 <20250405141635.243786-2-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405141635.243786-2-wangqing7171@gmail.com>

On Sat, Apr 05, 2025 at 10:16:34PM +0800, Qing Wong wrote:
> From: Qing Wang <wangqing7171@gmail.com>
> 
> This reverts commit 15def34e2635ab7e0e96f1bc32e1b69609f14942.
> 
> The hardlockup failure does not exist because:
> 1. The hardlockup's watchdog event is a pinned event, which exclusively
> occupies a dedicated PMC (Performance Monitoring Counter) and is unaffected
> by PMC scheduling.
> 2. The hardware event throttling mechanism only disables the specific PMC
> where throttling occurs, without impacting other PMCs. Consequently, The
> hardlockup event's dedicated PMC remains entirely unaffected.
> 
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0bb21659e252..29cdb240e104 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10049,8 +10049,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>  		hwc->interrupts = 1;
>  	} else {
>  		hwc->interrupts++;
> -		if (unlikely(throttle &&
> -			     hwc->interrupts > max_samples_per_tick)) {
> +		if (unlikely(throttle
> +			     && hwc->interrupts >= max_samples_per_tick)) {

Well, it restores bad coding style. The referred commit also states that
max_samples_per_tick can be 1, at which point we'll always throttle the
thing, since we've just increased.

That is, the part of the old commit that argued about e050e3f0a71bf
flipped the compare and the increment is still true. So even though it
might not be related to the hardlockup problem, I still don't think the
patch was wrong.
