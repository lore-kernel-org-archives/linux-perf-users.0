Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6CC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C646139E
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhKGPmj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 10:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234620AbhKGPmj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 10:42:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EED5C61360;
        Sun,  7 Nov 2021 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636299596;
        bh=UctrSiCSqqFwHtjyA8ftG4QDESmQNgS2a9+iqBA0Okg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pz1kwUYFQlKACr+NAS59oWh4j2s6s4NRv3vn71BFUkTLDZiYCRh23bZm36ie52H70
         QbFq4QJ4R+V9i0E5g8G0bv5cDTv0jNS+JL6MPZqvM33fvG0ji6+09Oi2L4nMJgCTKI
         Z1xW8UYm8n3JLSly0kj/aYnD2yGflD8PgHhR0MYwHKBY3EG//w6Gw6lmyh/esawZXl
         wvIWE9fqHKZ76Dagm7pqN2CF+1MpOjYuAlDRYb6BkWj3ZoTac0w36ckvZZY5/ygTce
         DLv7Q88/wNZyIfADGm0uIQ6KKXYXpdGtUM/axU1BEQ2Rd9mAAL9R+blAETAzmxTCX3
         fH2LL+qP+0OGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC7B5410A1; Sun,  7 Nov 2021 12:39:53 -0300 (-03)
Date:   Sun, 7 Nov 2021 12:39:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 2/3] perf parse-event: Add init and exit to
 parse_event_error
Message-ID: <YYfzScy1XicE0/nc@kernel.org>
References: <20211107090002.3784612-1-irogers@google.com>
 <20211107090002.3784612-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107090002.3784612-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 07, 2021 at 01:00:01AM -0800, Ian Rogers escreveu:
> parse_events may succeed but leave string memory allocations reachable
> in the error. Add an init/exit that must be called to initialize and
> clean up the error. This fixes a leak in metricgroup parse_ids.

A bit big, could've been split in more patches, but I couldn't find
problems, so I'm applying.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/kvm-stat.c |  3 +-
>  tools/perf/bench/evlist-open-close.c    |  6 ++--
>  tools/perf/builtin-stat.c               | 38 ++++++++++++++-----------
>  tools/perf/builtin-trace.c              | 17 +++++------
>  tools/perf/tests/backward-ring-buffer.c |  3 +-
>  tools/perf/tests/bpf.c                  |  3 +-
>  tools/perf/tests/expand-cgroup.c        |  2 ++
>  tools/perf/tests/parse-events.c         |  4 +--
>  tools/perf/tests/pmu-events.c           | 22 +++++++-------
>  tools/perf/tests/topology.c             |  2 ++
>  tools/perf/util/metricgroup.c           |  3 +-
>  tools/perf/util/parse-events.c          | 20 +++++++++----
>  tools/perf/util/parse-events.h          |  2 ++
>  13 files changed, 74 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
> index 16510686c138..2a74bec15a3e 100644
> --- a/tools/perf/arch/powerpc/util/kvm-stat.c
> +++ b/tools/perf/arch/powerpc/util/kvm-stat.c
> @@ -113,10 +113,11 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
>  	struct parse_events_error err;
>  	int ret;
>  
> -	bzero(&err, sizeof(err));
> +	parse_events_error__init(&err);
>  	ret = parse_events(evlist, str, &err);
>  	if (err.str)
>  		parse_events_print_error(&err, "tracepoint");
> +	parse_events_error__exit(&err);
>  	return ret;
>  }
>  
> diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> index 3f9518936367..482738e9bdad 100644
> --- a/tools/perf/bench/evlist-open-close.c
> +++ b/tools/perf/bench/evlist-open-close.c
> @@ -78,7 +78,7 @@ static int evlist__count_evsel_fds(struct evlist *evlist)
>  
>  static struct evlist *bench__create_evlist(char *evstr)
>  {
> -	struct parse_events_error err = { .idx = 0, };
> +	struct parse_events_error err;
>  	struct evlist *evlist = evlist__new();
>  	int ret;
>  
> @@ -87,14 +87,16 @@ static struct evlist *bench__create_evlist(char *evstr)
>  		return NULL;
>  	}
>  
> +	parse_events_error__init(&err);
>  	ret = parse_events(evlist, evstr, &err);
>  	if (ret) {
>  		parse_events_error__print(&err, evstr);
> +		parse_events_error__exit(&err);
>  		pr_err("Run 'perf list' for a list of valid events\n");
>  		ret = 1;
>  		goto out_delete_evlist;
>  	}
> -
> +	parse_events_error__exit(&err);
>  	ret = evlist__create_maps(evlist, &opts.target);
>  	if (ret < 0) {
>  		pr_err("Not enough memory to create thread/cpu maps\n");
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index af447a179d84..7974933dbc77 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1750,14 +1750,12 @@ static int add_default_attributes(void)
>  	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
>  	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
>  };
> -	struct parse_events_error errinfo;
> -
>  	/* Set attrs if no event is selected and !null_run: */
>  	if (stat_config.null_run)
>  		return 0;
>  
> -	bzero(&errinfo, sizeof(errinfo));
>  	if (transaction_run) {
> +		struct parse_events_error errinfo;
>  		/* Handle -T as -M transaction. Once platform specific metrics
>  		 * support has been added to the json files, all architectures
>  		 * will use this approach. To determine transaction support
> @@ -1772,6 +1770,7 @@ static int add_default_attributes(void)
>  							 &stat_config.metric_events);
>  		}
>  
> +		parse_events_error__init(&errinfo);
>  		if (pmu_have_event("cpu", "cycles-ct") &&
>  		    pmu_have_event("cpu", "el-start"))
>  			err = parse_events(evsel_list, transaction_attrs,
> @@ -1783,12 +1782,13 @@ static int add_default_attributes(void)
>  		if (err) {
>  			fprintf(stderr, "Cannot set up transaction events\n");
>  			parse_events_error__print(&errinfo, transaction_attrs);
> -			return -1;
>  		}
> -		return 0;
> +		parse_events_error__exit(&errinfo);
> +		return err ? -1 : 0;
>  	}
>  
>  	if (smi_cost) {
> +		struct parse_events_error errinfo;
>  		int smi;
>  
>  		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
> @@ -1804,23 +1804,23 @@ static int add_default_attributes(void)
>  			smi_reset = true;
>  		}
>  
> -		if (pmu_have_event("msr", "aperf") &&
> -		    pmu_have_event("msr", "smi")) {
> -			if (!force_metric_only)
> -				stat_config.metric_only = true;
> -			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
> -		} else {
> +		if (!pmu_have_event("msr", "aperf") ||
> +		    !pmu_have_event("msr", "smi")) {
>  			fprintf(stderr, "To measure SMI cost, it needs "
>  				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
> -			parse_events_error__print(&errinfo, smi_cost_attrs);
>  			return -1;
>  		}
> +		if (!force_metric_only)
> +			stat_config.metric_only = true;
> +
> +		parse_events_error__init(&errinfo);
> +		err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
>  		if (err) {
>  			parse_events_error__print(&errinfo, smi_cost_attrs);
>  			fprintf(stderr, "Cannot set up SMI cost events\n");
> -			return -1;
>  		}
> -		return 0;
> +		parse_events_error__exit(&errinfo);
> +		return err ? -1 : 0;
>  	}
>  
>  	if (topdown_run) {
> @@ -1875,18 +1875,22 @@ static int add_default_attributes(void)
>  			return -1;
>  		}
>  		if (topdown_attrs[0] && str) {
> +			struct parse_events_error errinfo;
>  			if (warn)
>  				arch_topdown_group_warn();
>  setup_metrics:
> +			parse_events_error__init(&errinfo);
>  			err = parse_events(evsel_list, str, &errinfo);
>  			if (err) {
>  				fprintf(stderr,
>  					"Cannot set up top down events %s: %d\n",
>  					str, err);
>  				parse_events_error__print(&errinfo, str);
> +				parse_events_error__exit(&errinfo);
>  				free(str);
>  				return -1;
>  			}
> +			parse_events_error__exit(&errinfo);
>  		} else {
>  			fprintf(stderr, "System does not support topdown\n");
>  			return -1;
> @@ -1896,6 +1900,7 @@ static int add_default_attributes(void)
>  
>  	if (!evsel_list->core.nr_entries) {
>  		if (perf_pmu__has_hybrid()) {
> +			struct parse_events_error errinfo;
>  			const char *hybrid_str = "cycles,instructions,branches,branch-misses";
>  
>  			if (target__has_cpu(&target))
> @@ -1906,15 +1911,16 @@ static int add_default_attributes(void)
>  				return -1;
>  			}
>  
> +			parse_events_error__init(&errinfo);
>  			err = parse_events(evsel_list, hybrid_str, &errinfo);
>  			if (err) {
>  				fprintf(stderr,
>  					"Cannot set up hybrid events %s: %d\n",
>  					hybrid_str, err);
>  				parse_events_error__print(&errinfo, hybrid_str);
> -				return -1;
>  			}
> -			return err;
> +			parse_events_error__exit(&errinfo);
> +			return err ? -1 : 0;
>  		}
>  
>  		if (target__has_cpu(&target))
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7f0acc94e9ac..624ea12ce5ca 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3063,15 +3063,11 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
>  	struct parse_events_error err;
>  	int ret;
>  
> -	bzero(&err, sizeof(err));
> +	parse_events_error__init(&err);
>  	ret = parse_events(evlist, "probe:vfs_getname*", &err);
> -	if (ret) {
> -		free(err.str);
> -		free(err.help);
> -		free(err.first_str);
> -		free(err.first_help);
> +	parse_events_error__exit(&err);
> +	if (ret)
>  		return false;
> -	}
>  
>  	evlist__for_each_entry_safe(evlist, evsel, tmp) {
>  		if (!strstarts(evsel__name(evsel), "probe:vfs_getname"))
> @@ -4925,12 +4921,13 @@ int cmd_trace(int argc, const char **argv)
>  	if (trace.perfconfig_events != NULL) {
>  		struct parse_events_error parse_err;
>  
> -		bzero(&parse_err, sizeof(parse_err));
> +		parse_events_error__init(&parse_err);
>  		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
> -		if (err) {
> +		if (err)
>  			parse_events_error__print(&parse_err, trace.perfconfig_events);
> +		parse_events_error__exit(&parse_err);
> +		if (err)
>  			goto out;
> -		}
>  	}
>  
>  	if ((nr_cgroups || trace.cgroup) && !trace.opts.target.system_wide) {
> diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
> index b4b9a9488d51..7447a4478991 100644
> --- a/tools/perf/tests/backward-ring-buffer.c
> +++ b/tools/perf/tests/backward-ring-buffer.c
> @@ -115,12 +115,13 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
>  		goto out_delete_evlist;
>  	}
>  
> -	bzero(&parse_error, sizeof(parse_error));
> +	parse_events_error__init(&parse_error);
>  	/*
>  	 * Set backward bit, ring buffer should be writing from end. Record
>  	 * it in aux evlist
>  	 */
>  	err = parse_events(evlist, "syscalls:sys_enter_prctl/overwrite/", &parse_error);
> +	parse_events_error__exit(&parse_error);
>  	if (err) {
>  		pr_debug("Failed to parse tracepoint event, try use root\n");
>  		ret = TEST_SKIP;
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index fa03ff0dc083..2bf146e49ce8 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -123,12 +123,13 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
>  	struct parse_events_state parse_state;
>  	struct parse_events_error parse_error;
>  
> -	bzero(&parse_error, sizeof(parse_error));
> +	parse_events_error__init(&parse_error);
>  	bzero(&parse_state, sizeof(parse_state));
>  	parse_state.error = &parse_error;
>  	INIT_LIST_HEAD(&parse_state.list);
>  
>  	err = parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj, NULL);
> +	parse_events_error__exit(&parse_error);
>  	if (err || list_empty(&parse_state.list)) {
>  		pr_debug("Failed to add events selected by BPF\n");
>  		return TEST_FAIL;
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index 57b4c5f30324..80cff8a3558c 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -124,6 +124,7 @@ static int expand_group_events(void)
>  	evlist = evlist__new();
>  	TEST_ASSERT_VAL("failed to get evlist", evlist);
>  
> +	parse_events_error__init(&err);
>  	ret = parse_events(evlist, event_str, &err);
>  	if (ret < 0) {
>  		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
> @@ -135,6 +136,7 @@ static int expand_group_events(void)
>  	rblist__init(&metric_events);
>  	ret = test_expand_events(evlist, &metric_events);
>  out:
> +	parse_events_error__exit(&err);
>  	evlist__delete(evlist);
>  	return ret;
>  }
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index e200af986613..6af94639b14a 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2045,7 +2045,6 @@ static int test_event(struct evlist_test *e)
>  	struct evlist *evlist;
>  	int ret;
>  
> -	bzero(&err, sizeof(err));
>  	if (e->valid && !e->valid()) {
>  		pr_debug("... SKIP");
>  		return 0;
> @@ -2055,6 +2054,7 @@ static int test_event(struct evlist_test *e)
>  	if (evlist == NULL)
>  		return -ENOMEM;
>  
> +	parse_events_error__init(&err);
>  	ret = parse_events(evlist, e->name, &err);
>  	if (ret) {
>  		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
> @@ -2063,7 +2063,7 @@ static int test_event(struct evlist_test *e)
>  	} else {
>  		ret = e->check(evlist);
>  	}
> -
> +	parse_events_error__exit(&err);
>  	evlist__delete(evlist);
>  
>  	return ret;
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 50b1299fe643..9ae894c406d8 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -787,9 +787,11 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
>  
>  static int check_parse_cpu(const char *id, bool same_cpu, const struct pmu_event *pe)
>  {
> -	struct parse_events_error error = { .idx = 0, };
> +	struct parse_events_error error;
> +	int ret;
>  
> -	int ret = check_parse_id(id, &error, NULL);
> +	parse_events_error__init(&error);
> +	ret = check_parse_id(id, &error, NULL);
>  	if (ret && same_cpu) {
>  		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
>  			pe->metric_name, id, pe->metric_expr);
> @@ -800,22 +802,18 @@ static int check_parse_cpu(const char *id, bool same_cpu, const struct pmu_event
>  			  id, pe->metric_name, pe->metric_expr);
>  		ret = 0;
>  	}
> -	free(error.str);
> -	free(error.help);
> -	free(error.first_str);
> -	free(error.first_help);
> +	parse_events_error__exit(&error);
>  	return ret;
>  }
>  
>  static int check_parse_fake(const char *id)
>  {
> -	struct parse_events_error error = { .idx = 0, };
> -	int ret = check_parse_id(id, &error, &perf_pmu__fake);
> +	struct parse_events_error error;
> +	int ret;
>  
> -	free(error.str);
> -	free(error.help);
> -	free(error.first_str);
> -	free(error.first_help);
> +	parse_events_error__init(&error);
> +	ret = check_parse_id(id, &error, &perf_pmu__fake);
> +	parse_events_error__exit(&error);
>  	return ret;
>  }
>  
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index b9028e304ddd..4574c46260d9 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -49,7 +49,9 @@ static int session_write_header(char *path)
>  
>  		session->evlist = evlist__new();
>  		TEST_ASSERT_VAL("can't get evlist", session->evlist);
> +		parse_events_error__init(&err);
>  		parse_events(session->evlist, "cpu_core/cycles/", &err);
> +		parse_events_error__exit(&err);
>  	}
>  
>  	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index edd7180b24e4..1b43cbc1961d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1339,7 +1339,7 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
>  		goto err_out;
>  	}
>  	pr_debug("Parsing metric events '%s'\n", events.buf);
> -	bzero(&parse_error, sizeof(parse_error));
> +	parse_events_error__init(&parse_error);
>  	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
>  	if (ret) {
>  		parse_events_error__print(&parse_error, events.buf);
> @@ -1352,6 +1352,7 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
>  	*out_evlist = parsed_evlist;
>  	parsed_evlist = NULL;
>  err_out:
> +	parse_events_error__exit(&parse_error);
>  	evlist__delete(parsed_evlist);
>  	strbuf_release(&events);
>  	return ret;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 75cafb9a0720..5bfb6f892489 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2301,6 +2301,19 @@ int __parse_events(struct evlist *evlist, const char *str,
>  	return ret;
>  }
>  
> +void parse_events_error__init(struct parse_events_error *err)
> +{
> +	bzero(err, sizeof(*err));
> +}
> +
> +void parse_events_error__exit(struct parse_events_error *err)
> +{
> +	zfree(&err->str);
> +	zfree(&err->help);
> +	zfree(&err->first_str);
> +	zfree(&err->first_help);
> +}
> +
>  void parse_events_error__handle(struct parse_events_error *err, int idx,
>  				char *str, char *help)
>  {
> @@ -2405,15 +2418,11 @@ void parse_events_error__print(struct parse_events_error *err,
>  		return;
>  
>  	__parse_events_error__print(err->idx, err->str, err->help, event);
> -	zfree(&err->str);
> -	zfree(&err->help);
>  
>  	if (err->num_errors > 1) {
>  		fputs("\nInitial error:\n", stderr);
>  		__parse_events_error__print(err->first_idx, err->first_str,
>  					err->first_help, event);
> -		zfree(&err->first_str);
> -		zfree(&err->first_help);
>  	}
>  }
>  
> @@ -2426,13 +2435,14 @@ int parse_events_option(const struct option *opt, const char *str,
>  	struct parse_events_error err;
>  	int ret;
>  
> -	bzero(&err, sizeof(err));
> +	parse_events_error__init(&err);
>  	ret = parse_events(evlist, str, &err);
>  
>  	if (ret) {
>  		parse_events_error__print(&err, str);
>  		fprintf(stderr, "Run 'perf list' for a list of valid events\n");
>  	}
> +	parse_events_error__exit(&err);
>  
>  	return ret;
>  }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 52ac26b3720a..c7fc93f54577 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -242,6 +242,8 @@ int is_valid_tracepoint(const char *event_string);
>  int valid_event_mount(const char *eventfs);
>  char *parse_events_formats_error_string(char *additional_terms);
>  
> +void parse_events_error__init(struct parse_events_error *err);
> +void parse_events_error__exit(struct parse_events_error *err);
>  void parse_events_error__handle(struct parse_events_error *err, int idx,
>  				char *str, char *help);
>  void parse_events_error__print(struct parse_events_error *err,
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog

-- 

- Arnaldo
