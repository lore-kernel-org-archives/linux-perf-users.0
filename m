Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456545;
	b=FZqb2XKsKh1boSK3NfF1uj8urolIP7UyfRyhLIr0R5GBXFisDg4FITq69dUQ5+k1Dft3
	 c/wfn6ZWTZ0rBJdCPAvYjPB6MlRYNz4Xt0FY691qn79Vi1oBYrQ4vyiFZIDBbtu2n8HWY
	 2CKPwVojzO9VC5jOk1NR5C5jjhrYdCfcKs3v4eZHFnrg7/iUpY9RgaGH/brtvGeAarSWw
	 2wZnkJxqelbQZrxxAaJqk1p7MLjzoWeDHk9uMZE69KhFfKl44pTwLLOdpdpNHarEzoz1D
	 fuIAh5Y3BoYZItRdZ43vgg205MRCLMr2VsDfsdwx6YChG2cGIFSRCqWYSC7SwHAd8sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=yVtNEwefQmvDUIkWL22wrsyVTS0HPIUc2diMJs3lPPw=;
	b=RTC5KDLiNZyFIeQPcueMfqAjxrxF6XnjEixiCmgRclg0AxO9Om9UQayfYIOpFdwgaRCY
	 KlIcZ1buIS5l1ZlyZrjBnkGQByYEPxAPWWrxTkoCgQpy6xgvLFehfSDm4WxxWi8lB1vYw
	 fOFojuZyK86yf3ktIiOsq9/L79Mthn2VGYDMMlYfEO8K0/z/qMl0yImPot9Q5LfxrXwNC
	 VMqI2axhXBzogs8QRw3Au9sJJb36P0M4hHDYczz1PjItKqVwDE/16YaVoZeTI1ET1nWQ9
	 CHiSPXN9X1fseeUj4hooedhBpTSunGhYiFtdoDyIZDQi6BXg5Y9JRKLECRI80bjsMPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bBHUvF1U;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E3606A321;
	Mon, 23 Nov 2026 17:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355E3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bBHUvF1U
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DBC6176B;
	Mon, 23 Nov 2026 09:55:40 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A939E3F763;
	Mon, 23 Nov 2026 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795456543; bh=DmpffMUW+0WvtzW7S8Ulzv+huswGuPkjQ4AkTENQ9gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBHUvF1UZA61LUkCxTjPlYt6sDQ01oOFpmVDLA62dE4dshGEUtqAz3VgnJP2zFRK1
	 sWkKzQJGGVZhvwBPrU2kTx0pa9cTPt4cNY4gBaTitoLOuk4/zJcxVBNSoJEd0RRo+M
	 nD/2Q0JZ9uXTawZzWD76SO78AKlVDYF8z9wnM4v0=
Date: Mon, 23 Nov 2026 17:55:40 +0000
From: Leo Yan <leo.yan@arm.com>
To: Amir Ayupov <aaupov@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org
Subject: Re: [RFC] perf: SW strobing for AUX trace windows
Message-ID: <20261123175540.GE9176@e132581.arm.com>
References: <20261113074125.4146687-1-aaupov@fb.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113074125.4146687-1-aaupov@fb.com>

On Thu, Nov 12, 2026 at 11:41:18PM -0800, Amir Ayupov wrote:

[...]

> pmu_pulse (coresight-only)
> ----------------------------------------------
> 
> The first attempt was to try to avoid perf/core entirely, and extend
> a coresight config with pulsing ETE external output on every cycle
> while tracing is enabled [1]. This way, pause event on TRCEXTOUTn
> ends the window after exacly N traced cycles. The use of ETE external
> output is pure coincidence, just a way to count cycles only while
> tracing is enabled.
> 
> However, the review has raised that the config is not self-contained
> and requires a lot of checks to only enable it on capable HW:
> - needs a helper in the arm64 PMUv3 header and a move of PMU
>   definitions - needs arm64 maintainer's approval;
> - only works on ETE whose PMU counts TRCEXTOUTn,
> - the window is always measured in traced cycles;
> - is restricted to ETM, doesn't help Intel PT,
> - the further it is from a pure config change, the less understanding
>   I have to support the patch series further.
> 
> I decided to abandon that approach and ask for a better/more general
> solution, hence this RFC.

I saw you have sent CoreSight and PMU pulse v6, I will review it.
It is a good improvement for me.

> Option 3: cross-event "arming" (attr.aux_pause_armed)
> ---------------------------------------------------------------------
> 
> This extends aux-action with a new bit (aux_pause_armed):
> - aux pause event period is set in an overflow of aux resume in group,
> - restarts from the full period,
> - on overflow, pauses aux tracing:
> 
> This is the most flexible and general solution:
> ```
>   # resume every 10M cycles, trace 5000 cycles
>   -e '{cs_etm/aux-action=start-paused/,
>        cycles/aux-action=resume,period=10000000/,
>        cycles/aux-action=pause-armed,period=5000,call-graph=fp/}'
> 
>   # resume on page faults, trace 100k instructions
>   -e '{intel_pt/aux-action=start-paused/,
>        page-faults/aux-action=resume/,
>        instructions/aux-action=pause-armed,period=100000/}'
> ```

I am just wandering if we can extend a bit "aux-action" syntax to
support delta value, something like:

  -e '{cs_etm/aux-action=start-paused/,
       cycles/aux-action=resume,period=10000000/,
       cycles/aux-action=pause,period=+5000,call-graph=fp/}'

The + symbol indicates that the pause event occurs 5,000 cycles after
the resume event.

> Cons:
> 1. the core has to keep a disarmed event stopped across group
> scheduling, throttling, ioc_period, power mgmt.
> 2. rearming happens in the overflow handler (in NMI/IRQ).
> 3. Software pause events are not supported.

Why here software pause event cannot be supported?

> Question
> ---------
> 
> Does it sound reasonable for perf to support this, or it's better
> to pursue pt/coresight-specific solutions? In the end, my use case
> is about tracing.

I think you are asking perf core maintainers to explore a proper way to
move forward. If no feedback, it is good to send RFC series to
demonstrate idea if you have a preference.

> If yes, which option is preferable?
> - Option 1 with restoring first period behavior that was already there,
> - option 2 as cleaner fix,
> - option 3 as completely general but with more core state to track,
> - something else?

Seems to me, if we extend a bit with "+" syntax, this can be general
enough to benefit all AUX trace. And we don't need to introduce extra
new interface.

Thanks,
Leo
