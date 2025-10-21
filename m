Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99C36CDEA;
	Tue, 21 Oct 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067140; cv=none; b=V0tnKAJc1qoQNYhXF4IRY9Ix02Xby2+usQmWHvrQwndA9Wp5o+8XZZSOYHZecUWWepNM3zcHP34z2GMGwJfHaZFzV5540DX04a1CSdIde8Ctw84Px8YvG7bJb3KeF2xCHoArz5yf/bpKEGU3wVbu+cYcuzJI/uS/njqrB8Y6oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067140; c=relaxed/simple;
	bh=99Xtdph8cDRaY1yeQ0aDYP3BJKKmIic14r/rh1CGqEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY8h9tSnpK5wrt2SU6oPwGDSKK3QnMqefIDgnMIgupeo5JtS8a2rd1jhzRillOk8X0JDuKpzsfKZJFRsJBNKaR/drF6caUKr8G3M2j3Lvf81Mo4/T5YkgoX/1T7eymwP90Rgrd9h/b3kz9PWh3ZXPJ0AUasR/MlveYMzrAwkiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PFUrSbXE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PFUrSbXE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iMPrx8pR13/xdmOQFWMIdXyB86WxHGYWDR+h/23oryo=; b=PFUrSbXEUG0Egmzu748TlM5z8k
	epMwDinvsbR/QDq1aPYhyYOxDGJJCxjVyx+XqW0Q/pbIU0gy9Vu8Y3R4GnlNEjVWn1gfco2Cn0tvK
	AstbJLl02QcZcTyZVXuNBmzRaCC1v+fgIhy6zHsWzcMUsMn3fk6NcHeQU5+dmGea5hofx7naEpepj
	LZ4F+ssfmZGOPgsjvnTkpGla6d4EtYPeM82VJfW6sBk5u71cZX8q4PdHncwrbtRxRMbDjDABPJ5xd
	LJHS2aVHiqKzjMgqTFxebdRUPl7bmiiSLh98qFMvuzs1o86F6wypGK3kKidFehyj9UHM84lgjNsJq
	7JOOwr7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0X-0000000DsJs-0Mjp;
	Tue, 21 Oct 2025 17:18:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9EF6C3030DD; Tue, 21 Oct 2025 17:49:30 +0200 (CEST)
Date: Tue, 21 Oct 2025 17:49:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v8 06/12] perf/x86/intel/ds: Factor out PEBS record
 processing code to functions
Message-ID: <20251021154930.GS3245006@noisy.programming.kicks-ass.net>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015064422.47437-7-dapeng1.mi@linux.intel.com>

On Wed, Oct 15, 2025 at 02:44:16PM +0800, Dapeng Mi wrote:

> +static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
> +						  struct pt_regs *regs,
> +						  struct perf_sample_data *data,
> +						  void *at, u64 pebs_status,
> +						  struct perf_event *events[],
> +						  short *counts, void **last,
> +						  setup_fn setup_sample)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct perf_event *event;
> +	int bit;
> +
> +	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
> +		event = cpuc->events[bit];
> +
> +		if (WARN_ON_ONCE(!event) ||
> +		    WARN_ON_ONCE(!event->attr.precise_ip))
> +			continue;
> +
> +		if (counts[bit]++)
> +			__intel_pmu_pebs_event(event, iregs, regs, data,
> +					       last[bit], setup_sample);

No brackets, while coding style requires.

> +
> +		last[bit] = at;
> +		/*
> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
> +		 * could trigger interrupt throttle and clear all event pointers of
> +		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
> +		 * it could be cleared. This avoids the possible NULL event pointer
> +		 * access and PEBS record loss.
> +		 */
> +		if (counts[bit] && !events[bit])
> +			events[bit] = cpuc->events[bit];
> +	}
> +}


> @@ -2671,41 +2728,15 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  		if (basic->format_size != cpuc->pebs_record_size)
>  			continue;
>  
> -		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
> -		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
> -			event = cpuc->events[bit];
> -
> -			if (WARN_ON_ONCE(!event) ||
> -			    WARN_ON_ONCE(!event->attr.precise_ip))
> -				continue;
> -
> -			if (counts[bit]++) {
> -				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
> -						       setup_pebs_adaptive_sample_data);
> -			}

Brackets. Which suggests you took effort to remove them, since cut-paste
code movement would've preserved them.

I've re-instated them.

> -			last[bit] = at;
> -
> -			/*
> -			 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
> -			 * could trigger interrupt throttle and clear all event pointers of
> -			 * the group in cpuc->events[] to NULL. So snapshot the event[] before
> -			 * it could be cleared. This avoids the possible NULL event pointer
> -			 * access and PEBS record loss.
> -			 */
> -			if (counts[bit] && !events[bit])
> -				events[bit] = cpuc->events[bit];
> -		}
> +		pebs_status = mask & basic->applicable_counters;
> +		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
> +					       pebs_status, events, counts, last,
> +					       setup_pebs_adaptive_sample_data);
