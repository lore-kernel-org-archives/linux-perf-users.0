Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B418F2FB;
	Fri, 13 Dec 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121271; cv=none; b=G8L6zWNSS4KEPdoc+8dlxfBFtttb8vlWG6JeRPs1YoWZGC1KgAaWlS0PFrPQ7Hyfqemng2WCngV8MaYzKeoHyALZimy8Ioogva0qSIb/eD+MlSV7qVOS3C1/+GMt0eXgK5Rt9zHiEUYXrPlrCmngDxaXqFsqhBZDtU3DrI4NTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121271; c=relaxed/simple;
	bh=E3bOxijDc+kqtfBtyblaqVT6S3rrhM7udJksoxIrnYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMawrbcCFolUvYBICjbT9LtwkZSRpJykOitxWM6HRBUDmYtW/HeD5PoAeJzT/8owRADgZyc6vOwxsGNdWPiZKzUFwRUNrtPiF/UAO1pPBwTlLkJoRz2Y9BoQl0FbxOaNpZOKr+J0mBL196cGh6/bYzjtTFYSQ7nw4lqNBGnZeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jS+ilNGd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jS+ilNGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734121269; x=1765657269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E3bOxijDc+kqtfBtyblaqVT6S3rrhM7udJksoxIrnYc=;
  b=jS+ilNGdUfq+0AFck7JTRQb678vlErKSUp3+vpJuKt1pA7Y9Krovv8Zc
   pZtZgkRCPlnE1Q7WQ10p9L6KOPnVlYdMmnD5NRSZIJaJ+dnVLGj60BQrU
   9ul4DeQ8Bp7G8uI5bTA7n6JaOBHfXprlVLcDijH4VTIEzaxT1girfUFTj
   Vd7M8EbhVwNBLwIZ6Bg21IoyXFeVz2kB+oN7/u5q+SvVDFrHhDs4rtdZr
   v1dnCxaReRhanbhJKzWnKyo6qJCjqHns8VCsXfn2VNkP9v3qvoqI5Xoqg
   pgAz0CFlD30bT1aHQmXn9GjzmluvA4LLJipKH3YeW1YcuA/p5KFuMStQw
   w==;
X-CSE-ConnectionGUID: 25TYSjPeQIS6w25xqfxO3w==
X-CSE-MsgGUID: s0CkCpkWRsyxY7TtUUtKiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34723734"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34723734"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:21:09 -0800
X-CSE-ConnectionGUID: fi9u+KgfRCKZfVixy+NTzQ==
X-CSE-MsgGUID: wwcO/nNzRlel1ew0TLPPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="96852210"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:21:08 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 76A8420B5713;
	Fri, 13 Dec 2024 12:21:07 -0800 (PST)
Message-ID: <219e5f79-d2c2-45df-9298-142597ebb404@linux.intel.com>
Date: Fri, 13 Dec 2024 15:21:06 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf script: Fix output type for dynamically allocated
 core PMU's
To: Thomas Falcon <thomas.falcon@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com
Cc: ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241213201109.630658-1-thomas.falcon@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241213201109.630658-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-13 3:11 p.m., Thomas Falcon wrote:
> perf script output may show different fields on different core PMU's
> that exist on heterogeneous platforms. For example,
> 
> perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=0xcd,\
> umask=0x01,ldlat=3,name=MEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> -c10000 -W -d -a -- sleep 1
> 
> perf script:
> 
> chromium-browse   46572 [002] 544966.882384:      10000 	cpu_core/MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
>  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
> 
> perf record -e cpu_atom/event=0xd0,umask=0x05,ldlat=3,\
> name=MEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
> 
> perf script:
> 
> gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
> 
> Some fields, such as data_src, are not included by default.
> 
> The cause is that while one PMU may be assigned a type such as
> PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
> If this value does not match an existing PERF_TYPE_X value,
> output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
> 
> Instead search for a core PMU with a matching perf_event_attr type
> and, if one is found, return PERF_TYPE_RAW to match output of other
> core PMU's.
> 
> Suggested-by: Kan Liang <kan.liang@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> ---
>  tools/perf/builtin-script.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9e47905f75a6..459794c737ce 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -384,6 +384,18 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
>  		       st.st_size / 1024.0 / 1024.0, es->filename, es->samples);
>  }
>  
> +static bool output_type_many_core_pmus(unsigned int type)
> +{
> +	struct perf_pmu *pmu;
> +
> +	if (perf_pmus__num_core_pmus() > 1) {
> +		pmu = perf_pmus__find_by_type(type);
> +		if (pmu && pmu->is_core)> +			return true;

I think it should be good enough to search the core_pmus.
	list_for_each_entry(pmu, &core_pmus, list) {
		if (pmu->type == type)
			return true;
	}

Thanks,
Kan
> +	}
> +	return false;
> +}
> +
>  static inline int output_type(unsigned int type)
>  {
>  	switch (type) {
> @@ -394,6 +406,9 @@ static inline int output_type(unsigned int type)
>  			return type;
>  	}
>  
> +	if (output_type_many_core_pmus(type))
> +		return PERF_TYPE_RAW;
> +
>  	return OUTPUT_TYPE_OTHER;
>  }
>  

