Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DAD3563EB
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999505; cv=none; b=YJTZo3HZafS42CY5keQ89G+0rXfMvrg5Sky9jWDFb/Tqp9X8dsRnexbwi14mm3EFEc08uJ8jpRX6jgfWPUYo/u8clFuZkqRAhgRdOkMCgdIjjwY5BZdp7+t/rzjyh8XQ4Aa0zYD+MjfF8liRzEqdaYDql4UiuJgOR0KasNY7Ncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999505; c=relaxed/simple;
	bh=BkhIivdHeU4QY0h86fTfJnU/MLRtmhPNTqfkaqcTDh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMHPcZ/YStKEk42bWhYFUnFfmqHA7X2dtGwLOhBjrqJo1odoLDDM//BiuiSUVEc00Z06BnhPoVMVM/h7H8aigmljc/llg5f4JSS1UTnw3llMiPeyDfcmVjr0snbqTlV0VlLgxH+z4VSKokJrXSWXnFVcxtayBvNHhkX5e9Eai6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jar51Sr3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jar51Sr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780999504; x=1812535504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BkhIivdHeU4QY0h86fTfJnU/MLRtmhPNTqfkaqcTDh4=;
  b=Jar51Sr3jFsRRK5Nw32FsVU8gg+0Wop96kAkbQoZNDd0xtsVFCbGcdO0
   e4XnQchGIyKxbpolILnE8BuD00sKr89Z5/YUm//mBw4cljJVQ30pHTJyx
   7JfQjUv50VXN1+L0q668cbep9dHVhBq6lgDASYZ28HYM8kiznhyvbkss2
   7n9eDGgAaucfvLIqQZ/lcstkOeo27Tz2Bh+Vs89CL3ZqZTjEAYvMZieaN
   Iq38vMqnqyuvbnOZuED2FOJFBbIvshglRroU1aVNNvJwLp9BbHqWjW0Nx
   CBh0dLObYL1f+5oldcYFW2nlffH6Gugofg4myItZBcm70Fzf9AJhmblcO
   g==;
X-CSE-ConnectionGUID: dNm5A4foSdyZzA/XQ73/5g==
X-CSE-MsgGUID: iQHXdVXrRea4fcdzT0XDuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81732850"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81732850"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 03:05:03 -0700
X-CSE-ConnectionGUID: /pxEQJLbRge9OW/nPdNoEg==
X-CSE-MsgGUID: voQOouT5R/iSneKBCKTbOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245664382"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 03:05:02 -0700
Message-ID: <22c9ceea-5bd3-4e50-8ee4-d7c668c52ec2@linux.intel.com>
Date: Tue, 9 Jun 2026 18:04:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 4/9] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>
 <20260609052405.4A50C1F00898@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609052405.4A50C1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/9/2026 1:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] The fallback to software branch decoding causes massive NMI overhead and drops valid LBR entries when user memory is paged out.
>
> Pre-existing issues:
> - [Critical] Page fault in NMI context due to an out-of-bounds direct memory read into unmapped guard pages during LBR software branch type decoding.
> --
>
> commit 11f8cb2dc702b7450f8fbb74de9eaa30a63a9248
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Subject: perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
>
> This commit updates intel_pmu_lbr_filter() to use software branch-type
> decoding when hardware branch-type decoding is unavailable (i.e.
> x86_lbr_type is not enabled). This aims to keep branch classification and
> filtering behavior correct across Arch LBR configurations.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index cae2e02fe6cc4..171fdf1962ade 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1233,6 +1233,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  		 * OTHER_BRANCH branch type still rely on software decoding.
>>  		 */
>>  		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
>> +		    static_branch_likely(&x86_lbr_type) &&
> [Severity: High]
> When x86_lbr_type is not enabled, this falls back to software decoding via
> branch_type(). Because intel_pmu_setup_hw_lbr_filter() unconditionally sets
> X86_BR_TYPE_SAVE for Arch LBR CPUs:
>
> arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
>     ...
>     if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
>         ...
>         reg->reg |= X86_BR_TYPE_SAVE;
>     ...
> }
>
> the early return fast-path in intel_pmu_lbr_filter() is bypassed. Does this
> cause intel_pmu_lbr_filter() to iterate over all LBR entries and perform
> high-overhead instruction decoding in NMI context even for generic branch
> requests?

Generally speaking, the x86_lbr_type should always be true for arch-LBR.
Even it's not true in some corner cases (like guest environment), high
overhead is better than wrong branch decoding.


>
> Additionally, if user memory is paged out, copy_from_user_nmi() will fail,
> causing branch_type() to return X86_BR_NONE. Does this result in valid LBR
> entries being silently dropped?

I doubt if the issue could really be seeb. Even it happens, it seems there
is nothing to do except dropping them.

Thanks.


>
> [Severity: Critical]
> This is a pre-existing issue, but falling back to software decoding exposes
> a vulnerability in get_branch_type() when processing LBR entries in NMI context:
>
> arch/x86/events/utils.c:get_branch_type() {
>     ...
>     if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
>         addr = (void *)from;
>         bytes_read = MAX_INSN_SIZE;
>     ...
>     insn_init(&insn, addr, bytes_read, is64);
>     ret = decode_branch_type(&insn);
>     ...
> }
>
> If the from address (which is controlled by the LBR hardware recording a
> faulting RIP) points to the very last byte of a mapped page, bytes_read is
> set to 15. The instruction decoder will blindly read past the page boundary
> into an unmapped guard page without exception table handlers.
>
> Can this trigger a kernel page fault (#PF) and Oops in NMI context when
> processing the PMU interrupt?
>
>>  		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>>  			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>>  			type = arch_lbr_br_type_map[type] | to_plm;
