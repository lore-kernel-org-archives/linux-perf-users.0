Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BA4B1E4A;
	Fri, 16 May 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401866; cv=none; b=W/Wh4WpPHbQHiuwQVn9/o+h2XCrp/sP1akWzkBHkoYfrKN/6tqXqAP/xcslYzTNGi7Q08uIHLffn8nHUxF7LtdoRrmZm37OM7G+D10SG60IlXYmceIUVVjmDH3K7K0HkBUscdpYXOYHQwrSkyLOP0iNGR7tXgdsrkbZXfyxXWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401866; c=relaxed/simple;
	bh=6/jcxTEdm9wXe+6OlFOP2LEwhHepytwKIl2c/ZL4CKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXbAcE7olPKVtBC56TneHZMx6Lgvjpc3qsQKmOh/QL3F9atT9KX4AAYUmqiedZ5FOvjYfXT9fhDf9cTsbr80vgV+nSHhUhbpEplkL1x7gqZYeax353+xezyPrjTUReAI6FeMjJ9rwpThLxJR+nvmHL6s4ivizaaR8TZOpjsI84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6E6169C;
	Fri, 16 May 2025 06:24:05 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CCC83F673;
	Fri, 16 May 2025 06:24:17 -0700 (PDT)
Date: Fri, 16 May 2025 14:24:12 +0100
From: Leo Yan <leo.yan@arm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Rob Herring <robh@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2 07/15] perf/arm: Remove driver-specific throttle
 support
Message-ID: <20250516132412.GF412060@e132581.arm.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514151401.2547932-8-kan.liang@linux.intel.com>

On Wed, May 14, 2025 at 08:13:53AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
> 
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring (Arm) <robh@kernel.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  drivers/perf/arm_pmuv3.c      | 3 +--
>  drivers/perf/arm_v6_pmu.c     | 3 +--
>  drivers/perf/arm_v7_pmu.c     | 3 +--
>  drivers/perf/arm_xscale_pmu.c | 6 ++----
>  4 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index e506d59654e7..3db9f4ed17e8 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -887,8 +887,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  		 * an irq_work which will be taken care of in the handling of
>  		 * IPI_IRQ_WORK.
>  		 */
> -		if (perf_event_overflow(event, &data, regs))
> -			cpu_pmu->disable(event);
> +		perf_event_overflow(event, &data, regs);

I did a test for Arm PMUv3, sometimes I can get consistent result
crossing events, but I still saw discrepancy in some runs:

   # perf record -c 400 -C 4,5,6,7 -e "{cycles,cycles}:S" -- sleep 5

   # perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
   7 5691046123610 0x63670 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1): 0/0:
   0xffff80008137a6d0 period: 400 addr: 0
   ... sample_read:
   .... group nr 2
   ..... id 00000000000000bf, value 000000000019d7a7, lost 0
   ..... id 00000000000000c3, value 000000000019d3f9, lost 0

Though it does not dismiss discrepancy totally (maybe it depends on
hardware mechanism), I do see this series can mitigate the issue
significantly.

Tested-by: Leo Yan <leo.yan@arm.com>
