Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8582EF640;
	Tue, 17 Jun 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169817; cv=none; b=PzeepYFn1P6Gt4mk7Wsy3sEjOpzPkrIqjTvdartCKdb7rUr355j9XxBBtOnZM7uvV2IsIXtsDZuDBlbvQKBXzik//IdNPItOH5qIT+yctTwUzSK27uVEeYoX+orSfStP2AAB6tBkJQUjlVPO40mH+PDJn2QDDVPFCo/h/QFT9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169817; c=relaxed/simple;
	bh=iEyW4AnJa17J41ytX30hyC0XYY5ykVW3PixyY/HYRVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4xQi+kBvfCL3oroVwUthcU5vkYyZcF3uZQGTQp5NNCoAVl3XxzgXPvhaaqwuSvaupBhdy1TdqOuYOHfr+vCPlXP1WC+rfs+QhMoPi/ioBnMQx4nvOuxkKKTZj9+K3qw04eFfAwXpnJre1M2Jh2mM82ecF/vRd8TE2/hJ/hoLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldedivNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldedivNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6580C4CEE3;
	Tue, 17 Jun 2025 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750169816;
	bh=iEyW4AnJa17J41ytX30hyC0XYY5ykVW3PixyY/HYRVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldedivNmC+Dx33QQGeX6YYlF02DbQyggnZlZuRrMnhpKdB7m1bLbV0x91X65tgwac
	 DhEuntanyRA4hfLIfYdnBEIzAH2dIfyCAa4IsHU3H0GHhXU7KF/zboBQuB0soGRKoi
	 YbvERIK3fGE6vQpsnVY9xhf7xFyliq1GygKDbTJ4tVuHWKhu1IqjAaQCw4B7q8Pmi9
	 brbxZGzZK6k9/QuJKjZ5+0OWGqw9sNBjNWwKHWW+kiTLupotsRNj8UaXOHGMFufYCw
	 Pqz29c87Ai6cQKfIWaQeHkfEWAa8AQQIwCAxPZPqdy9hUFq5vy27uDcWxvzMYVJTsl
	 MRQ3Pg408arhg==
Date: Tue, 17 Jun 2025 15:16:50 +0100
From: Will Deacon <will@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Nick Chan <towinchenmi@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>,
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple
 A7-A11, T2 SoC support
Message-ID: <20250617141649.GA19021@willie-the-truck>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com>
 <20250616102945.GA17431@willie-the-truck>
 <CAP-5=fVjJyV2eA1aDnk6cqAhJGc9FZVyHhP7-f=1OyWmzxjN8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVjJyV2eA1aDnk6cqAhJGc9FZVyHhP7-f=1OyWmzxjN8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 16, 2025 at 03:44:49AM -0700, Ian Rogers wrote:
> On Mon, Jun 16, 2025 at 3:29 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jun 16, 2025 at 02:36:18AM -0700, Ian Rogers wrote:
> > > On Sun, Jun 15, 2025 at 6:32 PM Nick Chan <towinchenmi@gmail.com> wrote:
> > > >
> > > > This series adds support for the CPU PMU in the older Apple A7-A11, T2
> > > > SoCs. These PMUs may have a different event layout, less counters, or
> > > > deliver their interrupts via IRQ instead of a FIQ. Since some of those
> > > > older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
> > > > be enabled by the driver where applicable.
> > > >
> > > > Patch 1 adds the DT bindings.
> > > > Patch 2-7 prepares the driver to allow adding support for those
> > > > older SoCs.
> > > > Patch 8-12 adds support for the older SoCs.
> > > > Patch 13-21 are the DT changes.
> > > >
> > > > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> > >
> > > Hi Nick,
> > >
> > > This is substantial work and it looks good to me. Do you know why
> > > there's been little progress on landing these patches? Buggy Apple ARM
> > > PMU support in the kernel has led to reworking the perf tool. It seems
> > > best that we can have the best drivers possible.
> >
> > You reworked the perf tool to support these things? Why? These changes
> > are targetting chips in old iPhones afaict (as opposed to "Apple Silicon").
> > I think that (a) most people don't particularly care about them and (b)
> > they're not fully supported _anyway_ because of crazy stuff like [1].
> 
> I was meaning that we reworked the perf tool to work around the Apple
> ARM PMU driver expecting to work as if it were an uncore rather than a
> core PMU driver. More context here:
> "[REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5"
> https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st/
> But in general it would be nice Apple ARM PMU support were well loved.
> I think we went 2 or 3 minor releases with the perf tool not working,
> threats of substantial reverts to avoid the PMU driver bug being
> exposed, etc.

It's unfortunate that you've had a torrid time with the Apple PMU driver,
but I think it's important to realise that it's both unmaintained (it
ends up with me via the catch-all for drivers/perf/) and was written
based off whatever reverse-engineering people could be bothered to do in
their spare time. It's frankly remarkable that it works as well as it
does.

Despite all of that, I still don't think that your concerns apply to the
patches in _this_ series, which is about adding support for older Apple
chips.

> As for which Apple ARM devices should have perf support, it seems the
> more the merrier.

Easy to say when you don't have to maintain the driver!

Will
