Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7541D4C1;
	Thu, 30 Jul 2026 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411990; cv=none; b=uM1beEIPBtMnML3cM4NHI+XOdQZdhIU7pWnqpy5LBQGaONyzEHxWYz+oGeAEjP5Jp1YCaMtmJgrRv88hBIoCdve7qGcnSFgIZKgeM5YCnmvgzdfjNw1WlV3HHdhHHPooFHQbOmqocGpdofMBi2RsvPowGYZ629Ia8Aq6khOsslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411990; c=relaxed/simple;
	bh=TWVBKtG7X2aZ8uXKm40DmM6+KNIXSqj4ryn2tFEnGwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7g/KE5jTJPw7fXUOb6KMUr9pjxKu6zMwnphaomqjOv+PT9pr/BvBuNYXAZehw2Ze+Qona+JlQGQNKFnT5uw7PZzcSK9i+qGFVOOiR062S5uflnkxRUVoFtje3uCYtOPF/ln7LOpZfqbNt2FDdIFq/IOodOQuoti+OYTic5hiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FoPw5iYi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FoPw5iYi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6917E1684;
	Thu, 30 Jul 2026 04:46:23 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BF0F3F763;
	Thu, 30 Jul 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785411987; bh=TWVBKtG7X2aZ8uXKm40DmM6+KNIXSqj4ryn2tFEnGwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FoPw5iYi9qGJ19/cy8p9oWt2HZF8Lqx+yKc+H6tLITLya9qFWn59s+C9i81es0+lb
	 +/wUSPVa+nS/Wrb9eGtPpPDl8vZ/V4GesNpYH3XP4Pb/P0wwQbrgkRO7V2zz2JQwY8
	 7mRc1fNnHhzfmar2hjSkqRZUsPRl0aPOsdfcj/NY=
Message-ID: <778b651c-ab2e-41d6-a0d6-5da144989df7@arm.com>
Date: Thu, 30 Jul 2026 12:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-6-dave.jiang@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729145555.3919550-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 3:55 pm, Dave Jiang wrote:
> The PMU pins its overflow interrupt to info->on_cpu in the hotplug
> online/offline callbacks, but requests it with only IRQF_SHARED |
> IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
> smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
> then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
> hwc->prev_count and event->count concurrently with the managing CPU;
> local64_t is only atomic against same-CPU access, so counts get
> corrupted.
> 
> Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
> matching other uncore-style PMU drivers.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/perf/cxl_pmu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index d1e810601e36..8b89db8f4d68 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
>   	if (!irq_name)
>   		return -ENOMEM;
>   
> -	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
> +	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
> +			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,

Bah, sorry, now I see I misspoke just now on the other patch - PMUs 
really _shouldn't_ permit shared IRQs, but this one does :(

Thus it's all well and good to prevent userspace changing affinity, but 
it doesn't help _all_ that much if other drivers can still legitimately 
change it behind our backs...

Thanks,
Robin.

>   			      irq_name, info);
>   	if (rc)
>   		return rc;

