Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556703B1EFC;
	Wed,  1 Jul 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889224; cv=none; b=gVqdx51bFAIqfYjzxqQ+JEgvdVsAjzuYr57fKtbGjxF5iG3mBnRcOtr++7ET8KKH3S6sDyN76XkIdLQXlmBC2Uvd5i8tKBZZNmoGxupELoQyqkCmfyHN904bvc+VlwjwuDZajBQNxYWpLm3MAzyhQMG63POs7GxWtcBi3i026Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889224; c=relaxed/simple;
	bh=Y9guv2F/oBqZGPTqN3QWMMt1gkXw0T2ueBHQuw37Mu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjDN6rwaVxInMmBZ0uU9+96XAfJxtJJ0JvLZFRR3YCw8Lxz9tlQCfKrotHb+Si29Z074Yl/wmEtuv6mbp9Og8Za91iQY6Olw9829Dmawy/ssBpgSfQSLxGPTen0bx+NXiQpx3+twk09cq5TvCBhb3Tv0Qg1Xh0zIsiHqUBCGNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JW+GAn2p; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JW+GAn2p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R+LC/M4ET5h02A5BnsmhishvP9qZsxELfeidDn/MK20=; b=JW+GAn2p9ZIpHlXept2F5VNXAh
	oPyVwq9xevU6R4FyQ+yxvGf++EolUla7PhPmuqFEQrAWfTMd5xArrye+XGkLtRcXBHS0givpJWQkw
	SiL6HDG+QMqBy93A+fFI/HWsJpb+BqHWdswKEsBaqkWXU1fwVXDRQLAOz/zioOi1+iHGNl3dYuMCE
	UcITiE4/xfefCk3EFvAoqCGaU8xReizpbzBC4gyOsvoAvNUd3BeQzOzq01Y+AnpRGXaKI4ZocTvAB
	rM/0lsX7iQlhllzPyglets2OowZoHtfJb4kegi2Dk5aE/74l7J9msv2jI/Rscil5g6fR3wV3pthlN
	dyLfX5MA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1weove-00000002S3Z-3eXs;
	Wed, 01 Jul 2026 07:00:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0B33030035C; Wed, 01 Jul 2026 09:00:14 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:00:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Liu <liuqi@hygon.cn>
Cc: mingo@redhat.com, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, lijing@hygon.cn,
	Zhenglang Hu <huzhenglang@hygon.cn>
Subject: Re: [PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper functions
Message-ID: <20260701070013.GJ48970@noisy.programming.kicks-ass.net>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-2-liuqi@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701034413.718872-2-liuqi@hygon.cn>

On Wed, Jul 01, 2026 at 03:44:11AM +0000, Qi Liu wrote:
> Add common helper functions for AMD-family uncore PMU handling.
> 
> The helpers cover event initialization, counter allocation, counter
> read/update, event start/stop and per-CPU context management.  These
> paths are not tied to a specific uncore unit and can be reused by
> drivers with a similar uncore PMU programming model.
> 
> Signed-off-by: Qi Liu <liuqi@hygon.cn>
> Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>

> +EXPORT_SYMBOL_GPL(uncore_common_set_update_interval);
> +EXPORT_SYMBOL_GPL(event_to_uncore_common_pmu);
> +EXPORT_SYMBOL_GPL(uncore_common_attr_group);
> +EXPORT_SYMBOL_GPL(uncore_common_start_hrtimer);
> +EXPORT_SYMBOL_GPL(uncore_common_read);
> +EXPORT_SYMBOL_GPL(uncore_common_start);
> +EXPORT_SYMBOL_GPL(uncore_common_stop);
> +EXPORT_SYMBOL_GPL(uncore_common_event_init);
> +EXPORT_SYMBOL_GPL(uncore_common_add);
> +EXPORT_SYMBOL_GPL(uncore_common_del);
> +EXPORT_SYMBOL_GPL(uncore_common_ctx_init);
> +EXPORT_SYMBOL_GPL(uncore_common_ctx_free);
> +EXPORT_SYMBOL_GPL(uncore_common_ctx_move);

I like the idea, but I don't particularly like the namespace.
'uncore_common' is too generic, there are a ton of uncore drivers, even
on x86 and these functions are specific to the AMD family. That is, they
aren't really common at all.


