Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02335028C;
	Wed, 26 Feb 2025 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552969; cv=none; b=UVcS/qwY1Og0cyb3IiVaH2R0m8cygSkBXK6ux7uoXhGI2r4I0pw5b5ffoXaa9q69Fn+Jutl/Ykyh46j41xeagVksb6SrNPvY8erSxp+OVcjt71a/9tFUMSzgkvQXLWnZRk0xICwchrmgsPu2m/R0j406pP/LEbHmGFlAPBFD8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552969; c=relaxed/simple;
	bh=q4ZyS3nL2pCIXXvsUTTmZGs+Mzd+5hRRC6xwUNA1o98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFIfEvvL5rBpyvuTfKVRHOURM7i4qVth6FZxZst3O7YqK/B+Mwo88DKq8BQLUgOK2tMENH03PY/rkjO36AC+aVxnud6Qs7/POaudI1UcSBmo6Ta4/09TcN9M1BrRkaZeNDL9fCnRVew+P7k4KiGPWwM9cXXzH6hOHCrn+YqQdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlXHZzBk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlXHZzBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740552968; x=1772088968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q4ZyS3nL2pCIXXvsUTTmZGs+Mzd+5hRRC6xwUNA1o98=;
  b=DlXHZzBkAw8U7llBwcKhrxGDrYWdl4M2Co0Pcvz2mDoYeVBdVGX0fSHg
   DG7pSLxPXleL4KQOBNX3+Y1VJQCnbWsoD/0u3FvdvVu3YOW/GxJ2jaFib
   KA7htrs16jxw87xPt3Ha5PtTa97d9G+Ez+T7eIv1okwXFb4wgGq77xBjT
   FenhMOl9MQBi8oNlJPHxiFeNDlc+KNDfHn0lWv6+6A30y+dc4K0nhCeTX
   ptOgKvd3de6ihE9pTfQDqoG3EjK/P/9p7BADGEIyn/RvOR6ekJ8Kvy1iE
   hMTtQMqwtgb9WRchkjzwZrUD/DVvShZTTga7HC4WU08mIwTN6nJXpnj1v
   A==;
X-CSE-ConnectionGUID: Oi+nmZdhSweLlk7Yb8RZ1w==
X-CSE-MsgGUID: NAlxO4TSRXKPfdM3p4ya1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45036985"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45036985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:56:08 -0800
X-CSE-ConnectionGUID: BLZlSfEPQImFfbcqS22cTA==
X-CSE-MsgGUID: U6PHjfyKSNWS/Jpn1cL2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121554118"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:56:04 -0800
Message-ID: <5bbed578-db74-408d-a92e-76d869054738@linux.intel.com>
Date: Wed, 26 Feb 2025 14:56:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 15/24] perf/x86/intel: Add SSP register support for
 arch-PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-16-dapeng1.mi@linux.intel.com>
 <20250225115229.GN11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225115229.GN11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/25/2025 7:52 PM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:09PM +0000, Dapeng Mi wrote:
>
>> +	if (unlikely(event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP))) {
>> +		/* Only arch-PEBS supports to capture SSP register. */
>> +		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
>> +			return -EINVAL;
>> +	}
>> @@ -27,9 +27,11 @@ enum perf_event_x86_regs {
>>  	PERF_REG_X86_R13,
>>  	PERF_REG_X86_R14,
>>  	PERF_REG_X86_R15,
>> +	/* Shadow stack pointer (SSP) present on Clearwater Forest and newer models. */
>> +	PERF_REG_X86_SSP,
> The first comment makes more sense. Nobody knows of cares what a
> clearwater forest is, but ARCH-PEBS is something you can check.

Sure. would modify it in next version.


>
> Also, this hard implies that anything exposing ARCH-PEBS exposes
> CET-SS. Does virt complicate this?

Yes, for real HW, I think CET-SS would be always supported as long as
arch-PEBS is supported, but it's not true for virt. So suppose we need to
check CET-SS is supported before reading it.


>
