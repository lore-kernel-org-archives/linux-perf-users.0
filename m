Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A71BC58;
	Mon, 11 Nov 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336526; cv=none; b=LgOYu3E6q1d4pRkuCwjOeJhAgScpCqIXWb+m2zHa15ZVtofy5Zu4ehujJUHqgUKHfyZluitTV14ohtwP0Sbru8EC/KP/4U7xPfCu7uGr2rtoeUgeRHFpZn7K0oxFVo1Y11LjO6L3M+3+0lUvsz0BTQN1/Dx4iqCFnUy4PcPZCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336526; c=relaxed/simple;
	bh=6MInw1nF1jtgbOJqQyUTTN/pSphFnTwKR2goS/QMk6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RpTgSoAz8Pg6c7kT+3kuFMDXT4zzSFEku6OWKoik2aDDa0FjAWgVay9JPHA8WbTssDgM/6yySYIIQ5NsufGg35qZ1Xk9Ep/XXdL13LYP2r9aTNTf9Re1bgriMayg1X71RANEFTGAvVkokZFZGaKWaJoJqG2L/VFfI8ENDy0aENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN53s34B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN53s34B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731336524; x=1762872524;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6MInw1nF1jtgbOJqQyUTTN/pSphFnTwKR2goS/QMk6Q=;
  b=DN53s34BzptcimEw0JXDtsGONEaxrgt8BHMsB0SWohOe0oBiqe7VCDZj
   R/C0PW0Qppi1gwZIyhxSVqbt9laxUw9436UMWyUWCK0AxXbZ0nOByXGqn
   AsdCpW9Lb8iSGFVrhhKskVzyWd44tGNIwVqDourDU3/2O7vvd+QmlhZTL
   +ZEIuKppehg9CfbVTIL5huzsVZOohKWo1NfabcAzoC5z9nNfY+cUVsBFl
   tyvE/neCL7lkUnqjJtOBy7mJWp6qL9fJ3VWdhFC6EDD8WqeTloXg+TcUm
   0syGWFtDHGl8DnegrZVgPK6qEvs3BPu8AZtYgAPlyzdYu/8WtK/Y3GTWx
   g==;
X-CSE-ConnectionGUID: lVjivA+KSOGPxeX3v5cZDA==
X-CSE-MsgGUID: PXlGI1BATbWicmgqkaxGPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="42539938"
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="42539938"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 06:48:44 -0800
X-CSE-ConnectionGUID: sSe0xfOYROmcGreLfcJs8Q==
X-CSE-MsgGUID: 9lqi+h25SEWhYg1xm50ChA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="91908219"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 06:48:44 -0800
Received: from [10.212.84.100] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D4A3D20B5703;
	Mon, 11 Nov 2024 06:48:42 -0800 (PST)
Message-ID: <7676a058-e7ae-4c6b-a9f8-be450b64f5e1@linux.intel.com>
Date: Mon, 11 Nov 2024 09:48:41 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf list: Fix topic and pmu_name argument order
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241109025801.560378-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241109025801.560378-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-08 9:58 p.m., Ian Rogers wrote:
> From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
> 
> Fix function definitions to match header file declaration. Fix two
> callers to pass the arguments in the right order.
> 
> On Intel Tigerlake, before:
> ```
> $ perf list -j|grep "\"Topic\""|sort|uniq
>         "Topic": "cache",
>         "Topic": "cpu",
>         "Topic": "floating point",
>         "Topic": "frontend",
>         "Topic": "memory",
>         "Topic": "other",
>         "Topic": "pfm icl",
>         "Topic": "pfm ix86arch",
>         "Topic": "pfm perf_raw",
>         "Topic": "pipeline",
>         "Topic": "tool",
>         "Topic": "uncore interconnect",
>         "Topic": "uncore memory",
>         "Topic": "uncore other",
>         "Topic": "virtual memory",
> $ perf list -j|grep "\"Unit\""|sort|uniq
>         "Unit": "cache",
>         "Unit": "cpu",
>         "Unit": "cstate_core",
>         "Unit": "cstate_pkg",
>         "Unit": "i915",
>         "Unit": "icl",
>         "Unit": "intel_bts",
>         "Unit": "intel_pt",
>         "Unit": "ix86arch",
>         "Unit": "msr",
>         "Unit": "perf_raw",
>         "Unit": "power",
>         "Unit": "tool",
>         "Unit": "uncore_arb",
>         "Unit": "uncore_clock",
>         "Unit": "uncore_imc_free_running_0",
>         "Unit": "uncore_imc_free_running_1",
> ```
> 
> After:
> ```
> $ perf list -j|grep "\"Topic\""|sort|uniq
>         "Topic": "cache",
>         "Topic": "floating point",
>         "Topic": "frontend",
>         "Topic": "memory",
>         "Topic": "other",
>         "Topic": "pfm icl",
>         "Topic": "pfm ix86arch",
>         "Topic": "pfm perf_raw",
>         "Topic": "pipeline",
>         "Topic": "tool",
>         "Topic": "uncore interconnect",
>         "Topic": "uncore memory",
>         "Topic": "uncore other",
>         "Topic": "virtual memory",
> $ perf list -j|grep "\"Unit\""|sort|uniq
>         "Unit": "cpu",
>         "Unit": "cstate_core",
>         "Unit": "cstate_pkg",
>         "Unit": "i915",
>         "Unit": "icl",
>         "Unit": "intel_bts",
>         "Unit": "intel_pt",
>         "Unit": "ix86arch",
>         "Unit": "msr",
>         "Unit": "perf_raw",
>         "Unit": "power",
>         "Unit": "tool",
>         "Unit": "uncore_arb",
>         "Unit": "uncore_clock",
>         "Unit": "uncore_imc_free_running_0",
>         "Unit": "uncore_imc_free_running_1",
> ```
> 
> Fixes: e5c6109f4813 ("perf list: Reorganize to use callbacks to allow honouring command line options")
> Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
> Tested-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> Note from Ian, I fixed the two callers and added it to
> Jean-Phillippe's original change.
> ---
>  tools/perf/builtin-list.c | 4 ++--
>  tools/perf/util/pfm.c     | 4 ++--
>  tools/perf/util/pmus.c    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index b8378ba18c28..9e7fdfcdd7ff 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -113,7 +113,7 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
>  	}
>  }
>  
> -static void default_print_event(void *ps, const char *pmu_name, const char *topic,
> +static void default_print_event(void *ps, const char *topic, const char *pmu_name,
>  				const char *event_name, const char *event_alias,
>  				const char *scale_unit __maybe_unused,
>  				bool deprecated, const char *event_type_desc,
> @@ -354,7 +354,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
>  	fputs(buf->buf, fp);
>  }
>  
> -static void json_print_event(void *ps, const char *pmu_name, const char *topic,
> +static void json_print_event(void *ps, const char *topic, const char *pmu_name,
>  			     const char *event_name, const char *event_alias,
>  			     const char *scale_unit,
>  			     bool deprecated, const char *event_type_desc,
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index 5ccfe4b64cdf..0dacc133ed39 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -233,7 +233,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>  	}
>  
>  	if (is_libpfm_event_supported(name, cpus, threads)) {
> -		print_cb->print_event(print_state, pinfo->name, topic,
> +		print_cb->print_event(print_state, topic, pinfo->name,
>  				      name, info->equiv,
>  				      /*scale_unit=*/NULL,
>  				      /*deprecated=*/NULL, "PFM event",
> @@ -267,8 +267,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>  				continue;
>  
>  			print_cb->print_event(print_state,
> -					pinfo->name,
>  					topic,
> +					pinfo->name,
>  					name, /*alias=*/NULL,
>  					/*scale_unit=*/NULL,
>  					/*deprecated=*/NULL, "PFM event",
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 107de86c2637..6d4c7c9ecf3a 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -501,8 +501,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>  			goto free;
>  
>  		print_cb->print_event(print_state,
> -				aliases[j].pmu_name,
>  				aliases[j].topic,
> +				aliases[j].pmu_name,
>  				aliases[j].name,
>  				aliases[j].alias,
>  				aliases[j].scale_unit,

