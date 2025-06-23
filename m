Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D951DFE8;
	Mon, 23 Jun 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642796; cv=none; b=qTOQRZwhuzZMlXoNtGWujYunJKk6MkkQr9Dn9XjC7X3E6Xrv8DUJFZPOMUFldNxNHn1lrfeS+Z1/OzGGTlt1i2471UOo7C3Zp7eeQiDR1nNw09UL3zu1+F7IuoRg1Jgh50TDTtAO3u5/fXgYPXrjgV6PnuAAey83NGHHWugiNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642796; c=relaxed/simple;
	bh=L1zu2i1ykeGi0dKO5wFiVz1FRaPj1r2GW37Ie+APNec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD/obZVndRDmj2hAaO9jGXY+Zt6YyU4+SZy57KvMzvLh6u/zYgIPOum8Ej9kcqMiSjn02uq78n2gOw6pFnn/2CR+r4FQo0OlRtKELl96+Dh4doCB0N8Y8rM+aBI1IlAQuS2+0/BAtWMgSQ5pBWhEb2RW2LpBq2v9kAgWll6akHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZs1YFmx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZs1YFmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750642795; x=1782178795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L1zu2i1ykeGi0dKO5wFiVz1FRaPj1r2GW37Ie+APNec=;
  b=MZs1YFmxADtkXLC/z+lgKkssEbjQq56KWALMXiCSRHs3YyNJG7VoRkeF
   qj774umbTOqg8p16etd2bMMpF+36OjXlhhXNIDOdWQlHnUrVAMadILcjH
   yUMxMDsqCfHJTRNKi08NJwtRoDXzAeUfbgG6gnxHb3X0QxWA7mcOTUuLs
   ClsGlNTDCsxdkGYih0g9cWvx+oRzkcKgTsmWyb5jwWQqVI2jaP5bEEGeV
   J5y6t2jrBl+2YSGXDSu6V/AmfxxTyh/t2v8grGRpndvRoDxeC/3F6dJ5v
   652H0wXE56CxiTtywITWLqPXGhKYISKvEWJZC4epSmddjLpqoM78SlvKT
   g==;
X-CSE-ConnectionGUID: PDClsr34Riyrlh7tbsAf3w==
X-CSE-MsgGUID: WgEjrJlnTAW01N3wBwglPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52804008"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52804008"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:39:54 -0700
X-CSE-ConnectionGUID: h3ZGfGXEQQaOVNHZuJ6n7w==
X-CSE-MsgGUID: wX1dvPsmTyuZLgCGy21DuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182325716"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:39:51 -0700
Message-ID: <0bc7542e-e7e2-4ee1-ad90-45fdac2b613a@linux.intel.com>
Date: Mon, 23 Jun 2025 09:39:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
 <20250621093638.GW1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250621093638.GW1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/21/2025 5:36 PM, Peter Zijlstra wrote:
> On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:
>> +static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
>> +{
>> +	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
>> +
>> +	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
>> +	if (caps & ARCH_PEBS_LBR)
>> +		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
>> +
>> +	if (!(caps & ARCH_PEBS_AUX))
>> +		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
>> +	if (!(caps & ARCH_PEBS_GPR))
>> +		x86_pmu.large_pebs_flags &=
>> +			~(PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
> Coding style wants { } on this, because multi-line.

Sure. Thanks.


>
>> +}
