Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89827B3;
	Mon,  4 Dec 2023 01:45:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E45FEC;
	Mon,  4 Dec 2023 01:46:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443083F6C4;
	Mon,  4 Dec 2023 01:45:57 -0800 (PST)
Date: Mon, 4 Dec 2023 09:45:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from
 'struct pmu_hw_events'
Message-ID: <ZW2f0kACNEp7-X-M@FVFF77S0Q05N>
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
 <20231115092805.737822-3-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115092805.737822-3-anshuman.khandual@arm.com>

On Wed, Nov 15, 2023 at 02:58:05PM +0530, Anshuman Khandual wrote:
> As 'pmu_lock' element is not being used in any ARM PMU implementation, just
> drop this from 'struct pmu_hw_events'.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_pmu.c       | 1 -
>  include/linux/perf/arm_pmu.h | 6 ------
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index d712a19e47ac..379479b50bdd 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -893,7 +893,6 @@ struct arm_pmu *armpmu_alloc(void)
>  		struct pmu_hw_events *events;
>  
>  		events = per_cpu_ptr(pmu->hw_events, cpu);
> -		raw_spin_lock_init(&events->pmu_lock);
>  		events->percpu_pmu = pmu;
>  	}
>  
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 143fbc10ecfe..e2503d48ddee 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -59,12 +59,6 @@ struct pmu_hw_events {
>  	 */
>  	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
>  
> -	/*
> -	 * Hardware lock to serialize accesses to PMU registers. Needed for the
> -	 * read/modify/write sequences.
> -	 */
> -	raw_spinlock_t		pmu_lock;
> -
>  	/*
>  	 * When using percpu IRQs, we need a percpu dev_id. Place it here as we
>  	 * already have to allocate this struct per cpu.
> -- 
> 2.25.1
> 
