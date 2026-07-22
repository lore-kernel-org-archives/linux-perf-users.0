Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819D344DA8
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688134; cv=none; b=ZpzI+L99bxuRNvFtyMnusZLUepcYZR1UfhhF1fsutgAyHoVlGPi654CejYLa5XjcQhB44yN48y/44tURdKwSA9XfWN38yk5g8TeBoXmyPBZALkYKV+/DXTwc8ugCHbiflRJ2ID3iRWZnVJLQmksxTQjnFtHzwEgTrYp5zxPQU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688134; c=relaxed/simple;
	bh=czS38IQbLPgSDR0vWuIhq2/Ok69ntlm/lchUQ24h1qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZd7JBxTmW0yylBygEljpBK6/l765CcycsIM6TLG7EaVImtuBcj/Iqz6GG+tqBmBCGLg7dX3+rjoXCKPzcEcBMi0YWwvql9tM5EnOAzZZF1Li1/RvMpe92npvBuZ1UJ81TCQgg55THdD7rPC1hw2ZVQQY6ZbpOCdkqgvjhZYJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SELQz5kW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SELQz5kW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784688134; x=1816224134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=czS38IQbLPgSDR0vWuIhq2/Ok69ntlm/lchUQ24h1qI=;
  b=SELQz5kWm7vWQUECgJYPicKB9Ev3MwZNDVqRZNvFUcbc35iqIXYufdzu
   c8xZH1N8OD6eLUMKqHb5HZEe9EW6PiYtK9GnObEw+ewOrY6pVuoEkeXOF
   PntxI9fq42WrrHJZUtMVgVuZPgGiYSOCaBapo8LIGghQ0i+xHN4+a/GjR
   Bpwyrp19z1+nryw3SL9rJvxcIVHBSPQnk6bpp16FNocK8zOSTNR3kOgg8
   +2Dsh1zwM4+AgZPcVErKkM6xS9B/Tj7Kxp/X2tUEvOylysIqcFoKkqVAi
   lcgWo34lU1+BTAsrROt29FoE3f2KJjgNyPVqKHTxCkiz2WhNs98zljyTw
   Q==;
X-CSE-ConnectionGUID: LrUvjpYSQpm1a00jdgFqBg==
X-CSE-MsgGUID: J3pXAgBaTK2KgttHy+9WVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96827326"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96827326"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:42:14 -0700
X-CSE-ConnectionGUID: p7gzmtt5T56VE8VkwuoSzw==
X-CSE-MsgGUID: 74fphYoLTKOLbEyLanredg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261510957"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:42:13 -0700
Message-ID: <ac737fff-998e-4bcf-aa52-b37b6699ea32@linux.intel.com>
Date: Wed, 22 Jul 2026 10:42:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 09/10] perf tests: Add x86 eGPRs/SSP registers
 sampling test
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-10-dapeng1.mi@linux.intel.com>
 <20260721074257.9E1D21F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260721074257.9E1D21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/21/2026 3:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added validation function `validate_gp_reg_sampling` executes a single-shot pipeline for `perf record`, bypassing the established `perf_record_with_retry` wrapper. This makes the test susceptible to intermittent failures (flakiness) in CI environments and prevents it from utilizing the fast-path optimization.
> --
>
> --- Patch [9]: [Patch v10 09/10] perf tests: Add x86 eGPRs/SSP registers sampling test ---
> commit a4a8e0ee768722ad01317e4cd04c08a71c39eecf
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf tests: Add x86 eGPRs/SSP registers sampling test
>
> Validate that eGPRs (extended general purpose registers) and SSP
> (shadow stack pointer) registers can be sampled correctly on x86
> platforms with hardware support.
>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 625240809fce3..3c17f68ceb929 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
> [ ... ]
>
>> +validate_gp_reg_sampling() {
>> +  local regs_opt="$1"
>> +  local regs_value="$2"
>> +  local script_field="$3"
>> +  local sample_output
>> +  shift 3
>> +
>> +  if ! sample_output=$(perf record -o - "${regs_opt}=${regs_value}" \
>> +    -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /dev/null \
>> +    | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)
> [Severity: Medium]
> Will this single-shot pipeline cause intermittent failures in CI environments
> under heavy load?
>
> Other tests in this file appear to use the perf_record_with_retry wrapper 
> to mitigate flakiness. That wrapper provides a fast-path optimization and
> scales up the recording duration if the system load prevents sufficient
> hardware events from being generated immediately.
>
> Since validate_gp_reg_sampling() executes perf record directly without a retry
> loop, could it fail spuriously if the workload doesn't generate enough events
> in the initial window?

Ok. It seems perf_record_with_retry() was just added into the tree about 4
weeks ago. It didn't exist when developing this patch. 

Anyway, would use perf_record_with_retry() to replace current raw "perf
record" command. 

Thanks.


>
>> +  then
>> +    return 1
>> +  fi
