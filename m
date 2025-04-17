Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3924BBE7;
	Thu, 17 Apr 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896343; cv=none; b=DPfgvpk0OlUKM9de02zlmWzeIpSNjfT7bGXvpvQ6W3yrQgKoGHKUiy/ICA+izQKsRaVHpdpUOoi4nY737uKd/7COIe12Nn9VQXn9m7AISXhnR+cLDGsrqTCk7tcnMh0aDtyCZaYeOyOUge0RPH6HhulfTy4cxqe6923M6ENcdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896343; c=relaxed/simple;
	bh=Drs94MUaxJbsVdM/zpcCB4DFPzpYU1vvnHCqfqX8EJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTqph5V/ZCG6AwYqfsL20X5mHshDnAcKMGkRrwiXFxhvEeUGXF1TGycCPBZHXPoRudqHhgem+R3G4G+aPkH1bXU3Lxap9yS7YlK9umhesEZrGXdfKhWPA2TbkYM7r6NlHD8sePPMMu7eONFs9SL31VWeVUwxOQcpoI/L9oua4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svKG27U0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svKG27U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C28C4CEED;
	Thu, 17 Apr 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744896342;
	bh=Drs94MUaxJbsVdM/zpcCB4DFPzpYU1vvnHCqfqX8EJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svKG27U0i8ZPd4YWJD+dQsdHbDu921JnCpGNZ/L2EtDdybbKCnQLp5AEa0vf0Nq4F
	 vvbqao0DBlNINB4XZFl9lIJCj7PofcGV6AV/W+x85d0rb7SOIP35/HqZbcdWzAOOBN
	 TB/ccEpGWxwMlE9i/tS06x6K02JieGNmsYzIZ/e8BbahMA/tx51PaOhyMwPgPis1pF
	 IYr0CRFpeSHpI/VVOmWHvJsO50RvGsYQwWS0nbAusP0He4xVKPzlL/Py7bELrti3LV
	 cWibMsDQh8IYLb5RmBiveiqadY9OFFC/LD/heCp7shCjK0RrwizQAhmG1TkLrdqWjS
	 hFnnX9fhrzWcw==
Date: Thu, 17 Apr 2025 14:25:37 +0100
From: Will Deacon <will@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com,
	Ganapatrao.Kulkarni@cavium.com, gkulkarni@marvell.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: Add NULL check in thunderx2_pmu
Message-ID: <20250417132536.GB12863@willie-the-truck>
References: <20250410112027.80131-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410112027.80131-1-hanchunchao@inspur.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 10, 2025 at 07:20:27PM +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure,but this
> returned value in tx2_uncore_pmu_register() and
> tx2_uncore_pmu_init_dev() is not checked.
> Add NULL check in tx2_uncore_pmu_register() and
> tx2_uncore_pmu_init_dev(), to handle kernel NULL
> pointer dereference error.
> 
> Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
> Fixes: 5e2c27e833bb ("drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/perf/thunderx2_pmu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 6ed4707bd6bb..03dd297ff326 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -738,6 +738,8 @@ static int tx2_uncore_pmu_register(
>  
>  	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
>  			"%s", name);
> +	if (!tx2_pmu->pmu.name)
> +		return -ENOMEM;

perf_pmu_register() rejects (and warns) for a NULL name, so I'm not sure
we need to litter the drivers with extra checks.

>  	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
>  }
> @@ -837,6 +839,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>  		tx2_pmu->attr_groups = l3c_pmu_attr_groups;
>  		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
>  				"uncore_l3c_%d", tx2_pmu->node);
> +		if (!tx2_pmu->name) {
> +			devm_kfree(dev, tx2_pmu);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +
>  		tx2_pmu->init_cntr_base = init_cntr_base_l3c;
>  		tx2_pmu->start_event = uncore_start_event_l3c;
>  		tx2_pmu->stop_event = uncore_stop_event_l3c;
> @@ -852,6 +859,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>  		tx2_pmu->attr_groups = dmc_pmu_attr_groups;
>  		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
>  				"uncore_dmc_%d", tx2_pmu->node);
> +		if (!tx2_pmu->name) {
> +			devm_kfree(dev, tx2_pmu);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +
>  		tx2_pmu->init_cntr_base = init_cntr_base_dmc;
>  		tx2_pmu->start_event = uncore_start_event_dmc;
>  		tx2_pmu->stop_event = uncore_stop_event_dmc;
> @@ -866,6 +878,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>  		tx2_pmu->attr_groups = ccpi2_pmu_attr_groups;
>  		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
>  				"uncore_ccpi2_%d", tx2_pmu->node);
> +		if (!tx2_pmu->name) {
> +			devm_kfree(dev, tx2_pmu);
> +			return ERR_PTR(-ENOMEM);
> +		}

Are any of these actually necessary? afaict, the vsprintf code will
emit "(null)" for a NULL pointer.

Will
