Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09132341AC7
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298511; cv=none; b=eEIfOlANh53Gepr9dFfVcbAZCARu7Ruu9vhPAfVkKaLxoih6oh28mq8sJG5TB+uwyQz+uAKEoBbypIiWxP2qY7ars5PLVfyeY+vh9OR6Zmj8a2AaRnP1j9STq2fDuprDMGhGWXYJH/pmjUlZ6Wb2Lh1ONHqHuZYQY+Ms/J1AbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298511; c=relaxed/simple;
	bh=22rA8iBKXYAa98HSJ5LTK6ngTKyhKcejbW6Q3Inql8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM1Dyg6i9qjjPfn0q1N20zvQzUHgSh/yCnSqe4peqbVcPrluCwf/MKvchfkvko2oXUhd5yn3J6cr5YwWdeESC9LXD83gl1+LZfjr0VM6C67b4HY19SvbyiVABkkFfJvg58LASOd8zhZaPr6xiWaC+Mn2nhWnbiWb3/Q/z4SS9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATM4RfF6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATM4RfF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780298509; x=1811834509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=22rA8iBKXYAa98HSJ5LTK6ngTKyhKcejbW6Q3Inql8o=;
  b=ATM4RfF6m4hBpywDV+EdnAT45c02Xhb3h34m6DnPqt1dCWaOnKxCl2Tx
   xHtddNtWdpQg/5oTHB8M16uGXE9CzNCy7E7H7QP6NadMLbuLOf2SsHYTd
   Q/SDSK28Gf4FS0P3Rn6p+EAREk3AicsbmQUYwZN39w8/bryEMnpFpr/4X
   hxoBYiVHuHlela0YQWk0Ai/yTCXeHEmegJVLuwqm+bLlMQo21qPQmaT/i
   GD8kuLvRXKasPk+v5hKgv8Jw/JoULglMUrAuzbS0phn//Y1ZioiA3iuIr
   aJgosdpyvP9CqQiRyU5SC6gsiZ5eZAPJ7VIgmewO/upwspayl+e6seKke
   g==;
X-CSE-ConnectionGUID: JbggxRb8Q0OFpsvC+MNR/Q==
X-CSE-MsgGUID: Y7DMa/bxQ2OUYHIpfG1q2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80188125"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="80188125"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:21:49 -0700
X-CSE-ConnectionGUID: Un6l6Gj6SVaHE0SAB7t04w==
X-CSE-MsgGUID: 7iU0RjQzSLCnkpibRSMpew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="248410308"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:21:48 -0700
Message-ID: <cb185446-b05f-47f2-a208-38259b9a79a2@linux.intel.com>
Date: Mon, 1 Jun 2026 15:21:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 16/23] perf/x86: Support OPMASK sampling using
 sample_simd_pred_reg_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-17-dapeng1.mi@linux.intel.com>
 <20260529092155.266641F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529092155.266641F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 5:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The UAPI header `arch/x86/include/uapi/asm/perf_regs.h` uses the `__GENMASK` macro without including `<linux/bits.h>`.
> --
>
> commit 105b880ba965bb46db4e0202af5a989492cd6220
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields
>
> This commit adds support for sampling OPMASK registers via the
> sample_simd_pred_reg_* fields. It updates x86_pmu_hw_config to check for
> OPMASK capabilities and modifies perf_simd_reg_value and
> perf_simd_reg_validate to handle the new registers.
>
>> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
>> index 3aacdd4e2764c..24c981ba8bae2 100644
>> --- a/arch/x86/include/uapi/asm/perf_regs.h
>> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> [ ... ]
>> @@ -60,14 +60,19 @@ enum {
>>  	PERF_X86_SIMD_YMM_REGS      = 16,
>>  	PERF_X86_SIMD_ZMM_REGS      = 32,
>>  	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
>> +
>> +	PERF_X86_SIMD_OPMASK_REGS   = 8,
>> +	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
>>  };
>>  
>> +#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
> [Severity: Low]
> Does this uapi header need to include <linux/bits.h> for the __GENMASK
> macro?
>
> Without the include, userspace applications directly including
> <asm/perf_regs.h> might fail to compile due to an implicitly defined macro.

Sure. 


>
>>  #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
