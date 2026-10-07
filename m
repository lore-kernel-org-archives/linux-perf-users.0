Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E0480331;
	Wed,  7 Oct 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382750; cv=none; b=AdAbU4xd9CUcsxDhk/C53vGZqbGh982NjVki2KFg5AQmO7bsjm6nLSrZpvxNbAe/zIMtvldJXnbeggOOHQ/YXnYuzutiP46xClqRZzvH6QeKjUbq1BtFPz0UKYLAGzSHXwal3/TJnXC4/sca169fji5J+PlpAoi+N9jH4nJ7inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382750; c=relaxed/simple;
	bh=hwccp9lknY33tQPANQfx5TJJ57/QY3qWuFwvTxcy+5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMjwkDlm6GOwxp+Vl1VTj4P2jYo8vl0FBTTI83+YlARHPASe4vv+wi6+GMqxkqm53fEkClPWHzMiBp15Owcp0F78X71r+ACHAQ8jq5PqU+NwyoDbfKAo8jojrTOY8igDyZCZhS9W8hmlrGmRlug1jdz4pDVSMk4uNLbvsh0Bw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk4XJlTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk4XJlTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831641F0089B;
	Wed,  7 Oct 2026 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382744;
	bh=9E5douEvnl79iHjWkyFm82J2TQ2sXA9KpzAuoqF4t4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gk4XJlTjQoSq2o6hSxLhwTu84JOe9R3yg1stHfUIJNJs/ZoJOFA12d714OGlTfGJT
	 DbsyPQWsprKRYM4S1xW10HiR8XUmxWsxjz5fOwDxgDD/M/RiuyHcTqIWwPA5cA9TAN
	 kgSlr3kASKMNNPzfDHSqn9qAp8QbUqYJ4joEbzZD/9Cryt+gqfCSDB8ex7J54r9F0T
	 3NrXBEf3rSYAs0DdccebCaBy/hFuP2drjuWD9Y4bqtdIOE9pXE0RF4HV8f1W+wJoYl
	 R9yIpzNuPeQlUQXHHKX76UnsroY6SyEVWpSzqEzOXWYTWLel1DB3FoCMumRMMJmPOB
	 TbposgSKGkAhA==
Date: Wed, 7 Oct 2026 15:18:59 +0100
From: Will Deacon <will@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ
 lookup
Message-ID: <asZU0waS4-lKy8uQ@willie-the-truck>
References: <20260811041934.7609-1-phucduc.bui@gmail.com>
 <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
 <asCyI2_CNSoDJy1w@willie-the-truck>
 <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>
 <asISGdljsG86gUwb@willie-the-truck>
 <CAABR9nFMR+D0j5kYR+HwLBOHG4WF7PUDrqjE4Bt0-VTUacxmBg@mail.gmail.com>
 <asJlxV06xzDIgqW4@willie-the-truck>
 <CAABR9nFz65Yt-SeHAx-Gxe18c4i3Sb3b_H-zsr7d+wwK5gB=CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nFz65Yt-SeHAx-Gxe18c4i3Sb3b_H-zsr7d+wwK5gB=CQ@mail.gmail.com>

On Mon, Oct 05, 2026 at 03:02:29PM +0700, Bui Duc Phuc wrote:
> > > > Sorry, but how is failing the probe possibly better than continuing without
> > > > the optional interrupt? Add a diagnostic if you like, but aborting the probe
> > > > feels completely unnecessary to me.
> > > >
> > >
> > > My understanding is that the driver is designed to be generic and
> > > support various hardware configurations, some with this resource (IRQ,
> > > GPIO, clock, ...) and some without.
> > >
> > > If a configuration describes the resource, it means the board is
> > > designed to use it. For that hardware the "optional" nature of the
> > > driver no longer applies, so if we fail to get the resource the error
> > > should be returned.
> > >
> > > A log alone is easy to miss, and the root cause still has to be found
> > > and fixed later anyway. Failing the probe makes the problem visible
> > > right away, when the board is being brought up.
> >
> > If you're doing bring-up, you should probably pay attention to the logs.
> 
> OK. Then we should probably write it as:
> -------------------------------------------------------------------------
> irq = platform_get_irq_optional(pdev, 0);
> if (irq < 0 && irq != -ENXIO)
>         return dev_err_probe(pdev, irq, "failed to get irq\n");

Won't this bail on errors != ENXIO and != EPROBE_DEFER? I think we should
only bail on EPROBE_DEFER. That's also more robust to changes in the error
codes that platform_get_irq_optional() can return.

> -------------------------------------------------------------------------
> 
> > If you're trying to use the device, you probably don't care about the
> > interrupt.
> 
> If we're worried about returning an error here because it might cause
> the device probe to fail, then shouldn't we hide errors from all
> the other functions in probe() as well? :-)

Not really. Only the irq is optional; we really can't continue if something
like ioremap() fails.

Will
