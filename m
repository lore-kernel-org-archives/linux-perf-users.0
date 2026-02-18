Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD92798E8;
	Wed, 18 Feb 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393895; cv=none; b=pTlTwVsLpUwFMsZnjjgt8iMoihU63UBiboCBDph4/or/wKj50WZzMzziDo2vdhhSRz5Qk2f1vUs01b09/n2okJ/rDG8mNldH0jkGe0wMngGfoByyZ90PROlIUhf/A1K3432lnFQXURcu8tJRb+ZbVcP0grqXisIBG4xIrN+xwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393895; c=relaxed/simple;
	bh=thk46i8BtK7i+MPwj1lgdOz72SgP7nVhVJWgG+zcIfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgaqiWypgzyqEnI4fGf2B4y8p98NDnHnA+GN1y2kxaMxfoytM0t1cc5DGre88AhhwELOXw0CocFOGXRjktaoEhlVyBbvy4uD5ao6ncl/U7Ej02W1VqNpeh2Uq1RoCoLaRYLtmHmBDbBTf704XfAB+bNPUkzX7pKlD2me7E753V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7v2Qlt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7v2Qlt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F67C19421;
	Wed, 18 Feb 2026 05:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771393895;
	bh=thk46i8BtK7i+MPwj1lgdOz72SgP7nVhVJWgG+zcIfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7v2Qlt1vArm72JCrGKmBTNUnaNH07gf15mHSK9kxl760SmYfIRffTaQXrKQVF1bU
	 obW+FJGEDs9eVJjyNfSbp6C49Rttbc6PAt3hjNO4tI2rAHjsfzlksJXYGyBFvE1edR
	 C55DclkkYPLj2rqYYdleJlTXvvpdFb0DX+hu6jvzav1aeAaKPYznC7NgFMItFk8lfu
	 loxdh8pE3SgtVYhX9dWh8rADWAZbTivQ7lEfRfodJKMy3k0MQS7s8FpQRFJLAC/RUg
	 9r/rLB29ypVyMjdPg2jevsFEjTT7muRriLKm6oSvdW5SYXgo/RhJnYL2nBDpo0y4Xq
	 5Ah3lpN8iqPVw==
Date: Tue, 17 Feb 2026 21:51:33 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 0/5] perf/amd/ibs: Assorted fixes
Message-ID: <aZVTZQDENf7yXkh3@z2>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260216042216.1440-1-ravi.bangoria@amd.com>

Hello Ravi,

On Mon, Feb 16, 2026 at 04:22:11AM +0000, Ravi Bangoria wrote:
> Address several issues in the AMD IBS perf code: interrupt accounting
> for discarded samples, a Zen5-specific quirk, PhyAddrVal handling,
> NMI-safety with perf_allow_kernel(), and a race between event add and
> NMI.
> 
> Patches are prepared on tip/perf/core (7db06e329af3)
> 
> v1: https://lore.kernel.org/r/20260116033450.965-1-ravi.bangoria@amd.com
> v1->v2:
>   - Split fixes series from future enhancements
>   - Add interrupt throttling for zero-rip erratum #1197
>   - Avoid calling perf_allow_kernel() in NMI context (new patch)
> 
> Ravi Bangoria (5):
>   perf/amd/ibs: Account interrupt for discarded samples
>   perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
>   perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
>   perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI
>     handler
>   perf/amd/ibs: Avoid race between event add and NMI

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  arch/x86/events/amd/ibs.c          | 28 ++++++++++++++++++++++------
>  arch/x86/events/perf_event_flags.h |  1 +
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.0
> 
