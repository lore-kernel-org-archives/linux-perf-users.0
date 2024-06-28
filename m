Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D13225CE;
	Fri, 28 Jun 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596706; cv=none; b=aAcsCWd9FbLbWLYfiViqSLj/0XcHgaSRgHgezbY6clhVx42aCYUbEySL7E+jZotPUScWkgi8IMHXxpL3HlX8j97iuAtmQNoqZYhBVqO7aPn5a2XIc/HmqPCyWZJAHxO4TEurL54Cxu/CZCg8CVI6xcklqNVscaYF5iME1KLf3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596706; c=relaxed/simple;
	bh=aNY+O6cDrcLDSxY03Nb33/NxPiS2cNiMTft/3ON4pLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f0DW2KRcxaF6V8Zu/2YO2yiK2XVklIblfVYPOJfdAC6mREv5yTNTKPya/LjrQyWz41cdcsm+56lURX0D1GO/w6egrAa18t/Gvd6Ue46GI/IL0ikb5bkmltzLI4SbLQ420IhmfC8C3DVj6kB4fzC1TsEBihYIE9XGwuF5EErC+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giyKwRNL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giyKwRNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719596704; x=1751132704;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=aNY+O6cDrcLDSxY03Nb33/NxPiS2cNiMTft/3ON4pLw=;
  b=giyKwRNLufXjrGIXM4FJ69DA0z9FF4isFKoAQivFgMXi8IFmvVxJT7nm
   aFXnO0muyLvfioO5WfHXMyP9gbVjcwufjfd/LwFrbfq6y+3RXnhSAVhH2
   TsybQS7GPBWC2U0ihek7oz4Su6VYp7uMg197Zw9DnMhZ9xhD4laGHxibr
   bi+CuyhAyW1wHmEfFERATjcIm9rT79HiWtsYyGEm2aF4HhJHpSIBJ9aNN
   wUXd4d9TsRk3Q0H4yP0c06zPwAYQZLtnoxbS3SWm2HfAh5vSHjKOXnHB8
   GlYxD9sUERH1SipMaX2aukrGTQBdrm2rBhnw5JZu3V1Zy56pen+QwvQ5O
   Q==;
X-CSE-ConnectionGUID: FILi8e2pTfWfU9nQu6HTjA==
X-CSE-MsgGUID: ZXwDT06jSQqBujn2MuHYeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27379483"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="27379483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:45:04 -0700
X-CSE-ConnectionGUID: vtFp6bmySZm6jlK0kwZSBg==
X-CSE-MsgGUID: 149hKepYTu63vL+i+3kR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="45471201"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:44:57 -0700
Message-ID: <d36acf6a-1505-459d-b392-be0fc952ad08@intel.com>
Date: Fri, 28 Jun 2024 20:44:50 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/27] perf auxevent: Zero size dummy tool
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240626203630.1194748-1-irogers@google.com>
 <20240626203630.1194748-2-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240626203630.1194748-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In subject: "auxevent" -> "auxtrace"

On 26/06/24 23:36, Ian Rogers wrote:
> The dummy tool is passed as a placeholder to allow a container_of to
> get additional parameters. As the tool isn't used, make it a zero
> sized array saving 320 bytes on an x86_64 build.
> 
> s390-cpumsf's dummy tool struct was unused, so remove.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/arm-spe.c     | 6 +++---
>  tools/perf/util/cs-etm.c      | 6 +++---
>  tools/perf/util/intel-bts.c   | 6 +++---
>  tools/perf/util/intel-pt.c    | 7 +++----
>  tools/perf/util/s390-cpumsf.c | 5 -----
>  5 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index afbd5869f6bf..ee0d5064ddd4 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1074,8 +1074,8 @@ static void arm_spe_print_info(__u64 *arr)
>  }
>  
>  struct arm_spe_synth {
> -	struct perf_tool dummy_tool;
>  	struct perf_session *session;
> +	struct perf_tool dummy_tool[0];

[] is preferred to [0]

>  };
>  
>  static int arm_spe_event_synth(struct perf_tool *tool,
> @@ -1084,7 +1084,7 @@ static int arm_spe_event_synth(struct perf_tool *tool,
>  			       struct machine *machine __maybe_unused)
>  {
>  	struct arm_spe_synth *arm_spe_synth =
> -		      container_of(tool, struct arm_spe_synth, dummy_tool);
> +		      container_of(tool, struct arm_spe_synth, dummy_tool[0]);
>  
>  	return perf_session__deliver_synth_event(arm_spe_synth->session,
>  						 event, NULL);
> @@ -1098,7 +1098,7 @@ static int arm_spe_synth_event(struct perf_session *session,
>  	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
>  	arm_spe_synth.session = session;
>  
> -	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
> +	return perf_event__synthesize_attr(arm_spe_synth.dummy_tool, attr, 1,

Passing a pointer to an object that doesn't exist there is NAK IMO

It would be better to just write another version of
perf_event__synthesize_attr().

>  					   &id, arm_spe_event_synth);
>  }
>  
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 32818bd7cd17..9fd2967d4e3f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1596,8 +1596,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  }
>  
>  struct cs_etm_synth {
> -	struct perf_tool dummy_tool;
>  	struct perf_session *session;
> +	struct perf_tool dummy_tool[0];
>  };
>  
>  static int cs_etm__event_synth(struct perf_tool *tool,
> @@ -1606,7 +1606,7 @@ static int cs_etm__event_synth(struct perf_tool *tool,
>  			       struct machine *machine __maybe_unused)
>  {
>  	struct cs_etm_synth *cs_etm_synth =
> -		      container_of(tool, struct cs_etm_synth, dummy_tool);
> +		      container_of(tool, struct cs_etm_synth, dummy_tool[0]);
>  
>  	return perf_session__deliver_synth_event(cs_etm_synth->session,
>  						 event, NULL);
> @@ -1620,7 +1620,7 @@ static int cs_etm__synth_event(struct perf_session *session,
>  	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
>  	cs_etm_synth.session = session;
>  
> -	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
> +	return perf_event__synthesize_attr(cs_etm_synth.dummy_tool, attr, 1,
>  					   &id, cs_etm__event_synth);
>  }
>  
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index ec1b3bd9f530..fb8fec3a3c36 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -738,8 +738,8 @@ static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
>  }
>  
>  struct intel_bts_synth {
> -	struct perf_tool dummy_tool;
>  	struct perf_session *session;
> +	struct perf_tool dummy_tool[0];
>  };
>  
>  static int intel_bts_event_synth(struct perf_tool *tool,
> @@ -748,7 +748,7 @@ static int intel_bts_event_synth(struct perf_tool *tool,
>  				 struct machine *machine __maybe_unused)
>  {
>  	struct intel_bts_synth *intel_bts_synth =
> -			container_of(tool, struct intel_bts_synth, dummy_tool);
> +			container_of(tool, struct intel_bts_synth, dummy_tool[0]);
>  
>  	return perf_session__deliver_synth_event(intel_bts_synth->session,
>  						 event, NULL);
> @@ -762,7 +762,7 @@ static int intel_bts_synth_event(struct perf_session *session,
>  	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
>  	intel_bts_synth.session = session;
>  
> -	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
> +	return perf_event__synthesize_attr(intel_bts_synth.dummy_tool, attr, 1,
>  					   &id, intel_bts_event_synth);
>  }
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index d6d7b7512505..b8b90773baa2 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3660,8 +3660,8 @@ static int intel_pt_queue_data(struct perf_session *session,
>  }
>  
>  struct intel_pt_synth {
> -	struct perf_tool dummy_tool;
>  	struct perf_session *session;
> +	struct perf_tool dummy_tool[0];
>  };
>  
>  static int intel_pt_event_synth(struct perf_tool *tool,
> @@ -3670,7 +3670,7 @@ static int intel_pt_event_synth(struct perf_tool *tool,
>  				struct machine *machine __maybe_unused)
>  {
>  	struct intel_pt_synth *intel_pt_synth =
> -			container_of(tool, struct intel_pt_synth, dummy_tool);
> +			container_of(tool, struct intel_pt_synth, dummy_tool[0]);
>  
>  	return perf_session__deliver_synth_event(intel_pt_synth->session, event,
>  						 NULL);
> @@ -3687,8 +3687,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
>  
>  	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
>  	intel_pt_synth.session = session;
> -
> -	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
> +	err = perf_event__synthesize_attr(intel_pt_synth.dummy_tool, attr, 1,
>  					  &id, intel_pt_event_synth);
>  	if (err)
>  		pr_err("%s: failed to synthesize '%s' event type\n",
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 6fe478b0b61b..4ec583e511af 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
>  	return err;
>  }
>  
> -struct s390_cpumsf_synth {
> -	struct perf_tool cpumsf_tool;
> -	struct perf_session *session;
> -};

Should really be a separate patch

> -
>  static int
>  s390_cpumsf_process_auxtrace_event(struct perf_session *session,
>  				   union perf_event *event __maybe_unused,

