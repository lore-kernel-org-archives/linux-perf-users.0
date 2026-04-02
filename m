Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA934676D;
	Thu,  2 Apr 2026 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114219; cv=none; b=m6ngMC+AMUYhl9gpCGzM74NH1gGfYQETGu0ulX4UXQQ6N0kykEIH0YKwhirV2oGzfL3AqT1netnGcDYNPiNDTNqDfDxkuRwxdQ1Vf4R/g08gEYQd2NuUIf14FjtuAWJH1pYjityptsmK203REeUngJ7IUw9ZVZR+3tr608xVmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114219; c=relaxed/simple;
	bh=ixF/iBiKqn/ro1PZ25psrjw6uL54La6KQJ7NHVOELj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5hWc8vzK6m59kve2wMRCcEGVzoga4krv5MuRKLRsyd37jEJlXzKbiEXIpcFhMj31+NnWbxqxJTEKIZ13Ph6vqsn40f/zr+VXPzvaW1aLgp4t8oiO89VB+vpf0J3+oF/rZYIxXHNRjPrlRRe01dKFCVk7LzySDsbw1Cnx2q2d1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW0ED8jl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW0ED8jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC4C2BC9E;
	Thu,  2 Apr 2026 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775114219;
	bh=ixF/iBiKqn/ro1PZ25psrjw6uL54La6KQJ7NHVOELj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW0ED8jluRS77KrOPN7CxwTQzYYqPYmVADP+myLmA6K89/ktGQQuN5D4hmMQwcSvt
	 fjIKeQBiMoYSheUCPFFgKJP3/YsvcNGFlP5ll7xJvEUC8sqKaA33BUky+QtZV+arB8
	 JhMU3sdVsw7Q3NlcAzafDXFdVvPxKD3inIv3zPe3BorHcq3n+0Uylou28Gdz5z5/CJ
	 BFWYXsGvx2zhXXckNUyQiAL7YV5vsILJTYhcJMTHjgEEoepe47Mj4MsPITBQxU5EUQ
	 2ia7IOCl0Lgb3yvVvFL1+EiMlbg2S9m7wvzzehHjMSw9Rrt93CAGmkn1tTZ8LEDUws
	 0yM2tvUxSdZUA==
Date: Thu, 2 Apr 2026 09:16:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, 
	will@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: perf: marvell: Document CN20K DDR PMU
Message-ID: <20260402-invaluable-delicate-clam-7fd6c5@quoll>
References: <20260401081640.23740-1-gakula@marvell.com>
 <20260401081640.23740-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401081640.23740-2-gakula@marvell.com>

On Wed, Apr 01, 2026 at 01:46:39PM +0530, Geetha sowjanya wrote:
> Add a devicetree binding for the Marvell CN20K DDR performance
> monitor block, including the marvell,cn20k-ddr-pmu compatible
> string and the required MMIO reg region.

You just repeated the diff. No need, we can read the diff, but what we
cannot read is the hardware you are here describing.

> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../bindings/perf/marvell-cn20k-ddr.yaml      | 39 +++++++++++++++++++

So you did not test v1. You did not test v2.

Did you finally test this one before sending?

>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
> new file mode 100644
> index 000000000000..fa757017d66e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/marvell-cn20k-ddr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell CN20K DDR performance monitor
> +
> +description:
> +  Performance Monitoring Unit (PMU) for the DDR controller
> +  in Marvell CN20K SoCs.
> +
> +maintainers:
> +  - Geetha sowjanya <gakula@marvell.com>
> +
> +properties:
> +  compatible:
> +    const: marvell,cn20k-ddr-pmu

There is no such thing as marvell,cn20k in upstream. What's that?

Best regards,
Krzysztof

