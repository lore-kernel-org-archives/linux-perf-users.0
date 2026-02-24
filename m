Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA51DE8BE;
	Tue, 24 Feb 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917070; cv=none; b=gfLSnS9IrALuFWZoXJAm/mS5cBt7Rz1S2x4aypKQKqC6NkV1M6OSaVKZ8mgaW+YiMtYne1m7+OoNgFCyPzQgq3AKt8EClaIkAtoRzNoKBfLnjLRPWrYHoa8PXkdbigWRPV3apI7/R6bKF+j8ukifp+umf+K4Cl1v8UsrS75BB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917070; c=relaxed/simple;
	bh=yhXONs2vzMRFL0TLV4LX9AS8omaatGcAbAurOoz/I7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWgVoNCUmP5BZSMR3EZ8B/qSvQW3YQGK//qpT5Z6Z0rd+4uj5qFK7iBpAROPhqfrfX38soZb8NktzNZKJVleXGIpcowQKj5X1YIyj3bcWVT15Bby1FyD59NQyrNJCzK652ml4WgjcUgfEsBd45oZc2HWVF3+/LuFUJm63JfBDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPfwSFgs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPfwSFgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771917070; x=1803453070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yhXONs2vzMRFL0TLV4LX9AS8omaatGcAbAurOoz/I7E=;
  b=EPfwSFgs8HhT/2bJ3oDN08ixcoC4CQ9hoo7ZtAmS0/o3DLif+hQoIeSf
   B6yiOlNKKQTeWhd31S92AsuSC55wuZrg23rc3py/vcAbBOjZyI1aUk0ot
   4lWRP4c5dTRSHkY4WQD8CVAPEf85VT636ppDBYH4+bFEs/wPQA6sdjrhe
   bHuROF32dRx6eiwWexDTpT+B/Q8lJT4zipnTPBtqNaHGGv0WA4wA3LQXe
   7P8WdPcnzxd6AWcoySUgxn/avMzPqwFCdgVfIZDA25Mg1VXAoVXHFwyXA
   NXOrTr8M1eJH+46bIfkYQ/RoFAwh9ppjWChpEjTOJJyRCWcK2zKrrlT6O
   g==;
X-CSE-ConnectionGUID: ylJoSiQ3SUCIHrqz+9HIAw==
X-CSE-MsgGUID: 3MFweAVTStepzf1SjmoHXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="75532888"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="75532888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 23:11:09 -0800
X-CSE-ConnectionGUID: NPdF8pXZQC6l5p88gZ4ZBw==
X-CSE-MsgGUID: STw0hfGVTNeAJf9gTdQ1iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="214077897"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 23:11:04 -0800
Message-ID: <e57a249b-ce70-4f5a-86f5-cd86bc477546@linux.intel.com>
Date: Tue, 24 Feb 2026 15:11:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 10/22] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-11-dapeng1.mi@linux.intel.com>
 <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/16/2026 7:58 AM, Chang S. Bae wrote:
> On 2/8/2026 11:20 PM, Dapeng Mi wrote:
>> This patch supports XMM sampling for non-PEBS events in the `REGS_INTR`
> Please avoid "This patch".

Sure.


>
> ...
>
>> +static inline void __x86_pmu_sample_ext_regs(u64 mask)
>> +{
>> +	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
>> +
>> +	if (WARN_ON_ONCE(!xsave))
>> +		return;
>> +
>> +	xsaves_nmi(xsave, mask);
>> +}
>> +
>> +static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
>> +					   struct xregs_state *xsave, u64 bitmap)
>> +{
>> +	u64 mask;
>> +
>> +	if (!xsave)
>> +		return;
>> +
>> +	/* Filtered by what XSAVE really gives */
>> +	mask = bitmap & xsave->header.xfeatures;
>> +
>> +	if (mask & XFEATURE_MASK_SSE)
>> +		perf_regs->xmm_space = xsave->i387.xmm_space;
>> +}
>> +
>> +static void x86_pmu_sample_extended_regs(struct perf_event *event,
>> +					 struct perf_sample_data *data,
>> +					 struct pt_regs *regs,
>> +					 u64 ignore_mask)
>> +{
> ...
>
>> +
>> +	if (intr_mask) {
>> +		__x86_pmu_sample_ext_regs(intr_mask);
>> +		xsave = per_cpu(ext_regs_buf, smp_processor_id());
>> +		x86_pmu_update_ext_regs(perf_regs, xsave, intr_mask);
> These three lines appear to just update xcomponent's _pointers_ to an 
> xsave storage:
>
>    * Retrieve a per-cpu XSAVE buffer if valid
>    * Ensure the component's presence against XSTATE_BV
>    * Then, update pointers in pref_regs.
>
> which could be done in a function with more descriptive name. Given 
> that, I don't think__x86_pmu_sample_ext_regs() has any point. I don't 
> understand x86_pmu_sample_extended_regs() naming, either.

Hmm, partially agree, __x86_pmu_sample_ext_regs() can be dropped. The
intent of this whole function is to sample the required SIMD and APX eGPRs
registers by leveraging xsaves instruction in a NMI handler context. All
the SIMD and eGPRs registers are collectively called "extended registers"
here. Not sure if the "extended registers" is a good word, please suggest
if there is a better one.

Thanks.


