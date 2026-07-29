Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52448987D;
	Wed, 29 Jul 2026 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363936; cv=none; b=lD4aUz7DDU9d8vjcwkm2C32A1KzmKMiyU6BeswNHeH6T1vHobbpDD5mE7uRcsXUM39t7bOBldUsk7NRasq3BU0As+IKK2TVrOWBLZpVC4T99PLm6CzgmFWy8waWsxmCj6OKH0LRGxN7aTnyn5dSiuxum+HbOpr5vqt85jCP4Tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363936; c=relaxed/simple;
	bh=31lh+ES/3Vvx0m9UblcE4aazbdLaNrQlTeljh5Ykd7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8flGRFuTra2PcEEUhdJgI8fVkwCOJIgb8QHmhL7sZFleKFxBGxfbkccpDbpbG4S1fj68x1pPO4kjVG+3RCGyJ8g9c0PxNpKC9uY71DU6sPbUgTaUmo5EnoekfnmK9QdOAESHmIZO3DymMxdIvSncRIaRlDJyhZi0XTB+3MDLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELe7Ee/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELe7Ee/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8139A1F00A3A;
	Wed, 29 Jul 2026 22:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785363934;
	bh=oqJZ0+GXjmTO7BzO9ERh0Bj5MFnomN5JB/CO3PIq9Jw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ELe7Ee/QmaG5FoKPBeOFJb0x0cWhREtv9MTZ3BwJrJQ3bxTSzO/MCrLcchlN4LUaR
	 Dbij8k/fp11QsZaWk/uEb9c988p1PHA3TXJFAqhN5O1gw+skbu3rB22rA13Py/WtwS
	 ZEBnyXujhtA/jFvX7RQd3KSNoEVqfDvuGOnEXOmJer1ih0LbA+qmtajK6y23UGvKvu
	 Kys3BA7V0Dumf1Dyw+azn0DLyPgHJ2pVb6Yhadh9MbpWvD1xoiqsVGjQx+Tt9iOQGR
	 bkmPnZG4dMi9JFEOJZA66agsXPvQLvYvvhBCFK0RzADkfrbpTA76INxUufDVjmf21f
	 mcwOYqTyG06Sw==
Date: Wed, 29 Jul 2026 23:25:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] perf/cxl: Clear stale event fields before
 reprogramming a counter
Message-ID: <20260729232529.27d08ff4@jic23-huawei>
In-Reply-To: <20260729145555.3919550-3-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
> selections into a configurable counter's config register without clearing
> those fields first, and cxl_pmu_event_stop() leaves them set. Reusing a
> counter for another event therefore ORs the new selection onto the old,
> counting the wrong events with stale edge/invert behaviour.
> 
> Clear EVENT_GRP_ID_IDX, EVENTS, EDGE and INVERT before applying the new
> values.

Maybe use FIELD_MODIFY() instead of mask then fill?

Otherwise LGTM.

> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/perf/cxl_pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index e77c0650a7eb..3138514157cd 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -641,6 +641,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>  	}
>  
>  	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> +	cfg &= ~(CXL_PMU_COUNTER_CFG_EDGE | CXL_PMU_COUNTER_CFG_INVERT);
>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
> @@ -651,6 +652,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>  
>  	/* Fixed purpose counters have next two fields RO */
>  	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> +		cfg &= ~(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK |
> +			 CXL_PMU_COUNTER_CFG_EVENTS_MSK);
>  		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
>  				  hwc->event_base);
>  		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,

