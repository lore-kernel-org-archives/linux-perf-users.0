Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E1C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95E561360
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhKGPh1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 10:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhKGPh0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 10:37:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A44561055;
        Sun,  7 Nov 2021 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636299283;
        bh=+ZH6oLIWMa/pNSMrkp57HxXRxsvgDiOpOEX5Ch5Zfo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7hGSubrFM9Pys/9mwk3G/c/LBQcb6FHw8VPF76bTEz69iO6W6BOt/rQqsgZLeOkj
         Mx3T6l79Sv8CqY/T3jSjGsehWshDLjlqBlXj2Zxv6miW01DB2TlU3BFhb7c2UQVvrt
         wNWxvnEJiwD6cpYN6uFc5xDyYSEe3h26rqmalCIMU7hUc7oLxGnE53UtWaM/hdaYIm
         ziOjD3EacmMBDhWjRjJCghjaYCylNKouFYW8oGyj3WZnFaya1TcBBpeJb/YaQML2tS
         Cqnl8EVxhZCqnf4LTiiMP5BtGyjz6Ot8I9kEjBzCA5A1mnNaP/gzgwS9TtGRAm63iz
         m3M9jmIs1d6Lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F3CB410A1; Sun,  7 Nov 2021 12:34:41 -0300 (-03)
Date:   Sun, 7 Nov 2021 12:34:41 -0300
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
Subject: Re: [PATCH v2 1/3] perf parse-events: Rename parse_events_error
 functions
Message-ID: <YYfyEcPfj5ct7w7Q@kernel.org>
References: <20211107090002.3784612-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107090002.3784612-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 07, 2021 at 01:00:00AM -0800, Ian Rogers escreveu:
> Group error functions and name after the data type they manipulate.

Sensible, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/bench/evlist-open-close.c |   2 +-
>  tools/perf/builtin-stat.c            |  10 +--
>  tools/perf/builtin-trace.c           |   2 +-
>  tools/perf/tests/expand-cgroup.c     |   2 +-
>  tools/perf/tests/parse-events.c      |   2 +-
>  tools/perf/util/metricgroup.c        |   2 +-
>  tools/perf/util/parse-events.c       | 116 +++++++++++++--------------
>  tools/perf/util/parse-events.h       |   8 +-
>  tools/perf/util/parse-events.y       |   4 +-
>  tools/perf/util/pmu.c                |   8 +-
>  10 files changed, 78 insertions(+), 78 deletions(-)
> 
> diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> index 75a53919126b..3f9518936367 100644
> --- a/tools/perf/bench/evlist-open-close.c
> +++ b/tools/perf/bench/evlist-open-close.c
> @@ -89,7 +89,7 @@ static struct evlist *bench__create_evlist(char *evstr)
>  
>  	ret = parse_events(evlist, evstr, &err);
>  	if (ret) {
> -		parse_events_print_error(&err, evstr);
> +		parse_events_error__print(&err, evstr);
>  		pr_err("Run 'perf list' for a list of valid events\n");
>  		ret = 1;
>  		goto out_delete_evlist;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f0ecfda34ece..af447a179d84 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1782,7 +1782,7 @@ static int add_default_attributes(void)
>  					   &errinfo);
>  		if (err) {
>  			fprintf(stderr, "Cannot set up transaction events\n");
> -			parse_events_print_error(&errinfo, transaction_attrs);
> +			parse_events_error__print(&errinfo, transaction_attrs);
>  			return -1;
>  		}
>  		return 0;
> @@ -1812,11 +1812,11 @@ static int add_default_attributes(void)
>  		} else {
>  			fprintf(stderr, "To measure SMI cost, it needs "
>  				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
> -			parse_events_print_error(&errinfo, smi_cost_attrs);
> +			parse_events_error__print(&errinfo, smi_cost_attrs);
>  			return -1;
>  		}
>  		if (err) {
> -			parse_events_print_error(&errinfo, smi_cost_attrs);
> +			parse_events_error__print(&errinfo, smi_cost_attrs);
>  			fprintf(stderr, "Cannot set up SMI cost events\n");
>  			return -1;
>  		}
> @@ -1883,7 +1883,7 @@ static int add_default_attributes(void)
>  				fprintf(stderr,
>  					"Cannot set up top down events %s: %d\n",
>  					str, err);
> -				parse_events_print_error(&errinfo, str);
> +				parse_events_error__print(&errinfo, str);
>  				free(str);
>  				return -1;
>  			}
> @@ -1911,7 +1911,7 @@ static int add_default_attributes(void)
>  				fprintf(stderr,
>  					"Cannot set up hybrid events %s: %d\n",
>  					hybrid_str, err);
> -				parse_events_print_error(&errinfo, hybrid_str);
> +				parse_events_error__print(&errinfo, hybrid_str);
>  				return -1;
>  			}
>  			return err;
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 2f1d20553a0a..7f0acc94e9ac 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4928,7 +4928,7 @@ int cmd_trace(int argc, const char **argv)
>  		bzero(&parse_err, sizeof(parse_err));
>  		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
>  		if (err) {
> -			parse_events_print_error(&parse_err, trace.perfconfig_events);
> +			parse_events_error__print(&parse_err, trace.perfconfig_events);
>  			goto out;
>  		}
>  	}
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index aaad51aba12f..57b4c5f30324 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -128,7 +128,7 @@ static int expand_group_events(void)
>  	if (ret < 0) {
>  		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
>  			 event_str, ret, err.str);
> -		parse_events_print_error(&err, event_str);
> +		parse_events_error__print(&err, event_str);
>  		goto out;
>  	}
>  
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 8875e388563e..e200af986613 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2059,7 +2059,7 @@ static int test_event(struct evlist_test *e)
>  	if (ret) {
>  		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
>  			 e->name, ret, err.str);
> -		parse_events_print_error(&err, e->name);
> +		parse_events_error__print(&err, e->name);
>  	} else {
>  		ret = e->check(evlist);
>  	}
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4917e9704765..edd7180b24e4 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1342,7 +1342,7 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
>  	bzero(&parse_error, sizeof(parse_error));
>  	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
>  	if (ret) {
> -		parse_events_print_error(&parse_error, events.buf);
> +		parse_events_error__print(&parse_error, events.buf);
>  		goto err_out;
>  	}
>  	ret = decode_all_metric_ids(parsed_evlist, modifier);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 278199ed788b..75cafb9a0720 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -191,39 +191,6 @@ static int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>  
>  #define MAX_EVENT_LENGTH 512
>  
> -void parse_events__handle_error(struct parse_events_error *err, int idx,
> -				char *str, char *help)
> -{
> -	if (WARN(!str, "WARNING: failed to provide error string\n")) {
> -		free(help);
> -		return;
> -	}
> -	switch (err->num_errors) {
> -	case 0:
> -		err->idx = idx;
> -		err->str = str;
> -		err->help = help;
> -		break;
> -	case 1:
> -		err->first_idx = err->idx;
> -		err->idx = idx;
> -		err->first_str = err->str;
> -		err->str = str;
> -		err->first_help = err->help;
> -		err->help = help;
> -		break;
> -	default:
> -		pr_debug("Multiple errors dropping message: %s (%s)\n",
> -			err->str, err->help);
> -		free(err->str);
> -		err->str = str;
> -		free(err->help);
> -		err->help = help;
> -		break;
> -	}
> -	err->num_errors++;
> -}
> -
>  struct tracepoint_path *tracepoint_id_to_path(u64 config)
>  {
>  	struct tracepoint_path *path = NULL;
> @@ -587,7 +554,7 @@ static void tracepoint_error(struct parse_events_error *e, int err,
>  	}
>  
>  	tracing_path__strerror_open_tp(err, help, sizeof(help), sys, name);
> -	parse_events__handle_error(e, 0, strdup(str), strdup(help));
> +	parse_events_error__handle(e, 0, strdup(str), strdup(help));
>  }
>  
>  static int add_tracepoint(struct list_head *list, int *idx,
> @@ -811,7 +778,7 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
>  
>  	return 0;
>  errout:
> -	parse_events__handle_error(parse_state->error, 0,
> +	parse_events_error__handle(parse_state->error, 0,
>  				strdup(errbuf), strdup("(add -v to see detail)"));
>  	return err;
>  }
> @@ -831,7 +798,7 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
>  		int err;
>  
>  		if (term->type_term != PARSE_EVENTS__TERM_TYPE_USER) {
> -			parse_events__handle_error(parse_state->error, term->err_term,
> +			parse_events_error__handle(parse_state->error, term->err_term,
>  						strdup("Invalid config term for BPF object"),
>  						NULL);
>  			return -EINVAL;
> @@ -851,7 +818,7 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
>  			else
>  				idx = term->err_term + error_pos;
>  
> -			parse_events__handle_error(parse_state->error, idx,
> +			parse_events_error__handle(parse_state->error, idx,
>  						strdup(errbuf),
>  						strdup(
>  "Hint:\tValid config terms:\n"
> @@ -923,7 +890,7 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
>  						   -err, errbuf,
>  						   sizeof(errbuf));
>  
> -		parse_events__handle_error(parse_state->error, 0,
> +		parse_events_error__handle(parse_state->error, 0,
>  					strdup(errbuf), strdup("(add -v to see detail)"));
>  		return err;
>  	}
> @@ -947,7 +914,7 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
>  			      struct bpf_object *obj __maybe_unused,
>  			      struct list_head *head_config __maybe_unused)
>  {
> -	parse_events__handle_error(parse_state->error, 0,
> +	parse_events_error__handle(parse_state->error, 0,
>  				   strdup("BPF support is not compiled"),
>  				   strdup("Make sure libbpf-devel is available at build time."));
>  	return -ENOTSUP;
> @@ -959,7 +926,7 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
>  			  bool source __maybe_unused,
>  			  struct list_head *head_config __maybe_unused)
>  {
> -	parse_events__handle_error(parse_state->error, 0,
> +	parse_events_error__handle(parse_state->error, 0,
>  				   strdup("BPF support is not compiled"),
>  				   strdup("Make sure libbpf-devel is available at build time."));
>  	return -ENOTSUP;
> @@ -1042,7 +1009,7 @@ static int check_type_val(struct parse_events_term *term,
>  		return 0;
>  
>  	if (err) {
> -		parse_events__handle_error(err, term->err_val,
> +		parse_events_error__handle(err, term->err_val,
>  					type == PARSE_EVENTS__TERM_TYPE_NUM
>  					? strdup("expected numeric value")
>  					: strdup("expected string value"),
> @@ -1087,7 +1054,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
>  	char *err_str;
>  
>  	if (term_type < 0 || term_type >= __PARSE_EVENTS__TERM_TYPE_NR) {
> -		parse_events__handle_error(err, -1,
> +		parse_events_error__handle(err, -1,
>  					strdup("Invalid term_type"), NULL);
>  		return false;
>  	}
> @@ -1110,7 +1077,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
>  		/* term_type is validated so indexing is safe */
>  		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
>  				config_term_names[term_type]) >= 0)
> -			parse_events__handle_error(err, -1, err_str, NULL);
> +			parse_events_error__handle(err, -1, err_str, NULL);
>  		return false;
>  	}
>  }
> @@ -1154,7 +1121,7 @@ do {									   \
>  		if (strcmp(term->val.str, "no") &&
>  		    parse_branch_str(term->val.str,
>  				    &attr->branch_sample_type)) {
> -			parse_events__handle_error(err, term->err_val,
> +			parse_events_error__handle(err, term->err_val,
>  					strdup("invalid branch sample type"),
>  					NULL);
>  			return -EINVAL;
> @@ -1163,7 +1130,7 @@ do {									   \
>  	case PARSE_EVENTS__TERM_TYPE_TIME:
>  		CHECK_TYPE_VAL(NUM);
>  		if (term->val.num > 1) {
> -			parse_events__handle_error(err, term->err_val,
> +			parse_events_error__handle(err, term->err_val,
>  						strdup("expected 0 or 1"),
>  						NULL);
>  			return -EINVAL;
> @@ -1202,7 +1169,7 @@ do {									   \
>  	case PARSE_EVENTS__TERM_TYPE_PERCORE:
>  		CHECK_TYPE_VAL(NUM);
>  		if ((unsigned int)term->val.num > 1) {
> -			parse_events__handle_error(err, term->err_val,
> +			parse_events_error__handle(err, term->err_val,
>  						strdup("expected 0 or 1"),
>  						NULL);
>  			return -EINVAL;
> @@ -1214,14 +1181,14 @@ do {									   \
>  	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
>  		CHECK_TYPE_VAL(NUM);
>  		if (term->val.num > UINT_MAX) {
> -			parse_events__handle_error(err, term->err_val,
> +			parse_events_error__handle(err, term->err_val,
>  						strdup("too big"),
>  						NULL);
>  			return -EINVAL;
>  		}
>  		break;
>  	default:
> -		parse_events__handle_error(err, term->err_term,
> +		parse_events_error__handle(err, term->err_term,
>  				strdup("unknown term"),
>  				parse_events_formats_error_string(NULL));
>  		return -EINVAL;
> @@ -1275,7 +1242,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
>  		return config_term_common(attr, term, err);
>  	default:
>  		if (err) {
> -			parse_events__handle_error(err, term->err_term,
> +			parse_events_error__handle(err, term->err_term,
>  				strdup("unknown term"),
>  				strdup("valid terms: call-graph,stack-size\n"));
>  		}
> @@ -1574,7 +1541,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		if (asprintf(&err_str,
>  				"Cannot find PMU `%s'. Missing kernel support?",
>  				name) >= 0)
> -			parse_events__handle_error(err, 0, err_str, NULL);
> +			parse_events_error__handle(err, 0, err_str, NULL);
>  		return -EINVAL;
>  	}
>  
> @@ -2334,6 +2301,39 @@ int __parse_events(struct evlist *evlist, const char *str,
>  	return ret;
>  }
>  
> +void parse_events_error__handle(struct parse_events_error *err, int idx,
> +				char *str, char *help)
> +{
> +	if (WARN(!str, "WARNING: failed to provide error string\n")) {
> +		free(help);
> +		return;
> +	}
> +	switch (err->num_errors) {
> +	case 0:
> +		err->idx = idx;
> +		err->str = str;
> +		err->help = help;
> +		break;
> +	case 1:
> +		err->first_idx = err->idx;
> +		err->idx = idx;
> +		err->first_str = err->str;
> +		err->str = str;
> +		err->first_help = err->help;
> +		err->help = help;
> +		break;
> +	default:
> +		pr_debug("Multiple errors dropping message: %s (%s)\n",
> +			err->str, err->help);
> +		free(err->str);
> +		err->str = str;
> +		free(err->help);
> +		err->help = help;
> +		break;
> +	}
> +	err->num_errors++;
> +}
> +
>  #define MAX_WIDTH 1000
>  static int get_term_width(void)
>  {
> @@ -2343,8 +2343,8 @@ static int get_term_width(void)
>  	return ws.ws_col > MAX_WIDTH ? MAX_WIDTH : ws.ws_col;
>  }
>  
> -static void __parse_events_print_error(int err_idx, const char *err_str,
> -				const char *err_help, const char *event)
> +static void __parse_events_error__print(int err_idx, const char *err_str,
> +					const char *err_help, const char *event)
>  {
>  	const char *str = "invalid or unsupported event: ";
>  	char _buf[MAX_WIDTH];
> @@ -2398,19 +2398,19 @@ static void __parse_events_print_error(int err_idx, const char *err_str,
>  	}
>  }
>  
> -void parse_events_print_error(struct parse_events_error *err,
> -			      const char *event)
> +void parse_events_error__print(struct parse_events_error *err,
> +			       const char *event)
>  {
>  	if (!err->num_errors)
>  		return;
>  
> -	__parse_events_print_error(err->idx, err->str, err->help, event);
> +	__parse_events_error__print(err->idx, err->str, err->help, event);
>  	zfree(&err->str);
>  	zfree(&err->help);
>  
>  	if (err->num_errors > 1) {
>  		fputs("\nInitial error:\n", stderr);
> -		__parse_events_print_error(err->first_idx, err->first_str,
> +		__parse_events_error__print(err->first_idx, err->first_str,
>  					err->first_help, event);
>  		zfree(&err->first_str);
>  		zfree(&err->first_help);
> @@ -2430,7 +2430,7 @@ int parse_events_option(const struct option *opt, const char *str,
>  	ret = parse_events(evlist, str, &err);
>  
>  	if (ret) {
> -		parse_events_print_error(&err, str);
> +		parse_events_error__print(&err, str);
>  		fprintf(stderr, "Run 'perf list' for a list of valid events\n");
>  	}
>  
> @@ -3324,7 +3324,7 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
>  	if (!parse_state->error)
>  		return;
>  
> -	parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
> +	parse_events_error__handle(parse_state->error, idx, strdup(str), NULL);
>  }
>  
>  static void config_terms_list(char *buf, size_t buf_sz)
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index f60a661a2247..52ac26b3720a 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -142,8 +142,6 @@ struct parse_events_state {
>  	char			  *hybrid_pmu_name;
>  };
>  
> -void parse_events__handle_error(struct parse_events_error *err, int idx,
> -				char *str, char *help);
>  void parse_events__shrink_config_terms(void);
>  int parse_events__is_hardcoded_term(struct parse_events_term *term);
>  int parse_events_term__num(struct parse_events_term **term,
> @@ -244,8 +242,10 @@ int is_valid_tracepoint(const char *event_string);
>  int valid_event_mount(const char *eventfs);
>  char *parse_events_formats_error_string(char *additional_terms);
>  
> -void parse_events_print_error(struct parse_events_error *err,
> -			      const char *event);
> +void parse_events_error__handle(struct parse_events_error *err, int idx,
> +				char *str, char *help);
> +void parse_events_error__print(struct parse_events_error *err,
> +			       const char *event);
>  
>  #ifdef HAVE_LIBELF_SUPPORT
>  /*
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 2d60f3cbe42b..174158982fae 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -186,7 +186,7 @@ group_def ':' PE_MODIFIER_EVENT
>  		struct parse_events_state *parse_state = _parse_state;
>  		struct parse_events_error *error = parse_state->error;
>  
> -		parse_events__handle_error(error, @3.first_column,
> +		parse_events_error__handle(error, @3.first_column,
>  					   strdup("Bad modifier"), NULL);
>  		free_list_evsel(list);
>  		YYABORT;
> @@ -248,7 +248,7 @@ event_name PE_MODIFIER_EVENT
>  		struct parse_events_state *parse_state = _parse_state;
>  		struct parse_events_error *error = parse_state->error;
>  
> -		parse_events__handle_error(error, @2.first_column,
> +		parse_events_error__handle(error, @2.first_column,
>  					   strdup("Bad modifier"), NULL);
>  		free_list_evsel(list);
>  		YYABORT;
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f3072c71d132..6ae58406f4fc 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1283,7 +1283,7 @@ static int pmu_config_term(const char *pmu_name,
>  			unknown_term = NULL;
>  		help_msg = parse_events_formats_error_string(pmu_term);
>  		if (err) {
> -			parse_events__handle_error(err, term->err_term,
> +			parse_events_error__handle(err, term->err_term,
>  						   unknown_term,
>  						   help_msg);
>  		} else {
> @@ -1316,7 +1316,7 @@ static int pmu_config_term(const char *pmu_name,
>  		if (term->no_value &&
>  		    bitmap_weight(format->bits, PERF_PMU_FORMAT_BITS) > 1) {
>  			if (err) {
> -				parse_events__handle_error(err, term->err_val,
> +				parse_events_error__handle(err, term->err_val,
>  					   strdup("no value assigned for term"),
>  					   NULL);
>  			}
> @@ -1331,7 +1331,7 @@ static int pmu_config_term(const char *pmu_name,
>  						term->config, term->val.str);
>  			}
>  			if (err) {
> -				parse_events__handle_error(err, term->err_val,
> +				parse_events_error__handle(err, term->err_val,
>  					strdup("expected numeric value"),
>  					NULL);
>  			}
> @@ -1348,7 +1348,7 @@ static int pmu_config_term(const char *pmu_name,
>  		if (err) {
>  			char *err_str;
>  
> -			parse_events__handle_error(err, term->err_val,
> +			parse_events_error__handle(err, term->err_val,
>  				asprintf(&err_str,
>  				    "value too big for format, maximum is %llu",
>  				    (unsigned long long)max_val) < 0
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog

-- 

- Arnaldo
