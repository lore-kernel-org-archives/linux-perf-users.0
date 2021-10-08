Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C73C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208A66103C
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 11:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJHLHL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 07:07:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3948 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhJHLHJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 07:07:09 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HQld04Q2qz67T5g;
        Fri,  8 Oct 2021 19:01:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 13:05:12 +0200
Received: from [10.47.80.141] (10.47.80.141) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 12:05:10 +0100
Subject: Re: [PATCH 04/21] perf pmu: Make pmu_event tables const.
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jacob Keller" <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>,
        "Fabian Hemmer" <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        "Sumanth Korikkar" <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20211007165647.3514803-1-irogers@google.com>
 <20211007165647.3514803-5-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <eb0fdeea-147b-0c02-f598-0f60b724d409@huawei.com>
Date:   Fri, 8 Oct 2021 12:07:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211007165647.3514803-5-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.141]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 07/10/2021 17:56, Ian Rogers wrote:
>   

- bouncing changbin du address

> -int arch_get_runtimeparam(struct pmu_event *pe)
> +int arch_get_runtimeparam(const struct pmu_event *pe)
>   {
>   	int count;
>   	char path[PATH_MAX] = "/devices/hv_24x7/interface/";
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index a31de0f77097..b3431c11c9cb 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -362,7 +362,7 @@ static int close_table;
>   
>   static void print_events_table_prefix(FILE *fp, const char *tblname)
>   {
> -	fprintf(fp, "struct pmu_event %s[] = {\n", tblname);
> +	fprintf(fp, "const struct pmu_event %s[] = {\n", tblname);

can these be static as well?

>   	close_table = 1;
>   }

