Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060456A33B;
	Mon, 27 Jan 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991179; cv=none; b=pE1iBHGRIsDbBo3o04zs6pSsGF0oDis7U15VyK/DqAnhE4VyngDMYP4gKKfSyP4XnxYD/bDzbhUztVaa/HZ+OTqnYHn82qsO/8EI5o5A3jbFs8+WEMC2RbcOHyEHsIK3i9E8VbSoh9XpFd/SDI4DdVyaLUTege8clzag6FkJWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991179; c=relaxed/simple;
	bh=pe8qfvMSe1ksQIj9r0Cig/DweSV8yfGBxeZqEyb2PI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDKXr+en2DfPslPcl5Z+KxEgUo1nJcl1desv+gaXhGi5gG3NM/T95KpJrvEdArf2Wt5FUJ95W5zgVNUHGYnBpx1IKTzsUPJ7jHinB7xp1Q9lCOVBr6SW6Ag8B5wmgtiB3XsLqUHwMm5gEEhjeKgPNv5G40fFRhA6b9KrJlLYmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdehforX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdehforX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737991178; x=1769527178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pe8qfvMSe1ksQIj9r0Cig/DweSV8yfGBxeZqEyb2PI4=;
  b=HdehforXoohapOLN7eU+oVPeDAe2KTnv1gly2eLv0W87mvKmwVdhYlcR
   s6kBGCK53axkVGyuxfbtTArhhXSySPnlGhCqf5wwXo1jcLWIe9gSwcQcS
   6RT17RGytQHLEqL0QYmpOIypvtfjcof4F+EUorF8MVnAw9oLUwGgfqsI/
   F4ZLWECoVBwbViFoUXg9XjJggBHL4QhcUP90WQvDxC/bgKO/VktOfThTP
   IkzHSJ3szmirzknsreIx+cq2AqIBjfrPunipzfy/wibJEb1bmYhXgKF/K
   /bWHx7tXGH3Y2lmEnBkKc1FZGto1cfGiqL66Qo77/wGYN/CckkznVi1eP
   w==;
X-CSE-ConnectionGUID: 7jkMulmATEihW5kRqpfOQA==
X-CSE-MsgGUID: aU3KOEG/RzeWBw6T9QIfVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38557487"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38557487"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:19:37 -0800
X-CSE-ConnectionGUID: YZX0nUpkQZ+Gpe5G+KTXag==
X-CSE-MsgGUID: VTemDsjcR6SbEFk9mhrtGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108278977"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:19:37 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D22DE20B5713;
	Mon, 27 Jan 2025 07:19:35 -0800 (PST)
Message-ID: <85588439-ec0e-4824-8193-f0737880ecb9@linux.intel.com>
Date: Mon, 27 Jan 2025 10:19:34 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] perf/x86/intel: Parse CPUID archPerfmonExt leaves
 for non-hybrid CPUs
To: Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-4-dapeng1.mi@linux.intel.com>
 <Z5KRT-F7MbTs6g6y@tassilo>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z5KRT-F7MbTs6g6y@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-23 1:58 p.m., Andi Kleen wrote:
>> +	/*
>> +	 * The archPerfmonExt (0x23) includes an enhanced enumeration of
>> +	 * PMU architectural features with a per-core view. For non-hybrid,
>> +	 * each core has the same PMU capabilities. It's good enough to
>> +	 * update the x86_pmu from the booting CPU. For hybrid, the x86_pmu
>> +	 * is used to keep the common capabilities. Still keep the values
>> +	 * from the leaf 0xa. The core specific update will be done later
>> +	 * when a new type is online.
>> +	 */
>> +	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
>> +		update_pmu_cap(NULL);
> 
> It seems ugly to have these different code paths. Couldn't non hybrid
> use x86_pmu in the same way? I assume it would be a larger patch.

The current non-hybrid is initialized in the intel_pmu_init(). But some
of the initialization code for the hybrid is in the
intel_pmu_cpu_starting(). Yes, it's better to move it together. It
should be a larger patch. Since it's impacted other features, a separate
patch set should be required.

Thanks,
Kan

