Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5244C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 05:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73076103C
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 05:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhJZFXn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:23:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234911AbhJZFXn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 01:23:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q1q7PD007359;
        Tue, 26 Oct 2021 05:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XDsTI/DSHvbylGRzAzj7OXc8kUeIsZCTPcWv6kVikZ8=;
 b=nBbEoTaE1ltfGkgnfQswxLYK9qz06vfNkgPbSTn+Xe4bzUb3dZY4slcKOtxlW89tFPsd
 QJNfrNMbL8TFViI3A4L9egk7DyFpwi4PauyNfOhjXNpnFi61PaAa2tbOh5nCEHxq/74t
 pTcXX+gRqRIeCiv5kfumqyB1bk1+Qxfq4KhxfrwMdiiVqMz14xrbY20gYDanLGyGhDuv
 pMN+oJXr6HV+o3/Tl85SLDSXK5pamVlC4gs36oevRVmvvOY5gBErV0PpK6odEO12QTEx
 3EPK8G2P4sWCQm6UmUiKxoa774OB/okv6Og4jmOvBT3GRo9gAGz7xcJ2YTi6MlUCcWmK 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k1gpar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 05:20:26 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q5KPqH020659;
        Tue, 26 Oct 2021 05:20:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k1gp9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 05:20:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q5IscX021548;
        Tue, 26 Oct 2021 05:20:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3bx4f12077-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 05:20:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q5KI7362587316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 05:20:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C724A4057;
        Tue, 26 Oct 2021 05:20:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E568A405F;
        Tue, 26 Oct 2021 05:20:07 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.120.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 05:20:06 +0000 (GMT)
Subject: Re: [PATCH v2 02/21] perf pmu: Add const to pmu_events_map.
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
 <20211015172132.1162559-3-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <25d62e70-1255-2730-d9b7-1cd3aa4ce54d@linux.ibm.com>
Date:   Tue, 26 Oct 2021 10:50:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015172132.1162559-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w39QLMuwMqVcpR7KdzG8HmlmVIzfTBDU
X-Proofpoint-ORIG-GUID: Cwb6P0810wEvxtpoKdWI5Tu-OdCDVt4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260026
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/15/21 10:51 PM, Ian Rogers wrote:
> The pmu_events_map is generated at compile time and used for lookup. For
> testing purposes we need to swap the map being used. Having the
> pmu_events_map be non-const is misleading as it may be an out argument.
> Make it const and update uses so they work on const too.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Patch Looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> ---
>  tools/perf/arch/arm64/util/pmu.c   |  2 +-
>  tools/perf/pmu-events/jevents.c    |  2 +-
>  tools/perf/pmu-events/pmu-events.h |  2 +-
>  tools/perf/tests/expand-cgroup.c   |  2 +-
>  tools/perf/tests/parse-metric.c    |  2 +-
>  tools/perf/tests/pmu-events.c      | 18 +++++++++---------
>  tools/perf/util/metricgroup.c      | 20 ++++++++++----------
>  tools/perf/util/metricgroup.h      |  4 ++--
>  tools/perf/util/pmu.c              | 10 +++++-----
>  tools/perf/util/pmu.h              |  6 +++---
>  tools/perf/util/s390-sample-raw.c  |  4 ++--
>  11 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 2234fbd0a912..d3a18f9c85f6 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -3,7 +3,7 @@
>  #include "../../../util/cpumap.h"
>  #include "../../../util/pmu.h"
>  
> -struct pmu_events_map *pmu_events_map__find(void)
> +const struct pmu_events_map *pmu_events_map__find(void)
>  {
>  	struct perf_pmu *pmu = NULL;
>  
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 19497e4f8a86..5624a37d6f93 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -798,7 +798,7 @@ static bool is_sys_dir(char *fname)
>  
>  static void print_mapping_table_prefix(FILE *outfp)
>  {
> -	fprintf(outfp, "struct pmu_events_map pmu_events_map[] = {\n");
> +	fprintf(outfp, "const struct pmu_events_map pmu_events_map[] = {\n");
>  }
>  
>  static void print_mapping_table_suffix(FILE *outfp)
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index 5c2bf7275c1c..42c6db6bedec 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -53,7 +53,7 @@ struct pmu_sys_events {
>   * Global table mapping each known CPU for the architecture to its
>   * table of PMU events.
>   */
> -extern struct pmu_events_map pmu_events_map[];
> +extern const struct pmu_events_map pmu_events_map[];
>  extern struct pmu_sys_events pmu_sys_event_tables[];
>  
>  #endif
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index 0e46aeb843ce..aaad51aba12f 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -193,7 +193,7 @@ static int expand_metric_events(void)
>  			.metric_name	= NULL,
>  		},
>  	};
> -	struct pmu_events_map ev_map = {
> +	const struct pmu_events_map ev_map = {
>  		.cpuid		= "test",
>  		.version	= "1",
>  		.type		= "core",
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 4f6f4904e852..dfc797ecc750 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -79,7 +79,7 @@ static struct pmu_event pme_test[] = {
>  }
>  };
>  
> -static struct pmu_events_map map = {
> +static const struct pmu_events_map map = {
>  	.cpuid		= "test",
>  	.version	= "1",
>  	.type		= "core",
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index d3534960ed25..8a1fdcd072f5 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -242,9 +242,9 @@ static bool is_same(const char *reference, const char *test)
>  	return !strcmp(reference, test);
>  }
>  
> -static struct pmu_events_map *__test_pmu_get_events_map(void)
> +static const struct pmu_events_map *__test_pmu_get_events_map(void)
>  {
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *map;
>  
>  	for (map = &pmu_events_map[0]; map->cpuid; map++) {
>  		if (!strcmp(map->cpuid, "testcpu"))
> @@ -421,7 +421,7 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
>  static int test_pmu_event_table(void)
>  {
>  	struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
> -	struct pmu_events_map *map = __test_pmu_get_events_map();
> +	const struct pmu_events_map *map = __test_pmu_get_events_map();
>  	struct pmu_event *table;
>  	int map_events = 0, expected_events;
>  
> @@ -518,7 +518,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
>  	struct perf_pmu *pmu;
>  	LIST_HEAD(aliases);
>  	int res = 0;
> -	struct pmu_events_map *map = __test_pmu_get_events_map();
> +	const struct pmu_events_map *map = __test_pmu_get_events_map();
>  	struct perf_pmu_alias *a, *tmp;
>  
>  	if (!map)
> @@ -571,7 +571,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>  	struct perf_pmu *pmu = &test_pmu->pmu;
>  	const char *pmu_name = pmu->name;
>  	struct perf_pmu_alias *a, *tmp, *alias;
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *map;
>  	LIST_HEAD(aliases);
>  	int res = 0;
>  
> @@ -825,7 +825,7 @@ struct metric {
>  
>  static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>  				 struct list_head *compound_list,
> -				 struct pmu_events_map *map,
> +				 const struct pmu_events_map *map,
>  				 const char *metric_name)
>  {
>  	struct hashmap_entry *cur, *cur_tmp;
> @@ -885,8 +885,8 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>  
>  static int test_parsing(void)
>  {
> -	struct pmu_events_map *cpus_map = pmu_events_map__find();
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *cpus_map = pmu_events_map__find();
> +	const struct pmu_events_map *map;
>  	struct pmu_event *pe;
>  	int i, j, k;
>  	int ret = 0;
> @@ -1027,7 +1027,7 @@ static int metric_parse_fake(const char *str)
>   */
>  static int test_parsing_fake(void)
>  {
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *map;
>  	struct pmu_event *pe;
>  	unsigned int i, j;
>  	int err = 0;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8ba5370f5f64..74ea0a3540ce 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -623,7 +623,7 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
>  void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  			bool raw, bool details)
>  {
> -	struct pmu_events_map *map = pmu_events_map__find();
> +	const struct pmu_events_map *map = pmu_events_map__find();
>  	struct pmu_event *pe;
>  	int i;
>  	struct rblist groups;
> @@ -910,7 +910,7 @@ static int __add_metric(struct list_head *metric_list,
>  		     match_metric(__pe->metric_name, __metric)))
>  
>  struct pmu_event *metricgroup__find_metric(const char *metric,
> -					   struct pmu_events_map *map)
> +					   const struct pmu_events_map *map)
>  {
>  	struct pmu_event *pe;
>  	int i;
> @@ -977,7 +977,7 @@ static int add_metric(struct list_head *metric_list,
>  static int __resolve_metric(struct metric *m,
>  			    bool metric_no_group,
>  			    struct list_head *metric_list,
> -			    struct pmu_events_map *map,
> +			    const struct pmu_events_map *map,
>  			    struct expr_ids *ids)
>  {
>  	struct hashmap_entry *cur;
> @@ -1025,7 +1025,7 @@ static int __resolve_metric(struct metric *m,
>  
>  static int resolve_metric(bool metric_no_group,
>  			  struct list_head *metric_list,
> -			  struct pmu_events_map *map,
> +			  const struct pmu_events_map *map,
>  			  struct expr_ids *ids)
>  {
>  	struct metric *m;
> @@ -1099,7 +1099,7 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  				   struct strbuf *events,
>  				   struct list_head *metric_list,
> -				   struct pmu_events_map *map)
> +				   const struct pmu_events_map *map)
>  {
>  	struct expr_ids ids = { .cnt = 0, };
>  	struct pmu_event *pe;
> @@ -1173,7 +1173,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>  					struct strbuf *events,
>  					struct list_head *metric_list,
> -					struct pmu_events_map *map)
> +					const struct pmu_events_map *map)
>  {
>  	char *llist, *nlist, *p;
>  	int ret = -EINVAL;
> @@ -1230,7 +1230,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  			bool metric_no_merge,
>  			struct perf_pmu *fake_pmu,
>  			struct rblist *metric_events,
> -			struct pmu_events_map *map)
> +			const struct pmu_events_map *map)
>  {
>  	struct parse_events_error parse_error;
>  	struct strbuf extra_events;
> @@ -1266,14 +1266,14 @@ int metricgroup__parse_groups(const struct option *opt,
>  			      struct rblist *metric_events)
>  {
>  	struct evlist *perf_evlist = *(struct evlist **)opt->value;
> -	struct pmu_events_map *map = pmu_events_map__find();
> +	const struct pmu_events_map *map = pmu_events_map__find();
>  
>  	return parse_groups(perf_evlist, str, metric_no_group,
>  			    metric_no_merge, NULL, metric_events, map);
>  }
>  
>  int metricgroup__parse_groups_test(struct evlist *evlist,
> -				   struct pmu_events_map *map,
> +				   const struct pmu_events_map *map,
>  				   const char *str,
>  				   bool metric_no_group,
>  				   bool metric_no_merge,
> @@ -1285,7 +1285,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
>  
>  bool metricgroup__has_metric(const char *metric)
>  {
> -	struct pmu_events_map *map = pmu_events_map__find();
> +	const struct pmu_events_map *map = pmu_events_map__find();
>  	struct pmu_event *pe;
>  	int i;
>  
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index cc4a92492a61..c931596557bf 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -44,9 +44,9 @@ int metricgroup__parse_groups(const struct option *opt,
>  			      bool metric_no_merge,
>  			      struct rblist *metric_events);
>  struct pmu_event *metricgroup__find_metric(const char *metric,
> -					   struct pmu_events_map *map);
> +					   const struct pmu_events_map *map);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
> -				   struct pmu_events_map *map,
> +				   const struct pmu_events_map *map,
>  				   const char *str,
>  				   bool metric_no_group,
>  				   bool metric_no_merge,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index bdabd62170d2..4bcdc595ce5e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -710,9 +710,9 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
>  	return cpuid;
>  }
>  
> -struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
> +const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>  {
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *map;
>  	char *cpuid = perf_pmu__getcpuid(pmu);
>  	int i;
>  
> @@ -737,7 +737,7 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>  	return map;
>  }
>  
> -struct pmu_events_map *__weak pmu_events_map__find(void)
> +const struct pmu_events_map *__weak pmu_events_map__find(void)
>  {
>  	return perf_pmu__find_map(NULL);
>  }
> @@ -824,7 +824,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>   * as aliases.
>   */
>  void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
> -			     struct pmu_events_map *map)
> +			     const struct pmu_events_map *map)
>  {
>  	int i;
>  	const char *name = pmu->name;
> @@ -859,7 +859,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>  
>  static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>  {
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *map;
>  
>  	map = perf_pmu__find_map(pmu);
>  	if (!map)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 394898b07fd9..dd5cdde6a3d0 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -120,10 +120,10 @@ int perf_pmu__test(void);
>  
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
>  void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
> -			     struct pmu_events_map *map);
> +			     const struct pmu_events_map *map);
>  
> -struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
> -struct pmu_events_map *pmu_events_map__find(void);
> +const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
> +const struct pmu_events_map *pmu_events_map__find(void);
>  bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
>  void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>  
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index 08ec3c3ae0ee..13f33d1ddb78 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -135,7 +135,7 @@ static int get_counterset_start(int setnr)
>   * the name of this counter.
>   * If no match is found a NULL pointer is returned.
>   */
> -static const char *get_counter_name(int set, int nr, struct pmu_events_map *map)
> +static const char *get_counter_name(int set, int nr, const struct pmu_events_map *map)
>  {
>  	int rc, event_nr, wanted = get_counterset_start(set) + nr;
>  
> @@ -159,7 +159,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
>  	unsigned char *buf = sample->raw_data;
>  	const char *color = PERF_COLOR_BLUE;
>  	struct cf_ctrset_entry *cep, ce;
> -	struct pmu_events_map *map;
> +	const struct pmu_events_map *map;
>  	u64 *p;
>  
>  	map = pmu_events_map__find();
> 
