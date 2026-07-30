Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E640B360;
	Thu, 30 Jul 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413066; cv=none; b=KkC5xg91/FYaDNIJWANLN6qoCTilkS89l+Iu8p72ocZRRdOtwJFWcwSsf5vAheyXJeDeuYHH+LjFfrixtIPuW4J0JmxEyVbBlqXkaQCeD3JxdYi3q9aPbBOlnylHT8UyIzhibctiIAAg7d5ayi7jwNX1oXJywWbtfhKjJG4n9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413066; c=relaxed/simple;
	bh=um1g/2uMu3LQvOq1cqHqGdaYxFWKxxZuu/+v0AfV1b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUJU8SiJqq6lW6yv4dJtniL4eqt1DMAhJfR6WzCxAfQdqWrjrHJ8FIwC76tMQuj+v4T505lJpU69aY0N8+OYov0zyr7rfJKGtxEhKkQ5UjdL+hPqhfonWj3V9VuTDQUPzc/kl/cSqua4DOYFaOO8+MLyL94cUDsEJ8HaYO7SX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g/F5fCq+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g/F5fCq+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E33DB1684;
	Thu, 30 Jul 2026 05:04:15 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 127EA3F86F;
	Thu, 30 Jul 2026 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785413060; bh=um1g/2uMu3LQvOq1cqHqGdaYxFWKxxZuu/+v0AfV1b4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g/F5fCq+P46j9c3fNUFpMDELGBgGKXvsPc7rOVxmpgFuCbObF5fpUGmUMdnRpBDMu
	 DM1wWo/oUidDMljNgyt24fzDTTlpt+b+TZ5HfRwkBcol88hy4SJwKSI+ncgsm2AE8x
	 6RSdUwSphcUeUQQYWCexR2EiDDI8cwUso8mC6Uv8=
Message-ID: <3dc5c366-652f-4977-84a1-6e5a921a74cc@arm.com>
Date: Thu, 30 Jul 2026 13:04:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-7-dave.jiang@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729145555.3919550-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2026 3:55 pm, Dave Jiang wrote:
> The counters are configured with Freeze on Overflow, so when any counter
> overflows the CPMU freezes every counter in the block (CXL r4.0
> §8.2.7.2.1). cxl_pmu_irq() reads the overflowed counters and clears the
> overflow status, but never writes the CPMU Freeze register to unfreeze,
> so all counters stay frozen until the next pmu_enable() and events in
> that window are silently lost.
> 
> Unfreeze after clearing the overflow status so counting resumes.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/perf/cxl_pmu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 8b89db8f4d68..52e78a6e0960 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -804,6 +804,15 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>   
>   	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
>   
> +	/*
> +	 * Counters are configured to freeze on overflow (Freeze on Overflow),
> +	 * which freezes every counter in the CPMU. Once the overflowed counters
> +	 * have been read and their status cleared, unfreeze so counting resumes;
> +	 * otherwise all counters stay frozen until the next pmu_enable() and
> +	 * events are silently lost.
> +	 */
> +	writeq(0, base + CXL_PMU_FREEZE_REG);

Does this unconditionally unfreeze _all_ counters, including any which 
might have have overflowed since the read of CXL_PMU_OVERFLOW_REG and 
thus have not been handled yet? Or are we hoping that the "global 
freeze" behaviour prevents that from being able to happen?

Furthermore, what if an overflow happens to occur just as 
cxl_pmu_disable() is intentionally freezing all the counters, such that 
by the time we get here, unfreezing them would be the wrong thing to do?

Thanks,
Robin.

> +
>   	return IRQ_HANDLED;
>   }
>   

