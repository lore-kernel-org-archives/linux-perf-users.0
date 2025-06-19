Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF699220680;
	Thu, 19 Jun 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343586; cv=none; b=sWfSGvOQpgqHEKeBfqKLQPnIqFPruLdtDKRzPHmvrQX+tawCTNRaCIP1Kcv2599h40oWNuDSasXtMNNKc2RLcqkV8UNWjkQ8mMhtoSeOlLWjfzgfPunwDmY7iO4SrVeqY1VHO7oBYG0u6jJ/raftofeCRvi/PwrhngSLJEThgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343586; c=relaxed/simple;
	bh=cxqG9VR36WYSMBGCWKwtu/zQVMtBVhABQTSjeHkx6M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA2UHJQAoC6TY9MvAnwLB2SZgC55XhefCwQv42ZqL8D2PNj/CpVAkDsZ7FoQ44jf0nk4Bf+HqGPQwaknxRFRkgVGqK/yQettRZMKuhgHQZiLQBnZPqkMpEzlPIntu5cohG/H56Sg4rb0pMLDwBec4FQAp3DK/269PdHuu6/cLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enNypCuv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enNypCuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750343585; x=1781879585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cxqG9VR36WYSMBGCWKwtu/zQVMtBVhABQTSjeHkx6M0=;
  b=enNypCuvq4uTHC+m/FG9NUP6nsRL/7oR2yxAOuMVLGxbZ/WQAUdDQB6u
   DfEE1vSkd+BN35R7kESZYKUomTLoDrqjG7XUldeV38cKttG892NjKUoyQ
   Iy4zQCHWlQijPo7zYmBMiGwQMdWrWJAAXCTZobFw2o0/t3rrlmDAqrFe5
   DfgpvHdl3UGLW/s7wNlO2Uho9vofq5y6MzcS8PjgULHgVH/R1Q4lOkiE8
   vlfGiPMHdb0fW42p83qsa1WdMN4wtbMkNZ8meYwB+1vBbs/HxX66G4jZ2
   pkI40RJfUf10wDc5BfllAuTOxJPPMt8stXUe69dvVSviUKG6vN9Mtt6dK
   w==;
X-CSE-ConnectionGUID: TItaxF2mSaSrJIWthMWrhw==
X-CSE-MsgGUID: 9X/wNVa8RnKu/3PjRIbxzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52465939"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="52465939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 07:33:04 -0700
X-CSE-ConnectionGUID: XkmHy/J3S8OK8arLKBtLEA==
X-CSE-MsgGUID: jw2rholqSG6sDSoxKuvptQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="154941010"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 07:33:03 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C5C0320B5736;
	Thu, 19 Jun 2025 07:33:02 -0700 (PDT)
Message-ID: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
Date: Thu, 19 Jun 2025 10:33:01 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/zhaoxin: Fix instructions error by missing
 fixedctr member
To: tanze <tanze@kylinos.cn>, peterz@infradead.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20250619031947.1111196-1-tanze@kylinos.cn>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250619031947.1111196-1-tanze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-18 11:19 p.m., tanze wrote:
> Perf's instructions event tests on Zhaoxin CPUs may exhibit:
> 
>   $perf stat -e instructions,cycles ls -l
> 
>   ......
>   Performance counter stats for 'ls -l':
> 
>                  0      instructions                     #    0.00  insn per cycle
>          9,488,278      cycles
> 
>        0.004365407 seconds time elapsed
> 
>        0.003303000 seconds user
>        0.001099000 seconds sys
> 
> The absence of the fixedctr member leads to an incorrect hwc->event_base
> value on Zhaoxin CPUs, causing a discrepancy in the instruction count
> reported by perf stat. This commit resolves the instruction count issue
> by properly initializing the fixedctr member.
> 
> Fixes: 149fd4712bcd ("perf/x86/intel: Support Perfmon MSRs aliasing")
> 

Please remove the empty line.

> Signed-off-by: tanze <tanze@kylinos.cn>

I have no idea Zhaoxin also have fixed counters.
If so, Yes, I think the patch is required.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan> ---
>  arch/x86/events/zhaoxin/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
> index 4bdfcf091200..3fc3f9abece9 100644
> --- a/arch/x86/events/zhaoxin/core.c
> +++ b/arch/x86/events/zhaoxin/core.c
> @@ -467,6 +467,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst = {
>  	.schedule_events	= x86_schedule_events,
>  	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
>  	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
> +	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
>  	.event_map		= zhaoxin_pmu_event_map,
>  	.max_events		= ARRAY_SIZE(zx_pmon_event_map),
>  	.apic			= 1,

