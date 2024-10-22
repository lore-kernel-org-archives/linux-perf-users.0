Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75128370;
	Tue, 22 Oct 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576558; cv=none; b=k6ALsz5PcAxYFQrJdXhXTpfCT07yumvtV59ssp5F1pYlg+MLNZNazpwm2Pz+IF0PV5AL05gTcYsPCSMpGvUp69xuniynmdStfOfSNxOZNT0ef1YoYlY6jeoIKoS7+mRegqHBIStShrxfL9lZk6Y72s77viyqzdgtRkrcGht1kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576558; c=relaxed/simple;
	bh=UoxLF1eIVDaRn+C3P85KUXBa3dHyYo8hW3sgoyrvTe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJnWPL7MGiX9f20SxtTEvmLVqKrreGKElWDeKsLUZUQucXp2/BbnWGJtmCWQ3h2FVRE+09UCPet99FkAheVZ6lRX+cq+WkPsDcde+zTZAZLsZuWzf7Gdm/eqKbZrmpH7DV9BOdFEik0WMcYasgPAIOVUAB26N20MhRebFlCeeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQDzxAE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQDzxAE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9D1C4CEC3;
	Tue, 22 Oct 2024 05:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729576558;
	bh=UoxLF1eIVDaRn+C3P85KUXBa3dHyYo8hW3sgoyrvTe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQDzxAE8ciaWwQuwRUXzshTY+eXTIZaeCd/mhg0bGtyLnUpwgqYAGlSPBMPjyxwum
	 rkoqFNY2pU2ILm8yWlPNKr93M7hY8wgHq/WETEWvXD41Je2hLO02Oe0E52SJgJxy6h
	 KPD/DPEoswKkgpBAr179lu+b0Zf/fYJTwvocNJ/P8Q19oDCXP3388if4ErY0n6XTP3
	 7MZIWc2Qccc2R5Dc7nr4HInJUiGlfOivwSy0hflDLC5N+gWd/0X4tPnzCU5tkEvDbe
	 YD3WaNLMVtN+vpHAWOJitzF1rV2zC08+R0ZsztZqdu7pKlEbLosqeGVAdIl9PFUpNp
	 +A8rw2sV54YpQ==
Date: Mon, 21 Oct 2024 22:55:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 07/16] perf stat: Move stat_config into config.c
Message-ID: <Zxc-bFLNAh7nrVQC@google.com>
References: <20241016042415.7552-1-irogers@google.com>
 <20241016042415.7552-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016042415.7552-8-irogers@google.com>

On Tue, Oct 15, 2024 at 09:24:06PM -0700, Ian Rogers wrote:
> stat_config is accessed by config.c via helper functions, but declared
> in builtin-stat. Move to util/config.c so that stub functions aren't
> needed in python.c which doesn't link against the builtin files.
> 
> To avoid name conflicts change builtin-script to use the same
> stat_config as builtin-stat. Rename local variables in tests to avoid
> shadow declaration warnings.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c |  1 -
>  tools/perf/builtin-stat.c   | 27 ---------------------------
>  tools/perf/tests/stat.c     | 16 +++++++++-------
>  tools/perf/util/config.c    | 27 +++++++++++++++++++++++++++
>  tools/perf/util/path.c      | 10 ++++++++++
>  tools/perf/util/path.h      |  1 +
>  tools/perf/util/python.c    |  9 ---------
>  tools/perf/util/stat.h      |  3 ++-
>  8 files changed, 49 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 27b2fb08ad67..1ce7b71f1f46 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -85,7 +85,6 @@ static bool			system_wide;
>  static bool			print_flags;
>  static const char		*cpu_list;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> -static struct perf_stat_config	stat_config;
>  static int			max_blocks;
>  static bool			native_arch;
>  static struct dlfilter		*dlfilter;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b5e18853982c..7c7424824b0e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -112,8 +112,6 @@ static struct target target = {
>  	.uid	= UINT_MAX,
>  };
>  
> -#define METRIC_ONLY_LEN 20
> -
>  static volatile sig_atomic_t	child_pid			= -1;
>  static int			detailed_run			=  0;
>  static bool			transaction_run;
> @@ -151,21 +149,6 @@ static struct perf_stat		perf_stat;
>  
>  static volatile sig_atomic_t done = 0;
>  
> -static struct perf_stat_config stat_config = {
> -	.aggr_mode		= AGGR_GLOBAL,
> -	.aggr_level		= MAX_CACHE_LVL + 1,
> -	.scale			= true,
> -	.unit_width		= 4, /* strlen("unit") */
> -	.run_count		= 1,
> -	.metric_only_len	= METRIC_ONLY_LEN,
> -	.walltime_nsecs_stats	= &walltime_nsecs_stats,
> -	.ru_stats		= &ru_stats,
> -	.big_num		= true,
> -	.ctl_fd			= -1,
> -	.ctl_fd_ack		= -1,
> -	.iostat_run		= false,
> -};
> -
>  /* Options set from the command line. */
>  struct opt_aggr_mode {
>  	bool node, socket, die, cluster, cache, core, thread, no_aggr;
> @@ -1059,16 +1042,6 @@ static void sig_atexit(void)
>  	kill(getpid(), signr);
>  }
>  
> -void perf_stat__set_big_num(int set)
> -{
> -	stat_config.big_num = (set != 0);
> -}
> -
> -void perf_stat__set_no_csv_summary(int set)
> -{
> -	stat_config.no_csv_summary = (set != 0);
> -}
> -
>  static int stat__set_big_num(const struct option *opt __maybe_unused,
>  			     const char *s __maybe_unused, int unset)
>  {
> diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
> index 6468cc0d0204..d60983657bad 100644
> --- a/tools/perf/tests/stat.c
> +++ b/tools/perf/tests/stat.c
> @@ -27,7 +27,7 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
>  				     struct machine *machine __maybe_unused)
>  {
>  	struct perf_record_stat_config *config = &event->stat_config;
> -	struct perf_stat_config stat_config = {};
> +	struct perf_stat_config test_stat_config = {};
>  
>  #define HAS(term, val) \
>  	has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
> @@ -39,25 +39,27 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
>  
>  #undef HAS
>  
> -	perf_event__read_stat_config(&stat_config, config);
> +	perf_event__read_stat_config(&test_stat_config, config);
>  
> -	TEST_ASSERT_VAL("wrong aggr_mode", stat_config.aggr_mode == AGGR_CORE);
> -	TEST_ASSERT_VAL("wrong scale",     stat_config.scale == 1);
> -	TEST_ASSERT_VAL("wrong interval",  stat_config.interval == 1);
> +	TEST_ASSERT_VAL("wrong aggr_mode", test_stat_config.aggr_mode == AGGR_CORE);
> +	TEST_ASSERT_VAL("wrong scale",     test_stat_config.scale == 1);
> +	TEST_ASSERT_VAL("wrong interval",  test_stat_config.interval == 1);
>  	return 0;
>  }
>  
>  static int test__synthesize_stat_config(struct test_suite *test __maybe_unused,
>  					int subtest __maybe_unused)
>  {
> -	struct perf_stat_config stat_config = {
> +	struct perf_stat_config test_stat_config = {
>  		.aggr_mode	= AGGR_CORE,
>  		.scale		= 1,
>  		.interval	= 1,
>  	};
>  
>  	TEST_ASSERT_VAL("failed to synthesize stat_config",
> -		!perf_event__synthesize_stat_config(NULL, &stat_config, process_stat_config_event, NULL));
> +		!perf_event__synthesize_stat_config(NULL, &test_stat_config,
> +						    process_stat_config_event,
> +						    NULL));
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 68f9407ca74b..2d07c9257a1a 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -13,6 +13,7 @@
>  #include <sys/param.h>
>  #include "cache.h"
>  #include "callchain.h"
> +#include "header.h"
>  #include <subcmd/exec-cmd.h>
>  #include "util/event.h"  /* proc_map_timeout */
>  #include "util/hist.h"  /* perf_hist_config */
> @@ -34,6 +35,22 @@
>  
>  #define DEBUG_CACHE_DIR ".debug"
>  
> +#define METRIC_ONLY_LEN 20
> +
> +struct perf_stat_config stat_config = {
> +	.aggr_mode		= AGGR_GLOBAL,
> +	.aggr_level		= MAX_CACHE_LVL + 1,
> +	.scale			= true,
> +	.unit_width		= 4, /* strlen("unit") */
> +	.run_count		= 1,
> +	.metric_only_len	= METRIC_ONLY_LEN,
> +	.walltime_nsecs_stats	= &walltime_nsecs_stats,
> +	.ru_stats		= &ru_stats,
> +	.big_num		= true,
> +	.ctl_fd			= -1,
> +	.ctl_fd_ack		= -1,
> +	.iostat_run		= false,
> +};
>  
>  char buildid_dir[MAXPATHLEN]; /* root dir for buildid, binary cache */
>  
> @@ -455,6 +472,16 @@ static int perf_ui_config(const char *var, const char *value)
>  	return 0;
>  }
>  
> +void perf_stat__set_big_num(int set)
> +{
> +	stat_config.big_num = (set != 0);
> +}
> +
> +static void perf_stat__set_no_csv_summary(int set)
> +{
> +	stat_config.no_csv_summary = (set != 0);
> +}
> +
>  static int perf_stat_config(const char *var, const char *value)
>  {
>  	if (!strcmp(var, "stat.big-num"))
> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> index 00adf872bf00..9712466c51e2 100644
> --- a/tools/perf/util/path.c
> +++ b/tools/perf/util/path.c
> @@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struct dirent *dent)
>  	return S_ISDIR(st.st_mode);
>  }
>  
> +bool is_directory_at(int dir_fd, const char *path)
> +{
> +	struct stat st;
> +
> +	if (fstatat(dir_fd, path, &st, /*flags=*/0))
> +		return false;
> +
> +	return S_ISDIR(st.st_mode);
> +}
> +

It looks like an unrelated change.

Thanks,
Namhyung


>  bool is_executable_file(const char *base_path, const struct dirent *dent)
>  {
>  	char path[PATH_MAX];
> diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
> index d94902c22222..fbafbe7015dd 100644
> --- a/tools/perf/util/path.h
> +++ b/tools/perf/util/path.h
> @@ -12,6 +12,7 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
>  
>  bool is_regular_file(const char *file);
>  bool is_directory(const char *base_path, const struct dirent *dent);
> +bool is_directory_at(int dir_fd, const char *path);
>  bool is_executable_file(const char *base_path, const struct dirent *dent);
>  
>  #endif /* _PERF_PATH_H */
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 5f11ae88943d..0fa8e27769be 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -17,7 +17,6 @@
>  #include "trace-event.h"
>  #include "mmap.h"
>  #include "util/env.h"
> -#include "util/kvm-stat.h"
>  #include "util/kwork.h"
>  #include "util/sample.h"
>  #include "util/lock-contention.h"
> @@ -1306,14 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
>  /* The following are stubs to avoid dragging in builtin-* objects. */
>  /* TODO: move the code out of the builtin-* file into util. */
>  
> -void perf_stat__set_no_csv_summary(int set __maybe_unused)
> -{
> -}
> -
> -void perf_stat__set_big_num(int set __maybe_unused)
> -{
> -}
> -
>  int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
>  {
>  	return -1;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index fd7a187551bd..78ddc14507b7 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -117,8 +117,9 @@ struct perf_stat_config {
>  	unsigned int		topdown_level;
>  };
>  
> +extern struct perf_stat_config stat_config;
> +
>  void perf_stat__set_big_num(int set);
> -void perf_stat__set_no_csv_summary(int set);
>  
>  void update_stats(struct stats *stats, u64 val);
>  double avg_stats(struct stats *stats);
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 
