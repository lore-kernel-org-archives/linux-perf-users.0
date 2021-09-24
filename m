Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55288C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A69A60F9C
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 19:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbhIXThp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:37:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3875 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbhIXThp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 15:37:45 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HGMdR5wM2z67bZV;
        Sat, 25 Sep 2021 03:33:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 24 Sep 2021 21:36:09 +0200
Received: from [10.47.85.198] (10.47.85.198) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 20:36:08 +0100
Subject: Re: [PATCH v3 1/2] perf test: Workload test of metric and
 metricgroups
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>
References: <20210917184240.2181186-1-irogers@google.com>
 <YU4iVcVc6uYAWft4@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ea23f319-49df-5905-758e-478baf44bdc9@huawei.com>
Date:   Fri, 24 Sep 2021 20:39:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YU4iVcVc6uYAWft4@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.198]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/09/2021 20:09, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 17, 2021 at 11:42:39AM -0700, Ian Rogers escreveu:
>> Test every metric and metricgroup with 'true' as a workload. For
>> metrics, check that we see the metric printed or get unsupported. If the
>> 'true' workload executes too quickly retry with 'perf bench internals
>> synthesize'.
>>
>> v3. Fix test condition (thanks to Paul A. Clarke<pc@us.ibm.com>). Add a
>>      fallback case of a larger workload so that we don't ignore "<not
>>      counted>".
>> v2. Switched the workload to something faster.
> Hi John, does your Reviewed-by stands for v3 too?
> 
> - Arnaldo
>   

Yeah,

Reviewed-by: John Garry <john.garry@huawei.com>


Thanks
