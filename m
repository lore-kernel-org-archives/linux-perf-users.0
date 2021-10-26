Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1185FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 06:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9DA60FD7
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 06:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhJZGVf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 02:21:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230344AbhJZGVe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 02:21:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q2mAtR020925;
        Tue, 26 Oct 2021 06:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iWV+ctYp61+7QYTWJETDtl8/6NC4kYW2SrhiAs5mG3U=;
 b=frYY1Y/k533/B81eFsU4YY2Yyau/v3SO3Lqa60EgAjUacieqS2DoAR5vopdT3iMP8bNS
 t8F4433P/yp4xEveIFyjYALRrXCsXsacxPproqRljeQLdrPcmUlkYAD6o891+W9U4ad2
 kTPW0G+JLWYrJhkGYOiV78cCdFbZZpkuYWTU4iITgkRvHBY1fEjJ/L2SUZUyhCQajbTC
 RHz503RcYZmHIemUVl7eiEqBOR+Saw7LLW2eqd6BiNc7NLi6erSNhM/GCFbOU6ECTh0e
 fVzr4zmZhFCMWrE2rPDfaMmik83TlO9GxSQL1eShSEkADP0bmx7t+Sfqtd2PErwkqrUr 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx5ex192h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 06:18:38 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q5opmu028367;
        Tue, 26 Oct 2021 06:18:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx5ex191c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 06:18:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q6ELZk030844;
        Tue, 26 Oct 2021 06:18:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4este07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 06:18:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q6IVfS62718218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 06:18:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80FE8A4059;
        Tue, 26 Oct 2021 06:18:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5ADDA4069;
        Tue, 26 Oct 2021 06:18:19 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.120.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 06:18:19 +0000 (GMT)
Subject: Re: [PATCH v2 04/21] perf pmu: Make pmu_event tables const.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20211015172132.1162559-1-irogers@google.com>
 <20211015172132.1162559-5-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <b2de056d-7741-32cf-22e9-a4fe8b9bd06d@linux.ibm.com>
Date:   Tue, 26 Oct 2021 11:48:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015172132.1162559-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BA2kN-xP1WIPBdiYbC_3X3G8syA25qwg
X-Proofpoint-ORIG-GUID: 1PrHs8_icPUphkXHCJUXLn72aurmbi26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260033
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/15/21 10:51 PM, Ian Rogers wrote:
> Make lookup nature of data structures clearer through their type. Reduce
> scope of architecture specific pmu_event tables by making them static.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/header.c |  2 +-
>  tools/perf/pmu-events/jevents.c       |  2 +-
>  tools/perf/pmu-events/pmu-events.h    |  4 +--
>  tools/perf/tests/pmu-events.c         | 16 ++++++------
>  tools/perf/util/metricgroup.c         | 36 +++++++++++++--------------
>  tools/perf/util/metricgroup.h         |  6 ++---
>  tools/perf/util/pmu.c                 |  8 +++---
>  tools/perf/util/pmu.h                 |  2 +-
>  tools/perf/util/s390-sample-raw.c     |  2 +-
>  9 files changed, 39 insertions(+), 39 deletions(-)

Patch looks good to me.

Reviewed-by: kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> index 58b2d610aadb..e8fe36b10d20 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -40,7 +40,7 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>  	return bufp;
>  }
>  
> -int arch_get_runtimeparam(struct pmu_event *pe)
> +int arch_get_runtimeparam(const struct pmu_event *pe)
>  {
>  	int count;
>  	char path[PATH_MAX] = "/devices/hv_24x7/interface/";
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index a31de0f77097..5ed1abedb724 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -362,7 +362,7 @@ static int close_table;
>  
>  static void print_events_table_prefix(FILE *fp, const char *tblname)
>  {
> -	fprintf(fp, "struct pmu_event %s[] = {\n", tblname);
> +	fprintf(fp, "static const struct pmu_event %s[] = {\n", tblname);
>  	close_table = 1;
>  }
>  
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index f6c9c9fc4ab2..6efe73976440 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -41,12 +41,12 @@ struct pmu_events_map {
>  	const char *cpuid;
>  	const char *version;
>  	const char *type;		/* core, uncore etc */
> -	struct pmu_event *table;
> +	const struct pmu_event *table;
>  };
>  
>  struct pmu_sys_events {
>  	const char *name;
> -	struct pmu_event *table;
> +	const struct pmu_event *table;
>  };
>  
>  /*
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index c0f8b61871c8..cc5cea141beb 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -256,7 +256,7 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
>  	return NULL;
>  }
>  
> -static struct pmu_event *__test_pmu_get_sys_events_table(void)
> +static const struct pmu_event *__test_pmu_get_sys_events_table(void)
>  {
>  	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
>  
> @@ -268,7 +268,7 @@ static struct pmu_event *__test_pmu_get_sys_events_table(void)
>  	return NULL;
>  }
>  
> -static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
> +static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event *e2)
>  {
>  	if (!is_same(e1->name, e2->name)) {
>  		pr_debug2("testing event e1 %s: mismatched name string, %s vs %s\n",
> @@ -420,9 +420,9 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
>  /* Verify generated events from pmu-events.c are as expected */
>  static int test_pmu_event_table(void)
>  {
> -	struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
> +	const struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
>  	const struct pmu_events_map *map = __test_pmu_get_events_map();
> -	struct pmu_event *table;
> +	const struct pmu_event *table;
>  	int map_events = 0, expected_events;
>  
>  	/* ignore 3x sentinels */
> @@ -774,7 +774,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
>  	return ret;
>  }
>  
> -static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
> +static int check_parse_cpu(const char *id, bool same_cpu, const struct pmu_event *pe)
>  {
>  	struct parse_events_error error = { .idx = 0, };
>  
> @@ -838,7 +838,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>  		all = true;
>  		hashmap__for_each_entry_safe(pctx->ids, cur, cur_tmp, bkt) {
>  			struct metric_ref *ref;
> -			struct pmu_event *pe;
> +			const struct pmu_event *pe;
>  
>  			pe = metricgroup__find_metric(cur->key, map);
>  			if (!pe)
> @@ -887,7 +887,7 @@ static int test_parsing(void)
>  {
>  	const struct pmu_events_map *cpus_map = pmu_events_map__find();
>  	const struct pmu_events_map *map;
> -	struct pmu_event *pe;
> +	const struct pmu_event *pe;
>  	int i, j, k;
>  	int ret = 0;
>  	struct expr_parse_ctx *ctx;
> @@ -1028,7 +1028,7 @@ static int metric_parse_fake(const char *str)
>  static int test_parsing_fake(void)
>  {
>  	const struct pmu_events_map *map;
> -	struct pmu_event *pe;
> +	const struct pmu_event *pe;
>  	unsigned int i, j;
>  	int err = 0;
>  
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 74ea0a3540ce..b60ccbbf0829 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -427,7 +427,7 @@ static bool match_metric(const char *n, const char *list)
>  	return false;
>  }
>  
> -static bool match_pe_metric(struct pmu_event *pe, const char *metric)
> +static bool match_pe_metric(const struct pmu_event *pe, const char *metric)
>  {
>  	return match_metric(pe->metric_group, metric) ||
>  	       match_metric(pe->metric_name, metric);
> @@ -511,7 +511,7 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
>  		putchar('\n');
>  }
>  
> -static int metricgroup__print_pmu_event(struct pmu_event *pe,
> +static int metricgroup__print_pmu_event(const struct pmu_event *pe,
>  					bool metricgroups, char *filter,
>  					bool raw, bool details,
>  					struct rblist *groups,
> @@ -586,14 +586,14 @@ struct metricgroup_print_sys_idata {
>  	bool details;
>  };
>  
> -typedef int (*metricgroup_sys_event_iter_fn)(struct pmu_event *pe, void *);
> +typedef int (*metricgroup_sys_event_iter_fn)(const struct pmu_event *pe, void *);
>  
>  struct metricgroup_iter_data {
>  	metricgroup_sys_event_iter_fn fn;
>  	void *data;
>  };
>  
> -static int metricgroup__sys_event_iter(struct pmu_event *pe, void *data)
> +static int metricgroup__sys_event_iter(const struct pmu_event *pe, void *data)
>  {
>  	struct metricgroup_iter_data *d = data;
>  	struct perf_pmu *pmu = NULL;
> @@ -612,7 +612,7 @@ static int metricgroup__sys_event_iter(struct pmu_event *pe, void *data)
>  	return 0;
>  }
>  
> -static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
> +static int metricgroup__print_sys_event_iter(const struct pmu_event *pe, void *data)
>  {
>  	struct metricgroup_print_sys_idata *d = data;
>  
> @@ -624,7 +624,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  			bool raw, bool details)
>  {
>  	const struct pmu_events_map *map = pmu_events_map__find();
> -	struct pmu_event *pe;
> +	const struct pmu_event *pe;
>  	int i;
>  	struct rblist groups;
>  	struct rb_node *node, *next;
> @@ -756,7 +756,7 @@ static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
>  		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
>  }
>  
> -static bool metricgroup__has_constraint(struct pmu_event *pe)
> +static bool metricgroup__has_constraint(const struct pmu_event *pe)
>  {
>  	if (!pe->metric_constraint)
>  		return false;
> @@ -770,7 +770,7 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>  	return false;
>  }
>  
> -int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
> +int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
>  {
>  	return 1;
>  }
> @@ -785,7 +785,7 @@ struct metricgroup_add_iter_data {
>  };
>  
>  static int __add_metric(struct list_head *metric_list,
> -			struct pmu_event *pe,
> +			const struct pmu_event *pe,
>  			bool metric_no_group,
>  			int runtime,
>  			struct metric **mp,
> @@ -909,10 +909,10 @@ static int __add_metric(struct list_head *metric_list,
>  		    (match_metric(__pe->metric_group, __metric) ||	\
>  		     match_metric(__pe->metric_name, __metric)))
>  
> -struct pmu_event *metricgroup__find_metric(const char *metric,
> -					   const struct pmu_events_map *map)
> +const struct pmu_event *metricgroup__find_metric(const char *metric,
> +						 const struct pmu_events_map *map)
>  {
> -	struct pmu_event *pe;
> +	const struct pmu_event *pe;
>  	int i;
>  
>  	map_for_each_event(pe, i, map) {
> @@ -968,7 +968,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
>  }
>  
>  static int add_metric(struct list_head *metric_list,
> -		      struct pmu_event *pe,
> +		      const struct pmu_event *pe,
>  		      bool metric_no_group,
>  		      struct metric **mp,
>  		      struct expr_id *parent,
> @@ -993,7 +993,7 @@ static int __resolve_metric(struct metric *m,
>  		all = true;
>  		hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
>  			struct expr_id *parent;
> -			struct pmu_event *pe;
> +			const struct pmu_event *pe;
>  
>  			pe = metricgroup__find_metric(cur->key, map);
>  			if (!pe)
> @@ -1040,7 +1040,7 @@ static int resolve_metric(bool metric_no_group,
>  }
>  
>  static int add_metric(struct list_head *metric_list,
> -		      struct pmu_event *pe,
> +		      const struct pmu_event *pe,
>  		      bool metric_no_group,
>  		      struct metric **m,
>  		      struct expr_id *parent,
> @@ -1070,7 +1070,7 @@ static int add_metric(struct list_head *metric_list,
>  	return ret;
>  }
>  
> -static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
> +static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
>  						  void *data)
>  {
>  	struct metricgroup_add_iter_data *d = data;
> @@ -1102,7 +1102,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  				   const struct pmu_events_map *map)
>  {
>  	struct expr_ids ids = { .cnt = 0, };
> -	struct pmu_event *pe;
> +	const struct pmu_event *pe;
>  	struct metric *m;
>  	LIST_HEAD(list);
>  	int i, ret;
> @@ -1286,7 +1286,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
>  bool metricgroup__has_metric(const char *metric)
>  {
>  	const struct pmu_events_map *map = pmu_events_map__find();
> -	struct pmu_event *pe;
> +	const struct pmu_event *pe;
>  	int i;
>  
>  	if (!map)
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index c931596557bf..88ba939a3082 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -43,8 +43,8 @@ int metricgroup__parse_groups(const struct option *opt,
>  			      bool metric_no_group,
>  			      bool metric_no_merge,
>  			      struct rblist *metric_events);
> -struct pmu_event *metricgroup__find_metric(const char *metric,
> -					   const struct pmu_events_map *map);
> +const struct pmu_event *metricgroup__find_metric(const char *metric,
> +						 const struct pmu_events_map *map);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>  				   const struct pmu_events_map *map,
>  				   const char *str,
> @@ -55,7 +55,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
>  void metricgroup__print(bool metrics, bool groups, char *filter,
>  			bool raw, bool details);
>  bool metricgroup__has_metric(const char *metric);
> -int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
> +int arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused);
>  void metricgroup__rblist_exit(struct rblist *metric_events);
>  
>  int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index c04a89cc7cef..cdd6c3f6caf1 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -315,7 +315,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>  }
>  
>  static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> -				 char *desc, char *val, struct pmu_event *pe)
> +				 char *desc, char *val, const struct pmu_event *pe)
>  {
>  	struct parse_events_term *term;
>  	struct perf_pmu_alias *alias;
> @@ -834,7 +834,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>  	i = 0;
>  	while (1) {
>  		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
> -		struct pmu_event *pe = &map->table[i++];
> +		const struct pmu_event *pe = &map->table[i++];
>  		const char *pname = pe->pmu ? pe->pmu : cpu_name;
>  
>  		if (!pe->name) {
> @@ -882,7 +882,7 @@ void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
>  			break;
>  
>  		while (1) {
> -			struct pmu_event *pe = &event_table->table[j++];
> +			const struct pmu_event *pe = &event_table->table[j++];
>  			int ret;
>  
>  			if (!pe->name && !pe->metric_group && !pe->metric_name)
> @@ -900,7 +900,7 @@ struct pmu_sys_event_iter_data {
>  	struct perf_pmu *pmu;
>  };
>  
> -static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
> +static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe, void *data)
>  {
>  	struct pmu_sys_event_iter_data *idata = data;
>  	struct perf_pmu *pmu = idata->pmu;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index dd5cdde6a3d0..cc9f9e001347 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -127,7 +127,7 @@ const struct pmu_events_map *pmu_events_map__find(void);
>  bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
>  void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>  
> -typedef int (*pmu_sys_event_iter_fn)(struct pmu_event *pe, void *data);
> +typedef int (*pmu_sys_event_iter_fn)(const struct pmu_event *pe, void *data);
>  void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data);
>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>  
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index 13f33d1ddb78..cd3a34840389 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -140,7 +140,7 @@ static const char *get_counter_name(int set, int nr, const struct pmu_events_map
>  	int rc, event_nr, wanted = get_counterset_start(set) + nr;
>  
>  	if (map) {
> -		struct pmu_event *evp = map->table;
> +		const struct pmu_event *evp = map->table;
>  
>  		for (; evp->name || evp->event || evp->desc; ++evp) {
>  			if (evp->name == NULL || evp->event == NULL)
> 
