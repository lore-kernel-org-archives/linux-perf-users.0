Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF653B47EE
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477344; cv=none; b=LcVQcbo683AAqbPGoezy9CktuFSea/QS8hasTRuAPgpkzl3TBAmXulsj4Q3XYvHGB6FEWnC3ivbikrQ57DaR2ldlpqKOBPJCFjZKn+hiQeLP8EfiR6g8Wvfb+dQbjUCNScN4NOHfwX+St3mBbRrfoydsKPlMJGzfiRXOP3Mswj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477344; c=relaxed/simple;
	bh=JzNmHyykV6TjBvTix2mItOeIg0tDxGKMSfE4lfXS6AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvKDhHEK7PGamyYfMn39tNnRJpbTo+cnQL4MSobE/ePccuZYRvTlARRvzNpXxwEcJIORhbsruiOVrTNRU1EeQhs4ML37gjnB9QOMI9hgemVOsPVjb4JKyr7kPYpiLNv2+63xEie1zX5/ZioQD+XVEEfNLhbNORvXeKTRiE3rMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF9+af+I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF9+af+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783477343; x=1815013343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JzNmHyykV6TjBvTix2mItOeIg0tDxGKMSfE4lfXS6AU=;
  b=LF9+af+IhZ35uiI2Cyub/3r34ZpskjVNLR0iHQ1nDhze9LM3Xoz1umBn
   HzxYt+O7N4Kfz2nEHPyLnCk9pcodZhjA5bSoA8J8010/WWauJ1su20aAf
   IfJIyytp9f4rFTz0KU4zBllpnleQURI8iOfF693hpeW9jkHYFl4sj8j98
   Zl0Jb7s9T7yhYAijNA+8bHNyw1xqBEShYJw6OAyTJwUOU/QPlNLIvOo/Z
   KWga2v7hPkRGfjl6HS5zK2ejfvICV/bGP18RgpZjHcYMZZCv3OHMQlBHD
   cN1yM8hBo+XzZLayRfFMLmTvywF7sqnyxC5smXblpQ7q4ZBD7gtMgIPz5
   Q==;
X-CSE-ConnectionGUID: bMpP6sO4QUyG0PdXlCKotg==
X-CSE-MsgGUID: 7s0CrMwGRguzc0YkdWhoAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101683064"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101683064"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:22:22 -0700
X-CSE-ConnectionGUID: imAF2AGWRFWB8FO8xutOYw==
X-CSE-MsgGUID: 3i72aESJT/KWqkS1E2BNWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258036585"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:22:21 -0700
Message-ID: <da90e694-8592-446c-851f-48babaa9ba85@linux.intel.com>
Date: Wed, 8 Jul 2026 10:21:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 07/10] perf regs: Enable dumping of SIMD registers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-8-dapeng1.mi@linux.intel.com>
 <20260706025559.8384B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706025559.8384B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:55 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] SIMD register decoding logic dynamically probes the host kernel, breaking cross-platform and offline analysis of perf.data files.
> --
>
> commit 2e9a4421bef9edf42fbc7bb3efd49ba82ff3a75d
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Enable dumping of SIMD registers
>
> Support dumping of SIMD registers with the new PERF_SAMPLE_REGS_ABI_SIMD
> ABI.
>
> Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
> platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.
>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 23f694c3f0c98..5768682dc95fc 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
> [ ... ]
>> @@ -719,23 +719,96 @@ static int perf_session__check_output_opt(struct perf_session *session)
> [ ... ]
>> +	for (reg_c = 0; reg_c < 64; reg_c++) {
>> +		if (!regs->nr_vectors)
>> +			break;
>> +		if (intr) {
>> +			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
>> +							       &qwords, /*pred=*/false);
>> +		} else {
>> +			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
>> +							       &qwords, /*pred=*/false);
>> +		}
> [Severity: Medium]
> Could this break offline and cross-platform analysis of perf.data files?
>
> The perf_intr_simd_reg_class_bitmap_qwords() function dynamically probes the
> host kernel via sys_perf_event_open() to determine the SIMD register lengths.
>
> If a user analyzes a perf.data file on a different machine lacking support for
> that specific SIMD ABI (such as a non-x86 architecture or an older kernel),
> would the probe fail and return a length of 0, causing the register names to
> be printed as "unknown"?
>
> This same pattern appears in tools/perf/util/scripting-engines/trace-event-python.c
> and tools/perf/util/session.c.

It's expected. Currently SIMD register sampling doesn't support cross-arch
parsing.


>
