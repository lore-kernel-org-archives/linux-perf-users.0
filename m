Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5F23BE;
	Mon, 30 Sep 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679096; cv=none; b=tmh7wTqULYRZgRp13sX4KqP9i1Sx9squYM6f7T839QgB8vThz9RtCZIptR21Z4aKDj6563uXtwOBks5bzlUHzzyu666NxXq4zvXnGiQjy01Cf8ndUi4XLF8QHUuMO8kJ9/JBz9SCnkfIg09qcdx2MnqFavbTgLcZleQ6aFGrif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679096; c=relaxed/simple;
	bh=yfMk8PBDC7C+uQXb/zeM0yaQzGPLDxEAMH0A/10Ar4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV3VkPLELGZ9cG14BLvCzsiFNiRwYPMwy+mMyHFmIP9hOXew6Bs3t70T4BHE7ZlBB/4kmofX+GblCuxgVGebwtq4YCeZ/kQ/x1dMNZPadV/VT5W58eI2thEYG5Vgkw97WkR9IBO77uFPRSorAVjcSqv90u0fMi9FCHu9GH+KeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX1m3ZrM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX1m3ZrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E172FC4CEC7;
	Mon, 30 Sep 2024 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727679095;
	bh=yfMk8PBDC7C+uQXb/zeM0yaQzGPLDxEAMH0A/10Ar4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MX1m3ZrMYsifdSaKXGYKSkF5CSNS0vDTa9w3LUqdLD5VvwbjfZBlcC09lB2wHnozS
	 Kf9c5hjrMikDma3iSJ++qP3umIDJKNI3BaIJJmckMs9e9DFw1l1Rmml2DpN5Mla7bV
	 RaqX5cew/wjPBCEyQXNtA3NXj/M5tGWiSAnNw3hzGZeRmUxPLXUJUTd+Lk0YVTVaxl
	 zyEKubqOMV1QzsRA4BBLzlxEQ3ns2mBLG+hbQZGmnDd1z3WuuO5DG4HT6DK/zbIhdS
	 FKkNeOZ9EDEZ2S2Hkm/+AwAytnDjxjVMXZlPnHdxN+KwQB8LsmMqVL+1Ui5d1sGjOV
	 oTFTgf/IxkU6w==
Date: Sun, 29 Sep 2024 23:51:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/8] perf record --off-cpu: Parse BPF output embedded
 data
Message-ID: <ZvpKdWjGqP87-3ng@google.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
 <20240927202736.767941-8-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927202736.767941-8-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 01:27:35PM -0700, Howard Chu wrote:
> Move evsel__is_offcpu_event() to evsel.h
> 
> Add a sample_type_embed member to the struct evsel, along with a couple
> of helper functions.
> 
> In session.c, we parse BPF output embedded samples in a two-step
> process.
> 
> Initial Parsing: Treat the sample as a regular BPF-output event.
> 
> Secondary Parsing: Extract data from raw_data and parse it according to
> the sample_type_embed specification. Since the second step relies on the
> raw_data obtained in the first step, we must avoid zero-initializing the
> sample data after the first step.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-script.c |  4 ++--
>  tools/perf/util/evsel.c     | 39 +++++++++++++++++++++++--------------
>  tools/perf/util/evsel.h     |  6 ++++++
>  tools/perf/util/session.c   | 12 +++++++++++-
>  4 files changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index a644787fa9e1..9719ffae45d5 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  
>  		evlist__for_each_entry(session->evlist, evsel) {
>  			not_pipe = true;
> -			if (evsel__has_callchain(evsel)) {
> +			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
>  				use_callchain = true;
>  				break;
>  			}
> @@ -2352,7 +2352,7 @@ static void process_event(struct perf_script *script,
>  	else if (PRINT_FIELD(BRSTACKOFF))
>  		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
>  
> -	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
> +	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
>  		perf_sample__fprintf_bpf_output(sample, fp);
>  	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 32196e4f0637..4199a1e409f7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1105,11 +1105,6 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
>  	}
>  }
>  
> -static bool evsel__is_offcpu_event(struct evsel *evsel)
> -{
> -	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
> -}
> -
>  /*
>   * The enable_on_exec/disabled value strategy:
>   *
> @@ -2677,6 +2672,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	u16 max_size = event->header.size;
>  	const void *endp = (void *)event + max_size;
>  	u64 sz;
> +	bool ip_in_callchain = false;
>  
>  	/*
>  	 * used for cross-endian analysis. See git commit 65014ab3
> @@ -2684,14 +2680,25 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	 */
>  	union u64_swap u;
>  
> -	memset(data, 0, sizeof(*data));
> -	data->cpu = data->pid = data->tid = -1;
> -	data->stream_id = data->id = data->time = -1ULL;
> -	data->period = evsel->core.attr.sample_period;
> -	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> -	data->misc    = event->header.misc;
> -	data->data_src = PERF_MEM_DATA_SRC_NONE;
> -	data->vcpu = -1;
> +	/*
> +	 * For sample data embedded in BPF output, don't clear the sample we read in the first pass,
> +	 * and read the embedded data from raw_data in the second pass.
> +	 */

I found this two-pass sample parsing is confusing.  I think you can just
use the existing parsing code and only update relevant fields when you
parse the raw data.  IIUC the only subtle part is CGROUP as it come
later than RAW in the sample format.  Maybe you can save it somewhere
and update at the end.

Thanks,
Namhyung


> +	if (evsel__is_offcpu_event(evsel) && data->raw_data) {
> +		type = OFFCPU_EMBEDDED_SAMPLE_TYPES;
> +		array = data->raw_data;
> +		ip_in_callchain = true;
> +	} else { /* for normal samples, clear to zero before reading */
> +		array = event->sample.array;
> +		memset(data, 0, sizeof(*data));
> +		data->cpu = data->pid = data->tid = -1;
> +		data->stream_id = data->id = data->time = -1ULL;
> +		data->period = evsel->core.attr.sample_period;
> +		data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> +		data->misc    = event->header.misc;
> +		data->data_src = PERF_MEM_DATA_SRC_NONE;
> +		data->vcpu = -1;
> +	}
>  
>  	if (event->header.type != PERF_RECORD_SAMPLE) {
>  		if (!evsel->core.attr.sample_id_all)
> @@ -2699,8 +2706,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		return perf_evsel__parse_id_sample(evsel, event, data);
>  	}
>  
> -	array = event->sample.array;
> -
>  	if (perf_event__check_size(event, evsel->sample_size))
>  		return -EFAULT;
>  
> @@ -2822,6 +2827,10 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		data->callchain = (struct ip_callchain *)array++;
>  		if (data->callchain->nr > max_callchain_nr)
>  			return -EFAULT;
> +
> +		if (ip_in_callchain && data->callchain->nr > 1)
> +			data->ip = data->callchain->ips[1];
> +
>  		sz = data->callchain->nr * sizeof(u64);
>  		OVERFLOW_CHECK(array, sz, max_size);
>  		array = (void *)array + sz;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3e751ea769ac..6fbf5d4219d1 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -11,6 +11,7 @@
>  #include <perf/evsel.h>
>  #include "symbol_conf.h"
>  #include "pmus.h"
> +#include "off_cpu.h"
>  
>  struct bpf_object;
>  struct cgroup;
> @@ -580,4 +581,9 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
>  void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>  				const char *config_name, u64 val);
>  
> +static inline bool evsel__is_offcpu_event(struct evsel *evsel)
> +{
> +	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
> +}
> +
>  #endif /* __PERF_EVSEL_H */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index dbaf07bf6c5f..d481bc466131 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1229,6 +1229,16 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
>  	u64 sample_type = evsel->core.attr.sample_type;
>  	u64 read_format = evsel->core.attr.read_format;
>  
> +	/* parse sample the second time to get embedded data from raw_data */
> +	if (evsel__is_offcpu_event(evsel) && sample->raw_data) {
> +		int err = evsel__parse_sample(evsel, event, sample);
> +
> +		if (err) {
> +			pr_err("Failed to parse BPF ouput embedded data, err = %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	/* Standard sample delivery. */
>  	if (!(sample_type & PERF_SAMPLE_READ))
>  		return tool->sample(tool, event, sample, evsel, machine);
> @@ -1339,7 +1349,7 @@ static int perf_session__deliver_event(struct perf_session *session,
>  				       u64 file_offset,
>  				       const char *file_path)
>  {
> -	struct perf_sample sample;
> +	struct perf_sample sample = { .raw_data = NULL }; /* avoid accidental read of embedded data */
>  	int ret = evlist__parse_sample(session->evlist, event, &sample);
>  
>  	if (ret) {
> -- 
> 2.43.0
> 
