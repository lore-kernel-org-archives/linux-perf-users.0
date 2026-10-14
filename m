Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459E2D5925;
	Wed, 14 Oct 2026 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952434; cv=none; b=CJIPHH+8JsLoRrbsVHcloSp/etLj2RYLsWnlY/YTQSRtEzINwHolL2x3RPY6H1OhghfJPDvA3p234K5gNgyX7jZ1MgjT+E/oPgK6FjiMjHC0uKpScdD8+QViU53FntHLcx54PK1EzVoQSoNbSvwluY0Xj6SCdYH6h0TuobcV/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952434; c=relaxed/simple;
	bh=WuJR9rNdHNOg5yZISoFvp3kVH3Qv7AiwBF1bWSJhq1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwDJnK5Zdd8suWsLCHRD8r0z/u0E6AujbaJxKHA0GNp2vsyFcwOPNgt/auHt4LlPP+p0pdsO9PacGE8Hv35Fpthrh0YKn8n573uD/DvPvmZ0WVvVLFg2eh0/ivMenQ8AA5slrVKukyGhBnB2MLJUr2mVy877UE0RkBGYEhA1WLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXZ1cR0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXZ1cR0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5541F000FF;
	Wed, 14 Oct 2026 04:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791952433;
	bh=jgrKJENA6Fuo/kBiIZwLHpnxCBpu7F/vcADbosM2nII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bXZ1cR0ReD4VORVk4VdqfFYNw0NqiNoCQxEWXenGRsIR1SJYoUL0iLjQbmilRgtuv
	 KmyEY3Ubi4MKwXDMWA1K2bLUWf5P6jJxcGlz45GJRoRIfbF4ggFCtjyKr3uKtEGLY2
	 iU7WQeT+1QddV0alJIgB+wuyZO2Zu+E0hQYPvcIbGQSfAdRGuXF5sWcA3I81tVSsDp
	 /X7sba4zBQ29cFX+5++4g1nI6Ep98jOi+9Tvp+gv/M0phur0hNIRGqO7kVKAiGBtma
	 RAxZuU4+hVN3DDsMn5ko0pjOpw8XZNhB7v3WdFAVzAZYQoWAFQK9g1PdktCxx21LnN
	 kxzyLfTIXSN4Q==
Date: Wed, 14 Oct 2026 12:13:49 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] perf/renesas: Remove remaining RISCV_ALTERNATIVE
 references
Message-ID: <as8BfaTCxKh72_iC@xhacker>
References: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>

On Tue, Oct 13, 2026 at 10:38:39AM +0200, Geert Uytterhoeven wrote:
> As riscv always selects RISCV_ALTERNATIVE, the option was removed.
> However, a few references were left, making it impossible to enable
> RZ/Five support (ARCH_R9A07G043).
> 
> Fix this by removing all remaining references.
> 
> Fixes: b924210f542e13c7 ("riscv: remove RISCV_ALTERNATIVE Kconfig option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
> To be applied to riscv/for-next, or folded into the original commit.
> ---
>  drivers/perf/Kconfig        | 2 +-
>  drivers/soc/renesas/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b9947a..8cef4bdef76aecab 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -117,7 +117,7 @@ config STARFIVE_STARLINK_PMU
>  
>  config ANDES_CUSTOM_PMU
>  	bool "Andes custom PMU support"
> -	depends on ARCH_RENESAS && RISCV_ALTERNATIVE && RISCV_PMU_SBI
> +	depends on ARCH_RENESAS && RISCV_PMU_SBI
>  	default y
>  	help
>  	  The Andes cores implement the PMU overflow extension very
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index a63df28df3b5e7c7..0b6876ef6dca228b 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -461,7 +461,6 @@ config ARCH_R9A07G043
>  	bool "RISC-V Platform support for R9A07G043F (RZ/Five)"
>  	depends on NONPORTABLE
>  	depends on !DMA_DIRECT_REMAP
> -	depends on RISCV_ALTERNATIVE
>  	depends on !RISCV_ISA_ZICBOM
>  	depends on RISCV_SBI
>  	select ARCH_RZG2L
> -- 
> 2.43.0
> 
