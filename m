Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EF1E00B4;
	Fri, 13 Dec 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114853; cv=none; b=q0ytKLJQ3NEs8szkJNiU0E4FyxUIxBD3nhOX56rkrFDgZAoGwCpyXwlGrcX00ri+D4AVhdNXdS4U50FG0VYfrDzvbpqfXHo0NgnaGwNu6wfRXlNzKj+PH4yF+IJg/u0zW7ZT4jDqvscJJZuzT+fBLPD5XNiluI+RZ6FYzQgUtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114853; c=relaxed/simple;
	bh=oM1Je83I0CSyi2U7GJfp+atfDrvaAqGgil3RfWpdjak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F877JjL1h0gWhpq/qRccMXSEUUEUxMHlcvNJIn3OQAw2tv8OAhiyRap1KW6oreboqIYqHXhSWT56GPZcNZXDOIo1yj3e4puNLkq1T3TpSjK+Mn29LFsI/+m9HgJLJHswY/LazSSzspjKro3l4o5LeDVNkNRTqMjuv8uk+W/pPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuBMTEGh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuBMTEGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734114852; x=1765650852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oM1Je83I0CSyi2U7GJfp+atfDrvaAqGgil3RfWpdjak=;
  b=LuBMTEGh3x6A1cu31LvMoub7K/VKSE5dlfIGhBsXDsRhgnjXnCbljWZY
   ZIMiyq628cGciQVNhAIpEzrVg66Z66ZwGRWrRkTekZjeU+knwlsJsEDqX
   JaV+J7KVJnOtsefAUVN/r2wklVSOxHv1PYAcewlMBeY1lkSKVQG+ztGnI
   m0vvCyvfHOcUIYrFz2zoPs00nrzTT2nwufrblFAPgmYT+Y9STgmbl5AC7
   vWCDa7IahoL/6btA5pGQ2r4LH/Bb28eTZ7w6z+zzaNg6xTwxSBSzlsRAl
   kyFbG5v8PCf1OmskCFSpp793t3n84AB5MhvyERuci9cmkzvZiqdF4Z3+p
   g==;
X-CSE-ConnectionGUID: zmtdYquNThy5/VAooJDLhw==
X-CSE-MsgGUID: J3uLWivZS2++0gKuSR4N9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="38257273"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="38257273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:34:10 -0800
X-CSE-ConnectionGUID: aEYP/Q7bR1aiD4sD3W8CXg==
X-CSE-MsgGUID: 49bMydHsSaa7SvS7BpAv4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="101449691"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:34:09 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4AB4820B5713;
	Fri, 13 Dec 2024 10:34:08 -0800 (PST)
Message-ID: <66df2821-80a4-4ec2-b326-d0edda8fcde2@linux.intel.com>
Date: Fri, 13 Dec 2024 13:34:07 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: Fix output type for dynamically allocated
 core PMU's
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com
References: <20241213003609.564709-1-thomas.falcon@intel.com>
 <fb6f17b7-8ee1-4197-afb6-923b372965c2@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <fb6f17b7-8ee1-4197-afb6-923b372965c2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-13 2:07 a.m., Ravi Bangoria wrote:
> Hi Thomas,
> 
>> @@ -386,6 +386,8 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
>>  
>>  static inline int output_type(unsigned int type)
>>  {
>> +	struct perf_pmu *pmu;
>> +
>>  	switch (type) {
>>  	case PERF_TYPE_SYNTH:
>>  		return OUTPUT_TYPE_SYNTH;
>> @@ -394,6 +396,10 @@ static inline int output_type(unsigned int type)
>>  			return type;
>>  	}
>>  
>> +	pmu = perf_pmus__find_by_type(type);
>> +	if (pmu && pmu->is_core)
>> +		return PERF_TYPE_RAW;
> 
> Minor nit ...
> 
> output_type() seems to be getting called a lot. For ex, for a perf.data
> with 4530 samples, output_type() was called 181246 times when I ran
> "perf script". IIUC, this pmu lookup is unnecessary for homogeneous
> platforms? If so, can we make it conditional?
> 

Agreed. I think the search should only be applied for the
perf_pmus__num_core_pmus() > 1 case.

We should just need to search the core_pmus when comparing the type.

Thanks,
Kan
