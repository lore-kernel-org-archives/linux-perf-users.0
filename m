Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5D288D1;
	Tue, 23 Jul 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725802; cv=none; b=lUq9KUV59TaLWMaX4fZxLGyqQMO0pKpSh3UH43tPRMMx0CC2SJLgnmYeYAZMpUjv2fUpjeXDXNvGSTUok1nHrvdUe/KXlxQ8uDRHPn2L2nu9hjmPsxd956L3iHE1m1Ah70Vj4KWeTiX6hexldaaEarhQ5BMFkJMUWXDMu4CSGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725802; c=relaxed/simple;
	bh=GUUm9SKdRyPJTlfF5XVO3Y0D5mrSIAzlwLYe2VuSGmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEC+y4uLgrZEEzmStPqjNlCo8AOPvKzGjXq2InCFqEqbXJrW1WJ8LCReysHQLPRQabdwRwFguTg3lMWb90WF8P0YZiHYFn7xhiQN3szfXPHAOotIgu6aKasj7j5Rg3akWsuA1Mbn2RnHXO5FKFY1hFPRFcFTBwWBOYbb2Z2ISXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2pLG0mD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2pLG0mD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721725800; x=1753261800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GUUm9SKdRyPJTlfF5XVO3Y0D5mrSIAzlwLYe2VuSGmk=;
  b=M2pLG0mDPdszr6wPVoYAcW2iBR49yWjNuY+Vl/kjkTnEzwS+eCQBgowt
   o5cobcdqSNTHFKZBnIE2ey974ISQajS7xaalqBG0pfclvKm6gCNDboFhf
   OxmMgW4GiFpJfokkJNpkdfTWd+fHwtAPwlfUpJMB6IoDb+yJ+oMappJvB
   Yobfg3I1wzgmatPl7b4bfCyFvbSSpAqzeKC/A+QpT6orE8zjRwnzm6rR1
   eMeaH/ZfaNM5rNLVPwMxCoQBg2BLpVl4uqmCw7LDpfI9DvSOGPVDCgSJy
   Qz5UA66mkBmSHC3biQC58xXCKxFzCQw+ZeAlpZDfQJ754hJ8SWXbV9hxY
   Q==;
X-CSE-ConnectionGUID: Gp43p1SlSM2851nl5BTNiQ==
X-CSE-MsgGUID: Kb8fyaA+T+6kP5JAOQEeEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19488017"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19488017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 02:09:59 -0700
X-CSE-ConnectionGUID: f55IJ0ZORHiJGO3vm5OjHQ==
X-CSE-MsgGUID: Vt2JV7n6TqWgHV/eVj+m/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52172573"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 02:09:52 -0700
Message-ID: <cb2433e2-d6a3-4d70-9b88-0047a9dd01d2@intel.com>
Date: Tue, 23 Jul 2024 12:09:46 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 06/13] perf tools: Enable evsel__is_aux_event() to work
 for S390_CPUMSF
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-7-adrian.hunter@intel.com>
 <dbfae024-c7ce-4311-9f7b-419aacc7e7d9@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <dbfae024-c7ce-4311-9f7b-419aacc7e7d9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/24 11:26, Leo Yan wrote:
> On 7/15/2024 5:07 PM, Adrian Hunter wrote:
>>
>> evsel__is_aux_event() identifies AUX area tracing selected events.
>>
>> S390_CPUMSF uses a raw event type (PERF_TYPE_RAW - refer
>> s390_cpumsf_evsel_is_auxtrace()) not a PMU type value that could be checked
>> in evsel__is_aux_event(). However it sets needs_auxtrace_mmap (refer
>> auxtrace_record__init()), so check that first.
>>
>> Currently, the features that use evsel__is_aux_event() are used only by
>> Intel PT, but that may change in the future.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Acked-by: Ian Rogers <irogers@google.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Namhyung, could we get patches 5 and 6 from this series
applied?  They are independent and Leo's new patch set is
dependent on patch 5.

> 
>> ---
>>  tools/perf/util/pmu.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 986166bc7c78..0b38c51bd6eb 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1199,8 +1199,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
>>
>>  bool evsel__is_aux_event(const struct evsel *evsel)
>>  {
>> -       struct perf_pmu *pmu = evsel__find_pmu(evsel);
>> +       struct perf_pmu *pmu;
>>
>> +       if (evsel->needs_auxtrace_mmap)
>> +               return true;
>> +
>> +       pmu = evsel__find_pmu(evsel);
>>         return pmu && pmu->auxtrace;
>>  }
>>
>> --
>> 2.34.1
>>
>>

