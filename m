Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC7EACD;
	Tue,  7 Oct 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827353; cv=none; b=Gixl9jZZVxnke0iZNq+Leqnt6S4ry4WwQdQDpB68SmOhmCe9M0eEeT8J7Fo2E+Tzon4HV8KcEq4Ty7tT//m2IhIO1vVvUgoo6pIA6DYIQbU+Q9MSs1o89lglAVsZa9kyYRgWir0aKx7xBNShNvqssfNKfx6FJBC9nH+NpJxjRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827353; c=relaxed/simple;
	bh=hB0ZyKqjU060+ZaIS56cSgUBFWB+DLMFnHVWx1XZC80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1cUXpVdOmTid6nQExnDaWpGG8x7wlsUyGeHtyOiEhI3e2JBl91I+OxuG2L6GilvZ7yBm1OkjU4G+VFiEriEAJCi8fhiRsTITxz4bPF2R3RuLajIU6vy7XFHybN0/FwwFux+9KrVe4h8pkKBz+taKSAgdN+Vi0SRWEn4Tvfq4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkTW5x8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkTW5x8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1390EC4CEF1;
	Tue,  7 Oct 2025 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759827352;
	bh=hB0ZyKqjU060+ZaIS56cSgUBFWB+DLMFnHVWx1XZC80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkTW5x8/h170WGrQ4PGT3HQQdS7lUYdSFaKg22VxLxwktYndU19z5oJuhATcNp01W
	 /zWG+Q49pfyxl7eB1puBn94tAZ+YbW4+2e66g2xOSRgYYYZWvufXtB01G8t1MVWw1s
	 PWBF3T+TtFxdqe/TMqQQG8AaP7UzR+gCM+ERm43kG2MjyJ6QimU9nUv8r9o6hmZ9gx
	 GkoYlzi70AeuIleUMm6F2Dyqmm4iuzpgrL7BLD3znHvGuzmhAPTfHW2twxf3jQDTEs
	 PSljeiNNvvR8VY1BL1lZZdkQuX2OeRMB4nJI4z+iapWVPPPkbNK+j145cTpxkGg2R2
	 chvQJS3K88h9Q==
Date: Tue, 7 Oct 2025 17:55:47 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: thomas.falcon@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v3 1/2] perf record: Add ratio-to-prev term
Message-ID: <aOTVkxY09-Uillf6@google.com>
References: <20251002234308.64218-1-thomas.falcon@intel.com>
 <20251002234308.64218-2-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251002234308.64218-2-thomas.falcon@intel.com>

On Thu, Oct 02, 2025 at 06:43:05PM -0500, thomas.falcon@intel.com wrote:
> From: Thomas Falcon <thomas.falcon@intel.com>
> 
> Provide ratio-to-prev term which allows the user to
> set the event sample period of two events corresponding
> to a desired ratio. If using on an Intel x86 platform with
> Auto Counter Reload support, also set corresponding event's
> config2 attribute with a bitmask which counters to reset and
> which counters to sample if the desired ratio is met or exceeded.
> On other platforms, only the sample period is affected by the
> ratio-to-prev term.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
>  tools/perf/Documentation/perf-list.txt |  2 +
>  tools/perf/arch/x86/util/evsel.c       | 52 ++++++++++++++++++
>  tools/perf/util/evsel.c                | 76 ++++++++++++++++++++++++++
>  tools/perf/util/evsel.h                |  1 +
>  tools/perf/util/evsel_config.h         |  1 +
>  tools/perf/util/parse-events.c         | 22 ++++++++
>  tools/perf/util/parse-events.h         |  3 +-
>  tools/perf/util/parse-events.l         |  1 +
>  tools/perf/util/pmu.c                  |  3 +-
>  10 files changed, 212 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/Documentation/intel-acr.txt
> 
> diff --git a/tools/perf/Documentation/intel-acr.txt b/tools/perf/Documentation/intel-acr.txt
> new file mode 100644
> index 000000000000..72654fdd9a52
> --- /dev/null
> +++ b/tools/perf/Documentation/intel-acr.txt
> @@ -0,0 +1,53 @@
> +Intel Auto Counter Reload Support
> +---------------------------------
> +Support for Intel Auto Counter Reload in perf tools
> +
> +Auto counter reload provides a means for software to specify to hardware
> +that certain counters, if supported, should be automatically reloaded
> +upon overflow of chosen counters. By taking a sample only if the rate of
> +one event exceeds some threshold relative to the rate of another event,
> +this feature enables software to sample based on the relative rate of
> +two or more events. To enable this, the user must provide a sample period
> +term and a bitmask ("acr_mask") for each relevant event specifying the
> +counters in an event group to reload if the event's specified sample
> +period is exceeded.

Thanks for the documentation, now I got the idea what it tries to do.
So acr_mask and ratio-to-prev are only allowed in a group..

> +
> +For example, if the user desires to measure a scenario when IPC > 2,
> +the event group might look like the one below:
> +
> +	perf record -e {cpu_atom/instructions,period=200000,acr_mask=0x2/, \
> +	cpu_atom/cycles,period=100000,acr_mask=0x3/} -- true
> +
> +In this case, if the "instructions" counter exceeds the sample period of
> +200000, the second counter, "cycles", will be reset and a sample will be
> +taken. If "cycles" is exceeded first, both counters in the group will be
> +reset. In this way, samples will only be taken for cases where IPC > 2.
> +
> +The acr_mask term is a hexadecimal value representing a bitmask of the
> +events in the group to be reset when the period is exceeded. In the
> +example above, "instructions" is assigned an acr_mask of 0x2, meaning
> +only the second event in the group is reloaded and a sample is taken
> +for the first event. "cycles" is assigned an acr_mask of 0x3, meaning
> +that both event counters will be reset if the sample period is exceeded
> +first.

IIUC bit of 1 means auto-reload without samples and 0 means to take a
sample (as normal), right?  And index is meaningful in a group and not
related to hardware, correct?


> +
> +ratio-to-prev Event Term
> +------------------------
> +To simplify this, an event term "ratio-to-prev" is provided which is used
> +alongside the sample period term n or the -c/--count option. This would
> +allow users to specify the desired relative rate between events as a
> +ratio. Note: Both events compared must belong to the same PMU.
> +
> +The command above would then become
> +
> +	perf record -e {cpu_atom/instructions/, \
> +	cpu_atom/cycles,period=100000,ratio-to-prev=0.5/} -- true
> +
> +ratio-to-prev is the ratio of the event using the term relative
> +to the previous event in the group, which will always be 1,
> +for a 1:0.5 or 2:1 ratio.

What about acr_mask?

> +
> +To sample for IPC < 2 for example, the events need to be reordered:
> +
> +	perf record -e {cpu_atom/cycles/, \
> +	cpu_atom/instructions,period=200000,ratio-to-prev=2.0/} -- true
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index a5039d1614f9..a4378a0cd914 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -393,6 +393,8 @@ Support raw format:
>  . '--raw-dump [hw|sw|cache|tracepoint|pmu|event_glob]', shows the raw-dump of
>    a certain kind of events.
>  
> +include::intel-acr.txt[]
> +
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-top[1],
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index e67701d26f24..23a8e662a912 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -4,6 +4,7 @@
>  #include <stdlib.h>
>  #include "util/evlist.h"
>  #include "util/evsel.h"
> +#include "util/evsel_config.h"
>  #include "util/env.h"
>  #include "util/pmu.h"
>  #include "util/pmus.h"
> @@ -71,6 +72,57 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
>  			 event_name);
>  }
>  
> +void arch_evsel__apply_ratio_to_prev(struct evsel *evsel,
> +				struct perf_event_attr *attr)
> +{
> +	struct perf_event_attr *prev_attr = NULL;
> +	struct evsel *evsel_prev = NULL;
> +	const char *name = "acr_mask";
> +	int evsel_idx = 0;
> +	__u64 ev_mask, pr_ev_mask;
> +
> +	if (!perf_pmu__has_format(evsel->pmu, name)) {
> +		pr_err("'%s' does not have acr_mask format support\n", evsel->pmu->name);
> +		return;
> +	}
> +	if (perf_pmu__format_type(evsel->pmu, name) !=
> +			PERF_PMU_FORMAT_VALUE_CONFIG2) {
> +		pr_err("'%s' does not have config2 format support\n", evsel->pmu->name);
> +		return;
> +	}
> +
> +	evsel_prev = evsel__prev(evsel);
> +	if (!evsel_prev) {
> +		pr_err("Previous event does not exist.\n");
> +		return;
> +	}
> +
> +	prev_attr = &evsel_prev->core.attr;
> +
> +	if (prev_attr->config2) {
> +		pr_err("'%s' has set config2 (acr_mask?) already, configuration not supported\n", evsel_prev->name);

This line is too long.

Also I'm afraid this only works for two events in a group.

Thanks,
Namhyung


> +		return;
> +	}
> +
> +	/*
> +	 * acr_mask (config2) is calculated using the event's index in
> +	 * the event group. The first event will use the index of the
> +	 * second event as its mask (e.g., 0x2), indicating that the
> +	 * second event counter will be reset and a sample taken for
> +	 * the first event if its counter overflows. The second event
> +	 * will use the mask consisting of the first and second bits
> +	 * (e.g., 0x3), meaning both counters will be reset if the
> +	 * second event counter overflows.
> +	 */
> +
> +	evsel_idx = evsel__group_idx(evsel);
> +	ev_mask = 1ull << evsel_idx;
> +	pr_ev_mask = 1ull << (evsel_idx - 1);
> +
> +	prev_attr->config2 = ev_mask;
> +	attr->config2 = ev_mask | pr_ev_mask;
> +}
> +
>  static void ibs_l3miss_warn(void)
>  {
>  	pr_warning(
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1a29d4f47bbf..56cef1310574 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1091,6 +1091,71 @@ static void evsel__reset_callgraph(struct evsel *evsel, struct callchain_param *
>  	}
>  }
>  
> +static void evsel__apply_ratio_to_prev(struct evsel *evsel,
> +				       struct perf_event_attr *attr,
> +				       struct record_opts *opts,
> +				       const char *buf)
> +{
> +	struct perf_event_attr *prev_attr = NULL;
> +	struct evsel *evsel_prev = NULL;
> +	u64 type = evsel->core.attr.sample_type;
> +	u64 prev_type = 0;
> +	double rtp;
> +
> +	rtp = strtod(buf, NULL);
> +	if (rtp <= 0) {
> +		pr_err("Invalid ratio-to-prev value %lf\n", rtp);
> +		return;
> +	}
> +	if (evsel == evsel__leader(evsel)) {
> +		pr_err("Invalid use of ratio-to-prev term without preceding element in group\n");
> +		return;
> +	}
> +	if (!evsel->pmu->is_core) {
> +		pr_err("Event using ratio-to-prev term must have a core PMU\n");
> +		return;
> +	}
> +
> +	evsel_prev = evsel__prev(evsel);
> +	if (!evsel_prev) {
> +		pr_err("Previous event does not exist.\n");
> +		return;
> +	}
> +
> +	if (evsel_prev->pmu->type != evsel->pmu->type) {
> +		pr_err("Compared events (\"%s\", \"%s\") must have same PMU\n",
> +			evsel->name, evsel_prev->name);
> +		return;
> +	}
> +
> +	prev_attr = &evsel_prev->core.attr;
> +	prev_type = evsel_prev->core.attr.sample_type;
> +
> +	if (!(prev_type & PERF_SAMPLE_PERIOD)) {
> +		attr->sample_period = prev_attr->sample_period * rtp;
> +		attr->freq = 0;
> +		evsel__reset_sample_bit(evsel, PERIOD);
> +	} else if (!(type & PERF_SAMPLE_PERIOD)) {
> +		prev_attr->sample_period = attr->sample_period / rtp;
> +		prev_attr->freq = 0;
> +		evsel__reset_sample_bit(evsel_prev, PERIOD);
> +	} else {
> +		if (opts->user_interval != ULLONG_MAX) {
> +			prev_attr->sample_period = opts->user_interval;
> +			attr->sample_period = prev_attr->sample_period * rtp;
> +			prev_attr->freq = 0;
> +			attr->freq = 0;
> +			evsel__reset_sample_bit(evsel_prev, PERIOD);
> +			evsel__reset_sample_bit(evsel, PERIOD);
> +		} else {
> +			pr_err("Event period term or count (-c) must be set when using ratio-to-prev term.\n");
> +			return;
> +		}
> +	}
> +
> +	arch_evsel__apply_ratio_to_prev(evsel, attr);
> +}
> +
>  static void evsel__apply_config_terms(struct evsel *evsel,
>  				      struct record_opts *opts, bool track)
>  {
> @@ -1104,6 +1169,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
>  	u32 dump_size = 0;
>  	int max_stack = 0;
>  	const char *callgraph_buf = NULL;
> +	const char *rtp_buf = NULL;
>  
>  	list_for_each_entry(term, config_terms, list) {
>  		switch (term->type) {
> @@ -1174,6 +1240,9 @@ static void evsel__apply_config_terms(struct evsel *evsel,
>  			break;
>  		case EVSEL__CONFIG_TERM_CFG_CHG:
>  			break;
> +		case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> +			rtp_buf = term->val.str;
> +			break;
>  		default:
>  			break;
>  		}
> @@ -1225,6 +1294,8 @@ static void evsel__apply_config_terms(struct evsel *evsel,
>  			evsel__config_callchain(evsel, opts, &param);
>  		}
>  	}
> +	if (rtp_buf)
> +		evsel__apply_ratio_to_prev(evsel, attr, opts, rtp_buf);
>  }
>  
>  struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evsel_term_type type)
> @@ -1249,6 +1320,11 @@ void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
>  {
>  }
>  
> +void __weak arch_evsel__apply_ratio_to_prev(struct evsel *evsel __maybe_unused,
> +					    struct perf_event_attr *attr __maybe_unused)
> +{
> +}
> +
>  static void evsel__set_default_freq_period(struct record_opts *opts,
>  					   struct perf_event_attr *attr)
>  {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 03f9f22e3a0c..521d280c4abe 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -343,6 +343,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
>  void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
>  int arch_evsel__open_strerror(struct evsel *evsel, int err, char *msg, size_t size);
> +void arch_evsel__apply_ratio_to_prev(struct evsel *evsel, struct perf_event_attr *attr);
>  
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index 94a1e9cf73d6..bcd3a978f0c4 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -28,6 +28,7 @@ enum evsel_term_type {
>  	EVSEL__CONFIG_TERM_AUX_ACTION,
>  	EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
>  	EVSEL__CONFIG_TERM_CFG_CHG,
> +	EVSEL__CONFIG_TERM_RATIO_TO_PREV,
>  };
>  
>  struct evsel_config_term {
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 452f12191f6e..da73d686f6b9 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -842,6 +842,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
>  		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
>  		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
>  		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
> +		[PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         = "ratio-to-prev",
>  	};
>  	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
>  		return "unknown term";
> @@ -892,6 +893,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
>  	case PARSE_EVENTS__TERM_TYPE_RAW:
>  	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>  	default:
>  		if (!err)
>  			return false;
> @@ -1045,6 +1047,21 @@ do {											\
>  		perf_cpu_map__put(map);
>  		break;
>  	}
> +	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> +		CHECK_TYPE_VAL(STR);
> +		if (strtod(term->val.str, NULL) <= 0) {
> +			parse_events_error__handle(parse_state->error, term->err_val,
> +						   strdup("zero or negative"),
> +						   NULL);
> +			return -EINVAL;
> +		}
> +		if (errno == ERANGE) {
> +			parse_events_error__handle(parse_state->error, term->err_val,
> +						   strdup("too big"),
> +						   NULL);
> +			return -EINVAL;
> +		}
> +		break;
>  	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>  	case PARSE_EVENTS__TERM_TYPE_USER:
>  	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> @@ -1173,6 +1190,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
>  	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
>  	case PARSE_EVENTS__TERM_TYPE_CPU:
> +	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>  	default:
>  		parse_events_error__handle(parse_state->error, term->err_term,
>  					strdup(parse_events__term_type_str(term->type_term)),
> @@ -1295,6 +1313,9 @@ do {								\
>  			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
>  					    term->val.num, term->weak);
>  			break;
> +		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> +			ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str, term->weak);
> +			break;
>  		case PARSE_EVENTS__TERM_TYPE_USER:
>  		case PARSE_EVENTS__TERM_TYPE_CONFIG:
>  		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
> @@ -1361,6 +1382,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
>  		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
>  		case PARSE_EVENTS__TERM_TYPE_CPU:
> +		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>  		default:
>  			break;
>  		}
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index a5c5fc39fd6f..8f8c8e7fbcf1 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -83,7 +83,8 @@ enum parse_events__term_type {
>  	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
>  	PARSE_EVENTS__TERM_TYPE_HARDWARE,
>  	PARSE_EVENTS__TERM_TYPE_CPU,
> -#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
> +	PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
> +#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV + 1)
>  };
>  
>  struct parse_events_term {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 294e943bcdb4..c985aa8a7d56 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -337,6 +337,7 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
>  aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
>  cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
> +ratio-to-prev		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV); }
>  cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
>  stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>  stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 5a291f1380ed..3d1f975e8db9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1541,7 +1541,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
>  			return -EINVAL;
> -		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
> +		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>  			/* Skip non-config terms. */
>  			break;
>  		default:
> @@ -1930,6 +1930,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
>  		"aux-action=(pause|resume|start-paused)",
>  		"aux-sample-size=number",
>  		"cpu=number",
> +		"ratio-to-prev=string",
>  	};
>  	struct perf_pmu_format *format;
>  	int ret;
> -- 
> 2.50.1
> 
