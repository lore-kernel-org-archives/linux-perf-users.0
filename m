Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A730DEA9;
	Mon,  3 Nov 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177464; cv=none; b=ohJe2/1k00evan20xxwBO5yjM18NeTWIwAboXXD3dX4cNwXT9V8oI756nd6KKwTWUKVEc2MMTvnPrfyMiSTHGao5thsOmPwE5ge5ffw9qNxK0oXif3BgRR7diFYcV3p/dSTrjrGuwHy689gvP/IZz/MqvTPloseFRPcLv8Kd3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177464; c=relaxed/simple;
	bh=0MbAV9bNWbSdrKxjEc6SEhW2otB9NDHuKXLNye47LYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7FVmPeTr36YNs8/qkUMDkbCRWIj1jzeqLUpaEJzUBySZIvA5X3Mk23kKmwoGHr2JSPF3AARhisLH12hl/jqcaaRNXA7Wt/dn4LJ9KJ1bGlVEQj93RLumPHX7Ap8AV/3Nd38ND2SVI1e2m7UKU1hOoilQIBtxNQDZBjKkhskrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQw4MTmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQw4MTmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8F1C4CEE7;
	Mon,  3 Nov 2025 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762177464;
	bh=0MbAV9bNWbSdrKxjEc6SEhW2otB9NDHuKXLNye47LYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQw4MTmkeuu7tJsm35ZTr+SPFj62DZG75dkVxgZ7qMlIoDYfG55sxMZzcOuBLZAqE
	 WCbtKleagoN5AxpZWR519RitBnVTxNUjYMRkoo7H9n0l7SVHDaZlGeK+h/FaHVlF0O
	 iUWl6eqUOPjvfw9MxqAi0KmTktxc7kKUlmOl+WtMQkejRumLVNkKAdyMlPk2XaWKvg
	 WAt5CLxLnj7vwOA0XVyipOQiaarEpW2K3BfkXiUvZms3LuR5XyC3qk+a2qyPBiGPf/
	 /9AnaWLcOX3bjlxjrwvY1unWAAcNTjLqaOtDbSGOMM17hsBgv+uiScOcEYnZ33uKIE
	 HfHs2TLsiepGw==
Date: Mon, 3 Nov 2025 13:44:16 +0000
From: Will Deacon <will@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org,
	aou@eecs.berkeley.edu, atish.patra@linux.dev,
	catalin.marinas@arm.com, dianders@chromium.org,
	johannes@sipsolutions.net, lihuafei1@huawei.com,
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org,
	mingo@kernel.org, nicolas.schier@linux.dev, palmer@dabbelt.com,
	paul.walmsley@sifive.com, suzuki.poulose@arm.com,
	thorsten.blum@linux.dev, wangjinchao600@gmail.com,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/2] watchdog: move arm64 watchdog_hld into common code
Message-ID: <aQixsIQXTjYyhRVj@willie-the-truck>
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
 <20251014031425.93284-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014031425.93284-2-cuiyunhui@bytedance.com>

On Tue, Oct 14, 2025 at 11:14:24AM +0800, Yunhui Cui wrote:
> @@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const char *str)
>  	wd_hw_attr.type = PERF_TYPE_RAW;
>  	wd_hw_attr.config = config;
>  }
> +
> +#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
> +/*
> + * Safe maximum CPU frequency in case a particular platform doesn't implement
> + * cpufreq driver. Although, architecture doesn't put any restrictions on
> + * maximum frequency but 5 GHz seems to be safe maximum given the available
> + * CPUs in the market which are clocked much less than 5 GHz. On the other
> + * hand, we can't make it much higher as it would lead to a large hard-lockup
> + * detection timeout on parts which are running slower (eg. 1GHz on
> + * Developerbox) and doesn't possess a cpufreq driver.
> + */
> +#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
> +__weak u64 hw_nmi_get_sample_period(int watchdog_thresh)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	unsigned long max_cpu_freq;
> +
> +	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> +	if (!max_cpu_freq)
> +		max_cpu_freq = SAFE_MAX_CPU_FREQ;
> +
> +	return (u64)max_cpu_freq * watchdog_thresh;
> +}

Why does this function become __weak? Neither arm64 nor riscv override
it afaict.

Will
