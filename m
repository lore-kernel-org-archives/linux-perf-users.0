Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B227703E
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657802; cv=none; b=htEmDUwjye6817ZoXyl4KZAKpuKNHICHi0B3k6x0D2QBUrkyfjxqOD6FefyDh12msfbW1qy9A0ZPeTYNlIsVeiZ/wPjKZhhVDfa7LpRlaPXiQ54soXrjPYDhbO0cQKJDsyMf/ZTVXzlDh5TpwB+v+/yGZTexkaCvolb2vSy4AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657802; c=relaxed/simple;
	bh=cR68oHfl1t9ywt/NWwZVHzu9vBeDFFwhdFjq16MJ57w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWiu6/fxdJ6gcJmR5rk1+REm8s3t7nUveuHNJcTJdXNHWe65YbsYSXdBNEitNJzmArmJ7boCx8CYVlMngWPeTGoQBvsyWuvpnQavnSmXK5A5QzaD0N+6DmnEsGquUBbXZZgoX3gjT3P9wnwOOk6goXdkArQ7O2pzMrxAJU7KMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihtr0SvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihtr0SvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0C3C4CEE4;
	Mon, 19 May 2025 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747657802;
	bh=cR68oHfl1t9ywt/NWwZVHzu9vBeDFFwhdFjq16MJ57w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ihtr0SvYpqY3g7eCmAA8tspChbubtaRSjSCEHzk7dF2AtdmnuJCPJRKqRn0qLfIcp
	 cwkycvCpuRe6jv3Khd7Iw2jGEKD0sIOCHNSdNWr4Z8KTyDqeYWtqHNbPM4ENcWiDpV
	 SE9ZcMZpjUIg3Fmv37RV4pk+fMvgS7X9xaR+gsGStQqSiO10EDQdKnx/YqgXn8Yss0
	 nrj5+1jOUqOOQqpWfWN5NXwE764qjq+Te8SgXSp11P01s5736sIy28eqFq3rj9MMhL
	 Ge+u17FbhsS+FTOBr+l8l9tz1j7tmHqV9T1LhXvrVMigxAyzrqBLOl/7lD5PHYjUag
	 FykWGyDtVzx5A==
Date: Mon, 19 May 2025 13:29:57 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, allen.wang@hj-micro.com,
	peter.du@hj-micro.com, andy.xu@hj-micro.com
Subject: Re: [PATCH 3/3] perf/arm-ni: Support sharing IRQs within an NI
 instance
Message-ID: <20250519122956.GA16848@willie-the-truck>
References: <cover.1747149165.git.robin.murphy@arm.com>
 <c7ac53d0f608d92d96e4e2827e253a9cb2a337bb.1747149165.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ac53d0f608d92d96e4e2827e253a9cb2a337bb.1747149165.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 13, 2025 at 04:39:00PM +0100, Robin Murphy wrote:
> From: Shouping Wang <allen.wang@hj-micro.com>
> 
> NI-700 has a distinct PMU interrupt output for each Clock Domain,
> however some integrations may still combine these together externally.
> The initial driver didn't attempt to support this, in anticipation of a
> more general solution for IRQ sharing between system PMU instances, but
> that's still a way off, so let's make this intermediate step for now to
> at least allow sharing IRQs within an individual NI instance.
> 
> Now that CPU affinity and migration are cleaned up, it's fairly
> straightforward to adopt similar logic to arm-cmn, to identify CDs with
> a common interrupt and loop over them directly in the handler.
> 
> Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
> [ rm: Rework for affinity handling, cosmetics, new commit message ]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-ni.c | 78 ++++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index 168750e78fc4..ca033c8785ff 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -102,6 +102,7 @@ struct arm_ni_unit {
>  struct arm_ni_cd {
>  	void __iomem *pmu_base;
>  	u16 id;
> +	s8 irq_friend;

Why not just store the pointer to the cd as opposed to a relative offset?

>  	int num_units;
>  	int irq;
>  	struct pmu pmu;
> @@ -448,33 +449,37 @@ static irqreturn_t arm_ni_handle_irq(int irq, void *dev_id)
>  {
>  	struct arm_ni_cd *cd = dev_id;
>  	irqreturn_t ret = IRQ_NONE;
> -	u32 reg = readl_relaxed(cd->pmu_base + NI_PMOVSCLR);
>  
> -	if (reg & (1U << NI_CCNT_IDX)) {
> -		ret = IRQ_HANDLED;
> -		if (!(WARN_ON(!cd->ccnt))) {
> -			arm_ni_event_read(cd->ccnt);
> -			arm_ni_init_ccnt(cd);
> +	for (;;) {

Could this be a do { ... } while (cd) loop instead?

> +		u32 reg = readl_relaxed(cd->pmu_base + NI_PMOVSCLR);
> +
> +		if (reg & (1U << NI_CCNT_IDX)) {
> +			ret = IRQ_HANDLED;
> +			if (!(WARN_ON(!cd->ccnt))) {
> +				arm_ni_event_read(cd->ccnt);
> +				arm_ni_init_ccnt(cd);
> +			}
>  		}
> -	}
> -	for (int i = 0; i < NI_NUM_COUNTERS; i++) {
> -		if (!(reg & (1U << i)))
> -			continue;
> -		ret = IRQ_HANDLED;
> -		if (!(WARN_ON(!cd->evcnt[i]))) {
> -			arm_ni_event_read(cd->evcnt[i]);
> -			arm_ni_init_evcnt(cd, i);
> +		for (int i = 0; i < NI_NUM_COUNTERS; i++) {
> +			if (!(reg & (1U << i)))
> +				continue;
> +			ret = IRQ_HANDLED;
> +			if (!(WARN_ON(!cd->evcnt[i]))) {
> +				arm_ni_event_read(cd->evcnt[i]);
> +				arm_ni_init_evcnt(cd, i);
> +			}
>  		}
> +		writel_relaxed(reg, cd->pmu_base + NI_PMOVSCLR);
> +		if (!cd->irq_friend)
> +			return ret;
> +		cd += cd->irq_friend;
>  	}
> -	writel_relaxed(reg, cd->pmu_base + NI_PMOVSCLR);
> -	return ret;
>  }
>  
>  static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
>  {
>  	struct arm_ni_cd *cd = ni->cds + node->id;
>  	const char *name;
> -	int err;
>  
>  	cd->id = node->id;
>  	cd->num_units = node->num_components;
> @@ -534,20 +539,11 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
>  		       cd->pmu_base + NI_PMCR);
>  	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
>  	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
> -	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENSET);
>  
>  	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
>  	if (cd->irq < 0)
>  		return cd->irq;
>  
> -	err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
> -			       IRQF_NOBALANCING | IRQF_NO_THREAD,
> -			       dev_name(ni->dev), cd);
> -	if (err)
> -		return err;
> -
> -	irq_set_affinity(cd->irq, cpumask_of(ni->cpu));
> -
>  	cd->pmu = (struct pmu) {
>  		.module = THIS_MODULE,
>  		.parent = ni->dev,
> @@ -593,6 +589,30 @@ static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
>  	node->num_components = readl_relaxed(base + NI_CHILD_NODE_INFO);
>  }
>  
> +static int arm_ni_init_irqs(struct arm_ni *ni)
> +{
> +	int err;
> +
> +	ni_for_each_cd(ni, cd) {
> +		for (struct arm_ni_cd *prev = cd; prev-- > ni->cds; ) {
> +			if (prev->irq == cd->irq) {
> +				prev->irq_friend = cd - prev;

Can't this race with the read of `irq_friend` in the interrupt handler?

Similarly, how do you handle the race between the interrupt firing on
one CD and the friend CD being torn down on e.g. the remove path?

> +				goto enable_irq;
> +			}
> +		}
> +		err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
> +				       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +				       dev_name(ni->dev), cd);

What's the reason not to use IRQF_SHARED and register multiple handlers?
I'm sure there is one, but capturing that in a comment would help to
justify the manual multiplexing.

Will
