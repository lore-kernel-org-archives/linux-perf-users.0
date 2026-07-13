Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAD233927;
	Mon, 13 Jul 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964401; cv=none; b=LYscwyU0FbefHieclSnCvJDkv7nCnPY8ImpKUKMO77uqUfJzWR8O/skHU8qjQIVcEfvIC0bJz8+hrAF5/LyPS3UHKUAhkQfjS1aRQnjbbD13i3tMFTHBqFJnbBn7u8iAyFmnpDgbc7PbwvUMqjr4LPLUBYMQgEIxROepG5qnYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964401; c=relaxed/simple;
	bh=7QL8mvF0GFn1iCKAg0bzOV8QSfUtROJoJDF27eSMD3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr45+mRLzVgZIzUkaOM5j06SqjtM+grs109noKwrSbNPBQB27LLDI9mKnuq7r/JlnVf55vsjF07sj6tKNApR8GRZi61RdPlgOuV79GHrAGeaStYOOhxVoubOv9VwvQ65xURJ2ESUIQluLN0mm3hlRyNnHalNvbEpoDg/33uDj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETssTygu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETssTygu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3961F000E9;
	Mon, 13 Jul 2026 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964399;
	bh=sG1shVW6C6K0eEqLZ77e5rk+mnLdAd9GF/c9D4JWkdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETssTyguX3MviR6B3aDc0t36MFOMdgBqQFCWGekxqXVl+dHoUEBZ3Gk5UZa4Mr4YP
	 5FWGgRdfcIA9j2iZ3dANGq2xTepdSikkXsAquFaLi58vUAtzOhfuOK6EWlHj+muAkw
	 Mh91TXMEXVG9VVKDZRKRuUdygsuHZwxvCr32mAKDfktLcW2/61kfrwwSUXWPiI8fxu
	 iEqTWCs3LumWPVaUu0Chm7JXMNMDi76oqi4F7XxHxISDkC6ksQXslZTykyW9m08Xq4
	 pnAN0kEpgEQKG9IozQhBcb1KAs/RBfucz4b5t21GLV/7DZjJnKHvfliLcoCEWS7QOL
	 5ZOYx1iBUr0/w==
Date: Mon, 13 Jul 2026 10:39:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf capstone: Fix build with Capstone versions before 6
Message-ID: <alUi7RgZkINlZOKP@google.com>
References: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>

On Mon, Jul 13, 2026 at 12:08:35PM +0100, Leo Yan wrote:
> The commit 12c4737f55f2 ("perf capstone: Determine architecture from
> e_machine") added a RISC-V mapping for Capstone disassembly.
> 
> However, the RISC-V arch and mode definitions are only available from
> Capstone 6.0.0. Older Capstone headers do not define CS_ARCH_RISCV,
> CS_MODE_RISCV64 or CS_MODE_RISCV32, so perf fails to build.
> 
> Guard the RISC-V mapping with a Capstone major version check. Also use
> CS_MODE_RISCV_C instead of CS_MODE_RISCVC, which is the mode name used
> by Capstone 6.

Please see

https://lore.kernel.org/r/20260706234836.815254-1-namhyung@kernel.org

Thanks,
Namhyung

> 
> Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machine")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/capstone.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 9bba78ee0c5a2e6c86a97ffe69ca4db966bafd9b..99efeb40ed03621e781ef9b888321e28d237a0ca 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -182,10 +182,12 @@ static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is_big_end
>  		*arch = CS_ARCH_SPARC;
>  		*mode |= CS_MODE_V9;
>  		return true;
> +#if defined(CS_VERSION_MAJOR) && CS_VERSION_MAJOR >= 6
>  	case EM_RISCV:
>  		*arch = CS_ARCH_RISCV;
> -		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
> +		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCV_C;
>  		return true;
> +#endif
>  	default:
>  		return false;
>  	}
> 
> ---
> base-commit: ef3af1df4f3372bd8ad47619452a283048b3bc8d
> change-id: 20260713-perf_fix_capstone_build-510dc3bfecfb
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
