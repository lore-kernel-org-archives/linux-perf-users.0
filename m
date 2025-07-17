Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5513790B;
	Thu, 17 Jul 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764719; cv=none; b=CfnmF/BgeaZoJ3mUIGo99OKfK8P+3UTisv40SrsTTEi4P6V5/ivS62GC6SHIMAvM0hAm4ke3ZcRKRyuHyLZBw9EtNYACtGt6pauuB8KgtGiAWsSpbr6GPdhuxxuRvY8cbLxyofG+SEa2I545F0R+dmIxtbyjs/wM/aWDrSpaWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764719; c=relaxed/simple;
	bh=uoLRd01WGj9blBLb7RINWtE7jWKrNCOt2K+pkM8WXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNrqYDw4XvNi/QUwnAyuNurpk2A67LS3Juj6UoFDcBK7LLOM2YhO/K59R9rZMFkeO09ToeIXrGZx4pzV1d358XCVBujO90Zp49j7BUA3QmCTZ9RMXs/nkE5Gs8PEZW5LSjs4WjqTrczx5Orwe/dG4A0zpBb6F74GRBBGrcYrXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20241596;
	Thu, 17 Jul 2025 08:05:09 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B73C3F694;
	Thu, 17 Jul 2025 08:05:14 -0700 (PDT)
Date: Thu, 17 Jul 2025 16:05:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <aHkRJdAuvhS2mNQj@J2N7QTR9R3>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <aHUeUMmn_19EayL1@willie-the-truck>
 <be327242-ad55-476a-bed4-44c33c263962@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be327242-ad55-476a-bed4-44c33c263962@gmail.com>

On Mon, Jul 14, 2025 at 11:59:36PM +0800, Nick Chan wrote:
> 
> Will Deacon 於 2025/7/14 夜晚11:12 寫道:
> > On Mon, Jun 16, 2025 at 09:31:49AM +0800, Nick Chan wrote:
> >> This series adds support for the CPU PMU in the older Apple A7-A11, T2
> >> SoCs. These PMUs may have a different event layout, less counters, or
> >> deliver their interrupts via IRQ instead of a FIQ. Since some of those
> >> older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
> >> be enabled by the driver where applicable.
> >>
> >> Patch 1 adds the DT bindings.
> >> Patch 2-7 prepares the driver to allow adding support for those
> >> older SoCs.
> > Modulo my nits, the patches look alright to this point...
> >
> >> Patch 8-12 adds support for the older SoCs.
> > ... but I'm not sure if anybody actually cares about these older SoCs
> > and, even if they do, what the state of the rest of Linux is on those
> > parts. I recall horror stories about the OS being quietly migrated
> > between CPUs with incompatible features, at which point I think we have
> > to question whether we actually care about supporting this hardware.
> The "horror" story you mentioned is about Apple A10/A10X/T2, which
> has a big little switcher integrated into the cpufreq block, so when the
> cpufreq driver switch between states in the same way as on other
> SoCs, on these SoCs that would silently cause a CPU migration. There
> is only one incompatible feature that I am aware of which is 32-bit EL0
> support.

Surely the MIDR/REVIDR/AIDR also change?

In general, silent migration isn't acceptable for the kernel, even if
you largely happen to get away with that today. It is not acceptable for
architectural feature support to change dynamically.

> However, since the CPUs in these SoCs does not support
> 4K pages anyways in practice this is not an issue for as long as
> CONFIG_EXPERT is disabled.

Do these parts have EL2?

> > On the other hand, if it all works swimmingly and it's just the PMU
> > driver that needs updating, then I could get on board with it.
> 
> As mentioned above, it does all work fine when CONFIG_EXPERT is not
> enabled, and if it is enabled, then 32-bit process may crash with illegal
> instruction but everything else will still works fine.

I don't think that's quite true, unless these parts are also violating
the architecture.

If the CPU doesn't implement AArch32, then an ERET to AArch32 is
illegal. The way illegal exception returns are handled means that this
will result in a (fatal) illegal execution state exception being taken
from the exception return code in the kernel, not an UNDEF being taken
from userspace that would result in a SIGILL.

I do not think that we should pretend to support hardware with silent
microarchitectural migration. So at the very least, we do not care about
A10/A10X/T2.

Mark.
