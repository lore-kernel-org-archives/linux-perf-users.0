Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933201DE3D6;
	Thu, 12 Jun 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739659; cv=none; b=qiq+0mWwUABHw9ILpCS7/HvJTJQ74FGQ5i+bLsyTqK7Dlia2iFsXyKDlQ2Ivq/EGCotvlASNYRSVwYhsqxxQX4Cv8eXIeKZXqH19TlOMhs4sfrno/zVV54Zd0ELNRzhanJiI+1OIAuQjBk/Hi2nIjP8nVC04ftK4nDOrfa6IjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739659; c=relaxed/simple;
	bh=K00w4iAVwrrz3Wu6qmWYXbbK2GlLs+RnMh9jR/luQYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMIlJUFGUm9axmOFQ4548oCIoKxwkOS0qHdovH1uiL42NOZntOiDsnzatxrqsQ5GTqwsYUEWYhnNVcbhCmPFEPlR3yb2VtWLUdOU1vjtgsc/ETXgycJIE+Gzn59ofN7tMenv7GvTLbqiNa2UoY4lBlqXgHjVNpT93oeyJPna5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAByfsMY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAByfsMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749739658; x=1781275658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K00w4iAVwrrz3Wu6qmWYXbbK2GlLs+RnMh9jR/luQYQ=;
  b=eAByfsMYlolttV8N1ssW6LVdMKnY5fRoBV2w91deqsFSdMhjO4/d1PVd
   iNodmfqILjC6SPFCsnrT1Z9NQ1apROkZE3T87lft80TICTpDCplMAMa8m
   bYbXTB4qepJYve2spBeiI2Pm9HC/wfjY3K7lunvQXL+aZ78amNpGeuaPE
   s1BsriZeN5clMm0Wj0aJsBagb1SmwPfiT/znf1tmzmkXp6ZzsApX4DWbL
   cnrN2rPS/w7t8EGuk0iHNhnCg7thI9XlSJMoVvkgAWBXekYKRxMXEJD3k
   LP/GcduFZ4q0luyZH9L22nO/38KeqdQ45D7Nxa6nerVK75HcbMknRTzjL
   Q==;
X-CSE-ConnectionGUID: 1QzoxGrUTx69fIJN0NQyZw==
X-CSE-MsgGUID: uM7Py4lhQxCQ4/OyFGY4NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51638534"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51638534"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 07:47:35 -0700
X-CSE-ConnectionGUID: sXK+fDkXS3q+6wZNYH4O1A==
X-CSE-MsgGUID: X3zZ90cUTRisEScbDIg0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="147389266"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 07:47:35 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0336120B5736;
	Thu, 12 Jun 2025 07:47:31 -0700 (PDT)
Message-ID: <36b65ee5-4bce-4b15-91bc-52604bc8a046@linux.intel.com>
Date: Thu, 12 Jun 2025 10:47:30 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] crashing bug in icl_update_topdown_event
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu>
 <080706b6-ed21-540d-dfae-ae27d130d796@maine.edu>
 <d8c64a21-ed4e-4d37-8d4b-9d3a9857b7fd@linux.intel.com>
 <704f6604-547b-f7ca-ad45-2afd2dd70456@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <704f6604-547b-f7ca-ad45-2afd2dd70456@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-11 3:28 p.m., Vince Weaver wrote:
> On Wed, 11 Jun 2025, Liang, Kan wrote:
> 
>>
>>
>> It seems an regression from the f9bdf1f95339 ("perf/x86/intel: Avoid
>> disable PMU if !cpuc->enabled in sample read").
>> The commit merged the intel_pmu_auto_reload_read() and
>> intel_pmu_read_topdown_event(). It's possible that a PEBS event 0x0400
>> runs on a ATOM CPU. So the PERF_X86_EVENT_AUTO_RELOAD is set for the
>> event. The is_topdown_event() also returns true.
>>
>> Does the below patch help?
>> It checks the PERF_X86_EVENT_TOPDOWN flag as well before invoking the
>> topdown functions.
> 
> With this patch applied my test case no longer crashes.
> 

Thanks for the test. I've posted a fix to LKML.
https://lore.kernel.org/linux-perf-users/20250612143818.2889040-1-kan.liang@linux.intel.com/

It's a little bit different from the one tested. Please check and
provide a 'tested-by' on the new patch if it works.Thanks,Kan
