Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15356C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14416058D
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 08:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhJZIVW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:21:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233719AbhJZIVU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 04:21:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q70IxD020681;
        Tue, 26 Oct 2021 08:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ebMojcpEyr6fUcE9nEoZuwjUb0IiK9BsYvDF0GExPco=;
 b=UMncXSirT7L/6+hcSb7M8kWlsKuyy9u210Q3bTOWUNFhNsI2Kl5f6DPoa7n11ihqrRUO
 oDnItpvDe7jzFySRXGw8ps7hsY1c2OXR4eDsF21uzLtXtt+UIF4noCCl6YQboFhPHeBB
 URPl9U0sK/XrtlQVGFzhLH+yQuNKy5a+K34BQiWKRTr5JFJkC1GfsGPLe9ERMnNlfMzQ
 NjxCbo+02/FK1AWNEPge8Ncb5CVkJ0PYWKe0mw2HOM/NWULDH270GuCWFmU59pXkSimm
 HwjFVpu4GsNLxp+SShssKcpBFVcNyVTbqavgnb+EBCsLjfNqMZ6yY5VWrRMOSxrzWrpL iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx5ex4ysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:18:22 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q8Ekd2000366;
        Tue, 26 Oct 2021 08:18:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx5ex4yrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:18:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q8CvaK030217;
        Tue, 26 Oct 2021 08:18:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3bx4f13ceh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:18:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q8IDeP50004260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 08:18:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F639A4051;
        Tue, 26 Oct 2021 08:18:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED7CCA405D;
        Tue, 26 Oct 2021 08:18:01 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.120.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 08:18:01 +0000 (GMT)
Subject: Re: [PATCH v2 06/21] perf metric: Add documentation and rename a
 variable.
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
 <20211015172132.1162559-7-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <38906a72-d974-73c1-636e-54a3d87f0fa5@linux.ibm.com>
Date:   Tue, 26 Oct 2021 13:48:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015172132.1162559-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bqqBUXNQeP3_KAQvJ_J1bh6nuIutP0R6
X-Proofpoint-ORIG-GUID: sW2-bQGKyeHsVAkKYR4Cvb7YyTQ6z920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260045
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/15/21 10:51 PM, Ian Rogers wrote:
> Documentation to make current functionality clearer. Rename a variable
> called 'metric' to 'metric_name' as it can be ambiguous as to whether a
> string is the name of a metric or the expression.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

>  tools/perf/util/metricgroup.c | 59 ++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 139f4a793f92..3e5f02938452 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -776,13 +776,27 @@ int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
>  
>  struct metricgroup_add_iter_data {
>  	struct list_head *metric_list;
> -	const char *metric;
> +	const char *metric_name;
>  	struct expr_ids *ids;
>  	int *ret;
>  	bool *has_match;
>  	bool metric_no_group;
>  };
>  
> +/**
> + * __add_metric - Add a metric to metric_list.
> + * @metric_list: The list the metric is added to.
> + * @pe: The pmu_event containing the metric to be added.
> + * @metric_no_group: Should events written to events be grouped "{}" or
> + *                   global. Grouping is the default but due to multiplexing the
> + *                   user may override.
> + * @runtime: A special argument for the parser only known at runtime.
> + * @mp: The pointer to a location holding the first metric added to metric
> + *      list. It is initialized here if this is the first metric.
> + * @parent: The last entry in a linked list of metrics being
> + *          added/resolved. This is maintained to detect recursion.
> + * @ids: Storage for parent list.
> + */
>  static int __add_metric(struct list_head *metric_list,
>  			const struct pmu_event *pe,
>  			bool metric_no_group,
> @@ -1076,7 +1090,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
>  	struct metric *m = NULL;
>  	int ret;
>  
> -	if (!match_pe_metric(pe, d->metric))
> +	if (!match_pe_metric(pe, d->metric_name))
>  		return 0;
>  
>  	ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
> @@ -1095,7 +1109,22 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
>  	return ret;
>  }
>  
> -static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> +/**
> + * metricgroup__add_metric - Find and add a metric, or a metric group.
> + * @metric_name: The name of the metric or metric group. For example, "IPC"
> + *               could be the name of a metric and "TopDownL1" the name of a
> + *               metric group.
> + * @metric_no_group: Should events written to events be grouped "{}" or
> + *                   global. Grouping is the default but due to multiplexing the
> + *                   user may override.
> + * @events: an out argument string of events that need to be parsed and
> + *          associated with the metric. For example, the metric "IPC" would
> + *          create an events string like "{instructions,cycles}:W".
> + * @metric_list: The list that the metric or metric group are added to.
> + * @map: The map that is searched for metrics, most commonly the table for the
> + *       architecture perf is running upon.
> + */
> +static int metricgroup__add_metric(const char *metric_name, bool metric_no_group,
>  				   struct strbuf *events,
>  				   struct list_head *metric_list,
>  				   const struct pmu_events_map *map)
> @@ -1107,7 +1136,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  	int i, ret;
>  	bool has_match = false;
>  
> -	map_for_each_metric(pe, i, map, metric) {
> +	/*
> +	 * Iterate over all metrics seeing if metric matches either the name or
> +	 * group. When it does add the metric to the list.
> +	 */
> +	map_for_each_metric(pe, i, map, metric_name) {
>  		has_match = true;
>  		m = NULL;
>  
> @@ -1130,7 +1163,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  			.fn = metricgroup__add_metric_sys_event_iter,
>  			.data = (void *) &(struct metricgroup_add_iter_data) {
>  				.metric_list = &list,
> -				.metric = metric,
> +				.metric_name = metric_name,
>  				.metric_no_group = metric_no_group,
>  				.ids = &ids,
>  				.has_match = &has_match,
> @@ -1169,6 +1202,22 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  	return ret;
>  }
>  
> +/**
> + * metricgroup__add_metric_list - Find and add metrics, or metric groups,
> + *                                specified in a list.
> + * @list: the list of metrics or metric groups. For example, "IPC,CPI,TopDownL1"
> + *        would match the IPC and CPI metrics, and TopDownL1 would match all
> + *        the metrics in the TopDownL1 group.
> + * @metric_no_group: Should events written to events be grouped "{}" or
> + *                   global. Grouping is the default but due to multiplexing the
> + *                   user may override.
> + * @events: an out argument string of events that need to be parsed and
> + *          associated with the metric. For example, the metric "IPC" would
> + *          create an events string like "{instructions,cycles}:W".
> + * @metric_list: The list that metrics are added to.
> + * @map: The map that is searched for metrics, most commonly the table for the
> + *       architecture perf is running upon.
> + */
>  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>  					struct strbuf *events,
>  					struct list_head *metric_list,
> 
