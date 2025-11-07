Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA072604;
	Fri,  7 Nov 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521056; cv=none; b=hOSw9iStdsrpxr8tm+z5IFg2hqvPP86/BT9PZrwH48X1FSy6uKo18dVXh2GsQDwUOnREETYY2vfRutwKnnefH7V2G3xq40ENn9On3Bz6DXeUSEi2xM2DRRHeOAEbQ3NmOy92/6sBAHp+67KokbLTIqHa6nE/jKcA1fp7YzreKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521056; c=relaxed/simple;
	bh=9yNpA1SE+6LUazhxfaVM0P+KTY2xAhLSO9vXTnuC8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+RRB4j7ehgvHkpUT6gT6uNiESXdHMpnjO2VF43yEQLgCZcBLKE+YvJ09sdBnA2yq4zGOQSwYO013IZtGVHgXJI/SDlmvgXWYsVrd+FvfhcbF6ojz0NMkVeWlCae/UArDL6FFTYS4+cEDIUbty5HT7P34DtD8Roa314JORzkgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1pL5YGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1pL5YGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84724C19421;
	Fri,  7 Nov 2025 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762521056;
	bh=9yNpA1SE+6LUazhxfaVM0P+KTY2xAhLSO9vXTnuC8wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1pL5YGYFuG6hxkKpIelSp4d5IkSoL6mbBtbq2kEckqm8NKtXk0sV5yE4uZEwNt1q
	 ethdg2+fJxg4IQ7wEAJCWBsr3M4QlRFC7sKNaUDJXDpXrb0nfCOAbjbv0gQI6Bru4h
	 fydJwyetpw3hex5Orwn9R0FuIcYMuiERvBPHxKwFDX6pnNRSlfwUb95i792MUyccOa
	 O9tAxtas6uw8A1dp02fOK28qXtF/zEGda7ciCQzGk07YYgKSw4/Oe51Xdq2hvdAj40
	 vHZ4hzLyNf5jfkxq0b0gGTPJw99/B9LhRb33I8h/Xl0Ebl2LMSB+9pgDUEbMvSEIE1
	 q358Q5AwLVEig==
Date: Fri, 7 Nov 2025 13:10:47 +0000
From: Will Deacon <will@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
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
Subject: Re: [External] Re: [PATCH v4 1/2] watchdog: move arm64 watchdog_hld
 into common code
Message-ID: <aQ3v15yrm9JaWgrm@willie-the-truck>
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
 <20251014031425.93284-2-cuiyunhui@bytedance.com>
 <aQixsIQXTjYyhRVj@willie-the-truck>
 <CAEEQ3wk5Ru4-=4Ecnc6kQAAbR57806xxYTz0o1z4KfgZE6Cg6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wk5Ru4-=4Ecnc6kQAAbR57806xxYTz0o1z4KfgZE6Cg6w@mail.gmail.com>

On Fri, Nov 07, 2025 at 10:42:25AM +0800, yunhui cui wrote:
> On Mon, Nov 3, 2025 at 9:44 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:14:24AM +0800, Yunhui Cui wrote:
> > > @@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const char *str)
> > >       wd_hw_attr.type = PERF_TYPE_RAW;
> > >       wd_hw_attr.config = config;
> > >  }
> > > +
> > > +#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
> > > +/*
> > > + * Safe maximum CPU frequency in case a particular platform doesn't implement
> > > + * cpufreq driver. Although, architecture doesn't put any restrictions on
> > > + * maximum frequency but 5 GHz seems to be safe maximum given the available
> > > + * CPUs in the market which are clocked much less than 5 GHz. On the other
> > > + * hand, we can't make it much higher as it would lead to a large hard-lockup
> > > + * detection timeout on parts which are running slower (eg. 1GHz on
> > > + * Developerbox) and doesn't possess a cpufreq driver.
> > > + */
> > > +#define SAFE_MAX_CPU_FREQ    5000000000UL // 5 GHz
> > > +__weak u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > +{
> > > +     unsigned int cpu = smp_processor_id();
> > > +     unsigned long max_cpu_freq;
> > > +
> > > +     max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > > +     if (!max_cpu_freq)
> > > +             max_cpu_freq = SAFE_MAX_CPU_FREQ;
> > > +
> > > +     return (u64)max_cpu_freq * watchdog_thresh;
> > > +}
> >
> > Why does this function become __weak? Neither arm64 nor riscv override
> > it afaict.
> 
> Would you say there’s any particular issue here? If some architectures
> might need to override the hw_nmi_get_sample_period() function later
> on, wouldn’t __weak be a more reasonable choice?

__weak is pretty brittle (it can depend on link order if you have multiple
targets) and I suspect it prevents inlining when LTO isn't enabled. It's
cleaner and more robust for architectures to provide their hooks by
#defining the symbol, as is done commonly in other parts of the kernel.

But in this particular case, it's completely unnecessary because there
isn't an architectural override and so this function should simply be
static.

Will
