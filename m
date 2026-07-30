Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7941391836;
	Thu, 30 Jul 2026 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411513; cv=none; b=IWLhMpJ8ta+iUnfycGTFo8C5duHeBmrSX6RK7j4b9Qxf5Ofw8fmLiHJgpNw0veblYuDMhbL8g0N77xggs9tY4U+yI+QFIGjv83XA3/GzRuSMghPz98bNhamZSrQQDWvzFeYXEkxQLljYbcqPm/DuC3JumavRzFHJr4yIyNXRfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411513; c=relaxed/simple;
	bh=c4ZJ8IIPgQftiJ+oNhBPr65R/wTqBU+rC9acagVn1jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF8fEQ3dmCweQ2Lbj4AK8T56AcOqTQkPG56HPNHrhBVU9xkeLe1H0DcEBdoeBgR773UbtHbuz4som/y8A9/pv/dnYl58KUKM+IJwmeul0E7a7vl92waCqx1Cwj2O4iiuERjT/BJ7hKenSVwj7aZ140LNNjlDLtWe32fckQDAiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fjCty8x6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fjCty8x6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4831684;
	Thu, 30 Jul 2026 04:38:26 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17C4A3F763;
	Thu, 30 Jul 2026 04:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785411511; bh=c4ZJ8IIPgQftiJ+oNhBPr65R/wTqBU+rC9acagVn1jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fjCty8x6BCAgATWai9hvfEzPk7JZMCzXQOJlQLdyg5lSqtRrtPhNKukPhGpWSOw3V
	 4Y/j8ZRoplRH8nRxJSckuHYDZHlWGr8zliDeV4lLKr28hC52SFkls7NR6kktX6h91A
	 tgzr6n3mFu+jfuLpUf5CDsWRZzwXqmzxFrUqf1LE=
Message-ID: <76fbd2ce-5d25-47a4-82d8-5577860a948c@arm.com>
Date: Thu, 30 Jul 2026 12:38:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplug
 callbacks after unregister
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-9-dave.jiang@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729145555.3919550-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 3:55 pm, Dave Jiang wrote:
> On device removal the devm actions unwind LIFO, so cxl_pmu_perf_unregister()
> runs first and perf_pmu_unregister() frees info->pmu.dev (device_del() +
> put_device() -> kfree()). The overflow IRQ (freed last) and the CPU-hotplug
> instance (removed next) are still live at that point, and both
> cxl_pmu_irq() and cxl_pmu_offline_cpu() log via dev_dbg()/dev_err() on
> info->pmu.dev, dereferencing freed memory. The shared IRQ can be entered
> for a co-function on the same MSI vector, and a CPU can go offline in the
> window before the hotplug instance is removed.
> 
> Log through info->pmu.parent instead, the cxl_pmu device passed to probe,
> which is devm-managed and outlives every teardown action.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/perf/cxl_pmu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 2e817a52ff1e..f42238b2b6b0 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -803,7 +803,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>   		struct perf_event *event = info->hw_events[i];
>   
>   		if (!event) {
> -			dev_dbg(info->pmu.dev,
> +			dev_dbg(info->pmu.parent,
>   				"overflow but on non enabled counter %d\n", i);
>   			continue;

This seems dubious - we don't permit sharing the IRQ, and all events 
must have been stopped and descheduled to allow the PMU to be removed in 
the first place, so how would an overflow interrupt happen?

>   		}
> @@ -966,7 +966,7 @@ static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>   	info->on_cpu = -1;
>   	target = cpumask_any_but(cpu_online_mask, cpu);
>   	if (target >= nr_cpu_ids) {

And this again is nonsense anyway - if the pointless dead code is 
bothering people, just delete the whole check.

Thanks,
Robin.

> -		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> +		dev_err(info->pmu.parent, "Unable to find a suitable CPU\n");
>   		return 0;
>   	}
>   

