Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2275C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4A6109F
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 18:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHLSXs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhHLSXs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Aug 2021 14:23:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C9ED60E78;
        Thu, 12 Aug 2021 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628792603;
        bh=zKSY7EbjsHMyvQs+Oeu2Cjk1u5zdLVhi5qkDzyrHaKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVFPhfzwPDG09pLjanYd2qmh3sR/ce9epnuAUWCAXeS/+iwWZOnTQcXI4rCMZLAOw
         wiKt480rllge0VGyuK3qC2uICkjU2xRZO/DCLrf+zIcP9YN6ZOJSEx0NlYVRRYZ3A/
         WANWvnVvAk7yZCuYhP7KnF+5M3AtLFGYbrNmn9SWkbwc+lIQOztMME1p2pUYcqS4fK
         YCtaQsJw2vNU+Z7Ue9PN5AaAlPnc53urQmpjEPfXMa1g4hzsn5+BK3ipsKKVsNnXjh
         G7PlPaAipWD25Bcru3DUwKdep/qs+WyFBRYErh9uhwSZDvrjOBnBU0m+Mg0MGEY3Cy
         cUmhEkUj/1dkg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E151E403F2; Thu, 12 Aug 2021 15:23:18 -0300 (-03)
Date:   Thu, 12 Aug 2021 15:23:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Claire Jensen <cjense@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, song@kernel.org,
        andi@firstfloor.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        alexander.antonov@linux.intel.com, changbin.du@intel.com,
        liuqi115@huawei.com, irogers@google.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf stat: Add JSON output option and testing.
Message-ID: <YRVnFtfgn0/IFqnW@kernel.org>
References: <20210811224317.1811618-1-cjense@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811224317.1811618-1-cjense@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 11, 2021 at 10:43:18PM +0000, Claire Jensen escreveu:
<SNIP>
> +++ b/tools/perf/util/stat-display.c
> @@ -1,25 +1,25 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <inttypes.h>
> -#include <linux/string.h>
> -#include <linux/time64.h>
> +#include "third_party/linux_tools/src/tools/include/linux/string.h"
> +#include "third_party/linux_tools/src/tools/include/linux/time64.h"
>  #include <math.h>
> -#include "color.h"
> -#include "counts.h"
> -#include "evlist.h"
> -#include "evsel.h"
> -#include "stat.h"
> -#include "top.h"
> -#include "thread_map.h"
> -#include "cpumap.h"
> -#include "string2.h"
> -#include <linux/ctype.h>
> -#include "cgroup.h"
> -#include <api/fs/fs.h>
> -#include "util.h"
> -#include "iostat.h"
> -#include "pmu-hybrid.h"
> -#include "evlist-hybrid.h"
> +#include "third_party/linux_tools/src/tools/perf/util/color.h"
> +#include "third_party/linux_tools/src/tools/perf/util/counts.h"
> +#include "third_party/linux_tools/src/tools/perf/util/evlist.h"
> +#include "third_party/linux_tools/src/tools/perf/util/evsel.h"
> +#include "third_party/linux_tools/src/tools/perf/util/stat.h"
> +#include "third_party/linux_tools/src/tools/perf/util/top.h"
> +#include "third_party/linux_tools/src/tools/perf/util/thread_map.h"
> +#include "third_party/linux_tools/src/tools/perf/util/cpumap.h"
> +#include "third_party/linux_tools/src/tools/perf/util/string2.h"
> +#include "third_party/linux_tools/src/tools/include/linux/ctype.h"
> +#include "third_party/linux_tools/src/tools/perf/util/cgroup.h"
> +#include "third_party/linux_tools/src/tools/lib/api/fs/fs.h"
> +#include "third_party/linux_tools/src/tools/perf/util/util.h"
> +#include "third_party/linux_tools/src/tools/perf/util/iostat.h"
> +#include "third_party/linux_tools/src/tools/perf/util/pmu-hybrid.h"
> +#include "third_party/linux_tools/src/tools/perf/util/evlist-hybrid.h"

Oops, these shouldn'be here, right? :-)

Some comments: Please separate the 'perf test' entry from the feature
being introduced, also align 'TODO' entries in the if block and remove
that b/somenumber (what is that for?)

Pay attention to indentation, you removed from several if blocks.

More below

Thanks for working on this, I hope the 'stat' guys can test this and
provide feedback.

- Arnaldo
  
>  #define CNTR_NOT_SUPPORTED	"<not supported>"
>  #define CNTR_NOT_COUNTED	"<not counted>"
> @@ -27,15 +27,21 @@
>  static void print_running(struct perf_stat_config *config,
>  			  u64 run, u64 ena)
>  {
> -	if (config->csv_output) {
> -		fprintf(config->output, "%s%" PRIu64 "%s%.2f",
> -					config->csv_sep,
> -					run,
> -					config->csv_sep,
> -					ena ? 100.0 * run / ena : 100.0);
> -	} else if (run != ena) {
> +

Please no blank line after { and the variables

> +	double enabled_percent = 100;
> +
> +	if (run != ena)
> +		enabled_percent = 100 * run / ena;
> +	if (config->json_output)
> +		fprintf(config->output,
> +						"\"event-runtime\" : %lu, \"pcnt-running\" : %.2f, ",

Why this newline before the format string?

> +						 run, enabled_percent);
> +	else if (config->csv_output)
> +		fprintf(config->output,
> +						"%s%" PRIu64 "%s%.2f", config->csv_sep,
> +						 run, config->csv_sep, enabled_percent);
> +	else if (run != ena)
>  		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
> -	}
>  }
>  
>  static void print_noise_pct(struct perf_stat_config *config,
> @@ -43,7 +49,9 @@ static void print_noise_pct(struct perf_stat_config *config,
>  {
>  	double pct = rel_stddev_stats(total, avg);
>  
> -	if (config->csv_output)
> +	if (config->json_output)
> +		fprintf(config->output, "\"variance\" : %.2f, ", pct);
> +	else if (config->csv_output)
>  		fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
>  	else if (pct)
>  		fprintf(config->output, "  ( +-%6.2f%% )", pct);
> @@ -63,9 +71,16 @@ static void print_noise(struct perf_stat_config *config,
>  
>  static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
>  {
> -	if (nr_cgroups) {
> +	if (config->json_output && nr_cgroups) {
>  		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
> +
> +		fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
> +	} else {
> +		if (nr_cgroups) {
> +			const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
> +
>  		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
> +		}
>  	}
>  }
>  
> @@ -73,8 +88,20 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
>  static void aggr_printout(struct perf_stat_config *config,
>  			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
>  {
> +
> +
> +	if (config->json_output && !config->interval)
> +		fprintf(config->output, "{");
> +
>  	switch (config->aggr_mode) {
>  	case AGGR_CORE:
> +		if (config->json_output) {
> +			fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\", \"cpu\" : %d, ",
> +						 id.socket,
> +						 id.die,
> +						 id.core,
> +						 nr);
> +	} else {

Indentation, align if/else

>  		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
>  			id.socket,
>  			id.die,
> @@ -84,56 +111,95 @@ static void aggr_printout(struct perf_stat_config *config,
>  			config->csv_output ? 0 : 4,
>  			nr,
>  			config->csv_sep);
> +	}
>  		break;
>  	case AGGR_DIE:
> -		fprintf(config->output, "S%d-D%*d%s%*d%s",
> -			id.socket,
> -			config->csv_output ? 0 : -8,
> -			id.die,
> -			config->csv_sep,
> -			config->csv_output ? 0 : 4,
> -			nr,
> -			config->csv_sep);
> +			if (config->json_output) {
> +				fprintf(config->output, "\"die\" : \"S%d-D%d\", \"cpu\" : %d, ",
> +					 id.socket,
> +					 id.die,
> +					 nr);
> +		} else {
> +			fprintf(config->output, "S%d-D%*d%s%*d%s",
> +				id.socket,
> +				config->csv_output ? 0 : -8,
> +				id.die,
> +				config->csv_sep,
> +				config->csv_output ? 0 : 4,
> +				nr,
> +				config->csv_sep);
> +		}
>  		break;
>  	case AGGR_SOCKET:
> -		fprintf(config->output, "S%*d%s%*d%s",
> -			config->csv_output ? 0 : -5,
> -			id.socket,
> -			config->csv_sep,
> -			config->csv_output ? 0 : 4,
> -			nr,
> -			config->csv_sep);
> +			if (config->json_output) {
> +				fprintf(config->output, "\"socket\" : \"S%d\", \"number\" : %d, ",
> +					 id.socket,
> +					 nr);
> +		} else {
> +			fprintf(config->output, "S%*d%s%*d%s",
> +				config->csv_output ? 0 : -5,
> +				id.socket,
> +				config->csv_sep,
> +				config->csv_output ? 0 : 4,
> +				nr,
> +				config->csv_sep);
> +		}
>  			break;
>  	case AGGR_NODE:
> -		fprintf(config->output, "N%*d%s%*d%s",
> -			config->csv_output ? 0 : -5,
> -			id.node,
> -			config->csv_sep,
> -			config->csv_output ? 0 : 4,
> -			nr,
> -			config->csv_sep);
> +			if (config->json_output) {
> +				fprintf(config->output, "\"node\" : \"N%d\", \"cpu\" : %d, ",
> +					 id.node,
> +					 nr);
> +		} else {
> +			fprintf(config->output, "N%*d%s%*d%s",
> +				config->csv_output ? 0 : -5,
> +				id.node,
> +				config->csv_sep,
> +				config->csv_output ? 0 : 4,
> +				nr,
> +				config->csv_sep);
> +		}
>  			break;
>  	case AGGR_NONE:
> -		if (evsel->percore && !config->percore_show_thread) {
> -			fprintf(config->output, "S%d-D%d-C%*d%s",
> -				id.socket,
> -				id.die,
> -				config->csv_output ? 0 : -3,
> -				id.core, config->csv_sep);
> +		if (config->json_output) {
> +			if (evsel->percore && !config->percore_show_thread) {
> +				fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\"",
> +					id.socket,
> +					id.die,
> +					id.core);
> +			} else if (id.core > -1) {
> +				fprintf(config->output, "\"cpu\" : \"%d\", ",
> +					evsel__cpus(evsel)->map[id.core]);
> +			}
> +		} else {
> +			if (evsel->percore && !config->percore_show_thread) {
> +				fprintf(config->output, "S%d-D%d-C%*d%s",
> +					id.socket,
> +					id.die,
> +					config->csv_output ? 0 : -3,
> +					id.core, config->csv_sep);
>  		} else if (id.core > -1) {
>  			fprintf(config->output, "CPU%*d%s",
>  				config->csv_output ? 0 : -7,
>  				evsel__cpus(evsel)->map[id.core],
>  				config->csv_sep);
> -		}
> +			}
> +	}
> +
>  		break;
>  	case AGGR_THREAD:
> -		fprintf(config->output, "%*s-%*d%s",
> -			config->csv_output ? 0 : 16,
> -			perf_thread_map__comm(evsel->core.threads, id.thread),
> -			config->csv_output ? 0 : -8,
> -			perf_thread_map__pid(evsel->core.threads, id.thread),
> -			config->csv_sep);
> +			if (config->json_output) {
> +				fprintf(config->output, "\"thread\" : \"%s-%d\", ",
> +					 perf_thread_map__comm(evsel->core.threads, id.thread),
> +					 perf_thread_map__pid(evsel->core.threads, id.thread));
> +		} else {
> +			fprintf(config->output, "%*s-%*d%s",
> +				config->csv_output ? 0 : 16,
> +				perf_thread_map__comm(evsel->core.threads, id.thread),
> +				config->csv_output ? 0 : -8,
> +				perf_thread_map__pid(evsel->core.threads, id.thread),
> +				config->csv_sep);
> +		}
>  		break;
>  	case AGGR_GLOBAL:
>  	case AGGR_UNSET:
> @@ -184,20 +250,56 @@ static void print_metric_std(struct perf_stat_config *config,
>  
>  	os->newline = false;
>  
> +		if (unit == NULL || fmt == NULL) {
> +			fprintf(out, "%-*s", METRIC_LEN, "");
> +			return;
> +		}
> +
> +		if (newline)
> +			do_new_line_std(config, os);
> +
> +		n = fprintf(out, " # ");
> +		if (color)
> +			n += color_fprintf(out, color, fmt, val);
> +		else
> +			n += fprintf(out, fmt, val);
> +		fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
> +}
> +
> +static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
> +			     void *ctx,
> +			     const char *color __maybe_unused,
> +			     const char *fmt, const char *unit, double val)
> +{
> +	struct outstate *os = ctx;
> +	FILE *out = os->fh;
> +	char buf[64], *vals, *ends;
> +
>  	if (unit == NULL || fmt == NULL) {
> -		fprintf(out, "%-*s", METRIC_LEN, "");
> +		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
>  		return;
>  	}
> +	snprintf(buf, sizeof(buf), fmt, val);
> +	ends = vals = skip_spaces(buf);
> +	while (isdigit(*ends) || *ends == '.')
> +		ends++;
> +	*ends = 0;
> +	fprintf(out, "%s%s%s%s", config->csv_sep, vals,
> +					 config->csv_sep, skip_spaces(unit));
> +}
>  
> -	if (newline)
> -		do_new_line_std(config, os);
> +static void print_metric_json(struct perf_stat_config *config __maybe_unused,
> +			     void *ctx,
> +			     const char *color __maybe_unused,
> +			     const char *fmt, const char *unit, double val)
> +{
> +	struct outstate *os = ctx;
> +	FILE *out = os->fh;
>  
> -	n = fprintf(out, " # ");
> -	if (color)
> -		n += color_fprintf(out, color, fmt, val);
> -	else
> -		n += fprintf(out, fmt, val);
> -	fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
> +	fprintf(out, "\"metric-value\" : %f, ", val);
> +	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> +	if (!config->metric_only)
> +		fprintf(out, "}");
>  }
>  
>  static void new_line_csv(struct perf_stat_config *config, void *ctx)
> @@ -213,25 +315,14 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
>  		fputs(config->csv_sep, os->fh);
>  }
>  
> -static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
> -			     void *ctx,
> -			     const char *color __maybe_unused,
> -			     const char *fmt, const char *unit, double val)
> +static void new_line_json(struct perf_stat_config *config, void *ctx)
>  {
>  	struct outstate *os = ctx;
> -	FILE *out = os->fh;
> -	char buf[64], *vals, *ends;
>  
> -	if (unit == NULL || fmt == NULL) {
> -		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
> -		return;
> -	}
> -	snprintf(buf, sizeof(buf), fmt, val);
> -	ends = vals = skip_spaces(buf);
> -	while (isdigit(*ends) || *ends == '.')
> -		ends++;
> -	*ends = 0;
> -	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
> +	fputc('\n', os->fh);
> +	if (os->prefix)
> +		fprintf(os->fh, "%s", os->prefix);
> +	aggr_printout(config, os->evsel, os->id, os->nr);
>  }
>  
>  /* Filter out some columns that don't work well in metrics only mode */
> @@ -292,7 +383,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
>  	if (!valid_only_metric(unit))
>  		return;
>  	unit = fixunit(tbuf, os->evsel, unit);
> -	snprintf(buf, sizeof buf, fmt, val);
> +	snprintf(buf, sizeof(buf), fmt, val);
>  	ends = vals = skip_spaces(buf);
>  	while (isdigit(*ends) || *ends == '.')
>  		ends++;
> @@ -300,6 +391,27 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
>  	fprintf(out, "%s%s", vals, config->csv_sep);
>  }
>  
> +static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
> +				  void *ctx, const char *color __maybe_unused,
> +				  const char *fmt,
> +				  const char *unit, double val)
> +{
> +	struct outstate *os = ctx;
> +	FILE *out = os->fh;
> +	char buf[64], *vals, *ends;
> +	char tbuf[1024];
> +
> +	if (!valid_only_metric(unit))
> +		return;
> +	unit = fixunit(tbuf, os->evsel, unit);
> +	snprintf(buf, sizeof(buf), fmt, val);
> +	ends = vals = skip_spaces(buf);
> +	while (isdigit(*ends) || *ends == '.')
> +		ends++;
> +	*ends = 0;
> +	fprintf(out, "{\"metric-value\" : \"%s\"}", vals);
> +}
> +
>  static void new_line_metric(struct perf_stat_config *config __maybe_unused,
>  			    void *ctx __maybe_unused)
>  {
> @@ -318,10 +430,13 @@ static void print_metric_header(struct perf_stat_config *config,
>  	    os->evsel->priv != os->evsel->evlist->selected->priv)
>  		return;
>  
> -	if (!valid_only_metric(unit))
> +	if (!valid_only_metric(unit) && !config->json_output)
>  		return;
>  	unit = fixunit(tbuf, os->evsel, unit);
> -	if (config->csv_output)
> +
> +	if (config->json_output)
> +		fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> +	else if (config->csv_output)
>  		fprintf(os->fh, "%s%s", unit, config->csv_sep);
>  	else
>  		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
> @@ -369,14 +484,28 @@ static void abs_printout(struct perf_stat_config *config,
>  
>  	aggr_printout(config, evsel, id, nr);
>  
> -	fprintf(output, fmt, avg, config->csv_sep);
> +	if (config->json_output)
> +		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
> +	else
> +		fprintf(output, fmt, avg, config->csv_sep);
>  
> -	if (evsel->unit)
> -		fprintf(output, "%-*s%s",
> -			config->csv_output ? 0 : config->unit_width,
> -			evsel->unit, config->csv_sep);
> +	if (config->json_output) {
> +		if (evsel->unit) {
> +			fprintf(output, "\"unit\" : \"%s\", ",
> +				evsel->unit);
> +		}
> +	} else {
> +		if (evsel->unit)
> +			fprintf(output, "%-*s%s",
> +				config->csv_output ? 0 : config->unit_width,
> +				evsel->unit, config->csv_sep);
> +	}
>  
> -	fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
> +
> +	if (config->json_output)
> +		fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
> +	else
> +		fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
>  
>  	print_cgroup(config, evsel);
>  }
> @@ -425,6 +554,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  		nl = new_line_metric;
>  		if (config->csv_output)
>  			pm = print_metric_only_csv;
> +		else if (config->json_output)
> +			pm = print_metric_only_json;
>  		else
>  			pm = print_metric_only;
>  	} else
> @@ -448,6 +579,24 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  			os.nfields++;
>  	}
>  
> +	if (config->json_output && !config->metric_only) {
> +		static int aggr_fields[] = {
> +			[AGGR_GLOBAL] = 0,
> +			[AGGR_THREAD] = 1,
> +			[AGGR_NONE] = 1,
> +			[AGGR_SOCKET] = 2,
> +			[AGGR_DIE] = 2,
> +			[AGGR_CORE] = 2,
> +		};
> +
> +		pm = print_metric_json;
> +		nl = new_line_json;
> +		os.nfields = 3;
> +		os.nfields += aggr_fields[config->aggr_mode];
> +		if (counter->cgrp)
> +			os.nfields++;
> +	}
> +
>  	if (!config->no_csv_summary && config->csv_output &&
>  	    config->summary && !config->interval) {
>  		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
> @@ -460,10 +609,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  		}
>  		aggr_printout(config, counter, id, nr);
>  
> -		fprintf(config->output, "%*s%s",
> -			config->csv_output ? 0 : 18,
> -			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
> -			config->csv_sep);
> +		if (config->json_output) {
> +			fprintf(config->output, "\"counter-value\" : \"%s\", ",
> +					counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED);
> +		} else {
> +			fprintf(config->output, "%*s%s",
> +				config->csv_output ? 0 : 18,
> +				counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
> +				config->csv_sep);
> +		}
>  
>  		if (counter->supported) {
>  			if (!evlist__has_hybrid(counter->evlist)) {
> @@ -473,21 +627,32 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  			}
>  		}
>  
> -		fprintf(config->output, "%-*s%s",
> -			config->csv_output ? 0 : config->unit_width,
> -			counter->unit, config->csv_sep);
> +		if (config->json_output) {
> +			fprintf(config->output, "\"unit\" : \"%s\", ", counter->unit);
> +		} else {
> +			fprintf(config->output, "%-*s%s",
> +				config->csv_output ? 0 : config->unit_width,
> +				counter->unit, config->csv_sep);
> +		}
>  
> -		fprintf(config->output, "%*s",
> -			config->csv_output ? 0 : -25, evsel__name(counter));
> +		if (config->json_output) {
> +			fprintf(config->output, "\"event\" : \"%s\", ",
> +				evsel__name(counter));
> +		} else {
> +			fprintf(config->output, "%*s",
> +				 config->csv_output ? 0 : -25, evsel__name(counter));
> +		}
>  
>  		print_cgroup(config, counter);
>  
> -		if (!config->csv_output)
> +		if (!config->csv_output && !config->json_output)
>  			pm(config, &os, NULL, NULL, "", 0);
>  		print_noise(config, counter, noise);
>  		print_running(config, run, ena);
>  		if (config->csv_output)
>  			pm(config, &os, NULL, NULL, "", 0);
> +		else if (config->json_output)
> +			pm(config, &os, NULL, NULL, "", 0);
>  		return;
>  	}
>  
> @@ -502,12 +667,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  	if (config->csv_output && !config->metric_only) {
>  		print_noise(config, counter, noise);
>  		print_running(config, run, ena);
> +	} else if (config->json_output && !config->metric_only) {
> +		print_noise(config, counter, noise);
> +		print_running(config, run, ena);
>  	}
>  
>  	perf_stat__print_shadow_stats(config, counter, uval,
>  				first_shadow_cpu(config, counter, id),
>  				&out, &config->metric_events, st);
> -	if (!config->csv_output && !config->metric_only) {
> +	if (!config->csv_output && !config->metric_only && !config->json_output) {
>  		print_noise(config, counter, noise);
>  		print_running(config, run, ena);
>  	}
> @@ -866,7 +1034,8 @@ static void print_counter_aggr(struct perf_stat_config *config,
>  		fprintf(output, "%s", prefix);
>  
>  	uval = cd.avg * counter->scale;
> -	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter, uval, prefix, cd.avg_running,
> +	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter,
> +		 uval, prefix, cd.avg_running,
>  		 cd.avg_enabled, cd.avg, &rt_stat);
>  	if (!metric_only)
>  		fprintf(output, "\n");
> @@ -981,8 +1150,12 @@ static void print_metric_headers(struct perf_stat_config *config,
>  	struct outstate os = {
>  		.fh = config->output
>  	};
> +	bool first = true;
>  
> -	if (prefix)
> +		if (config->json_output && !config->interval)
> +			fprintf(config->output, "{");
> +
> +	if (prefix && !config->json_output)
>  		fprintf(config->output, "%s", prefix);
>  
>  	if (!config->csv_output && !no_indent)
> @@ -1002,6 +1175,9 @@ static void print_metric_headers(struct perf_stat_config *config,
>  		os.evsel = counter;
>  		out.ctx = &os;
>  		out.print_metric = print_metric_header;
> +		if (!first && config->json_output)
> +			fprintf(config->output, ", ");
> +		first = false;
>  		out.new_line = new_line_metric;
>  		out.force_header = true;
>  		perf_stat__print_shadow_stats(config, counter, 0,
> @@ -1010,6 +1186,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>  					      &config->metric_events,
>  					      &rt_stat);
>  	}
> +	if (config->json_output)
> +		fprintf(config->output, "}");
>  	fputc('\n', config->output);
>  }
>  
> @@ -1025,10 +1203,18 @@ static void print_interval(struct perf_stat_config *config,
>  	if (config->interval_clear)
>  		puts(CONSOLE_CLEAR);
>  
> -	if (!config->iostat_run)
> -		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
> -
> -	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
> +	if (!config->iostat_run && !config->json_output)
> +		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
> +				 ts->tv_nsec, config->csv_sep);
> +	if (!config->iostat_run && config->json_output && !config->metric_only)
> +		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
> +				 ts->tv_sec, ts->tv_nsec);
> +	if (!config->iostat_run && config->json_output && config->metric_only)
> +		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
> +				 ts->tv_sec, ts->tv_nsec);
> +
> +	if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
> +			 || config->interval_clear) {
>  		switch (config->aggr_mode) {
>  		case AGGR_NODE:
>  			fprintf(output, "#           time node   cpus");
> @@ -1072,8 +1258,14 @@ static void print_interval(struct perf_stat_config *config,
>  		}
>  	}
>  
> -	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
> +	if ((num_print_interval == 0 || config->interval_clear)
> +			 && metric_only && !config->json_output)
> +		print_metric_headers(config, evlist, " ", true);
> +	if ((num_print_interval == 0 || config->interval_clear)
> +			 && metric_only && config->json_output) {
> +		fprintf(output, "{");
>  		print_metric_headers(config, evlist, " ", true);
> +	}
>  	if (++num_print_interval == 25)
>  		num_print_interval = 0;
>  }
> @@ -1087,7 +1279,7 @@ static void print_header(struct perf_stat_config *config,
>  
>  	fflush(stdout);
>  
> -	if (!config->csv_output) {
> +	if (!config->csv_output && !config->json_output) {
>  		fprintf(output, "\n");
>  		fprintf(output, " Performance counter stats for ");
>  		if (_target->bpf_str)
> @@ -1276,6 +1468,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  			num_print_iv = 0;
>  		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
>  			fprintf(config->output, "%s", prefix);
> +
> +		if (config->json_output && !config->metric_only)
> +			fprintf(config->output, "}");
>  	}
>  
>  	switch (config->aggr_mode) {
> @@ -1319,7 +1514,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  		break;
>  	}
>  
> -	if (!interval && !config->csv_output)
> +	if (!interval && !config->csv_output && !config->json_output)
>  		print_footer(config);
>  
>  	fflush(config->output);
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 34a7f5c1fff7..8a04b6433591 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -981,8 +981,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		total = max(total, runtime_stat_avg(st,
>  						    STAT_STALLED_CYCLES_BACK,
>  						    cpu, &rsd));
> -
> -		if (total && avg) {
> +// TODO: Refactor code to avoid errors in JSON output b/194436171
> +// !config->json_output is temporary workaround for JSON linter.
> +		if (total && avg && !config->json_output) {
>  			out->new_line(config, ctxp);
>  			ratio = total / avg;
>  			print_metric(config, ctxp, NULL, "%7.2f ",
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 32c8527de347..2bde525e7630 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -117,6 +117,7 @@ struct perf_stat_config {
>  	bool			 no_inherit;
>  	bool			 identifier;
>  	bool			 csv_output;
> +	bool			 json_output;
>  	bool			 interval_clear;
>  	bool			 metric_only;
>  	bool			 null_run;
> -- 
> 2.32.0.605.g8dce9f2422-goog
> 

-- 

- Arnaldo
