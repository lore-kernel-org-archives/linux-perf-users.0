Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56203C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 07:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3972F611C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 07:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhIPHjF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:39:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3835 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhIPHjE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 03:39:04 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H984x0ZHjz67mMR;
        Thu, 16 Sep 2021 15:35:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 09:37:42 +0200
Received: from [10.47.81.58] (10.47.81.58) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 08:37:41 +0100
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eranian@google.com>
References: <20210916060525.1890638-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
Date:   Thu, 16 Sep 2021 08:41:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210916060525.1890638-1-irogers@google.com>
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

On 16/09/2021 07:05, Ian Rogers wrote:
> Test every metric and metricgroup with 'true' as a workload.
> 
> Signed-off-by: Ian Rogers<irogers@google.com>

Reviewed-by: John Garry <john.garry@huawei.com>

Note that I also had a local test for pmu events:
for e in `$PERF list --raw-dump pmu`; do
   echo "Testing $e"
   result=$($PERF stat -v -e "$e" perf bench internals synthesize)
   if [[ "$result" =~ "$e" ]]; then
     echo "Event not printed: $e"
     exit 1
   fi
done

Is there any value in upstreaming this? I could not see same already 
there. Or else make your new script generic, so that it accepts an 
argument whether to test events or metrics or metricgroups
