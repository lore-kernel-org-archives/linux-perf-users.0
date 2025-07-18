Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B3B1B87F0;
	Fri, 18 Jul 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850929; cv=none; b=ocrBdmp0gi0uL0SGbjGvrlMBG3jf5jgvESgsO8lCpSmSih9aEZXe3wee9TFkZ3hmJK74sffNOOO+BgwnEyIzeJ57PmuJnkUKZkcmJiHhkc6pIDSLRgY0EsklBK2z2rO+lBHzKVuqEUypycOGaSnS5LAXQBv7H4jxdMxuk8oYv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850929; c=relaxed/simple;
	bh=gaE4ZC3ILEUagvfAVqvzN406gZmK89Cu8YYw+eY8jXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACnu7f8halKZ7Z3z6JfQIz98KEPbvJpG6nqnNTYcsMy6BWH7qBs2aYv22ZFytBZiQqJBKXdBg+zOUa0sGyN+rH8YbksVTG22Wl0m3QxIh7MUBaR+jB4aMRz1PTK6O06U4CUn3SvMVE2mef854Mn318TrZ6wAMK9kG9T5gAlYdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF4216A3;
	Fri, 18 Jul 2025 08:01:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617CB3F6A8;
	Fri, 18 Jul 2025 08:02:04 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:01:58 +0100
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
Message-ID: <aHph5u4-b6mfggPv@J2N7QTR9R3>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <aHUeUMmn_19EayL1@willie-the-truck>
 <be327242-ad55-476a-bed4-44c33c263962@gmail.com>
 <aHkRJdAuvhS2mNQj@J2N7QTR9R3>
 <705f1dfb-7e1b-4930-a1a9-c763299a4305@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <705f1dfb-7e1b-4930-a1a9-c763299a4305@gmail.com>

On Fri, Jul 18, 2025 at 01:00:45AM +0800, Nick Chan wrote:
> On 17/7/2025 23:05, Mark Rutland wrote:
> > On Mon, Jul 14, 2025 at 11:59:36PM +0800, Nick Chan wrote:
> >> Will Deacon 於 2025/7/14 夜晚11:12 寫道:
> >>> On Mon, Jun 16, 2025 at 09:31:49AM +0800, Nick Chan wrote:
> >>>> Patch 8-12 adds support for the older SoCs.
> >>> ... but I'm not sure if anybody actually cares about these older SoCs
> >>> and, even if they do, what the state of the rest of Linux is on those
> >>> parts. I recall horror stories about the OS being quietly migrated
> >>> between CPUs with incompatible features, at which point I think we have
> >>> to question whether we actually care about supporting this hardware.
> >> The "horror" story you mentioned is about Apple A10/A10X/T2, which
> >> has a big little switcher integrated into the cpufreq block, so when the
> >> cpufreq driver switch between states in the same way as on other
> >> SoCs, on these SoCs that would silently cause a CPU migration. There
> >> is only one incompatible feature that I am aware of which is 32-bit EL0
> >> support.
> > 
> > Surely the MIDR/REVIDR/AIDR also change?
> They do not change. ID_AA64PFR0_EL1 also does not change (fixed 0x12).
> What *does* change however is MPIDR. (P-cores has bit 16 set while
> E-cores do not)

The MPIDR changing isn't ok either. You might get away with that today,
but that's not supposed to change behind the back of the kernel.

Is there anything else that can change, or are we absolutley certain
that *only* MPIDR changes?

> >> As mentioned above, it does all work fine when CONFIG_EXPERT is not
> >> enabled, and if it is enabled, then 32-bit process may crash with illegal
> >> instruction but everything else will still works fine.
> > 
> > I don't think that's quite true, unless these parts are also violating
> > the architecture.
> > 
> > If the CPU doesn't implement AArch32, then an ERET to AArch32 is
> > illegal. The way illegal exception returns are handled means that this
> > will result in a (fatal) illegal execution state exception being taken
> > from the exception return code in the kernel, not an UNDEF being taken
> > from userspace that would result in a SIGILL.
> Speaking from experience, when testing with the userspace cpufreq governor,
> trying to run AArch32 code on the ecores really does result in illegal
> instruction for that process while everything else remains fine.
> 
> Referencing ID_AA64PFR0_EL1, the E-cores does claim to support
> AArch32 EL0, even though they could not execute it for real.

Ok, so that's a clear violation of the architecture, and doesn't fill me
with confidence about anything else.

> > I do not think that we should pretend to support hardware with silent
> > microarchitectural migration. So at the very least, we do not care about
> > A10/A10X/T2.
> As explained above, what actually happens on the hardware is different
> from what you believed, so please do reconsider.

Different certainly, but still problematic.

I maintain that we should not pretend to support this hardware.

Mark.
