Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775714;
	b=NWZC+WNHow0OFcrPH4+nn0s37ltAs6+VuBp5gfOSPi8Nt8fwx7HsoXOZcQMRHYnN5gMp
	 SfqYEsXMO6tup24u26csc0mxj8Ok1rpI0M8QYp3KSogrEQU/R6Nuoc0EKhNM6uQaEPGJx
	 o9BE23DXa4OacLJ2Kgr+4ligH03kNrhg4Ct/nRlQklfhvlHb9Vc/DEqWrjP1Bvj8GA2fG
	 Cx9bPOjC7C/P8hiIFFOkso+F2LnWcw8ttb57zU4JbyyeA8kI5HLiCjaVHQuWMsemohFU4
	 Ux1nzEdJ0gkvwP1Ub7e2j06wgYLycMYB9D2ncYYgW2zMO1ClHfS9cEJ10gNKCO3N7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775714;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=952yiB3XKkKJx2jlcE2T9cBcHOdTpffUYRnjcZrOm9g=;
	b=c7iQkgYFRa2icB21npIw2BfD6crb89j9ib4thVNV/pcXZTW2XTpTUMsmQP6qBGZV3umJ
	 2ZWzVVvNObSEqkLVA9PywEhKhmWbSVGcjt3J5htM1w58feWVkUiyj2z9V1ggdF7wsjXdX
	 nLVsgOfs2K7ATPgLiIOmaSuNuo+Cmj/PqwAHjSyquxBERuP7uLORXNo+v3a4qdomt/HcC
	 KVkH3UXREL6IyZjt04J3FJDIqw8ulZxRWipd0/PdQPYOENGkhRHCoOZoUhBd116fhtfEK
	 FpYsu+TDIuKL2KkI7dt2WzXowvNrUb5B8DmG5KEW1j0esHf2wumMOMxHCZ7PJKpanTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jky6L6vz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C514606A31C;
	Fri, 27 Nov 2026 10:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C514606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jky6L6vz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1CA31756;
	Fri, 27 Nov 2026 02:35:10 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3570A3F86C;
	Fri, 27 Nov 2026 02:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795775713; bh=+viwC7r5nVf1JXawcduVmmgm0qbQG3S33zlJBCPnFiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jky6L6vzghiEMhFKHHd5yU67Vr0X5oRfMhikFrwX0Wt0vtfvZvBS4TvR+HVfA0olM
	 alltWBqxSOw0cH1itYcRnd/9jAy2h7DfSn8CiL0obkWJxUs9ecoNGlmLJhrUi7zcx3
	 AQpDkyyMjlEZ3PbmjW+wwOYBYl+rdAWZH6YsFRQ0=
Date: Fri, 27 Nov 2026 10:35:11 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ping Li <leeonion.muyu@gmail.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh@kernel.org,
	james.clark@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Probe PMSNEVFR and PMSDSFR filter bits
 independently
Message-ID: <20261127103511.GA861809@e132581.arm.com>
References: <20261123073719.3190149-1-leeonion.muyu@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123073719.3190149-1-leeonion.muyu@gmail.com>

On Mon, Nov 23, 2026 at 03:37:19PM +0800, Ping Li wrote:

>   * The inverse event filter is written verbatim to PMSNEVFR_EL1, so
>     if PMSNEVFR_EL1 implements a different set of bits to PMSEVFR_EL1
>     then a filter using bits that are RAZ/WI is accepted and silently
>     has no effect, while a filter using bits that are writable in
>     PMSNEVFR_EL1 but not PMSEVFR_EL1 is wrongly rejected with
>     -EOPNOTSUPP.

I don't worry "PMSNEVFR_EL1 implements a different set of bits to
PMSEVFR_EL1", I would expect both have the same res bits in
implementation.

A possible case is FEAT_INV_FILT_EVT is not implemented, current code
uses pmsevfr_res0 to validate invert event filter, it can silently pass
check and start event, so it miss the chance to report error in the
first place.

>   * PMSDSFR_EL1 holds an inclusion mask which the driver exposes
>     inverted, so a set config4 bit requests that a data source is
>     excluded and a cleared bit requests that it is included. Bits
>     that are RAZ/WI are stuck at 0, so their data sources cannot be
>     included while the data source filter is active: exclusion
>     requests are always honoured, but inclusion requests for such
>     sources are silently dropped.

Arm ARM DDI 0487 M.b, D24.7.10 says unsupported data source bits are
RAZ/WI, so probing PMSDSFR_EL1 separately makes sense.

> Discover the supported filter bits of PMSNEVFR_EL1 and PMSDSFR_EL1
> separately, probing each register only when the corresponding feature
> (FnE / FDS) is implemented. Validate the inverse event filter against
> the PMSNEVFR_EL1 mask, and reject data source filter configs which
> ask to include a data source whose PMSDSFR_EL1 bit is not implemented.
> For missing features, keep a full mask so that filter requests are
> still rejected alongside the pre-existing feature checks.
> 
> Runtime-tested on Cortex-A78AE (SPEv1.0, which implements neither
> FnE nor FDS) and on an SPEv1.2 CPU implementing FnE (but not FDS):
> the PMU probes cleanly with the per-register discovery in place,
> event filter configs are validated per-bit against the probed masks
> with unimplemented bits rejected using -EOPNOTSUPP, and sampling is
> unaffected. The PMSNEVFR_EL1 probe path itself is exercised on the
> SPEv1.2 CPU, where the register happens to implement the same bits
> as PMSEVFR_EL1. Only the FDS path lacks coverage on hardware
> implementing the feature.
> 
> Fixes: 8d9190f00a975 ("perf: arm_spe: Add support for SPEv1.2 inverted event filtering")
> Fixes: e6a27290d800 ("perf: arm_spe: Add support for filtering on data source")

Please split the two fixes so each can be backported independently.

> Tested-by: Ping Li <leeonion.muyu@gmail.com>

Drop your own Tested-by tag.

> @@ -818,13 +820,22 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
>  		return -EOPNOTSUPP;
>  
> -	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
> +	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsnevfr_res0)
>  		return -EOPNOTSUPP;
>  
>  	if (arm_spe_event_to_pmsdsfr(event) != U64_MAX &&
>  	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * The data source filter is exposed inverted, so validate the
> +	 * value written to PMSDSFR_EL1 (~config4) rather than config4
> +	 * itself.
> +	 */
> +	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter) &&
> +	    (arm_spe_event_to_pmsdsfr(event) & spe_pmu->pmsdsfr_res0))
> +		return -EOPNOTSUPP;

Could we group it with the FDS check?

  reg = arm_spe_event_to_pmsdsfr(event);
  if (reg != U64_MAX) {
          if (!(spe_pmu->features & SPE_PMU_FEAT_FDS))
                  return -EOPNOTSUPP;

          if (reg & spe_pmu->pmsdsfr_res0)
                  return -EOPNOTSUPP;
  }

Thanks,
Leo
