Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167CFC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6D061440
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 15:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbhI2PRu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:17:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3891 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345079AbhI2PRt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 11:17:49 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKKdR1LCKz67Ntj;
        Wed, 29 Sep 2021 23:13:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 17:16:06 +0200
Received: from [10.47.26.77] (10.47.26.77) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 16:16:05 +0100
Subject: Re: [PATCH v9 00/13] Don't compute events that won't be used in a
 metric.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>,
        kajoljain <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
References: <20210923074616.674826-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <00eb6280-fad0-66c4-b957-a4d27dffd0da@huawei.com>
Date:   Wed, 29 Sep 2021 16:19:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.77]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 23/09/2021 08:46, Ian Rogers wrote:
> For a metric like:
>    EVENT1 if #smt_on else EVENT2
>      
> currently EVENT1 and EVENT2 will be measured and then when the metric
> is reported EVENT1 or EVENT2 will be printed depending on the value
> from smt_on() during the expr parsing. Computing both events is
> unnecessary and can lead to multiplexing as discussed in this thread:
> https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
> 
> This change modifies expression parsing so that constants are
> considered when building the set of ids (events) and only events not
> contributing to a constant value are measured.

Based on some testing on my arm64 platform, no regression seen, so:

Tested-by: John Garry <john.garry@huawei.com>

