Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED44CD2FB;
	Tue, 27 May 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363017; cv=none; b=CUvelzsAjxjNENyOIcaCpls2+kaqGDr2BHMbKLngMoKl2+ltcyrzep+a1+71h/AFtJrZG90vA+pgxTPOkVJshwa3tqtTy9N/Rd5QOMhEVw6YfhltphEYGJm9XnRXo7Hbt2G4a09CjLDdB9JPolbIDMXtl4ufqX4uejyIao2/N68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363017; c=relaxed/simple;
	bh=3gSEwh3yQrm8CDKuxh5nsCVALPNKzTjOfG4cW6XmXtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVAhZ3Y3UYd9mOOYdIop/Ppm5Z80XNxItEAg10xaFu+6Pg2l5xzgOjd/HtwH+xahZA5yCkjsrwckom81116mvLTzTqPQVBSzcG/mQshjcmyezXtuJoDOSiaLmvHQwEarhP387kDnLekKAr6FbL2fzMmFplIIpiOmwi5a2yEGJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12AC714BF;
	Tue, 27 May 2025 09:16:54 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AABFF3F5A1;
	Tue, 27 May 2025 09:17:09 -0700 (PDT)
Date: Tue, 27 May 2025 17:16:56 +0100
From: Leo Yan <leo.yan@arm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH V4 01/16] perf: Fix the throttle logic for a group
Message-ID: <20250527161656.GJ2566836@e132581.arm.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520181644.2673067-2-kan.liang@linux.intel.com>

Hi Kan,

[ + Aishwarya ]

On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wrote:

[...]

> @@ -10331,8 +10358,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>  	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
>  		__this_cpu_inc(perf_throttled_count);
>  		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
> -		hwc->interrupts = MAX_INTERRUPTS;
> -		perf_log_throttle(event, 0);
> +		perf_event_throttle_group(event);
>  		ret = 1;
>  	}

Our (Arm) CI reports RCU stall that caused by this patch.  I can use a
simple command to trigger system stuck with cpu-clock:

  perf record -a -e cpu-clock -- sleep 2

I confirmed that if removing throttling code for cpu-clock event, then
the issue can be dimissed.  Based on reading code, the flow below:

  hrtimer interrupt:
   `> __perf_event_account_interrupt()
       `> perf_event_throttle_group()
           `> perf_event_throttle()
               `> cpu_clock_event_stop()
                   `> perf_swevent_cancel_hrtimer()
                       `> hrtimer_cancel()  -> Inifite loop.

In the hrtimer interrupt handler, it tries to cancel itself and causes
inifite loop.  Please consider to fix the issue.


Thanks,
Leo
