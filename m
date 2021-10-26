Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34817C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 05:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1064F61002
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 05:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhJZF3R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:29:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233375AbhJZF3Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 01:29:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q2AkmV024786;
        Tue, 26 Oct 2021 05:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sZcOWG43I4PDcyKDJGRSZD7/rNzsQiLLe5P+jAVx1Vw=;
 b=Fckrji53l/1FAQtegIjCkVAwhFZAicpN1tq7BMRYLmQcnnv63qrzmauJLI+/AiLAdFKA
 h7t/tPv5vgJAZMgmcoyn6WecVNYh2JCDRPQ25oBjfREbPy6ImT8ahx5W71eOzXQCOi7x
 uzVfpzn4WUK36mBxKG6A5//xwIahzWbJokbZtY75yPx6gyvnfOAzGFkSqABp2zrFat6p
 o7X1wkZzZnO3Gg25/5ZiPOtYH5sGbQ3bk7la7epq8LL2eZILMmb3UppjYxE+5ldQDjDT
 jpFh/dP75vHhOOQKeRnK4aVn6Cr3c6QrPqKaacYaWJ0AWO4okmB1HVY3SYTpZDDVTb1y FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx4k5gsk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 05:26:20 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q4fAva009358;
        Tue, 26 Oct 2021 05:26:19 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx4k5gsj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 05:26:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q5MWne006972;
        Tue, 26 Oct 2021 05:26:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4est180-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 05:26:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q5QDHs53150090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 05:26:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3E69A4040;
        Tue, 26 Oct 2021 05:26:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7510DA4057;
        Tue, 26 Oct 2021 05:26:02 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.120.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 05:26:02 +0000 (GMT)
Subject: Re: [PATCH v2 03/21] perf pmu: Make pmu_sys_event_tables const.
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
 <20211015172132.1162559-4-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <ec94273e-2f11-cee9-4d8d-4cc9d664c0b2@linux.ibm.com>
Date:   Tue, 26 Oct 2021 10:56:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015172132.1162559-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _U3S9reME-n30kEA0LEUxwlzP4wzAcAu
X-Proofpoint-GUID: _FI8ZpIzSKG4SCL4xCarG3yK5zp-oYiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260026
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/15/21 10:51 PM, Ian Rogers wrote:
> Make lookup nature of data structures clearer through their type.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 2 +-
>  tools/perf/pmu-events/pmu-events.h | 2 +-
>  tools/perf/tests/pmu-events.c      | 2 +-
>  tools/perf/util/pmu.c              | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 5624a37d6f93..a31de0f77097 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -832,7 +832,7 @@ static void print_mapping_test_table(FILE *outfp)
>  
>  static void print_system_event_mapping_table_prefix(FILE *outfp)
>  {
> -	fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
> +	fprintf(outfp, "\nconst struct pmu_sys_events pmu_sys_event_tables[] = {");
>  }
>  
>  static void print_system_event_mapping_table_suffix(FILE *outfp)
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index 42c6db6bedec..f6c9c9fc4ab2 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -54,6 +54,6 @@ struct pmu_sys_events {
>   * table of PMU events.
>   */
>  extern const struct pmu_events_map pmu_events_map[];
> -extern struct pmu_sys_events pmu_sys_event_tables[];
> +extern const struct pmu_sys_events pmu_sys_event_tables[];
>  
>  #endif
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 8a1fdcd072f5..c0f8b61871c8 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -258,7 +258,7 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
>  
>  static struct pmu_event *__test_pmu_get_sys_events_table(void)
>  {
> -	struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
> +	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
>  
>  	for ( ; tables->name; tables++) {
>  		if (!strcmp("pme_test_soc_sys", tables->name))
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 4bcdc595ce5e..c04a89cc7cef 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -873,7 +873,7 @@ void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
>  	int i = 0;
>  
>  	while (1) {
> -		struct pmu_sys_events *event_table;
> +		const struct pmu_sys_events *event_table;
>  		int j = 0;
>  
>  		event_table = &pmu_sys_event_tables[i++];
> 
