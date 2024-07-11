Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F284DF1;
	Thu, 11 Jul 2024 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680207; cv=none; b=U8n0IWFGPbTCwx1SZGcjr50KxIPtnYSErmyMnnnSFB+r/L7/pCNCLhXQOMInTcu8lI2hw/iA9iKNA6MjTjicOZWOktUL4C9xEASzYd/An4wfWgVDEfoWw5dIUppj9YwK+cOc9Qf1903EpEztlOQFu1JBmUGlUHbgksGlAhnxKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680207; c=relaxed/simple;
	bh=ukvBIwZ85jmi2nW55ZuutFFoxk+4v29YHKcED+9uWf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lYlydg2xzzfbK/3cekEDpeTQB9Ne+sGydx5Xjfmb7mZBYfNYypRILoyCSv51XqZgqq9BEk1Mxr6HEqcnKU7rG69mE9FMDDb6ANKuDnpggVfSvV9Fdi6y+Zx7ZtSytEJ8oR23D2u4qBOBUSQ3WI93dnC5U4JTpBElhe3gHrWHZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F967TQTH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F967TQTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720680205; x=1752216205;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ukvBIwZ85jmi2nW55ZuutFFoxk+4v29YHKcED+9uWf4=;
  b=F967TQTHGrYFonMdHpJtPJOk2GhqjHIfATuz5amgd6rTAfvKzkD5NeCE
   pm2EM7Ml4MjT7IcupftM07VDY3DIwhg3/f1xsy5AgTFbFbDlKieDE9ZG6
   QbBf5gb+lhjQdMX94U2pPqIrFldDuBHcgkbx96uzURWNpobVL6lbJ3EIF
   1Y762g7evKuhTn4GCzgtd/m0vqK0Y1TYNullAnS2f1gV4SOrLbvwuS0Qn
   1i17HvN2jRH4BYQ3nPvLOaYi1rAL5QhTYdqlizz6VC8JcgkwlsXonjRnW
   yMxQlAXqL3Mtyf4g8o7ff710icp0qF0V1SDC95lB69SwYTcBtFe3UCdvi
   w==;
X-CSE-ConnectionGUID: p9W+Iq5IT0igvobfIhlU/w==
X-CSE-MsgGUID: rLuV3UbqROy7Vb9BkqH2Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17856793"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="17856793"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:43:24 -0700
X-CSE-ConnectionGUID: 2xG/r5DpRWiCziBYtdaxkg==
X-CSE-MsgGUID: MnOx9f/RT2Snb6th6BLfYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="49209203"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:43:16 -0700
Message-ID: <d55916c7-a771-4fae-8bc8-595b7b1e9861@intel.com>
Date: Thu, 11 Jul 2024 09:43:10 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] perf auxtrace: Remove dummy tools
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
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240629045350.285243-1-irogers@google.com>
 <20240629045350.285243-2-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240629045350.285243-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/24 07:53, Ian Rogers wrote:
> Add perf_session__deliver_synth_attr_event that synthesizes a
> perf_record_header_attr event with one id. Remove use of
> perf_event__synthesize_attr that necessitates the use of the dummy
> tool in order to pass the session.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/arm-spe.c   | 49 ++++++++-----------------------------
>  tools/perf/util/cs-etm.c    | 33 ++-----------------------
>  tools/perf/util/intel-bts.c | 31 +----------------------
>  tools/perf/util/intel-pt.c  | 24 +-----------------
>  tools/perf/util/session.c   | 30 +++++++++++++++++++++++
>  tools/perf/util/session.h   |  3 +++
>  6 files changed, 47 insertions(+), 123 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index afbd5869f6bf..fa40f3cb6266 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1073,35 +1073,6 @@ static void arm_spe_print_info(__u64 *arr)
>  	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
>  }
>  
> -struct arm_spe_synth {
> -	struct perf_tool dummy_tool;
> -	struct perf_session *session;
> -};
> -
> -static int arm_spe_event_synth(struct perf_tool *tool,
> -			       union perf_event *event,
> -			       struct perf_sample *sample __maybe_unused,
> -			       struct machine *machine __maybe_unused)
> -{
> -	struct arm_spe_synth *arm_spe_synth =
> -		      container_of(tool, struct arm_spe_synth, dummy_tool);
> -
> -	return perf_session__deliver_synth_event(arm_spe_synth->session,
> -						 event, NULL);
> -}
> -
> -static int arm_spe_synth_event(struct perf_session *session,
> -			       struct perf_event_attr *attr, u64 id)
> -{
> -	struct arm_spe_synth arm_spe_synth;
> -
> -	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
> -	arm_spe_synth.session = session;
> -
> -	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
> -					   &id, arm_spe_event_synth);
> -}
> -
>  static void arm_spe_set_event_name(struct evlist *evlist, u64 id,
>  				    const char *name)
>  {
> @@ -1172,7 +1143,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		spe->sample_flc = true;
>  
>  		/* Level 1 data cache miss */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->l1d_miss_id = id;
> @@ -1180,7 +1151,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		id += 1;
>  
>  		/* Level 1 data cache access */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->l1d_access_id = id;
> @@ -1192,7 +1163,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		spe->sample_llc = true;
>  
>  		/* Last level cache miss */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->llc_miss_id = id;
> @@ -1200,7 +1171,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		id += 1;
>  
>  		/* Last level cache access */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->llc_access_id = id;
> @@ -1212,7 +1183,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		spe->sample_tlb = true;
>  
>  		/* TLB miss */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->tlb_miss_id = id;
> @@ -1220,7 +1191,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		id += 1;
>  
>  		/* TLB access */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->tlb_access_id = id;
> @@ -1232,7 +1203,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		spe->sample_branch = true;
>  
>  		/* Branch miss */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->branch_miss_id = id;
> @@ -1244,7 +1215,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		spe->sample_remote_access = true;
>  
>  		/* Remote access */
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->remote_access_id = id;
> @@ -1255,7 +1226,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	if (spe->synth_opts.mem) {
>  		spe->sample_memory = true;
>  
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->memory_id = id;
> @@ -1276,7 +1247,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>  		attr.sample_period = spe->synth_opts.period;
>  		spe->instructions_sample_period = attr.sample_period;
> -		err = arm_spe_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		spe->instructions_id = id;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 32818bd7cd17..c53812f343e9 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1595,35 +1595,6 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	return ret;
>  }
>  
> -struct cs_etm_synth {
> -	struct perf_tool dummy_tool;
> -	struct perf_session *session;
> -};
> -
> -static int cs_etm__event_synth(struct perf_tool *tool,
> -			       union perf_event *event,
> -			       struct perf_sample *sample __maybe_unused,
> -			       struct machine *machine __maybe_unused)
> -{
> -	struct cs_etm_synth *cs_etm_synth =
> -		      container_of(tool, struct cs_etm_synth, dummy_tool);
> -
> -	return perf_session__deliver_synth_event(cs_etm_synth->session,
> -						 event, NULL);
> -}
> -
> -static int cs_etm__synth_event(struct perf_session *session,
> -			       struct perf_event_attr *attr, u64 id)
> -{
> -	struct cs_etm_synth cs_etm_synth;
> -
> -	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
> -	cs_etm_synth.session = session;
> -
> -	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
> -					   &id, cs_etm__event_synth);
> -}
> -
>  static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  				struct perf_session *session)
>  {
> @@ -1675,7 +1646,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  		attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
>  		attr.sample_period = 1;
>  		attr.sample_type |= PERF_SAMPLE_ADDR;
> -		err = cs_etm__synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		etm->branches_sample_type = attr.sample_type;
> @@ -1698,7 +1669,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>  		attr.sample_period = etm->synth_opts.period;
>  		etm->instructions_sample_period = attr.sample_period;
> -		err = cs_etm__synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err)
>  			return err;
>  		etm->instructions_sample_type = attr.sample_type;
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index ec1b3bd9f530..160d346cb450 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -737,35 +737,6 @@ static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
>  	return evsel->core.attr.type == bts->pmu_type;
>  }
>  
> -struct intel_bts_synth {
> -	struct perf_tool dummy_tool;
> -	struct perf_session *session;
> -};
> -
> -static int intel_bts_event_synth(struct perf_tool *tool,
> -				 union perf_event *event,
> -				 struct perf_sample *sample __maybe_unused,
> -				 struct machine *machine __maybe_unused)
> -{
> -	struct intel_bts_synth *intel_bts_synth =
> -			container_of(tool, struct intel_bts_synth, dummy_tool);
> -
> -	return perf_session__deliver_synth_event(intel_bts_synth->session,
> -						 event, NULL);
> -}
> -
> -static int intel_bts_synth_event(struct perf_session *session,
> -				 struct perf_event_attr *attr, u64 id)
> -{
> -	struct intel_bts_synth intel_bts_synth;
> -
> -	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
> -	intel_bts_synth.session = session;
> -
> -	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
> -					   &id, intel_bts_event_synth);
> -}
> -
>  static int intel_bts_synth_events(struct intel_bts *bts,
>  				  struct perf_session *session)
>  {
> @@ -814,7 +785,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
>  		attr.sample_type |= PERF_SAMPLE_ADDR;
>  		pr_debug("Synthesizing 'branches' event with id %" PRIu64 " sample type %#" PRIx64 "\n",
>  			 id, (u64)attr.sample_type);
> -		err = intel_bts_synth_event(session, &attr, id);
> +		err = perf_session__deliver_synth_attr_event(session, &attr, id);
>  		if (err) {
>  			pr_err("%s: failed to synthesize 'branches' event type\n",
>  			       __func__);
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index d6d7b7512505..1fc03bfd14c3 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3659,37 +3659,15 @@ static int intel_pt_queue_data(struct perf_session *session,
>  					   data_offset, timestamp);
>  }
>  
> -struct intel_pt_synth {
> -	struct perf_tool dummy_tool;
> -	struct perf_session *session;
> -};
> -
> -static int intel_pt_event_synth(struct perf_tool *tool,
> -				union perf_event *event,
> -				struct perf_sample *sample __maybe_unused,
> -				struct machine *machine __maybe_unused)
> -{
> -	struct intel_pt_synth *intel_pt_synth =
> -			container_of(tool, struct intel_pt_synth, dummy_tool);
> -
> -	return perf_session__deliver_synth_event(intel_pt_synth->session, event,
> -						 NULL);
> -}
> -
>  static int intel_pt_synth_event(struct perf_session *session, const char *name,
>  				struct perf_event_attr *attr, u64 id)
>  {
> -	struct intel_pt_synth intel_pt_synth;
>  	int err;
>  
>  	pr_debug("Synthesizing '%s' event with id %" PRIu64 " sample type %#" PRIx64 "\n",
>  		 name, id, (u64)attr->sample_type);
>  
> -	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
> -	intel_pt_synth.session = session;
> -
> -	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
> -					  &id, intel_pt_event_synth);
> +	err = perf_session__deliver_synth_attr_event(session, attr, id);
>  	if (err)
>  		pr_err("%s: failed to synthesize '%s' event type\n",
>  		       __func__, name);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0ec92d47373c..44db5b49128f 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1764,6 +1764,36 @@ int perf_session__deliver_synth_event(struct perf_session *session,
>  	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
>  }
>  
> +int perf_session__deliver_synth_attr_event(struct perf_session *session,
> +					   const struct perf_event_attr *attr,
> +					   u64 id)
> +{
> +	union {
> +		struct {
> +			struct perf_record_header_attr attr;
> +			u64 ids[1];
> +		} attr_id;
> +		union perf_event ev;
> +	} ev = {
> +		.attr_id = {
> +			.attr = {
> +				.header = {
> +					.type = PERF_RECORD_HEADER_ATTR,
> +					.size = PERF_ALIGN(sizeof(struct perf_event_attr),
> +							   sizeof(u64))
> +					    + sizeof(struct perf_event_header)
> +					    + sizeof(u64),
> +				},
> +			},
> +			.ids = { id, }
> +		},

Nested definitions are not needed.  It can just be:

		.attr_id.attr.header.type = PERF_RECORD_HEADER_ATTR,
		.attr_id.attr.header.size = sizeof(ev.attr_id),
		.attr_id.ids[0] = id,

> +	};
> +
> +	memcpy(&ev.attr_id.attr.attr, attr, min((u32)sizeof(struct perf_event_attr), attr->size));

It is not unreasonable to validate attr->size, but neither slicing
nor padding will work.  Better to just return an error:

	if (attr->size != sizeof(ev.attr_id.attr))
		return -EINVAL;

Then:

	ev.attr_id.attr.attr = *attr;


> +	ev.attr_id.attr.attr.size = sizeof(struct perf_event_attr);
> +	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
> +}
> +
>  static void event_swap(union perf_event *event, bool sample_id_all)
>  {
>  	perf_event__swap_op swap;
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 4c29dc86956f..cc28976bb00e 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -154,6 +154,9 @@ extern volatile int session_done;
>  int perf_session__deliver_synth_event(struct perf_session *session,
>  				      union perf_event *event,
>  				      struct perf_sample *sample);
> +int perf_session__deliver_synth_attr_event(struct perf_session *session,
> +					   const struct perf_event_attr *attr,
> +					   u64 id);
>  
>  int perf_session__dsos_hit_all(struct perf_session *session);
>  

