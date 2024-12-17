Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39EEED8;
	Tue, 17 Dec 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442634; cv=none; b=meYtL+jBge1uUMt+waEwouvFxewlvC51R3fGiR1j7HmGqKLzrfmgG2eMCN9I80VStL1PWyb1rjMNz/TpndkX+LOxmoFSpmF/WtmfNtB0U17Y1dIjbwjFUVcNXRqwvAfD7bfYjgW/1Ttki64g7JdbO5jC493mYOAO7O71Kw1E4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442634; c=relaxed/simple;
	bh=Qz8U7whF8mZJBtM9cuHoqE5mi9QRsDImf2edJO1eQ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVwPck/gKzChbOPq5j5/jFczVFthX1PO3i/QlfmxQwYLgFVXejqOSUJXwGOzqjCBex3cKiYybZkMmRZ1CxWEPM8L2D7X+I3Kx3u/l8UkWs6WkBBpr7TA+iI/oybqGZtRWVeLWXSgHcFru/Bn8rHlQKIoXV2MFFDoV7UNbOLLDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZV2HDTY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZV2HDTY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pmngiQtyKWtEVigv/m7WJAI71XogMaDStb8A3KF11q4=; b=dZV2HDTYcgqkZsCJBzrkmJWKFB
	eBPyLvwgy4vVpnEhTuUJ/1cJeFZBvqMEjeoOQyyVxSI4jnzCbNTd/BwXqaBMSnWbp54RLuEu0Qm5i
	cc8ANnxehGCYK4wvVW03Tjio+Qvw99ZFOGgl1CsGHU9Xu4OOSkPlS2BsswPXirtiiTi1SfDuAmW4/
	1CkzVCJNbQw12rvnloUuOteg3cxU6ZNMc191qnz6y8TMtxP5fcLLu4AmmQIbRx/j3+n79oTlryov5
	B8alG3apy6pvXKW++QKzziRjpsQu+fZrTnXlqliHdF5MZWQoFSzb8iJMSYq/4IXiGv9XkpB+xFOQl
	606gQTUA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNXl5-0000000557V-2sIT;
	Tue, 17 Dec 2024 13:37:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40B0330015F; Tue, 17 Dec 2024 14:37:07 +0100 (CET)
Date: Tue, 17 Dec 2024 14:37:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V5 4/4] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20241217133707.GB2354@noisy.programming.kicks-ass.net>
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
 <20241216204505.748363-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216204505.748363-4-kan.liang@linux.intel.com>

On Mon, Dec 16, 2024 at 12:45:05PM -0800, kan.liang@linux.intel.com wrote:

> @@ -2049,6 +2102,40 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		}
>  	}
>  
> +	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
> +		struct pebs_cntr_header *cntr = next_record;
> +		int bit;
> +
> +		next_record += sizeof(struct pebs_cntr_header);
> +
> +		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
> +			x86_perf_event_update(cpuc->events[bit], (u64 *)next_record);
> +			next_record += sizeof(u64);
> +		}

I still don't much like any of this -- the next_record value might be in
the past relative to what is already in the event.

Why can't you use something like the below -- that gives you a count
value matching the pmc value you put in, as long as it is 'near' the
current value.

---
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac0d445..3cf8b4f2b2c1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -154,6 +154,26 @@ u64 x86_perf_event_update(struct perf_event *event)
 	return new_raw_count;
 }
 
+u64 x86_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int shift = 64 - x86_pmu.cntval_bits;
+	u64 prev_pmc, prev_count;
+	u64 delta;
+
+	do {
+		prev_pmc = local64_read(&hwc->prev_count);
+		barrier();
+		prev_count = local64_read(&event->count);
+		barrier();
+	} while (prev_pmc != local64_read(&hwc->prev_count));
+
+	delta = (pmc << shift) - (prev_pmc << shift);
+	delta >>= shift;
+
+	return prev_count + delta;
+}
+
 /*
  * Find and validate any extra registers to set up.
  */
