Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF91A76DA;
	Wed, 23 Apr 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416597; cv=none; b=E3mkUAhkG53d6vAVItplK5xHeOP1oWbMkvuczNnfLbJbzT1kePG86sBa5+Y4hrE6GrF1cyZcfBrdUZlxpZfERcmzRO0GGMfF71KzUxAPWm7spGC9cMvl2bZ4lPviMt96MbFLlLqvfrLoMzYxANY5zEW68Bt5Bt0yYD58G8HuGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416597; c=relaxed/simple;
	bh=auoAlb7hyUDmuDCP7tSTUj94impkQjqeg8PWz3X6bZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2+8mCkpfFzS8o9v2+PiDpP1a3bEUeZwudtCKNW21xLATlEYwDjUC0udxiRtMrTyrKr03BAewgg6I5Woxt+BPkmN87+oGNRxBGyrvK21qi/ElstzpJyfV0pGUtptnK3IPLZd6/nimgvg2IRipfiLPvORJErNCy4nW7EnhPCayi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOw2jYP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOw2jYP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E13DC4CEE3;
	Wed, 23 Apr 2025 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745416597;
	bh=auoAlb7hyUDmuDCP7tSTUj94impkQjqeg8PWz3X6bZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOw2jYP6JnnyE7JT1A8t4YbBPzzYQtoDfjbpb8ElFbCUpjOifA6LunLn905SjHVLf
	 4lvhHb2aHoMB7E9SBQ047amXeT5Rf+/xOIk5e4HMx/9k8ayAixMFW0PLhdCMsOk5/5
	 89dIuZVu2uPOdlQ99NpSIJ+sGCLrhXyRBB6KFDuLNRqqopvez67dcHyg3dX8ItGMDu
	 EYN7CfWoi4ETm0ULCL67Nt9Qh6wfSHeZpmdm6kCKGDZJ0UkhHyHKCNrCv9t7Du0hYk
	 a/LMiR2ED9zl3IthveSn/gkda5n4pltgmjM5Pc6Mfxcotj4l9tZO3dnVNRL7VU9147
	 iN6uuhIrf0UdA==
Date: Wed, 23 Apr 2025 10:56:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH v5 14/16] perf stat: Add mean, min, max and last
 --tpebs-mode options
Message-ID: <aAjxkfz4rSHe5Eoi@x1>
References: <20250414174134.3095492-1-irogers@google.com>
 <20250414174134.3095492-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414174134.3095492-15-irogers@google.com>

On Mon, Apr 14, 2025 at 10:41:32AM -0700, Ian Rogers wrote:
> Add command line configuration option for how retirement latency
> events are combined. The default "mean" gives the average of
> retirement latency. "min" or "max" give the smallest or largest
> retirment latency times respectively. "last" uses the last retirment
> latency sample's time.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Weilin Wang <weilin.wang@intel.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-stat.txt |  7 +++++++
>  tools/perf/builtin-stat.c              | 27 ++++++++++++++++++++++++++
>  tools/perf/util/intel-tpebs.c          | 20 ++++++++++++++++++-
>  tools/perf/util/intel-tpebs.h          |  8 ++++++++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 2bc063672486..61d091670dee 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -506,6 +506,13 @@ this option is not set. The TPEBS hardware feature starts from Intel Granite
>  Rapids microarchitecture. This option only exists in X86_64 and is meaningful on
>  Intel platforms with TPEBS feature.
>  
> +--tpebs-mode=[mean|min|max|last]::
> +Set how retirement latency events have their sample times
> +combined. The default "mean" gives the average of retirement
> +latency. "min" or "max" give the smallest or largest retirment latency
> +times respectively. "last" uses the last retirment latency sample's
> +time.
> +
>  --td-level::
>  Print the top-down statistics that equal the input level. It allows
>  users to print the interested top-down metrics level instead of the
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 80e491bd775b..4adf2ae53b11 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2327,6 +2327,30 @@ static void setup_system_wide(int forks)
>  	}
>  }
>  
> +static int parse_tpebs_mode(const struct option *opt, const char *str,
> +			    int unset __maybe_unused)
> +{
> +	enum tpebs_mode *mode = opt->value;
> +
> +	if (!strcasecmp("mean", str)) {
> +		*mode = TPEBS_MODE__MEAN;
> +		return 0;
> +	}
> +	if (!strcasecmp("min", str)) {
> +		*mode = TPEBS_MODE__MIN;
> +		return 0;
> +	}
> +	if (!strcasecmp("max", str)) {
> +		*mode = TPEBS_MODE__MAX;
> +		return 0;
> +	}
> +	if (!strcasecmp("last", str)) {
> +		*mode = TPEBS_MODE__LAST;
> +		return 0;
> +	}
> +	return -1;
> +}
> +
>  int cmd_stat(int argc, const char **argv)
>  {
>  	struct opt_aggr_mode opt_mode = {};
> @@ -2431,6 +2455,9 @@ int cmd_stat(int argc, const char **argv)
>  #ifdef HAVE_ARCH_X86_64_SUPPORT
>  		OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
>  			"enable recording for tpebs when retire_latency required"),
> +		OPT_CALLBACK(0, "tpebs-mode", &tpebs_mode, "tpebs-mode",
> +			"Mode of TPEBS recording: mean, min or max",
> +			parse_tpebs_mode),
>  #endif

  20     5.60 debian:experimental-x-mips    : FAIL gcc version 14.2.0 (Debian 14.2.0-1) 
    builtin-stat.c:2330:12: error: 'parse_tpebs_mode' defined but not used [-Werror=unused-function]
     2330 | static int parse_tpebs_mode(const struct option *opt, const char *str,
          |            ^~~~~~~~~~~~~~~~
    --


I'm enclosing parse_tpebs_mode() under #ifdef HAVE_ARCH_X86_64_SUPPORT
to fix this.

- Arnaldo

>  		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
>  			"Set the metrics level for the top-down statistics (0: max level)"),
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index de9fea601964..6b00bd5b0af1 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -31,6 +31,7 @@
>  #define PERF_DATA		"-"
>  
>  bool tpebs_recording;
> +enum tpebs_mode tpebs_mode;
>  static LIST_HEAD(tpebs_results);
>  static pthread_t tpebs_reader_thread;
>  static struct child_process tpebs_cmd;
> @@ -45,6 +46,8 @@ struct tpebs_retire_lat {
>  	char *event;
>  	/** @stats: Recorded retirement latency stats. */
>  	struct stats stats;
> +	/** @last: Last retirement latency read. */
> +	uint64_t last;
>  	/* Has the event been sent to perf record? */
>  	bool started;
>  };
> @@ -142,6 +145,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	 * latency value will be used. Save the number of samples and the sum of
>  	 * retire latency value for each event.
>  	 */
> +	t->last = sample->retire_lat;
>  	update_stats(&t->stats, sample->retire_lat);
>  	mutex_unlock(tpebs_mtx_get());
>  	return 0;
> @@ -517,7 +521,21 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
>  			return ret;
>  		mutex_lock(tpebs_mtx_get());
>  	}
> -	val = rint(t->stats.mean);
> +	switch (tpebs_mode) {
> +	case TPEBS_MODE__MIN:
> +		val = rint(t->stats.min);
> +		break;
> +	case TPEBS_MODE__MAX:
> +		val = rint(t->stats.max);
> +		break;
> +	case TPEBS_MODE__LAST:
> +		val = t->last;
> +		break;
> +	default:
> +	case TPEBS_MODE__MEAN:
> +		val = rint(t->stats.mean);
> +		break;
> +	}
>  	mutex_unlock(tpebs_mtx_get());
>  
>  	if (old_count) {
> diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
> index 218a82866cee..9475e2e6ea74 100644
> --- a/tools/perf/util/intel-tpebs.h
> +++ b/tools/perf/util/intel-tpebs.h
> @@ -8,7 +8,15 @@
>  struct evlist;
>  struct evsel;
>  
> +enum tpebs_mode {
> +	TPEBS_MODE__MEAN,
> +	TPEBS_MODE__MIN,
> +	TPEBS_MODE__MAX,
> +	TPEBS_MODE__LAST,
> +};
> +
>  extern bool tpebs_recording;
> +extern enum tpebs_mode tpebs_mode;
>  
>  int evsel__tpebs_open(struct evsel *evsel);
>  void evsel__tpebs_close(struct evsel *evsel);
> -- 
> 2.49.0.604.gff1f9ca942-goog
