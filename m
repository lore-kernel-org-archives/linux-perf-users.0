Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D11B423B;
	Thu,  2 Jan 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843893; cv=none; b=j6jfXntALgC8YWIWx0k+xkZmpXXRWm3mdOTVrfaXDFMhOyiTEwk8FihgnMxRHb3ZPcnz6mu3f/iaApOFSm8YdLoZAUMyrSa/infmd4uMcmutlXpXpP121N2i88ojLzhEDw3ZAj9PyoyJsGqr6K6MByd31FSLAcgRXyN+4sCPwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843893; c=relaxed/simple;
	bh=03yn+9Xb0rMHxyPsacharfBcsDOmk/HN1Mu38V5bIw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1/hYorPmGwpw6vYnX2aSSsXnoSn6my6dibsI7H6GjNDCLgsDTNpjDVHCiqS4iLq3a804aC2BpwNBEbGjn76EATMh045A25LB1kv2/TZ3e8+xKXXAZsBLolm3cTj+Ab6p+XKMndG+H4sbKwM0e/Wv8MY/2CF7T4Jzw9eBG6xQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRe38jLC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRe38jLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735843891; x=1767379891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=03yn+9Xb0rMHxyPsacharfBcsDOmk/HN1Mu38V5bIw4=;
  b=nRe38jLCYeFSksVAqf280/Mf3+3e97wfbHPEqtTt4qGSZjSOqCPo7Cso
   DPSj2fi+s1+3UHl8pbeP5RAzKejh7eYEFLR8uSdn2ZhsTeIgv74dwNefw
   m3opRpS9XGrtrermeLdxfImARnHyvIsOTpJpw2e3mhnASQYu/vrQqY2LA
   keLMo1fzNx+lXivQt9LfLGAaWG+W0cgUhBIoNDR53wXSPussVTHt8PbzE
   gsu9HhQ/TH1lMw3eMBe4+LLzjCtJfp4sUFM91U2B2Jmgi2TMq8ePl386M
   YpeRqK/8W+4/mwHa5MzOEJ49sJ4VxUL66c9NxSQ+jcHtGv870KjVr5BZO
   w==;
X-CSE-ConnectionGUID: o8B6qEs+S0SakfBJsuWvDQ==
X-CSE-MsgGUID: 3i50JD3uQ0mpyMPYLLIjIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="53638866"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="53638866"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 10:51:29 -0800
X-CSE-ConnectionGUID: h+aVZJIZS4q5tOJUwOUWFg==
X-CSE-MsgGUID: KIscBzueQYCyAHqLDf2PZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="102041203"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 10:51:29 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2037220B5713;
	Thu,  2 Jan 2025 10:51:27 -0800 (PST)
Message-ID: <987bd15e-c392-48c1-ade2-057fb4b45978@linux.intel.com>
Date: Thu, 2 Jan 2025 13:51:25 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add support for pebs fmt6(Lunar Lake)
To: Yiwei Yang <yangyiwei2000@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
 tglx@linutronix.de, adrian.hunter@intel.com, irogers@google.com,
 jolsa@kernel.org, alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
 namhyung@kernel.org, acme@kernel.org, mingo@redhat.com,
 peterz@infradead.org, Yiwei Yang <victoryang00@ucsc.edu>
References: <20241226085605.43208-1-victoryang00@ucsc.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241226085605.43208-1-victoryang00@ucsc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-26 3:56 a.m., Yiwei Yang wrote:
> Signed-off-by: Yiwei Yang <victoryang00@ucsc.edu>
> 
> Lunar lake's pebs is not kernel ready. in dmesg I found
> 
> victoryang00@victoryang00-ASUS-Zenbook-S-14-UX5406SA-UX5406SA:~$ sudo dmesg|grep PMU
> [sudo] password for victoryang00: 
> [    0.107418] Performance Events: XSAVE Architectural LBR, no PEBS fmt6+,  AnyThread deprecated, Lunarlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.107418] core: cpu_core PMU driver: 
> [    0.107418] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.007380] core: cpu_atom PMU driver: 
> [    2.802582] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> [    2.802585] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    2.802586] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    2.802587] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    2.802587] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> 
> But lunar lake has the pebs extension in lscpu
> 
>     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m
>                           ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s
>                           s ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc 
>                           art arch_perfmon pebs bts rep_good nopl xtopology nons
>                           top_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq 
>                           dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma c
>                           x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt t
>                           sc_deadline_timer aes xsave avx f16c rdrand lahf_lm ab
>                           m 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp i
>                           brs_enhanced tpr_shadow flexpriority ept vpid ept_ad f
>                           sgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rd
>                           t_a rdseed adx smap clflushopt clwb intel_pt sha_ni xs
>                           aveopt xsavec xgetbv1 xsaves split_lock_detect avx_vnn
>                           i lam wbnoinvd dtherm ida arat pln pts hwp hwp_notify 
>                           hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku o
>                           spke waitpkg gfni vaes vpclmulqdq rdpid bus_lock_detec
>                           t movdiri movdir64b fsrm md_clear serialize pconfig ar
>                           ch_lbr ibt flush_l1d arch_capabilities
> 
> 
> But I found implementation [1] and [2].
> 
> The code in the kernel seems not updated [3].
> 
> [1] https://github.com/search?q=repo%3Atorvalds%2Flinux%20MSR_IA32_PMC_V6_FX0_CTR&type=code 
> [2] https://lwn.net/ml/all/20240625182256.291914-9-kan.liang@linux.intel.com/
> [3] https://elixir.bootlin.com/linux/v6.13-rc3/source/arch/x86/events/intel/ds.c#L2480
> 

Thanks for the report. The fix has been merged into the tip branch.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=b8c3a2502a205321fe66c356f4b70cabd8e1a5fc

Thanks,
Kan

