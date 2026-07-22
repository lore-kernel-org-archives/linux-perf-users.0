Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B935CB6A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688197; cv=none; b=OJPEoWzjplg+UQnO5j/eVoRKI01w4RgRruWnCEXGgiM0zFFUVsITyBugC8wYKETIz64V8PEiuXRMjAADc8zB1mKW3lkPwu/6pXzF0vb7qLxdXkUBdGeOy9GZpIBaPK/dJK+9N02l9LDr9RzzkmNd8GPBTYmZyADF9ViTeTNxPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688197; c=relaxed/simple;
	bh=nPEjdMgt1ss0NLIbHISPW7ns8fg7wg0pPyILfxGGc4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4c6YQN4zyBORonzKnlD8kpY7fR6hLno3zykn16CW5m+2lV3oRcPx+9TnboY3N1eU5TfUtXm9D3hJmmdF3nR2GEVuVVNNmpreM8ZRwP0G6hqmmfTD5Cqi1vZJOCSjOjlPL3btOkCy0VBKuxROcylUMrfq0uSc0P93Jq6V9lJb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeriIXuf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeriIXuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784688196; x=1816224196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nPEjdMgt1ss0NLIbHISPW7ns8fg7wg0pPyILfxGGc4s=;
  b=TeriIXufO8EuonNJSF8NS1RDlcC6VHLTL4gLIuJlI5kZzhDcZrTlVku6
   XpMwLuUGXxz3Th3/mxlWabF7eL4CUxSqjWJIEv9VKtZPOdQ1jcr49b+Kc
   qOpdBpUM8WGYPM3zRqY2tkh/aeC1Aip9bSOOVTA7/hKfo/U771BmSnPBL
   pHu4mtp7gOKYia0t5he5VM3Nthm1LdlT/oO2DuaQFpqUUYjAF0IFzGW3H
   6E+Mov7caAuAPU6SJsPAhfJ/8BPmLVdccwkIMZKGq+BITGrzkK1HitO6q
   f72BM+5JvkD08t8MovPnY+KNnZ718wrU7nmnQdGkWhrKyJC8U9eYtuoh/
   w==;
X-CSE-ConnectionGUID: S/h4S5iqST2KqAuhOGx7kQ==
X-CSE-MsgGUID: ftIySIMRSxWVTHIN8sTc8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96827352"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96827352"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:43:16 -0700
X-CSE-ConnectionGUID: lvjOFKW4TFSxxJ/FmD857A==
X-CSE-MsgGUID: 1shIvTi2ShCkPxEUq48vhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261511001"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:43:15 -0700
Message-ID: <75344ddb-d173-4b01-a489-3c72251776df@linux.intel.com>
Date: Wed, 22 Jul 2026 10:43:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 10/10] perf tests: Add SIMD registers sampling test
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-11-dapeng1.mi@linux.intel.com>
 <20260721074809.E5E151F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260721074809.E5E151F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/21/2026 3:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test validation logic for SIMD register sampling uses a loose grep pattern that can falsely report success if a sampled symbol contains the register class name.
> --
>
> --- Patch [10]: [Patch v10 10/10] perf tests: Add SIMD registers sampling test ---
> commit 1c34ec145d62a684219e4898c8fe2a820402bef2
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf tests: Add SIMD registers sampling test
>
> Validate that SIMD registers (XMM/YMM/ZMM on x86) can be sampled
> correctly with hardware support.
>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 3c17f68ceb929..4a8539a65fa86 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
> [ ... ]
>
>> @@ -252,6 +252,136 @@ test_egpr_register_capture() {
> [ ... ]
>
>> +validate_simd_sampling_mode() {
>> +  local regs_opt="$1"
>> +  local simd_classes="$2"
>> +  local script_field="$3"
>> +  local simd_class
>> +  local sample_output
>> +
>> +  for simd_class in ${simd_classes}
>> +  do
>> +    if ! sample_output=$(perf record -o - "${regs_opt}=${simd_class}" \
>> +      -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /dev/null \
>> +      | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)
>> +    then
>> +      echo "SIMD register capture test [Failed record ${regs_opt}=${simd_class}]"
>> +      return 1
>> +    fi
>> +
>> +    if ! has_required_regs "${sample_output}" "${simd_class}"
> [Severity: Medium]
> Will this search pattern mistakenly match symbol names instead of the actual
> register dump?
>
> When perf script outputs symbol names alongside the registers, passing the
> raw class name without delimiters to has_required_regs might falsely match
> C library routines like __memcmp_sse4_1_xmm or __memcpy_avx_unaligned_erms_ymm.
>
> Could this check be made more strict, perhaps by including delimiters to
> ensure it only matches the register dump data and not the sampled symbol
> names?

Sure. Thanks.


>
>> +    then
>> +      echo "SIMD register capture test [Failed missing ${simd_class} sampling data]"
>> +      return 1
>> +    fi
>> +  done
>> +
>> +  return 0
>> +}
