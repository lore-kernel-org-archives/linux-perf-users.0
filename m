Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC8EC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 14 Aug 2021 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6635860F48
	for <linux-perf-users@archiver.kernel.org>; Sat, 14 Aug 2021 13:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbhHNN1f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 14 Aug 2021 09:27:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235352AbhHNN1e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 14 Aug 2021 09:27:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ED4OtX064803;
        Sat, 14 Aug 2021 09:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+psbUmxeJJF7M2t5Ov2hNzqoZbornktl37q5wPnhzM8=;
 b=nDaWDWgIglBR9H57FWIvYTnb45haFiBwpwOHEryMlr+5KpdDng1mi2r0lQ9kELJV0hmB
 d9gDbHXvFh5huQ/ZAeBzBU3ie+fFBI/4te3LQruJPk6YFpJeBVunqa5NQvXb5Wrub/JW
 r/VRXOYLYOMNbgDjVYzKAZYMqQn6ZDu2Tn//NjcvwIgdyrCe/JzmWi17ohANqLutX1k6
 xdTaIQpnkXmdygDVf2sfXhA7VEpGvS0oKA9JAdStdqmI5Eza3WuZ/kE4zT/iG9hbyJqw
 bnazKHUuFOlioXNJdoqAiGFW+p5IFhHkrZ0G8x921z0JZJWxZ6t8MxeWphU5cdQyC53y 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ae7eu72bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 09:26:41 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17EDPh77121619;
        Sat, 14 Aug 2021 09:26:40 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ae7eu72bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 09:26:40 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17EDBtq6022124;
        Sat, 14 Aug 2021 13:26:39 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3ae5fa2h3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 13:26:39 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17EDQcvv18743590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Aug 2021 13:26:38 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E99206E052;
        Sat, 14 Aug 2021 13:26:37 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A956E053;
        Sat, 14 Aug 2021 13:26:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.157])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 14 Aug 2021 13:26:30 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] perf stat: Add JSON output option.
To:     Claire Jensen <cjense@google.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, song@kernel.org,
        andi@firstfloor.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        alexander.antonov@linux.intel.com, changbin.du@intel.com,
        liuqi115@huawei.com, irogers@google.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        clairej735@gmail.com
References: <20210813220754.2104922-1-cjense@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <bdd48739-d073-e3ca-0117-584c2cd6cfe6@linux.ibm.com>
Date:   Sat, 14 Aug 2021 18:56:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210813220754.2104922-1-cjense@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SgqdFxP6B1YFh7iZm5bI4T4Yts9i7a6n
X-Proofpoint-ORIG-GUID: 5e8120EHCmxQVqz1rGxgjiELMAfjGiwj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-14_02:2021-08-13,2021-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108140080
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/14/21 3:37 AM, Claire Jensen wrote:
> CSV output is tricky to format and column layout changes are susceptible
> to breaking parsers. New JSON-formatted output has variable names to
> identify fields that are consistent and informative, making
> the output parseable.
> 
> CSV output example:
> 
> 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> 0,,context-switches:u,1204272,100.00,0.000,/sec
> 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> 70,,page-faults:u,1204272,100.00,58.126,K/sec
> 
> JSON output example:
> 
> {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> {"counter-value" : "6166.000000", "unit" : "", "event" :
> "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> {"counter-value" : "466.000000", "unit" : "", "event" :
> "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> {"counter-value" : "208.000000", "unit" : "", "event" :
> "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
> 
> Also added documentation for JSON option.
> 
> Version 2 includes change to SPDX-License-Identifier location, moving it
> to line 3 due to an error when the test name was not found on
> line 2. Additionally, testing was separated from the output patch.
> 
> Signed-off-by: Claire Jensen <cjense@google.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  21 ++
>  tools/perf/builtin-stat.c              |   2 +
>  tools/perf/util/stat-display.c         | 383 ++++++++++++++++++-------
>  tools/perf/util/stat-shadow.c          |   5 +-
>  tools/perf/util/stat.h                 |   1 +
>  5 files changed, 310 insertions(+), 102 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 45c2467e4eb2..80ae3802a904 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -554,6 +554,27 @@ Additional metrics may be printed with all earlier fields being empty.
>  
>  include::intel-hybrid.txt[]
>  
> +JSON FORMAT
> +-----------
> +
> +With -j, perf stat is able to print out a JSON format output
> +that can be used for parsing.
> +
> +- timestamp : optional usec time stamp in fractions of second (with -I)
> +- optional aggregate options:
> +		- core : core identifier (with --per-core)
> +		- die : die identifier (with --per-die)
> +		- socket : socket identifier (with --per-socket)
> +		- node : node identifier (with --per-node)
> +		- thread : thread identifier (with --per-thread)
> +- counter-value : counter value
> +- unit : unit of the counter value or empty
> +- event : event name
> +- variance : optional variance if multiple values are collected (with -r)
> +- runtime : run time of counter
> +- metric-value : optional metric value
> +- metric-unit : optional unit of metric
> +
>  SEE ALSO
>  --------
>  linkperf:perf-top[1], linkperf:perf-list[1]
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 634375937db9..71b8418a2a06 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1218,6 +1218,8 @@ static struct option stat_options[] = {
>  	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
>  	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
>  		   "print counts with custom separator"),
> +	OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
> +		   "print counts in JSON format"),
>  	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
>  		     "monitor event in cgroup name only", parse_stat_cgroups),
>  	OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 588601000f3f..59de118352f3 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -27,23 +27,26 @@
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
> +	double enabled_percent = 100;
> +	if (run != ena)
> +		enabled_percent = 100 * run / ena;
> +	if (config->json_output)
> +		fprintf(config->output, "\"event-runtime\" : %lu, \"pcnt-running\" : %.2f, ",
> +			 run, enabled_percent);
> +	else if (config->csv_output)
> +		fprintf(config->output, "%s%" PRIu64 "%s%.2f", config->csv_sep,
> +			 run, config->csv_sep, enabled_percent);
> +	else if (run != ena)
>  		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
> -	}
>  }
>  
>  static void print_noise_pct(struct perf_stat_config *config,
>  			    double total, double avg)
>  {
>  	double pct = rel_stddev_stats(total, avg);
> -
> -	if (config->csv_output)
> +	if (config->json_output)
> +		fprintf(config->output, "\"variance\" : %.2f, ", pct);
> +	else if (config->csv_output)
>  		fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
>  	else if (pct)
>  		fprintf(config->output, "  ( +-%6.2f%% )", pct);
> @@ -63,9 +66,14 @@ static void print_noise(struct perf_stat_config *config,
>  
>  static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
>  {
> -	if (nr_cgroups) {
> +	if (config->json_output && nr_cgroups) {
>  		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
> +		fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
> +	} else {
> +		if (nr_cgroups) {
> +			const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
>  		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
> +		}
>  	}
>  }
>  
> @@ -73,8 +81,18 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
>  static void aggr_printout(struct perf_stat_config *config,
>  			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
>  {
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
> +               	} else {
>  		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
>  			id.socket,
>  			id.die,
> @@ -84,56 +102,95 @@ static void aggr_printout(struct perf_stat_config *config,
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

Hi Claire,
      This section of if-else have indentation issue.

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

Similarly here. You can get all these format error by running scripts/checkpatch.pl script.


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
> @@ -184,20 +241,54 @@ static void print_metric_std(struct perf_stat_config *config,
>  
>  	os->newline = false;
>  
> +		if (unit == NULL || fmt == NULL) {
> +			fprintf(out, "%-*s", METRIC_LEN, "");
> +			return;
> +		}
> +		if (newline)
> +			do_new_line_std(config, os);
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
> @@ -213,25 +304,14 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
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
> @@ -292,7 +372,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
>  	if (!valid_only_metric(unit))
>  		return;
>  	unit = fixunit(tbuf, os->evsel, unit);
> -	snprintf(buf, sizeof buf, fmt, val);
> +	snprintf(buf, sizeof(buf), fmt, val);
>  	ends = vals = skip_spaces(buf);
>  	while (isdigit(*ends) || *ends == '.')
>  		ends++;
> @@ -300,6 +380,27 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
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
> @@ -318,10 +419,13 @@ static void print_metric_header(struct perf_stat_config *config,
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
> @@ -369,14 +473,27 @@ static void abs_printout(struct perf_stat_config *config,
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
> +	if (config->json_output)
> +		fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
> +	else
> +		fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
>  
>  	print_cgroup(config, evsel);
>  }
> @@ -425,6 +542,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  		nl = new_line_metric;
>  		if (config->csv_output)
>  			pm = print_metric_only_csv;
> +		else if (config->json_output)
> +			pm = print_metric_only_json;
>  		else
>  			pm = print_metric_only;
>  	} else
> @@ -448,6 +567,24 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
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
> @@ -460,10 +597,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
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
> @@ -473,21 +615,32 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
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

Here in multiple places we have if condition check for (config->json_output), is it better to merge all these in single
if condition?

Thanks,
Kajol Jain

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
> @@ -502,12 +655,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
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
> @@ -866,7 +1022,8 @@ static void print_counter_aggr(struct perf_stat_config *config,
>  		fprintf(output, "%s", prefix);
>  
>  	uval = cd.avg * counter->scale;
> -	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter, uval, prefix, cd.avg_running,
> +	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter,
> +		 uval, prefix, cd.avg_running,
>  		 cd.avg_enabled, cd.avg, &rt_stat);
>  	if (!metric_only)
>  		fprintf(output, "\n");
> @@ -981,8 +1138,12 @@ static void print_metric_headers(struct perf_stat_config *config,
>  	struct outstate os = {
>  		.fh = config->output
>  	};
> +	bool first = true;
> +
> +		if (config->json_output && !config->interval)
> +			fprintf(config->output, "{");
>  
> -	if (prefix)
> +	if (prefix && !config->json_output)
>  		fprintf(config->output, "%s", prefix);
>  
>  	if (!config->csv_output && !no_indent)
> @@ -1002,6 +1163,9 @@ static void print_metric_headers(struct perf_stat_config *config,
>  		os.evsel = counter;
>  		out.ctx = &os;
>  		out.print_metric = print_metric_header;
> +		if (!first && config->json_output)
> +			fprintf(config->output, ", ");
> +		first = false;
>  		out.new_line = new_line_metric;
>  		out.force_header = true;
>  		perf_stat__print_shadow_stats(config, counter, 0,
> @@ -1010,6 +1174,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>  					      &config->metric_events,
>  					      &rt_stat);
>  	}
> +	if (config->json_output)
> +		fprintf(config->output, "}");
>  	fputc('\n', config->output);
>  }
>  
> @@ -1025,10 +1191,18 @@ static void print_interval(struct perf_stat_config *config,
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
> @@ -1072,8 +1246,14 @@ static void print_interval(struct perf_stat_config *config,
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
> @@ -1087,7 +1267,7 @@ static void print_header(struct perf_stat_config *config,
>  
>  	fflush(stdout);
>  
> -	if (!config->csv_output) {
> +	if (!config->csv_output && !config->json_output) {
>  		fprintf(output, "\n");
>  		fprintf(output, " Performance counter stats for ");
>  		if (_target->bpf_str)
> @@ -1276,6 +1456,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  			num_print_iv = 0;
>  		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
>  			fprintf(config->output, "%s", prefix);
> +
> +		if (config->json_output && !config->metric_only)
> +			fprintf(config->output, "}");
>  	}
>  
>  	switch (config->aggr_mode) {
> @@ -1319,7 +1502,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  		break;
>  	}
>  
> -	if (!interval && !config->csv_output)
> +	if (!interval && !config->csv_output && !config->json_output)
>  		print_footer(config);
>  
>  	fflush(config->output);
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 34a7f5c1fff7..156302f8eaf6 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -981,8 +981,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		total = max(total, runtime_stat_avg(st,
>  						    STAT_STALLED_CYCLES_BACK,
>  						    cpu, &rsd));
> -
> -		if (total && avg) {
> +                // TODO: Refactor code to avoid errors in JSON output.
> +                // !config->json_output is temporary workaround for JSON linter.
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
> 
