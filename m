Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C31EE032;
	Mon,  7 Apr 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055817; cv=none; b=bfF5SnpWKvb9VLogOtQgSEZmF5mgXQBBrkHSXxcyp8h/vzeRA8wutVPrSNDLRR3OIVT/M72FP+SepKZtRgACu/ZI1ZRXk9kB2sFw0UoIO5MA9gWNNmfKJGma9IdiTWrhXg+vaQXE4tl4UF8lz/p3hQnyvpXobvebHYRp1o1cYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055817; c=relaxed/simple;
	bh=php8EIOk6BYXVsKfscJQr4caE1Nr9sdW4mLkv44J7GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D5BB4tU8nXwLUmTJ4XPBm4wbpcQQ/awr5+30T2XrCy4CayNkj12cMwaaFzWnL8Ey17vo92SVWovFrHZJJM/cTzpQ6SyMebHWf2GhRownP2S0Iu0w5my5MxGGODywE8vao0bBKrANj1J8OwZhiSVDbGFeP2OR7ka14nM5RMwnvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBXwfpbu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBXwfpbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744055815; x=1775591815;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=php8EIOk6BYXVsKfscJQr4caE1Nr9sdW4mLkv44J7GY=;
  b=KBXwfpbuu82wBt105edM62TCzUePNwTJaRWTCPC5BY1Aj7HoPkFtHVME
   F0znwDM4y6o4uLB7Fz2JhtOujgGZT0coYANyIy7GJ64qU1x6v9E/+yjmC
   a9eaMEhj5Hp/N6LipBi7/0OT9126A+GQ45U6/bM4M0TAOngJ7rYB/WLqR
   ipjNwglLLJPgcCeapxBY4rEWRoEWSjAz0e0IixVKXBScpfjmVLzcgzbxg
   wKUaIlx8jNLdxzKlmUQmtyFWz+OBT017piS/1VAcq8UxP2SwM5Xg3X/eH
   rjVeOzJF8WPJAqYmVfATXe8It0Vy+PYtqIcVN4xR/vaB8pQU0yQi+qzLC
   Q==;
X-CSE-ConnectionGUID: NbLoeZW/Sb2IX0z+wj1RBg==
X-CSE-MsgGUID: e0Dvpy+tQ+qQkJtt5vLufA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33069470"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="33069470"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:56:54 -0700
X-CSE-ConnectionGUID: OXjFkQkSRLqJV2fFG/C/fA==
X-CSE-MsgGUID: JzzTMcMtRaS+OWGFkFFEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="128581795"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:56:53 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6AD7920B58A2;
	Mon,  7 Apr 2025 12:56:50 -0700 (PDT)
Message-ID: <8b06ba86-c7a4-45b4-8a51-525ef5e2187a@linux.intel.com>
Date: Mon, 7 Apr 2025 15:56:49 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] perf stat: Add mean, min, max and last
 --tpebs-mode options
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, James Clark <james.clark@linaro.org>,
 Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>,
 Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407050101.1389825-1-irogers@google.com>
 <20250407050101.1389825-15-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250407050101.1389825-15-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> Add command line configuration option for how retirement latency
> events are combined. The default "mean" gives the average of
> retirement latency. "min" or "max" give the smallest or largest
> retirment latency times respectively. "last" uses the last retirment
> latency sample's time.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
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
>  		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
>  			"Set the metrics level for the top-down statistics (0: max level)"),
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index f9584b00fb05..e1bdab4bba6f 100644
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
> +		val = rint(t->stats.mean);

t->stats.min?

> +		break;
> +	case TPEBS_MODE__MAX:
> +		val = rint(t->stats.mean);

t->stats.max?

Thanks,
Kan

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

