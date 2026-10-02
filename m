Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86222EEE63;
	Fri,  2 Oct 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959410; cv=none; b=ZnSA24BjxFaYmzPosH45turUHz7O76xP7KbNUkZrf2Ko3mycGn9b79FZ6kYazmzGDxJZPtkXgCnJzdja2ZffVAqptSAWPJwXp3NNwzWMXOLq1y9RP1zB1lMeW/gckNTwwm1xKja4kH2+41XWUrE2hx+Ha/G9a5H7ctvMENZv37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959410; c=relaxed/simple;
	bh=JFVH1W9u8QFQnSy5r+eC+gXWDg8VT498sBM4EA17SiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHr32SQoOURssISecPHNR5byEcx6O5S/mwXS16OI0yNelHSldlLkUnm+5K1NbTk+3wuCYqBOetnqWqZXndzAes0taiBKmDkCohaw94WMbmP4X4DLSFOPsXvVlpnxQalndzsJy5Hd6jUVrGXlcdz3vUcABB8GulJ3TGtnR2iLxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyf7DrWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyf7DrWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501091F000FF;
	Fri,  2 Oct 2026 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959409;
	bh=sHPDYQbyPP1ku3yBPr6G5hWWFQvi7Z4+YXceflcUoUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oyf7DrWXsPmbKy8znM9DpP18qVBew8jD+mX6KMuUW7h0hSR8uR2+Z9YFavg5A1Gmb
	 Gx+rJT7zxzdsiD760v+6u1+uIGoohC9HT410iZpEeQMdWOHRuO8MfAIEruMEaSI16E
	 +UPbKHD34W+47OMoA3wro6E9qyC+fibAjwcJ+69CGYskb5LrqB3h2ki81EcuMM5sJ/
	 GIKYq1nZQt+5OCPU8Hm+cFMCWOaPc1FfEoQQRRlf3+FmRtj4wjxi1+DdH6RLl/46sD
	 wF44GeRcBI2oiMvs23S9olNR912JtujBAWNNDyOHN0Wz/rbX+z3Gfk0mST5ZEDWoou
	 d36z++H2evNvA==
Date: Fri, 2 Oct 2026 17:43:24 +0100
From: Will Deacon <will@kernel.org>
To: phucduc.bui@gmail.com
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ
 lookup
Message-ID: <ar_fLAeFU4rmrwiH@willie-the-truck>
References: <20260811041934.7609-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811041934.7609-1-phucduc.bui@gmail.com>

On Tue, Aug 11, 2026 at 11:19:34AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available, while other errors should be propagated.
> 
> Propagate all error codes returned by platform_get_irq_optional() other
> than -ENXIO.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 621f02a7f43b..6c942697e57f 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -893,6 +893,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq < 0 && irq != -ENXIO)
> +		return irq;

Not sure about this. If it's optional, why should we bail the probe if
we don't manage to get an irq? Surely it's better to continue without
the interrupt in that case?

Will
