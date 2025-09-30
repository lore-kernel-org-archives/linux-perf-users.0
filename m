Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB380604;
	Tue, 30 Sep 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200603; cv=none; b=rYq6eECoofttLMJSgaZNxpzcSfFCHfLGqlYSDhIu6TFTeiaoNKRpBH3Hv6Td2o3dLvS7B2uoJOeF+UcgdIoF2AHhcr1CDw3rufCrPSCZXye3ePJ4TKyR+gy61eRVWp/oIuPeYFKNCQ0hkDtTE/wPNPUmaFVYYc0Hd4W8ghGAnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200603; c=relaxed/simple;
	bh=FFgPD/gTRbTBPPHwmYLsUAHGHdmtr5rkckDNuuD/9b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZUeuWN8NCCY6PzR0avsss5sSkQQgLp9/wWaes8xXl0ttCwW7oNJDelN+6XziMSt5ozKhN3U3ACHSRrMZacr/qn/JdeCzy7u87d/vR76O/BFsFAbD57993KHoTNTa0b8GBkIehci7jcs1k5nHWwCyiVQU3FuE3De9nKDuOAHkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOLpCrVc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOLpCrVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759200602; x=1790736602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FFgPD/gTRbTBPPHwmYLsUAHGHdmtr5rkckDNuuD/9b0=;
  b=BOLpCrVcjQ6DXj/qU/b60DSeURZDyaMYHBdWueKg4qOG2B34GqU+pVBq
   j6nat8MQwr3BeCRUohcOJBSvYc3gjXBMwimKQGtbgOOYSk+3Q6yw8BzNA
   BQDqB5LjqO7UEJ/Qo+n8AoAvPdbKM23MPgNuGPKPhZij7x7mAiU0k6yyU
   0Kx3vvmvBhLvesgjNEs6+RgH+i6yGtAojZSXCCTrgsDPE/88xRPn0BFAV
   ThjPJnGdyZLYWJrJ5mRc1uca45qvSjcP8KmVVkZ6krMbQCn3rDMfJEpkl
   Q2YjYRScqJHUPLBW8VtnFGPge6nnPc1wn7Yc2p9jhWaazUbV6Xy24JSBN
   A==;
X-CSE-ConnectionGUID: dixxvyQ0QRyp8L2HCDB5Dw==
X-CSE-MsgGUID: K+jYGBCGRs+pYmyBQTffFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="71696587"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="71696587"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:50:02 -0700
X-CSE-ConnectionGUID: jLE9vQpZSEeyJgSh9wbK/g==
X-CSE-MsgGUID: 0mKt3EiCSYKGGlbjB0obHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="177519730"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:49:59 -0700
Message-ID: <c962d1a5-b941-4361-839c-c34e621de5ee@linux.intel.com>
Date: Tue, 30 Sep 2025 10:49:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/zhaoxin: Fix instructions error by missing
 fixedctr member
To: tanze <tanze@kylinos.cn>, peterz@infradead.org, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
 <20250620023757.1429898-1-tanze@kylinos.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620023757.1429898-1-tanze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/20/2025 10:37 AM, tanze wrote:
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
> Signed-off-by: tanze <tanze@kylinos.cn>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
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

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


