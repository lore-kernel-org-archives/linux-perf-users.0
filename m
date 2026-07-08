Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BD420896
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476959; cv=none; b=jDA9Y/avPd4arQFBjb7aGXXwzC0yhq3ufAwYjJukNxM9jRKX+aznomk3KYbhsEyugcUUT8t15zTPFVcVq3tW35SO5sKHTls6MIHRiMb/wGTctxp/PC8kN8Wp+WKRC7OcwVupk8Ys3MPdtmQe3r0v0T0e+wzhKza3FZcVfXwNC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476959; c=relaxed/simple;
	bh=8EymMBj3ZdGKC7L1yME6CiK/4LTyp/T+bgN9iz/7i1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPidkvww5R2jcwHzMDGGvv2Hz5gn1bWVig15ZvDpQsascTPLvoGTUUANQln3VXz441u8fqqc+F7NLwwpP5BDE9e7k+5+l0/8uO9yjkoLkJ0ZlXAs0/sOo+zwzfYkklCkdKQaROGwuBZW/9Uk9uArYPuJv8mRtyFR7QRaAg44h5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyasEgmc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyasEgmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476958; x=1815012958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8EymMBj3ZdGKC7L1yME6CiK/4LTyp/T+bgN9iz/7i1A=;
  b=IyasEgmcPiFQRLs7kV/5L1l5b/H9zZsTPUOFiGoJTcFzJnc7d2n3kb24
   2RkRHxY5wtEHiGHerHX2zqEbUEGXtuakLDNvg9ktGcY1w+d+wAYb6pJr+
   gKVgj++A90/H9Uk28zOiNt8iNWcfE24CHadKJH8lvZ+C+/a+v25xH4CyI
   nI7e4BFItLpXjA9Q5WyOXP+Oopi3KCiAxu5OU/R/krRmiUkWYIblXQbDB
   PgHX+dP8O7wYdkXtopafz1xLeZHf25tdxk8HvzIlb55jE/j7NectCUIDV
   a43BzxZaTq3wsT1VIQ4mRdb25XsIekuMt60WsJ9D9KOCLpy/yiagJVzLC
   g==;
X-CSE-ConnectionGUID: fjq/rAOTQh6ubpFA1Ckvaw==
X-CSE-MsgGUID: TrXSsHEuTvK0DQT4Y8izzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="88047257"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="88047257"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:15:58 -0700
X-CSE-ConnectionGUID: vd2fsttNSjWs6dEYc6Mudg==
X-CSE-MsgGUID: +Do9yousSkiruuuLFj66+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253062587"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:15:54 -0700
Message-ID: <025b109b-3ea3-464a-92d6-94c65331605a@linux.intel.com>
Date: Wed, 8 Jul 2026 10:15:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 05/10] perf regs: Support x86 eGPRs/SSP sampling
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-6-dapeng1.mi@linux.intel.com>
 <20260706025926.3AA051F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706025926.3AA051F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Reclaiming XMM register space breaks explicit XMM register selection on SIMD-capable hosts.
> --
>
> commit 4a688e42468a5e89b85174c21cc87866b350369c
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Support x86 eGPRs/SSP sampling
>
> This commit adds support for sampling x86 extended GP registers (R16-R31)
> and the shadow stack pointer (SSP) by reclaiming the original XMM register
> space. A new abi argument is introduced to distinguish the register layout,
> defaulting to the new SIMD layout on supported platforms.
>
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
> [ ... ]
>> @@ -87,14 +100,16 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>  			*p = '\0';
>>  
>>  		if (!strcmp(s, "?")) {
>> -			list_perf_regs(stderr, mask);
>> +			list_perf_regs(stderr, mask, abi);
>>  			goto error;
>>  		}
>>  
>> -		reg_mask = name_to_perf_reg_mask(s, mask);
>> -		if (reg_mask == 0) {
>> -			ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
>> -				s, intr ? "-I" : "--user-regs=");
>> +		reg_mask = name_to_perf_reg_mask(s, mask, abi);
>> +		if (reg_mask) {
>> +			if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +				opts->sample_simd_regs_enabled = 1;
>> +		} else {
>> +			ui__warning(warn, s, intr ? "-I" : "--user-regs=");
> [Severity: Medium]
> Will this change break explicit XMM register selection on SIMD-capable hosts?
>
> Because PERF_SAMPLE_REGS_ABI_SIMD is set by default on platforms with SIMD
> support, the reclaimed register space means name_to_perf_reg_mask will now map
> to eGPRs instead of XMM registers. 
>
> If a user runs an existing script that explicitly requests individual XMM
> registers, such as perf record -I xmm0, won't this branch fail to match the
> string, return an Unknown register warning, and break backward compatibility
> for those CLI options?
The User should run "perf record -I?" or "perf record --user-regs=?" to get
the supported registers before running "perf record -I xmm0".


