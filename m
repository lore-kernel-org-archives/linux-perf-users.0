Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158225CC7A;
	Mon, 14 Jul 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505942; cv=none; b=qXfzjNWPjZ4QSqzkYLqHKT1X/XqQiYGljKBOJWLb/2TmAe9ghYYUZ2+Z0GjsxfFv+lUgZbDGvZVIjRc6uRrBt5iDgayK7zrlhv9yBt3mNdTGt/HcMDauhq38UsaE0UUDhs5y5itx/Ff8VMd6TjlDhHc3l6FHV7mHM+0WyWltl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505942; c=relaxed/simple;
	bh=mXB87Bpc3vfmGJ3xVQnf0jSRexpExNYLcwlFgBP5krk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmOgPpM6vrI0dR6njEVgryM5Szy33jeOL8WVXEUZ1yOOnnUMisqymBs5OQSihgV7C+vDerS0JMdMVZIOFoGSAg9gyg4IDrUZedwNNQ3L00puNTk6u6dbNtQyDFtcHLScwXPsJ6+cp7xdWeFxFzN79M0sPzOBcI9G1ZXsqLlkF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj/H0Noq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj/H0Noq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BA4C4CEED;
	Mon, 14 Jul 2025 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505941;
	bh=mXB87Bpc3vfmGJ3xVQnf0jSRexpExNYLcwlFgBP5krk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj/H0NoqvGLmDRq2iwlyOPEE0dpYcGJaPGpn6tdKz68CeIpoluy6/VJQqcLSPCLdg
	 t2AmcHR216SD5vFfy+XvAI/hLiHuRhBK1HSgzafBx9vJ/1CTqobJbo7hgf6QDM/zDW
	 MU+VL0tJ0IeuOIwxp+dEtaTgIg8wl21ALR+lMmJW8DfZib02JL8ar2NVqFbEVnbdSL
	 /dmbMT4B6YbFOEugb47P2/ioekwZcBYS+OQ0EqtLFJTDYxlRvWEAUhUkJomL3R+P79
	 dw4ZSAc8zeI4MWUSgxQbhmo89zPOtFjzts7nyn5Vx9CSEWuZHl+xLQWevxszvWGE6c
	 NacDlA62rUTbg==
Date: Mon, 14 Jul 2025 16:12:16 +0100
From: Will Deacon <will@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <aHUeUMmn_19EayL1@willie-the-truck>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>

On Mon, Jun 16, 2025 at 09:31:49AM +0800, Nick Chan wrote:
> This series adds support for the CPU PMU in the older Apple A7-A11, T2
> SoCs. These PMUs may have a different event layout, less counters, or
> deliver their interrupts via IRQ instead of a FIQ. Since some of those
> older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
> be enabled by the driver where applicable.
> 
> Patch 1 adds the DT bindings.
> Patch 2-7 prepares the driver to allow adding support for those
> older SoCs.

Modulo my nits, the patches look alright to this point...

> Patch 8-12 adds support for the older SoCs.

... but I'm not sure if anybody actually cares about these older SoCs
and, even if they do, what the state of the rest of Linux is on those
parts. I recall horror stories about the OS being quietly migrated
between CPUs with incompatible features, at which point I think we have
to question whether we actually care about supporting this hardware.

On the other hand, if it all works swimmingly and it's just the PMU
driver that needs updating, then I could get on board with it.

Will
