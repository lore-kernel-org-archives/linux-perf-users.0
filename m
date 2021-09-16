Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC05C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 07:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D3B61185
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 07:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhIPHcK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:32:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3834 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhIPHcH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 03:32:07 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H97wf6bg0z67tFm;
        Thu, 16 Sep 2021 15:28:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 16 Sep 2021 09:30:42 +0200
Received: from [10.47.81.58] (10.47.81.58) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 08:30:39 +0100
Subject: Re: [RFC PATCH] perf test: Workload test of metric and metricgroups
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Jin Yao" <yao.jin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>
References: <20210819055629.1059168-1-irogers@google.com>
 <YS52wU9r9U/x4lkb@krava>
 <CAP-5=fUf5zK-GEjzqK--6G_R=nj4qERCzo2+muQhKWwreWBCww@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2ec8cbf6-cbc1-0dc2-0025-08da764f1ade@huawei.com>
Date:   Thu, 16 Sep 2021 08:34:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUf5zK-GEjzqK--6G_R=nj4qERCzo2+muQhKWwreWBCww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.58]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>>> --- /dev/null
>>> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
>>> @@ -0,0 +1,16 @@
>>> +#!/bin/sh
>>> +# perf all metrics test
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +set -e
>>> +
>>> +for m in `perf list --raw-dump metrics`; do
>>> +  echo "Testing $m"
>>> +  result=$(perf stat -M "$m" perf bench internals synthesize)
>> good test, but takes forever.. running 'true' should be enough for the test?
>>
>> jirka
> Agreed/done:
> https://lore.kernel.org/linux-perf-users/20210916060525.1890638-1-irogers@google.com/T/#u
> There is an issue that I see a lot of "<not counted>" for metricgroups
> like this. 

https://lore.kernel.org/linux-perf-users/CAP-5=fVERioMuK=JgKr1QWXKvU0Y31efQjxh7hX32ifL9V+_EA@mail.gmail.com/

Same issue, right?

Thanks,
John

> Note, the metricgroups test is also failing on my skylake
> as I hit the bug fixed in:
> https://lore.kernel.org/lkml/20210819054707.1057819-1-irogers@google.com/

