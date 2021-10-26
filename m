Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C258C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 08:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81ED360F9B
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 08:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhJZIOM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:14:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhJZIOM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 04:14:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q679Kd020646;
        Tue, 26 Oct 2021 08:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CckOy3BX6rMzz3xJOE2WaICSLCka9rD/eRARQ0lpd50=;
 b=seo6mviofbRYX1C45HCgPodRei4YbYnO+Ev93lSfhTIB0atKa4FMPvvzba/nIBqyja07
 oG0Y+6utcJsujNzesnYCh7hvKssZAEMk0a1P/q+ylWgrC2434vYpnQmp+Ck0on2Q1QMS
 fIA3np+j7wOgfzaPBX7CM9v1kMTHbF/uU29Nmbm5N1IZenuRZn5ppSaJca/j/HDfRm29
 cZT+F6WHvEgQOsz5sutNDuakCoA0qFrWPos/+zDCU5e11gLuiyywIn/UyFk0hcgjglgA
 MTjdnGOlXzZCQdyiZFgNVRfjcbE6XozVag4/RTNANuEKvWldqI/Li3FbiOVhIS65HWNb Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k25qse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:11:09 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q6cVMM026830;
        Tue, 26 Oct 2021 08:11:08 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k25qqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:11:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q82bvH027249;
        Tue, 26 Oct 2021 08:11:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4esuacs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:11:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q8B16045089050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 08:11:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF2EA4040;
        Tue, 26 Oct 2021 08:11:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAFF2A405B;
        Tue, 26 Oct 2021 08:10:49 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.120.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 08:10:49 +0000 (GMT)
Subject: Re: [PATCH v2 05/21] perf metric: Move runtime value to the expr
 context
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20211015172132.1162559-1-irogers@google.com>
 <20211015172132.1162559-6-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <fb6c23a4-628d-4777-4863-b8b49e1d20cc@linux.ibm.com>
Date:   Tue, 26 Oct 2021 13:40:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015172132.1162559-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ggj2G38jCIboMHkUdvcPBd2WrEoFR6V_
X-Proofpoint-GUID: DNr8Ue3prseysnBbUv6U48WcDXUwE6I7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260045
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/15/21 10:51 PM, Ian Rogers wrote:
> The runtime value is needed when recursively parsing metrics, currently
> a value of 1 is passed which is incorrect. Rather than add more
> arguments to the bison parser, add runtime to the context. Fix call
> sites not to pass a value. The runtime value is defaulted to 0, which is
> arbitrary. In some places this replaces a value of 1, which was also
> arbitrary. This shouldn't affect anything other than PPC. The use of
> 0 or 1 shouldn't matter as a proper runtime value would be needed in a
> case that it did matter.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> ---
>  tools/perf/tests/expr.c       | 15 ++++++++-------
>  tools/perf/tests/pmu-events.c | 10 +++++-----
>  tools/perf/util/expr.c        | 15 ++++++++-------
>  tools/perf/util/expr.h        |  5 +++--
>  tools/perf/util/metricgroup.c |  7 +++----
>  tools/perf/util/stat-shadow.c |  7 ++++---
>  6 files changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index f1d8411fce12..3c16f3df1980 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -56,7 +56,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
>  {
>  	double val;
>  
> -	if (expr__parse(&val, ctx, e, 1))
> +	if (expr__parse(&val, ctx, e))
>  		TEST_ASSERT_VAL("parse test failed", 0);
>  	TEST_ASSERT_VAL("unexpected value", val == val2);
>  	return 0;
> @@ -104,17 +104,17 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	}
>  
>  	p = "FOO/0";
> -	ret = expr__parse(&val, ctx, p, 1);
> +	ret = expr__parse(&val, ctx, p);
>  	TEST_ASSERT_VAL("division by zero", ret == -1);
>  
>  	p = "BAR/";
> -	ret = expr__parse(&val, ctx, p, 1);
> +	ret = expr__parse(&val, ctx, p);
>  	TEST_ASSERT_VAL("missing operand", ret == -1);
>  
>  	expr__ctx_clear(ctx);
>  	TEST_ASSERT_VAL("find ids",
>  			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
> -					ctx, 1) == 0);
> +					ctx) == 0);
>  	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
>  	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR",
>  						    (void **)&val_ptr));
> @@ -124,9 +124,10 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  						    (void **)&val_ptr));
>  
>  	expr__ctx_clear(ctx);
> +	ctx->runtime = 3;
>  	TEST_ASSERT_VAL("find ids",
>  			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
> -					NULL, ctx, 3) == 0);
> +					NULL, ctx) == 0);
>  	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
>  	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3/",
>  						    (void **)&val_ptr));
> @@ -137,7 +138,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	expr__ctx_clear(ctx);
>  	TEST_ASSERT_VAL("find ids",
>  			expr__find_ids("EVENT1 if #smt_on else EVENT2",
> -				NULL, ctx, 0) == 0);
> +				NULL, ctx) == 0);
>  	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
>  	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
>  						  smt_on() ? "EVENT1" : "EVENT2",
> @@ -147,7 +148,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	expr__ctx_clear(ctx);
>  	TEST_ASSERT_VAL("find ids",
>  			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
> -			NULL, ctx, 0) == 0);
> +			NULL, ctx) == 0);
>  	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
>  
>  	expr__ctx_free(ctx);
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index cc5cea141beb..71b08c296410 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -866,7 +866,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>  			ref->metric_expr = pe->metric_expr;
>  			list_add_tail(&metric->list, compound_list);
>  
> -			rc = expr__find_ids(pe->metric_expr, NULL, pctx, 0);
> +			rc = expr__find_ids(pe->metric_expr, NULL, pctx);
>  			if (rc)
>  				goto out_err;
>  			break; /* The hashmap has been modified, so restart */
> @@ -916,7 +916,7 @@ static int test_parsing(void)
>  			if (!pe->metric_expr)
>  				continue;
>  			expr__ctx_clear(ctx);
> -			if (expr__find_ids(pe->metric_expr, NULL, ctx, 0) < 0) {
> +			if (expr__find_ids(pe->metric_expr, NULL, ctx) < 0) {
>  				expr_failure("Parse find ids failed", map, pe);
>  				ret++;
>  				continue;
> @@ -949,7 +949,7 @@ static int test_parsing(void)
>  				free(metric);
>  			}
>  
> -			if (expr__parse(&result, ctx, pe->metric_expr, 0)) {
> +			if (expr__parse(&result, ctx, pe->metric_expr)) {
>  				expr_failure("Parse failed", map, pe);
>  				ret++;
>  			}
> @@ -989,7 +989,7 @@ static int metric_parse_fake(const char *str)
>  		pr_debug("expr__ctx_new failed");
>  		return TEST_FAIL;
>  	}
> -	if (expr__find_ids(str, NULL, ctx, 0) < 0) {
> +	if (expr__find_ids(str, NULL, ctx) < 0) {
>  		pr_err("expr__find_ids failed\n");
>  		return -1;
>  	}
> @@ -1010,7 +1010,7 @@ static int metric_parse_fake(const char *str)
>  		}
>  	}
>  
> -	if (expr__parse(&result, ctx, str, 0))
> +	if (expr__parse(&result, ctx, str))
>  		pr_err("expr__parse failed\n");
>  	else
>  		ret = 0;
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index db2445677c8c..62fb39fd4d9d 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -246,7 +246,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
>  			data->ref.metric_name);
>  		pr_debug("processing metric: %s ENTRY\n", id);
>  		data->kind = EXPR_ID_DATA__REF_VALUE;
> -		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr, 1)) {
> +		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr)) {
>  			pr_debug("%s failed to count\n", id);
>  			return -1;
>  		}
> @@ -284,6 +284,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
>  
>  	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
>  	ctx->parent = NULL;
> +	ctx->runtime = 0;
>  	return ctx;
>  }
>  
> @@ -314,10 +315,10 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
>  
>  static int
>  __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
> -	      bool compute_ids, int runtime)
> +	      bool compute_ids)
>  {
>  	struct expr_scanner_ctx scanner_ctx = {
> -		.runtime = runtime,
> +		.runtime = ctx->runtime,
>  	};
>  	YY_BUFFER_STATE buffer;
>  	void *scanner;
> @@ -345,15 +346,15 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
>  }
>  
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> -		const char *expr, int runtime)
> +		const char *expr)
>  {
> -	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
> +	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false) ? -1 : 0;
>  }
>  
>  int expr__find_ids(const char *expr, const char *one,
> -		   struct expr_parse_ctx *ctx, int runtime)
> +		   struct expr_parse_ctx *ctx)
>  {
> -	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
> +	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true);
>  
>  	if (one)
>  		expr__del_id(ctx, one);
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index b20513f0ae59..124475a4f245 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -21,6 +21,7 @@ struct expr_id {
>  struct expr_parse_ctx {
>  	struct hashmap	*ids;
>  	struct expr_id	*parent;
> +	int runtime;
>  };
>  
>  struct expr_id_data;
> @@ -52,10 +53,10 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
>  		     struct expr_id_data **datap);
>  
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> -		const char *expr, int runtime);
> +		const char *expr);
>  
>  int expr__find_ids(const char *expr, const char *one,
> -		struct expr_parse_ctx *ids, int runtime);
> +		   struct expr_parse_ctx *ids);
>  
>  double expr_id_data__value(const struct expr_id_data *data);
>  struct expr_id *expr_id_data__parent(struct expr_id_data *data);
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b60ccbbf0829..139f4a793f92 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -124,7 +124,6 @@ struct metric {
>  	const char *metric_unit;
>  	struct list_head metric_refs;
>  	int metric_refs_cnt;
> -	int runtime;
>  	bool has_constraint;
>  };
>  
> @@ -391,7 +390,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		expr->metric_name = m->metric_name;
>  		expr->metric_unit = m->metric_unit;
>  		expr->metric_events = metric_events;
> -		expr->runtime = m->runtime;
> +		expr->runtime = m->pctx->runtime;
>  		list_add(&expr->nd, &me->head);
>  	}
>  
> @@ -812,7 +811,7 @@ static int __add_metric(struct list_head *metric_list,
>  		m->metric_name = pe->metric_name;
>  		m->metric_expr = pe->metric_expr;
>  		m->metric_unit = pe->unit;
> -		m->runtime = runtime;
> +		m->pctx->runtime = runtime;
>  		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
>  		INIT_LIST_HEAD(&m->metric_refs);
>  		m->metric_refs_cnt = 0;
> @@ -862,7 +861,7 @@ static int __add_metric(struct list_head *metric_list,
>  	 * For both the parent and referenced metrics, we parse
>  	 * all the metric's IDs and add it to the parent context.
>  	 */
> -	if (expr__find_ids(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
> +	if (expr__find_ids(pe->metric_expr, NULL, m->pctx) < 0) {
>  		if (m->metric_refs_cnt == 0) {
>  			expr__ctx_free(m->pctx);
>  			free(m);
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 9bc841e09a0c..20f1b9d0f272 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -394,7 +394,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>  		if (!metric_events) {
>  			if (expr__find_ids(counter->metric_expr,
>  					   counter->name,
> -					   ctx, 1) < 0)
> +					   ctx) < 0)
>  				continue;
>  
>  			metric_events = calloc(sizeof(struct evsel *),
> @@ -894,13 +894,14 @@ static void generic_metric(struct perf_stat_config *config,
>  	if (!pctx)
>  		return;
>  
> +	pctx->runtime = runtime;
>  	i = prepare_metric(metric_events, metric_refs, pctx, cpu, st);
>  	if (i < 0) {
>  		expr__ctx_free(pctx);
>  		return;
>  	}
>  	if (!metric_events[i]) {
> -		if (expr__parse(&ratio, pctx, metric_expr, runtime) == 0) {
> +		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
>  			char *unit;
>  			char metric_bf[64];
>  
> @@ -951,7 +952,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
>  	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu, st) < 0)
>  		goto out;
>  
> -	if (expr__parse(&ratio, pctx, mexp->metric_expr, 1))
> +	if (expr__parse(&ratio, pctx, mexp->metric_expr))
>  		ratio = 0.0;
>  
>  out:
> 
