Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECA25A323;
	Mon, 14 Jul 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505929; cv=none; b=lwsKLZnch7vz2h4PSoZhbTHMq6FHpzaKW1ugFO5VitGL+qOz1vjC8ukgBo5dSpnDgEFomcxmsq/pCeT/cy/3OVnGP5Qd+bjUndrD1BH7ViMv2UYl3AZVu8E+CmreJixZvaBoiGp9yRVUOzE1R7uxlugE5PhXg4pbzpxWj09CGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505929; c=relaxed/simple;
	bh=26IYlYe0seETAdGJ661Ilcz5CFOkeFLOZRNhB9DEQqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuNY7+SF5XE695Mnf1/9GW61cwnB2kFnJcjlDoUbfB5UBC60Io5OTmImIJPo7vtCH7NVVAUlPxzdyRyZ+Y4gzMtHHiR5Jlv+1JVTCxVJtgDnCkry1sZ39uS9lPvSrF9UEi9e2BOGoJaDXzGKq2NqhUno9ZT1n0y7wqGAAsiVVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxG5ScAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxG5ScAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D99C4CEED;
	Mon, 14 Jul 2025 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505929;
	bh=26IYlYe0seETAdGJ661Ilcz5CFOkeFLOZRNhB9DEQqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxG5ScAXHk+Rl0eeBfa4igek8hkW3Yvbk+n1Gx8+5Xq2Nhuq+w1hYegvBAzPkxp6g
	 MDxabxOCAKq2VAi5NEbCaf31UCeihxlhL2sUrhHEKgmX5RcyLd7TnES7tsqKlxOrHc
	 I37W0h8nE+kxfXCLBkOdea8h04lVhoEHIvfaFOLetv7pdHv8PkT+8UAJ2z1BEveOjR
	 K46WQMIuLbzCDzWT9r66y4yGimYxg6WpIiNaoD+pUbX+m7YTeBH+EfnaElf2JKXRpG
	 4e2soIHN/UREhccMk7xW3el0crejY84dSxrGjRWWKlybyA0e/2rmMjjegEem8uwTLk
	 PkHJDeYoyDDTw==
Date: Mon, 14 Jul 2025 16:12:03 +0100
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
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 05/21] drivers/perf: apple_m1: Support
 configuring counters for 32-bit EL0
Message-ID: <aHUeQ8at8UnNtE4m@willie-the-truck>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <20250616-apple-cpmu-v7-5-df2778a44d5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-apple-cpmu-v7-5-df2778a44d5c@gmail.com>

On Mon, Jun 16, 2025 at 09:31:54AM +0800, Nick Chan wrote:
> Add support for configuring counters for 32-bit EL0 to allow adding support
> for implementations with 32-bit EL0.
> 
> For documentation purposes, also add the bitmask for configuring counters
> for 64-bit EL3.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  arch/arm64/include/asm/apple_m1_pmu.h | 3 +++
>  drivers/perf/apple_m1_cpu_pmu.c       | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
> index 02e05d05851f739b985bf416f1aa3baeafd691dc..6e238043e0dc2360c4fd507dc6a0eb7e055d2d6f 100644
> --- a/arch/arm64/include/asm/apple_m1_pmu.h
> +++ b/arch/arm64/include/asm/apple_m1_pmu.h
> @@ -38,8 +38,11 @@
>  
>  #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
>  #define SYS_IMP_APL_PMCR1_EL12	sys_reg(3, 1, 15, 7, 2)
> +#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
>  #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
>  #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
> +#define PMCR1_COUNT_A64_EL3_0_7	GENMASK(31, 24)

No need to add this one ^^

Will
