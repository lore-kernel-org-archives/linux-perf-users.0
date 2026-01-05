Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061C3D561;
	Mon,  5 Jan 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645341; cv=none; b=G1Ok+H1lefq7j5Mlm2CIeOn3VCdn6rDrQpyDIvsJmMtxzNJMS04qWXCiuoEmovvAdNFg5b3AjelI73RjxOzX8ELTzBFmOtXZc/mOFyKvBvrP294D7fPRsB5gT+Yh74QJv2A9PIR02RRX/tn/TxK0qAT/R/29oiUq+pBF14QX9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645341; c=relaxed/simple;
	bh=c0kzSZSP3Sc7meNMb3f814HG8Dspx6UwG6XS4EJ4IvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTHLUVV9ShHsRZivVtvQBn51ktzZOtJWDCDvtlbIgLNOClqfryHYNorKQw+E+dJ2dacGjWgecnb60fwfvDoW5rTAbGL0nlBUdVODTjDtSRlFI/vXnspjUmKYIRKF7maylol7vjv4tOL0WFsEC6PmiEB2nSqsP5eYH79grSbzhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMXJkWfs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMXJkWfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EA5C116D0;
	Mon,  5 Jan 2026 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645341;
	bh=c0kzSZSP3Sc7meNMb3f814HG8Dspx6UwG6XS4EJ4IvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMXJkWfso9Tos+MG/oop2Igl6Htr4RrwoBSNoJyB5IBmZ/eFJs0Sd8+kQnIRxgrPr
	 SirfMAsj1zJGvMeArIESyWKUosRymHUH5nBf/ZUowfQB24QzUr0Q5laB5lFznhDUqm
	 EN47fHrG2GtjZmmJ6O81VdsEmQHRdUBnFpHaKAmWaOOpqJV6Fz2Q6w50XlWPJfRFe2
	 bjisla2OHhYGJ2B6+FoW73e4b83Js2WWdD6hYPKN4SNmWMmkZZcQjJViL+BNsGovqB
	 eGExT8i2wax+aszxxD6svRwKC6yJhYC2TkJHDqZUuvUD5glfIdrJE6Jn3T77u73B+d
	 HfKoORi6zCTfg==
Date: Mon, 5 Jan 2026 20:35:36 +0000
From: Will Deacon <will@kernel.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: hw_breakpoint: warn on invalid breakpoint
 length
Message-ID: <aVwgmMlOjL1UXvOL@willie-the-truck>
References: <20251213112336.26503-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213112336.26503-1-osama.abdelkader@gmail.com>

On Sat, Dec 13, 2025 at 12:23:35PM +0100, Osama Abdelkader wrote:
> Some tools (e.g. perf) incorrectly assume that breakpoints should be
> sizeof(long), but this is wrong for AArch64 where breakpoints must be
> 4 bytes. Add a warning when we silently fix up the parameter so tool
> developers can get notified.
> 
> This addresses the FIXME comment by adding diagnostic output rather
> than breaking existing tools by returning -EINVAL.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2: fix warning messageline splitting
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index ab76b36dce82..cce306145d78 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -475,11 +475,13 @@ static int arch_build_bp_info(struct perf_event *bp,
>  				return -EINVAL;
>  		} else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
>  			/*
> -			 * FIXME: Some tools (I'm looking at you perf) assume
> -			 *	  that breakpoints should be sizeof(long). This
> -			 *	  is nonsense. For now, we fix up the parameter
> -			 *	  but we should probably return -EINVAL instead.
> +			 * Some tools (e.g. perf) incorrectly assume that
> +			 * breakpoints should be sizeof(long). This is wrong
> +			 * for AArch64 where breakpoints must be 4 bytes.
> +			 * Warn the user and fix up the parameter.
>  			 */
> +			pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d, fixing to 4 bytes\n",
> +				     hw->ctrl.len);
>  			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;

This is user triggerable so I don't see why printing a message is a good
idea. Just remove the FIXME tag if it bothers you -- we can't really
change the behaviour at this point.

Will
