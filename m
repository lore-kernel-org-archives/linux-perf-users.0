Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C6E555;
	Mon, 23 Jun 2025 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642695; cv=none; b=ZQn0Nf9uhWWB1WAHJ1PLZcCoTrDkFXooYoRmXrw8vDVyMXCLEYDIBQhuUkobLyRp2wTLhAaFUWlRStAouTKtd/1u1xxSfqQl/gHSenoBNdONPeyg2hr2svPh7/nIVjcDl9x+gjcM+hXwCzNQMf6ZkBX5o0ZbY8XA3Mv4T4pnTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642695; c=relaxed/simple;
	bh=HfqyG3kXHnCcLbS8cbdxIXtXdT7Qjgp9E12+G2/XvYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2tXaWI68/G7wRBcBiQVd+JQPkZEE4UOt3c/1QIfGh+CTIUCMWT3pd+qlGNp04/30kBGDa86RQ7575hvznGedYsxeqkCbmL5Jbiks9viMbKRPVB+7uCeVe4t6qY4SF145pKhX1Ojq99eym8AF2eSpzqYnumlUUdM2OifvC+BqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1Kn9mpv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1Kn9mpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750642693; x=1782178693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HfqyG3kXHnCcLbS8cbdxIXtXdT7Qjgp9E12+G2/XvYM=;
  b=I1Kn9mpv/h/0z9qJ53c94bPdAckokok6xVniZdmDKnv9nID0ws3o5UCd
   rDMnL7/MTWSqWr++y30w9qngv1ZmI/FTO4PkWNXTNUseisdhk13n/VmRq
   eHQOOEh8Q/GEDtZMYw/2EXF1R7ZAiStlrCaw5scO7TMBWImwvzrxmNJMO
   ywfhXcIdzgu6PtYCn09fRspT9ugcP0IFA19Q8bWvnX2o4uFbURh5LkKo6
   PQrNEkI/elxTvtS/+mvia8D227T8bx+ciRrYg6Hek3iyyEPjuv7Wkqgn+
   Qik2GC5C2suGgAxhVpKpy4yUTNFiteu77CNvGvcWhcc7y4ggUyHfwMTdi
   A==;
X-CSE-ConnectionGUID: +729Chv8Rtm7rtGwxk0C2g==
X-CSE-MsgGUID: ThE0f3RbRbO3R9c5/wZ8Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="55471366"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="55471366"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:38:12 -0700
X-CSE-ConnectionGUID: ZpBNVfeHTCObCtjuXJMe3A==
X-CSE-MsgGUID: T3CWd3UNTGqUuXStwzafEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="151654523"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:38:09 -0700
Message-ID: <b31633cf-4127-4f0e-94b1-233d76aa38d6@linux.intel.com>
Date: Mon, 23 Jun 2025 09:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
 <20250621093437.GV1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250621093437.GV1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/21/2025 5:34 PM, Peter Zijlstra wrote:
> On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:
>
>> +static void intel_pmu_enable_event_ext(struct perf_event *event)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	union arch_pebs_index cached, index;
>> +	struct arch_pebs_cap cap;
>> +	u64 ext = 0;
>> +
>> +	if (!x86_pmu.arch_pebs)
>> +		return;
>> +
>> +	cap = hybrid(cpuc->pmu, arch_pebs_cap);
>> +
>> +	if (event->attr.precise_ip) {
>> +		u64 pebs_data_cfg = intel_get_arch_pebs_data_config(event);
>> +
>> +		ext |= ARCH_PEBS_EN;
>> +		if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD)
>> +			ext |= (-hwc->sample_period) & ARCH_PEBS_RELOAD;
>> +
>> +		if (pebs_data_cfg && cap.caps) {
>> +			if (pebs_data_cfg & PEBS_DATACFG_MEMINFO)
>> +				ext |= ARCH_PEBS_AUX & cap.caps;
>> +
>> +			if (pebs_data_cfg & PEBS_DATACFG_GP)
>> +				ext |= ARCH_PEBS_GPR & cap.caps;
>> +
>> +			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
>> +				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
>> +
>> +			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>> +				ext |= ARCH_PEBS_LBR & cap.caps;
>> +		}
>> +
>> +		if (cpuc->n_pebs == cpuc->n_large_pebs)
>> +			index.split.thresh = ARCH_PEBS_THRESH_MUL;
>> +		else
>> +			index.split.thresh = ARCH_PEBS_THRESH_SINGLE;
>> +
>> +		rdmsrl(MSR_IA32_PEBS_INDEX, cached.full);
> Its unclear to me we need this rdmrsl(); does anything actually change
> in there or is it just the value we wrote last? The naming seems to
> suggested you want it cached instead of re-read. Most confusing.

HW could write MSR_IA32_PEBS_INDEX as well, so strictly speaking it's not
we wrote last. The aim of this part of code is to check if large PEBS is
used by last time, if so we need to drain up the PEBS buffer before
re-enable PEBS. 

Yes, the "cache" is some kind of misleading. I would change it.


>
> Also, if you do:
>
> union arch_perf_index {
> 	u64 full;
> 	struct {
> 		u64 foo:1,
> 		    bar:2;
> 	};
> };
>
> Then you can get rid of that .split naming.

Sure. Thanks.


>
>> +		if (index.split.thresh != cached.split.thresh || !cached.split.en) {
>> +			if (cached.split.thresh == ARCH_PEBS_THRESH_MUL &&
>> +			    cached.split.wr > 0) {
>> +				/*
>> +				 * Large PEBS was enabled.
>> +				 * Drain PEBS buffer before applying the single PEBS.
>> +				 */
>> +				intel_pmu_drain_pebs_buffer();
>> +			} else {
>> +				index.split.wr = 0;
>> +				index.split.full = 0;
>> +				index.split.en = 1;
>> +				wrmsrq(MSR_IA32_PEBS_INDEX, index.full);
>> +			}
>> +		}
>> +	}
>> +
>> +	if (cpuc->cfg_c_val[hwc->idx] != ext)
>> +		__intel_pmu_update_event_ext(hwc->idx, ext);
>> +}
