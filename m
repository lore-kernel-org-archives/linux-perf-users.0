Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF821862BB;
	Sat, 21 Jun 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750498485; cv=none; b=Uwt8QDD/x4nU8/N6Iz7JID5+exZ3l8jVAsHlDkrIVfD+KOg+MJEsvMNffNT5+E0Car2tvfG3eJNEbcT5+0UUFqXxK+0K4DfmNmrwW60X0WNG2n99EvsSDViGcFDIiXW7JiY1lJhjPI3deGve4iXLGKg/8N0hEIXrPMajZ4rklME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750498485; c=relaxed/simple;
	bh=jSapbn2R2cljWXIud+/Xr7wMWJtjsyd/0qYZYvnp7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzO0If8RGRMBjzRYWWiSnHE5kA/bPSFR7Yx19cDSM8ObZYHhkjyxBjK8O+9+moxY3LkNbxqGiBAbTTA6ki2Olmt1EW7L8UAJbiA9loBTQCZtO0cDX6Xg8hnC9Mxjk1kWr7zZODfPjIDO9IByqi2SO1sjcnVPEhvjyfxwssrMhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hbmvdx/A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbmvdx/A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xsmu5nZjKdQUvIxx1o6O6iMtNowAeQmQ5L2U1RWpOdM=; b=hbmvdx/AlLj6lXiLCQr57nNXJx
	ym3g34+LXVkE9v5aDsYL2eaxIdDgMRX9/gk+PARfE/nzPAjR6Ua8r87CMUf+6843I9lt9QJAQqayw
	7GkRC2JXgtFYPU5doVsPPKT96SR83iAATfln0WjbFgqFLCTR5dVwWEin6UzKyqONllg9mv1zimBfK
	1xdLjpdavgnuY2E40DV/jAlf7fUpCmFyDEPcK0Xtv4VzsitUwkLBJeYiueWnmjyQovPbo8+SeDbdL
	4Wcftnupphqfi2B4L/euL+81Nur+NtjIT3wvt0jRX0+UMGboRiTrVEGVOZRCO76iLOJepPy1u++6h
	yCgm041Q==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSucQ-0000000EvyO-24LF;
	Sat, 21 Jun 2025 09:34:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 713543087E7; Sat, 21 Jun 2025 11:34:37 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:34:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
Message-ID: <20250621093437.GV1613376@noisy.programming.kicks-ass.net>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>

On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:

> +static void intel_pmu_enable_event_ext(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	union arch_pebs_index cached, index;
> +	struct arch_pebs_cap cap;
> +	u64 ext = 0;
> +
> +	if (!x86_pmu.arch_pebs)
> +		return;
> +
> +	cap = hybrid(cpuc->pmu, arch_pebs_cap);
> +
> +	if (event->attr.precise_ip) {
> +		u64 pebs_data_cfg = intel_get_arch_pebs_data_config(event);
> +
> +		ext |= ARCH_PEBS_EN;
> +		if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD)
> +			ext |= (-hwc->sample_period) & ARCH_PEBS_RELOAD;
> +
> +		if (pebs_data_cfg && cap.caps) {
> +			if (pebs_data_cfg & PEBS_DATACFG_MEMINFO)
> +				ext |= ARCH_PEBS_AUX & cap.caps;
> +
> +			if (pebs_data_cfg & PEBS_DATACFG_GP)
> +				ext |= ARCH_PEBS_GPR & cap.caps;
> +
> +			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
> +				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
> +
> +			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
> +				ext |= ARCH_PEBS_LBR & cap.caps;
> +		}
> +
> +		if (cpuc->n_pebs == cpuc->n_large_pebs)
> +			index.split.thresh = ARCH_PEBS_THRESH_MUL;
> +		else
> +			index.split.thresh = ARCH_PEBS_THRESH_SINGLE;
> +
> +		rdmsrl(MSR_IA32_PEBS_INDEX, cached.full);

Its unclear to me we need this rdmrsl(); does anything actually change
in there or is it just the value we wrote last? The naming seems to
suggested you want it cached instead of re-read. Most confusing.

Also, if you do:

union arch_perf_index {
	u64 full;
	struct {
		u64 foo:1,
		    bar:2;
	};
};

Then you can get rid of that .split naming.

> +		if (index.split.thresh != cached.split.thresh || !cached.split.en) {
> +			if (cached.split.thresh == ARCH_PEBS_THRESH_MUL &&
> +			    cached.split.wr > 0) {
> +				/*
> +				 * Large PEBS was enabled.
> +				 * Drain PEBS buffer before applying the single PEBS.
> +				 */
> +				intel_pmu_drain_pebs_buffer();
> +			} else {
> +				index.split.wr = 0;
> +				index.split.full = 0;
> +				index.split.en = 1;
> +				wrmsrq(MSR_IA32_PEBS_INDEX, index.full);
> +			}
> +		}
> +	}
> +
> +	if (cpuc->cfg_c_val[hwc->idx] != ext)
> +		__intel_pmu_update_event_ext(hwc->idx, ext);
> +}
