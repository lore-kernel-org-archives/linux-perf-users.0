Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16D41442F;
	Sun,  4 Oct 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103520; cv=none; b=ifpL9A1Y7vi7agaBn3avb5RDOJa2qNdMP/gCQCJbEZ05AF+y6bZj5Cm2waExFwbmCrJR/FYdM7bU6Ug4R3cuY8TDb2DfOUUus23ZBAWK8Dt8EIKQU6e1yFry/dEzYZo88+/kemMqgr0IUJ4qJuqVr+0+L5KXu/LQw0pHamNiNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103520; c=relaxed/simple;
	bh=M2+1n/Et7nEdx2QhvFqH/JrUMuhz223DfjvwVDJTSSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPQnCj2vUwNX6ljCYpGu9Eum/9q1tTDHANg9gzJRwEfVco9MPwzB2P9ai6tEE8J4yA1d/qj55hAA0YdmUTLVaFg1QD0ncjnElEL3namiODCSfiA5/BRqyVoMg8jkdDoLnuwhyQbobeYL9tVq6TL6meANyaybpYCBSKpdwUTOWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZYL6ljQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZYL6ljQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E621F000FF;
	Sun,  4 Oct 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791103518;
	bh=mWtZc0bjjl64xaANXigV+9F0Zg1QFWUdNiNWNiWvNto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GZYL6ljQie/p6P3XjvuAqOTszsXJz0/4NmqMGLHgFUkl6eUusjXheNkOk0TEpslfh
	 JAkOnL4DRM4wpjzDMk8SLZiZjzMXpRu1J+MdZ0n4p3ci1FtFaDAkvqJRjBEchsi5Cu
	 ybJ8iRy9gCfwSsI9jFgeLe5ErKoKtR354m35+UW8igrAefAGO+7rCr/R3g1wTZeR46
	 ZBDCZFWKz+rnZbafxP55dxaRYgrZzpaMMy6RKYLPa/eYexZMgboIc8MjAQeEZk3Ucb
	 4hxiqVXKKxFhid6v8IrOQJrpqgR9kV+m9eE18hXr2/QbEcILBTg9t4xriL/XkF7mam
	 pMaHqZmEHDCXA==
Date: Sun, 4 Oct 2026 09:45:13 +0100
From: Will Deacon <will@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ
 lookup
Message-ID: <asISGdljsG86gUwb@willie-the-truck>
References: <20260811041934.7609-1-phucduc.bui@gmail.com>
 <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
 <asCyI2_CNSoDJy1w@willie-the-truck>
 <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>

On Sat, Oct 03, 2026 at 06:11:52PM +0700, Bui Duc Phuc wrote:
> Hi Will,
> 
> > > > Not sure about this. If it's optional, why should we bail the probe if
> > > > we don't manage to get an irq? Surely it's better to continue without
> > > > the interrupt in that case?
> > > >
> > >
> > > platform_get_irq_optional() returns -ENXIO when no IRQ is available.
> > > Other negative return values indicate errors, including -EPROBE_DEFER.
> > > In the case of -EPROBE_DEFER, we should propagate the error so that
> > > the probe can be retried later.
> >
> > Thanks, The -EPROBE_DEFER case seems more compelling, so perhaps we should
> > check for the expliitly (because it won't fail the probe altogether)?
> >
> 
> The idea of the _optional getters is that only the "not present" case
> is turned into a special value (-ENXIO here, NULL for
> devm_clk_get_optional()), while real errors are still reported to the
> caller.
> 
> Besides -EPROBE_DEFER, platform_get_irq_optional() can return other
> negative error values depending on how the IRQ is obtained. These
> indicate an actual error rather than the IRQ simply being absent.
> Ignoring them would leave the device running without its interrupt
> and no indication of what went wrong.
>
> 
> So I'd rather keep:
> 
> -----------------------------------------------------
> irq = platform_get_irq_optional(pdev, 0);
> if (irq < 0 && irq != -ENXIO)
>         return irq;
> -----------------------------------------------------
> 
> and continue without the IRQ only for -ENXIO. This is also the usual
> pattern for platform_get_irq_optional() users.

Sorry, but how is failing the probe possibly better than continuing without
the optional interrupt? Add a diagnostic if you like, but aborting the probe
feels completely unnecessary to me.

Will
