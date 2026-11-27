Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795759972;
	b=aVXfGsO6seZik1h/QO7NAg4+auSEhgxsfuOAoWIlhi91p4mOFNs4pKcfN23RIWmfaq6z
	 tpmY3eF/muOFUzT0NkDgdP25QgN/1XRNo/M+PxYNpjGLh/4Eyuy8VP5LYl8bqlD7q7iA+
	 UkTSQmJ8hHX+Dc6b+zNuQBYVruQXvQnrfh5bAKGuxy7FCsQQX0HrEgmoHO0X3plbwGorP
	 zq2qu/BNGcXOgVyUWsmRDGutkcm67wFMyuqVQzyp4RQsv80Zzoe/zhetMMQRn8YxF5TyI
	 8vJijnZusO+FJIWX2jKpFj3Vv9BFPVniL/yB8R/hD12+yDtXTFiLBDwcHaSsa5tFP/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759972;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cHrNC2jzdj2jHs0cTakIGu8j4jjplUz3R5H7yU9nUkc=;
	b=LoNcs9O+np0Q+AfBCAgW/nRng/HNWkQ0aaCo2uSyQQOIgVytEkYgFLSXZ/5f2e+3TNdy
	 sUjDqwenDqwIF3Hov79cAp5etybmeafSCsvhAx9FQDHQHJmaON+v47ka5SdbSGf9X+QcD
	 3i0fUA+j0l1d/Kod6O9v7Zd1xU7Ff89Oc9F9AljSNahoMGuRFUF70WZhngzSkvY6s6Cnp
	 GybZ6rt3E29HANjbglkvgjjlpe0TXAbPzvEUDiQzs8ro/eSk423QpN/q0l/3pclIxgWPr
	 47OFsbkK4HZ9dQ9jDRD8TwEIzFtjityKCFu9/RBHDOiKCoPbv46u47dOERwYuJ9MUHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C4MToYBo;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5C606A31C;
	Fri, 27 Nov 2026 06:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C4MToYBo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795759972; x=1827295972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9tu79qrVQIfAN4gZIEBfqBBBhveaA6t+b5b559ShEB0=;
  b=C4MToYBoxl2MY7s8/fH6it9Uh4WgxWJZj5B69IXuuTUEYgm6vv0MWm+k
   X9A0gscIQCUejxezYzdBlPHIN/XO5N5BkGIytyrh7Pjyhn5sMj83Me13T
   CpcX17zho8+WG7JswurX76VJGguWyoBF89woY5ytGTnQrWbWH9rMaleoY
   +UtZkM+UxdFhkPS5AuF3dKV037wKWECZxt+uLcGpz0xVOPzXUSR47lVzA
   E/wZn7Scp6zLli7o4xexM2T7riHrmG/AW2cDQERG3BEaXUrcKnOhVnsoC
   sYFDvYvjzsIuOS67Wtnt83D3j3uRw8FaiQpjLM+Xkm+qmffvjDGz5+zb4
   g==;
X-CSE-ConnectionGUID: uyxwC1jMQBWUpD/ObYyuxQ==
X-CSE-MsgGUID: PCAnD4/kT6CivROhvEd3EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4509687"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4509687"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 22:12:51 -0800
X-CSE-ConnectionGUID: 4ro1cSFCS9SoyAywuiNSrA==
X-CSE-MsgGUID: rkNXaCunQw6H8owP5EwvqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12467285"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 22:12:46 -0800
Message-ID: <7f5430f2-4220-4d96-b4f7-af667fb14dde@linux.intel.com>
Date: Fri, 27 Nov 2026 14:12:42 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Don't allow extended register sampling
 for BTS events
To: Jiwoo Kim <arpe1618@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261114062249.1301-1-arpe1618@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261114062249.1301-1-arpe1618@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Could you please review this patch? If it can be merged in the 7.4 release
cycle, then no backport is needed. Thanks.


On 11/14/2026 2:22 PM, Jiwoo Kim wrote:
> x86_pmu_hw_config() accepts extended (XMM) register sampling in
> REGS_USER for events without precise_ip, and the same goes for the SIMD
> register fields. The BTS event is such an event, and
> intel_pmu_bts_config() does not reject it.
>
> For a sample taken in the PMI handler, x86_pmu_update_perf_regs() copies
> the user registers into the per-CPU x86_user_regs, which is a struct
> x86_perf_regs. That is what perf_reg_value() and perf_simd_reg_value()
> expect: they use container_of() on the sampled struct pt_regs to reach
> the fields that follow it.
>
> intel_pmu_drain_bts_buffer() does not call x86_pmu_update_perf_regs().
> It passes zeroed on-stack registers to perf_prepare_sample(), so the
> generic perf_sample_regs_user() takes the user registers from
> perf_get_regs_user(). That returns task_pt_regs(current), or on x86_64,
> when the buffer is drained from the PMI handler, a copy in the per-CPU
> nmi_user_regs, and neither is embedded in a struct x86_perf_regs. For a
> BTS event that requests these registers in REGS_USER, perf_reg_value()
> and perf_simd_reg_value() therefore read past the end of the struct
> pt_regs they are given, and use the words found there as pointers.
> REGS_INTR is not affected: BTS events must set exclude_kernel, and
> perf_sample_regs_intr() then reports no registers, as the zeroed ones
> are not user mode.
>
> BTS samples are built from the BTS buffer when it is drained, not from
> the registers of an interrupted context, so there is nothing meaningful
> to report in these registers for them. Reject extended and SIMD
> register sampling for BTS events in intel_pmu_bts_config(), as was the
> case before these registers could be sampled for events without
> precise_ip.
>
> This was found with an AI coding assistant, which also drafted this
> patch and its changelog. It has not been reproduced, and the change
> has only been compile-tested.
>
> Fixes: edd9aec51213 ("perf/x86: Enable XMM register sampling for REGS_USER case")
> Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
> ---
> No Cc: stable, as the Fixes target first appeared in v7.4-rc1.
>
> The container_of() on a struct pt_regs that is not embedded in a struct
> x86_perf_regs came up in the review of v10 of the SIMD sampling series,
> for software events and bpf_perf_event_output():
> https://lore.kernel.org/r/20260824091225.514D71F000E9@smtp.kernel.org
> The reply there pointed out that the PMU capability checks reject those
> events. The BTS event is created on the core PMU, which has
> PERF_PMU_CAP_EXTENDED_REGS (and PERF_PMU_CAP_SIMD_REGS where supported),
> so those checks do not stop it.
>
>  arch/x86/events/intel/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df59..88a60d3e4eeb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4778,6 +4778,16 @@ static int intel_pmu_bts_config(struct perf_event *event)
>  		if (attr->precise_ip)
>  			return -EOPNOTSUPP;
>  
> +		/*
> +		 * BTS samples are built from the BTS buffer when it is drained,
> +		 * not from the registers of an interrupted context, and
> +		 * intel_pmu_drain_bts_buffer() does not provide the registers in
> +		 * the struct x86_perf_regs layout that extended register sampling
> +		 * relies on.
> +		 */
> +		if (event_has_extended_regs(event) || event_has_simd_regs(event))
> +			return -EOPNOTSUPP;
> +
>  		/* disallow bts if conflicting events are present */
>  		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
>  			return -EBUSY;
>
> base-commit: 59f1398140869432c7171b9a2a279ca315467c4e
