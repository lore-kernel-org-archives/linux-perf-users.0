Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128871B977;
	Mon, 22 Jul 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645365; cv=none; b=dsnVxBM/6pIWLoVaLEqermRK7nYuVWBtSpIxciWc5c8PhhWwE5O2xnDxEBJdQ/AuhphYfsYYTAhRUPDZLXb2njWUsq9R/d9gbClKvxYjy1lJ5PWhAOFFBBZXF/o09gOYk4S96wEHsWifsRUZpFRXypK1lw2wpLSSgluPsH8NDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645365; c=relaxed/simple;
	bh=axkKqf9J2QE3tYQxCTqVu+D1ma9u2t96aa92YShZob0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oGRBqR61xOGx3N7V95koyiS7EI6ev3qkVjOdNTQF4bdAdmwHKHWHumpINgIDNanAsl76hpPQOamMBQ0clwIjW1ElCv53yvfZnucCHnu0aHj0fWYHycIHk1H4dQBa0TyObEh4dqZ4IpEE0o0f5mtzvgFA7X6iCsN9+zvY4Y00TqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwF89oYa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwF89oYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721645364; x=1753181364;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=axkKqf9J2QE3tYQxCTqVu+D1ma9u2t96aa92YShZob0=;
  b=CwF89oYaXhDoHL9InOvA8c/LcwNkFLEW7PPTpBV/9KGMawBgDf+wjT5h
   De/TPTjTEGQ8z5bfZUuqXWZ3qb+Vcnb4uzKtx1+ewSjVLOST6PNUnhsRV
   oG/t06q3ZO/i9PmT1m9NZd2EckwED8Iexc3i2qbe5zy4tUUdNhfYSkNFD
   Ckg0jr5G0XV9DNPimPdgi8ZQLyMpWGI1CR4y8HRJulhICMmLgGWTiBBK2
   Z8o4jDlzUGe/urwCsr9K3fdrRdRe6m6EiUW/Q6fae75NfXyQZlqpbUdWx
   WMIwKS23rvFalT3/snDhYZSuZuOQW+TRs9OIDEp/yGxWXY49Eh7yRx6sX
   g==;
X-CSE-ConnectionGUID: nIFDvW+lQcOU9GRsbZnfZA==
X-CSE-MsgGUID: oT6yGk6AQmqvD03+QG8IxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="29823106"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="29823106"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 03:49:23 -0700
X-CSE-ConnectionGUID: 1h+VyFoNQYGouPKhNBTKPg==
X-CSE-MsgGUID: 0RKLCgkVRa+zpqSrwCVOGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="56019411"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 03:49:19 -0700
Message-ID: <785cf263-5a76-48d8-964b-c248297de47e@intel.com>
Date: Mon, 22 Jul 2024 13:49:15 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] perf auxtrace arm: Set the 'auxtrace' flag for AUX
 events
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-3-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240721202113.380750-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/24 23:21, Leo Yan wrote:
> Originally, the 'auxtrace' flag in the PMU event is used for AUX area
> sampling. It indicates a PMU event is for AUX tracing.
> 
> Set this flag for AUX trace events on Arm.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Note same as:

https://lore.kernel.org/all/20240715160712.127117-6-adrian.hunter@intel.com/

Either should be fine:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/arm/util/pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 1c9541d01722..b7fa1245e242 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -25,6 +25,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  		/* add ETM default config here */
>  		pmu->selectable = true;
>  		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
> +		pmu->auxtrace = true;
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
>  		pmu->selectable = true;
> @@ -32,8 +33,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
>  		if (strstarts(pmu->name, "arm_spe_"))
>  			pmu->mem_events = perf_mem_events_arm;
> +		pmu->auxtrace = true;
>  	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>  		pmu->selectable = true;
> +		pmu->auxtrace = true;
>  #endif
>  	}
>  #endif

