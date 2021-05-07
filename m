Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13226C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 09:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50DE6144F
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 09:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhEGJBC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 05:01:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3034 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhEGJBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 05:01:01 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fc44d3ChRz6rnCk;
        Fri,  7 May 2021 16:54:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 11:00:00 +0200
Received: from [10.47.82.108] (10.47.82.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 09:59:59 +0100
Subject: Re: [PATCH] perf jevents: Silence warning for ArchStd files
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210506225640.1461000-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
Date:   Fri, 7 May 2021 09:59:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210506225640.1461000-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.108]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06/05/2021 23:56, Ian Rogers wrote:
> json files in the level 1 directory are used for ArchStd events (see
> preprocess_arch_std_files), as such they shouldn't be warned about.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/jevents.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index ed4f0bd72e5a..7422b0ea8790 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>   			mapfile = strdup(fpath);
>   			return 0;
>   		}
> -
> -		pr_info("%s: Ignoring file %s\n", prog, fpath);
> +		if (is_json_file(bname))
> +			pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath)
We could get more elaborate and add the same first debug print in 
process_one_file() to preprocess_arch_std_file() to give the allusion 
that they are preprocessed, and change the logic not print that for arch 
std files (in process_one_file()). But not sure it's worth it.

Or else we could also just omit any print here for archstd files here.

But I suppose what you are doing is ok...

Thanks,
John

> +		else
> +			pr_info("%s: Ignoring file %s\n", prog, fpath);
>   		return 0;
>   	}
>   
> 

