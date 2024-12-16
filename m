Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3931487E5;
	Mon, 16 Dec 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363532; cv=none; b=KkvitRUVmuNssdCs54xTBjvXEdMNAsr3MtWh5s6FpNrV9iK3MUMuL9TZ7D+bzduyffNimxiGK0i4lrXAl6+RxJdyuosFmt9Hz9X++e/fOy5a/XeQP4wjzx9O1Bi7cXkHH7ZaQd+o6JhfSWEkRdg22+9LItp2AQB4sBlipg8BmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363532; c=relaxed/simple;
	bh=4JhJzogwod5lusET8+1uvXahWabilaM5cqQbZt+f798=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IM3rgflz0FasSs5uxjhVgj5mrbTEPOBqsO4k269zIsWEtyFEPPuGwXV8dCywSMt7OK+XE5OIHDftsoXu8sLQ6gI2pLxh05f4fahO4c9IcyqHW3N6LlSGWn6BBwI377iv45lnfUk1omKIFN+XHX5kZU1N/iN5Ptk0FiitRv1iUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHSZ/zW4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHSZ/zW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734363530; x=1765899530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4JhJzogwod5lusET8+1uvXahWabilaM5cqQbZt+f798=;
  b=CHSZ/zW4n8fO45nEroBnFKqbidrHOPGNjQZJ4BZkyIy0m/Aj+jMbqe2W
   uiQVlCin36TDQ/3ulZ3j7p0c0XQhGnyvaj42fT0PTkW+Pnggn5LyqIJSg
   yLdR8/Roxs6DKJbC7KT5SITgMtPNFTxSNGAXr00Rjy+azIWH7ElWHKn0q
   9CiYZ8pum9PuEQiHAaYGG4to0mEpFXnbQrqw0tiMpVlOmtqPdlguPgCLf
   iWuKGnocsfw9fpnqbscJkMlSMBn+OKOUSPgjcNcgAfLNFkah4hHzT2pW4
   VV97XR4LWit2HQsE4h6R53VnqnxUprT5SEAwB1L+tLrOxIYhIti1JHfdl
   g==;
X-CSE-ConnectionGUID: 3E91DYH2RGqexZ+rW8PMCQ==
X-CSE-MsgGUID: Ib1kT2jTR+CkUu10u62Wzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34982153"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34982153"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:38:49 -0800
X-CSE-ConnectionGUID: KmwkxK/1S0WQjDjMiHPFog==
X-CSE-MsgGUID: 64Vy4xYMQh2lFA+D+dwjDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134573103"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:38:49 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 49A8020B5713;
	Mon, 16 Dec 2024 07:38:47 -0800 (PST)
Message-ID: <4ceb9d79-a651-43da-95fd-ada0c775cf4b@linux.intel.com>
Date: Mon, 16 Dec 2024 10:38:46 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf script: Fix output type for dynamically allocated
 core PMU's
To: Thomas Falcon <thomas.falcon@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com
Cc: ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241213215421.661139-1-thomas.falcon@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241213215421.661139-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-13 4:54 p.m., Thomas Falcon wrote:
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

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> v3: only scan core pmu list
> ---
>  tools/perf/builtin-script.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9e47905f75a6..685232883f9c 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -384,6 +384,19 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
>  		       st.st_size / 1024.0 / 1024.0, es->filename, es->samples);
>  }
>  
> +static bool output_type_many_core_pmus(unsigned int type)
> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	if (perf_pmus__num_core_pmus() > 1) {
> +		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +			if (pmu->type == type)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static inline int output_type(unsigned int type)
>  {
>  	switch (type) {
> @@ -394,6 +407,9 @@ static inline int output_type(unsigned int type)
>  			return type;
>  	}
>  
> +	if (output_type_many_core_pmus(type))
> +		return PERF_TYPE_RAW;
> +
>  	return OUTPUT_TYPE_OTHER;
>  }
>  

