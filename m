Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B34315A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498459; cv=none; b=bt0UyJEc978boa8nNdd4JAlxUn0hDcq8TKljipAHaCMQ79YMaaoWL3pHNlRqEZGgqGgU/M6n4eBcK6aM+HfUCv+b+9pH8JwZcLP28kJb8BV1hybOFVbGufBOmDX+KZhHfx1uivOsyDi9AUBtofgzAjgbCYCcqc9JdfFmICdhu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498459; c=relaxed/simple;
	bh=jqkD9NnjSzNMQFIzMgtc42gfx4cD5lfa7KYuegCaDgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXsS6ZpNKjnhDB+UqKrEPWR0MY3/ZL9Kj0na7G2d5J9Aj/Y0RT3U7z0ISyvG8sN023bWn1lFOpk1Rb8rnQe0HWULxCfz6KzLLlVItlkEPCrB1phYaAhFOfl1L6mPGvW/7PQLi7i/l0MQ3nzA05kI9EElzTcP4wl5c8etD3Y2t1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAXIvsSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAXIvsSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4972C4CEED;
	Mon, 14 Jul 2025 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498458;
	bh=jqkD9NnjSzNMQFIzMgtc42gfx4cD5lfa7KYuegCaDgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAXIvsSc1FY8lEunNfVO1/aODep/5SEf1uGccoGx/j4JCYuAJkOVB6g7tjj6OCohl
	 Ds63TKBa9uGAI5Begs2L3F0mx3o+FzUT4NRLxWKkdcFb0VEmZPdKB2+zYDFrYGEo3v
	 oGXMB5VwZVJXzXkT8GdpT1MGcS/4+8yKiI6LsWM3yZpaDdW11OlW3qJStxlUU5pFTz
	 9Jlk6GwJdt0gqvRJ/eYY0yeKrFmmXg/DNemtjkLqQKFn/7dlgHZCaiNgcFe3L7uaWj
	 2u3/Zrp2ylTk0ni52XWHN4Zd6Q1usfQ6NYGDFtLT3WTnym1/Z6VJ0FXiQZWqN3xpnd
	 FrT3HtTnySjeA==
Date: Mon, 14 Jul 2025 14:07:32 +0100
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	German Gomez <german.gomez@arm.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 01/14] drivers/perf: arm_spe: Expose event filter
Message-ID: <aHUBFGPck-O3vs9b@willie-the-truck>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
 <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>

On Mon, Jul 07, 2025 at 02:39:23PM +0100, Leo Yan wrote:
> Expose an "event_filter" entry in the caps folder to inform user space
> about which events can be filtered.
> 
> Change the return type of arm_spe_pmu_cap_get() from u32 to u64 to
> accommodate the added event filter entry.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4ec5604eba242cb620327cd2a6a87d..78d8cb59b66d7bc6319eb4ee40e6d2d32ffb8bdf 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -115,6 +115,7 @@ enum arm_spe_pmu_capabilities {
>  	SPE_PMU_CAP_FEAT_MAX,
>  	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
>  	SPE_PMU_CAP_MIN_IVAL,
> +	SPE_PMU_CAP_EVENT_FILTER,
>  };
>  
>  static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
> @@ -122,7 +123,21 @@ static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
>  	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
>  };
>  
> -static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
> +static u64 arm_spe_pmsevfr_res0(u16 pmsver)
> +{
> +	switch (pmsver) {
> +	case ID_AA64DFR0_EL1_PMSVer_IMP:
> +		return PMSEVFR_EL1_RES0_IMP;
> +	case ID_AA64DFR0_EL1_PMSVer_V1P1:
> +		return PMSEVFR_EL1_RES0_V1P1;
> +	case ID_AA64DFR0_EL1_PMSVer_V1P2:
> +	/* Return the highest version we support in default */
> +	default:
> +		return PMSEVFR_EL1_RES0_V1P2;
> +	}
> +}

Hmm. This logic was already a little shakey and so I'm not sure it's a
good idea to expose it directly to userspace. Maintaining RES0 masks for
different versions of SPE won't scale and there are already things that
we can't sensibly handle. For example, E[8]:

  | When (FEAT_SPEv1p4 is implemented or filtering on event 8 is
  | optionally supported) and event 8 is implemented:

So, stepping back, can we remove this stuff altogether? The bits are
RAZ/WI in the case that the even is not implement, but that means that:

  | Software can rely on the field reading as all 0s, and on writes being
  | ignored.

so why are we even bothering to police this?

In other words, remove arm_spe_pmsevfr_res0() and the two checks that
use it in arm_spe_pmu_event_init(). If userspace tries to filter events
that aren't implemented, then it gets to keep the pieces.

Will
