Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93C10A11;
	Wed, 26 Jun 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385178; cv=none; b=kCztIXzKYazEWnpquJyv8S2qeEQEX8P5CfaK3f8g+AJ0NOOjaEAc3Wg5lI8eDjYBN16INuDWCUP0PiHvfsbW+3JsLRhdL9e/UweSDLsjzP3mPvfs7gTxS+r8iI/m1tiiFPser5yxM+V2jByRRjQDHKhTiDYp2MuBKL8JkNQ+POU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385178; c=relaxed/simple;
	bh=F7Vpya+7j+dMbuEFDpaXdFPnPs9r3oWYBeeZVByqmkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AQnNKhm4RADOP331mywIxDpfJO/8+X8iAKkS5g0y7m1LmMBJU2XFbV+v7hgD5waNBdR56/tAZDR98ZAelgu0dLo/RM/ASlSg6V0tZ6RZEO2DERgV+ecKwgfctDSydnzz2b5uVCYXZcNjWYCaDWL45GbJmoxMGLClx3SQsykkoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXq7/gMR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXq7/gMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719385177; x=1750921177;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=F7Vpya+7j+dMbuEFDpaXdFPnPs9r3oWYBeeZVByqmkM=;
  b=hXq7/gMR010eHnMHkvExEOLCHWweICft4AICZZAE8sywjTtuOPGnMw/F
   YKwRmZWCTgSM4JISlrLBzx/MTWcNwHy9pRQ0LqB3kBVALolEdluBlBXr5
   JO43H+F+EWkEsv85nZ7yH+O8Ef6SXkJKjrIqbvWIz1hB9HTjF75NhJyIf
   HhWOMPJ8Uq/q2PhCyt4fjnjS9aWNU8M6BZizeoRHNO6++HEouI4jE27QE
   c8smoNkAq4n54ECJFa1yDSMS3KOYbCv35PunudF5eVWIgivvfDvSQeooI
   W4SpDU9EDQS2ggpe+COr79OF0shpSkvbHFmoPuhWYWSCRCsjJo6Ya7svg
   g==;
X-CSE-ConnectionGUID: +UihRZYOSXuazyHV5fjwBw==
X-CSE-MsgGUID: oLcULofwReqVIeUEY3JtoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16317354"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16317354"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 23:59:36 -0700
X-CSE-ConnectionGUID: Ad4KmJhCS3ehFjR9r2Vaww==
X-CSE-MsgGUID: 4x5SIM5PQ0qrOKTevQo+gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48494075"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 23:59:29 -0700
Message-ID: <5db205f3-550f-4b9b-8bf4-aaa8054043aa@intel.com>
Date: Wed, 26 Jun 2024 09:59:23 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 22/26] perf auxevent: Add explicit dummy tool
 initialization
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
References: <20240625172603.900667-1-irogers@google.com>
 <20240625172603.900667-23-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240625172603.900667-23-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/24 20:25, Ian Rogers wrote:
> Ensure tool is initialized to avoid lazy initialization pattern so
> that more uses of struct perf_tool can be made const.

This does not look necessary.

The dummy tool is not used, and is not subject to lazy initialization,
so the existing initialization to zero is fine.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/arm-spe.c     | 1 +
>  tools/perf/util/cs-etm.c      | 1 +
>  tools/perf/util/intel-bts.c   | 1 +
>  tools/perf/util/intel-pt.c    | 2 +-
>  tools/perf/util/s390-cpumsf.c | 1 -
>  5 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 70bad18c4a0d..06a198b2f483 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1097,6 +1097,7 @@ static int arm_spe_synth_event(struct perf_session *session,
>  
>  	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
>  	arm_spe_synth.session = session;
> +	perf_tool__init(&arm_spe_synth.dummy_tool, /*ordered_events=*/false);
>  
>  	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
>  					   &id, arm_spe_event_synth);
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 231cd833c012..02eb5b3eed14 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1619,6 +1619,7 @@ static int cs_etm__synth_event(struct perf_session *session,
>  
>  	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
>  	cs_etm_synth.session = session;
> +	perf_tool__init(&cs_etm_synth.dummy_tool, /*ordered_events=*/false);
>  
>  	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
>  					   &id, cs_etm__event_synth);
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 779982c478e0..ae97109542be 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -761,6 +761,7 @@ static int intel_bts_synth_event(struct perf_session *session,
>  
>  	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
>  	intel_bts_synth.session = session;
> +	perf_tool__init(&intel_bts_synth.dummy_tool, /*ordered_events=*/false);
>  
>  	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
>  					   &id, intel_bts_event_synth);
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index bed35029e1f6..48ed60e521ed 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3687,7 +3687,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
>  
>  	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
>  	intel_pt_synth.session = session;
> -
> +	perf_tool__init(&intel_pt_synth.dummy_tool, /*ordered_events=*/false);
>  	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
>  					  &id, intel_pt_event_synth);
>  	if (err)
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 5834bad6ac0f..eb835e531cd6 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -953,7 +953,6 @@ s390_cpumsf_process_event(struct perf_session *session,
>  }
>  
>  struct s390_cpumsf_synth {
> -	struct perf_tool cpumsf_tool;
>  	struct perf_session *session;
>  };
>  

