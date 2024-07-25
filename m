Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009B18028
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922729; cv=none; b=GlzoHVwvq/6jI0g1K7hHG6GpfQ1TGMUww9an9WfQhLkimsjKcjEDgm4ygI5w9Mijvr6lzn3PT4r50yNao4Vb8GDyDB5T4/IqGmBt17mI3lJO1RUGTwYgNChe6FYppfKztKA3FWO5WBomlLS50sY8HTac0Z3hPPUMbxoCacOC4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922729; c=relaxed/simple;
	bh=ht4OxHzXG5XgLcZlowtMN4BV0rKVu0Y+e9bJbXIpOvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rrbN7I90tmEbR5WDxTGuDNv5CDFiZ/R1ylg8oTHm8oa9YuIFUx0Tm64zbQVg36uW7duwiZW8IJ5PYD3utV3LpJQrMdxo0TZBqJFe4L4LrN9mKcRhsE2fbFYX3gVSoPiak+BpyJB020Pn8TZDL6vkT/3HoX0CyHvvucIfER0ujyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KebQe9Tm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KebQe9Tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721922728; x=1753458728;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ht4OxHzXG5XgLcZlowtMN4BV0rKVu0Y+e9bJbXIpOvY=;
  b=KebQe9TmEe1b+r/dE96RvTNt9ayw+r3Pngi9jaD1o8UoI+mnjvlVPYqW
   MDBOJ6nBumA1LiS1RlTMC+n4H5wdHzH16qPTC+EQzQ+0GECSfV59kYNtb
   WM5E8eQTV4lC3YQ9g1NqvYftA18NczZmjHdqhJ5dguuM+oLFXTPIXh217
   duGi1LKabKhFHuZsvmG3VpxLvWo/mF1kxWxeVMj0Mb/0Y8ynEF5D3CNxh
   Ya8rRTq8ENfB6h85u0dacthxRujHvq+zmp4J74j/V9DCXo+X8vOnlp+aX
   J51wCPKxaUz9CnSnyggGm1zDvUBlrs/1ZuHX0GdrFDBbxp8pQlhPvNJnx
   A==;
X-CSE-ConnectionGUID: nxnqtv+0Qh+CZZeBdjV9zA==
X-CSE-MsgGUID: LI6zNtlGTAeQDaLWr2Lz2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19799496"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19799496"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 08:52:06 -0700
X-CSE-ConnectionGUID: XoDzfOXjS56RszxicWQwJg==
X-CSE-MsgGUID: YbHq2uRGSKuuaG9qqJDTzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57773004"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 08:52:02 -0700
Message-ID: <dfc486a3-fc69-4ae5-a1c2-768bae92f70b@intel.com>
Date: Thu, 25 Jul 2024 18:51:56 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] perf auxtrace: Remove unused 'pmu' pointer from
 struct auxtrace_record
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20240725064620.1651819-1-leo.yan@arm.com>
 <20240725064620.1651819-3-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725064620.1651819-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 09:46, Leo Yan wrote:
> The 'pmu' pointer in the auxtrace_record structure is not used after
> support multiple AUX events, remove it.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c     | 1 -
>  tools/perf/arch/arm64/util/arm-spe.c  | 1 -
>  tools/perf/arch/arm64/util/hisi-ptt.c | 1 -
>  tools/perf/arch/x86/util/intel-bts.c  | 1 -
>  tools/perf/arch/x86/util/intel-pt.c   | 1 -
>  tools/perf/util/auxtrace.h            | 1 -
>  6 files changed, 6 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index da6231367993..96aeb7cdbee1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -888,7 +888,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
>  	}
>  
>  	ptr->cs_etm_pmu			= cs_etm_pmu;
> -	ptr->itr.pmu			= cs_etm_pmu;
>  	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
>  	ptr->itr.recording_options	= cs_etm_recording_options;
>  	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 0b52e67edb3b..622fd47573ec 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -497,7 +497,6 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>  	}
>  
>  	sper->arm_spe_pmu = arm_spe_pmu;
> -	sper->itr.pmu = arm_spe_pmu;
>  	sper->itr.snapshot_start = arm_spe_snapshot_start;
>  	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
>  	sper->itr.find_snapshot = arm_spe_find_snapshot;
> diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
> index ba97c8a562a0..eac9739c87e6 100644
> --- a/tools/perf/arch/arm64/util/hisi-ptt.c
> +++ b/tools/perf/arch/arm64/util/hisi-ptt.c
> @@ -174,7 +174,6 @@ struct auxtrace_record *hisi_ptt_recording_init(int *err,
>  	}
>  
>  	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
> -	pttr->itr.pmu = hisi_ptt_pmu;
>  	pttr->itr.recording_options = hisi_ptt_recording_options;
>  	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
>  	pttr->itr.info_fill = hisi_ptt_info_fill;
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index 34696f3d3d5d..85c8186300c8 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -434,7 +434,6 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
>  	}
>  
>  	btsr->intel_bts_pmu = intel_bts_pmu;
> -	btsr->itr.pmu = intel_bts_pmu;
>  	btsr->itr.recording_options = intel_bts_recording_options;
>  	btsr->itr.info_priv_size = intel_bts_info_priv_size;
>  	btsr->itr.info_fill = intel_bts_info_fill;
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 4b710e875953..ea510a7486b1 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -1197,7 +1197,6 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
>  	}
>  
>  	ptr->intel_pt_pmu = intel_pt_pmu;
> -	ptr->itr.pmu = intel_pt_pmu;
>  	ptr->itr.recording_options = intel_pt_recording_options;
>  	ptr->itr.info_priv_size = intel_pt_info_priv_size;
>  	ptr->itr.info_fill = intel_pt_info_fill;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index f99e53426528..a54f7b99ba5a 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -411,7 +411,6 @@ struct auxtrace_record {
>  	int (*read_finish)(struct auxtrace_record *itr, int idx);
>  	unsigned int alignment;
>  	unsigned int default_aux_sample_size;
> -	struct perf_pmu *pmu;
>  	struct evlist *evlist;
>  };
>  

