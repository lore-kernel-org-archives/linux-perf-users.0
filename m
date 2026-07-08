Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830630D406
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477814; cv=none; b=QulBLvnCBopj9yD7Y2tY8UNAiR9MTQHpoaHVwuMQR8iW++dWoqL+zsQHk9YSVeRgwmHgZaM1ozp2wrQpoaBZmOPKk1aICUpSedU2IGAYQHlBlj67/oMB2OGLZbcnKP0p2Z0DruEm9td7ILqIZpVElQMyHP3ssAEHiv9Q5gGz2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477814; c=relaxed/simple;
	bh=7Qw+uUL36LO2eE4xRdqMv9qoCyI6GLJ/5veOFprZnfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUr9kpHbe2+w9q/2p7Evsy3zarqhPyhtFsGeDC1FMTGUfVcjvpsJwMhpSBBu8FDVsZG3VEvytmPgyEJOaeH76CLzRuoCcFpt3KUSiYGhFox8QYrCvvMDZE4xLosH7WB+SnrZyJs4Ra8FPoLQ6LEzDbicFCl/p2UpVpEcfEGUt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuOdqLjf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuOdqLjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783477812; x=1815013812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Qw+uUL36LO2eE4xRdqMv9qoCyI6GLJ/5veOFprZnfQ=;
  b=RuOdqLjfNsTStHejlOFwn+Uj+FxR8nD1GcMxK1fXY/Gm1JKrBCzxX/vz
   7yfsCNhCj+jiKfkkxnj9OOm0ek5pLIBShyTcJa4jfye8J9FYaLwZhvmoF
   wp4dJviQRltniZnYK0u3/Qlbcfo1ptVu8AVrToTX8sf/ztf0HuZWGFPHU
   LCFrhNwFWZKkOCR9FnC+gh8ybKwSxPw2nm2vv+fCVJuL2Py3tGa4NBg0J
   MPl91WVNO4cjDMIiwv+eMRYaElkWM9QqG9mPzeA85jVelEmhmMDqJSvUy
   Qx6FBp1jX2q3asU80mbKQfX/7snCCulv/VF6x9OyuTVVaoLcl+cOCCs6D
   Q==;
X-CSE-ConnectionGUID: 1nW8CTkuQSuX6cr8FkkTYA==
X-CSE-MsgGUID: oU5cmd34Q8+P5Ln9nGmQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94739919"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94739919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:30:11 -0700
X-CSE-ConnectionGUID: 392Nq0gvSFiBbL5/LfW+Rw==
X-CSE-MsgGUID: WO0VtwR+QimpldWV6nsJgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="259066655"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:30:10 -0700
Message-ID: <a9ad6d88-f693-48f2-84b5-8c76eabd0a75@linux.intel.com>
Date: Wed, 8 Jul 2026 10:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 09/10] perf tests: Add x86 eGPRs/SSP registers sampling
 test
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-10-dapeng1.mi@linux.intel.com>
 <20260706030025.4A6731F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706030025.4A6731F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 11:00 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The validation function `validate_gp_reg_sampling` executes a single hardcoded `perf record` pipeline instead of using the standard `perf_record_with_retry` helper, leading to test flakiness and untraceable failures.
> --
>
> commit 5bc6b87aa83194eef4aff3394561f1bdb19039e4
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf tests: Add x86 eGPRs/SSP registers sampling test
>
> Validate that eGPRs (extended general purpose registers) and SSP
> (shadow stack pointer) registers can be sampled correctly on x86
> platforms with hardware support.
>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index dd90fef2088b1..48c722e563e27 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
> [ ... ]
>
>> @@ -131,6 +131,131 @@ check_system_wide() {
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
> Could this hardcoded perf record pipeline lead to test flakiness on slower
> environments?
>
> By not using the standard perf_record_with_retry helper, a single execution
> might fail to generate the 1000 near calls required to trigger a hardware
> sample.
>
> Additionally, does suppressing stderr with 2> /dev/null permanently hide
> error details from the CI pipelines by bypassing the PERF_RECORD_LOGS
> collection mechanism?

This comment seems a false positive. There is no perf_record_with_retry
helper in kernel code base.


>
>> +  then
>> +    return 1
>> +  fi
>> +
>> +  if ! has_required_regs "${sample_output}" "$@"
>> +  then
>> +    return 1
>> +  fi
>> +
>> +  return 0
>> +}
