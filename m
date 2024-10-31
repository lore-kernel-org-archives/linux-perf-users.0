Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4F13AD03;
	Thu, 31 Oct 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402364; cv=none; b=uRn1giMT7QgS05KB7M/0a+EquVWUy76JXx5KXUUDAvuSTtXCl9P30OsZZm5h75oIiBTvf/PRkwM19yxBxguJ1tyvfrsNUeqGrMZTYnhneUQExKbPNThjvcVHj74nF8o/+3P2DbVA1QQYWw2sM7zt9T2jHFiKyAvgOUzNiWhzBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402364; c=relaxed/simple;
	bh=dvTKGiPk4UeXxBUa59Oqd92Jo21z1p/x+RK6+PStoDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5CZvpfjcIcLAZIRz+QGeS+tpu/ctlgajg/TQ07NIa/mj5LpZbqb2EUL9oUsJqy8kBGjwL5fuuKDjA6Q+A1sQUtQDHf38kNfK2eaIIbV8ghouNAy/Cy6OXDEpC+InI/xmbAfxr/qvf6Ko4tZCkV2IpFI5RLTvKUsioVzrMqA/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2JFxMUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2JFxMUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FE1C4CEC3;
	Thu, 31 Oct 2024 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402364;
	bh=dvTKGiPk4UeXxBUa59Oqd92Jo21z1p/x+RK6+PStoDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2JFxMUFn0c3ptPyk0JT2j/66T4gRT+V+qpiAQbMK4keWG3c8PzxHA2AmMDSRO/Go
	 K8AeFHwkO5JUhK2M//ixvkTto2+gUxI4b04APRzl6B6thGI+BkDD+rWlKLfXAMJyTv
	 IiaJBCRe+iDg2a0Xp5MeP+auJC1N2V5JuLHf+ft7WT3COB1XJHHNURWa943DFPW7zt
	 NszZ7qhY5pBq/DK9L5PXJ/L9Yst5rBSSW+OXbKoF4fgomP8TAmWzjiPrlUbi1QWxhH
	 syYEyrImMgfmaxX3zbMwiJSsViixXmh+XQvlVdtOusRlAV6J2I/aEtLu0ApkQ+UhwI
	 idxwNVyQ5iQFw==
Date: Thu, 31 Oct 2024 16:19:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/21] perf stat: Move stat_config into config.c
Message-ID: <ZyPYNxL333la6Dmm@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-8-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:38PM -0700, Ian Rogers wrote:
> stat_config is accessed by config.c via helper functions, but declared
> in builtin-stat. Move to util/config.c so that stub functions aren't
> needed in python.c which doesn't link against the builtin files.
> 
> To avoid name conflicts change builtin-script to use the same
> stat_config as builtin-stat. Rename local variables in tests to avoid
> shadow declaration warnings.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c |  1 -
>  tools/perf/builtin-stat.c   | 27 ---------------------------
>  tools/perf/tests/stat.c     | 16 +++++++++-------
>  tools/perf/util/config.c    | 27 +++++++++++++++++++++++++++
>  tools/perf/util/python.c    |  9 ---------
>  tools/perf/util/stat.h      |  3 ++-
>  6 files changed, 38 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e9ec74056f71..62e851fdf5ca 100644
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
> index c12158d99353..a1625443e5a5 100644
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
> @@ -1071,16 +1054,6 @@ static void sig_atexit(void)
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
> index 6f8cff3cd39a..2fda9acd7374 100644
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
> 2.47.0.163.g1226f6d8fa-goog
