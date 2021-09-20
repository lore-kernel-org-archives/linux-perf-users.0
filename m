Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34DC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1078660F4B
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 10:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhITKCR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 06:02:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3845 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhITKCQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Sep 2021 06:02:16 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HCg3h30Pjz67N8Z;
        Mon, 20 Sep 2021 17:58:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 20 Sep 2021 12:00:47 +0200
Received: from [10.47.88.85] (10.47.88.85) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 20 Sep
 2021 11:00:46 +0100
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>, Paul Clarke <pc@us.ibm.com>
References: <20210916060525.1890638-1-irogers@google.com>
 <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
 <CAP-5=fUAxfHb8fNjpPKthztJhB7Q3yUZucLS-6kKZtq-iNOVoA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <361478a4-98d0-d488-2903-2c859a2c8524@huawei.com>
Date:   Mon, 20 Sep 2021 11:04:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUAxfHb8fNjpPKthztJhB7Q3yUZucLS-6kKZtq-iNOVoA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.85]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/09/2021 20:16, Ian Rogers wrote:
> On Thu, Sep 16, 2021 at 12:37 AM John Garry<john.garry@huawei.com>  wrote:
>> On 16/09/2021 07:05, Ian Rogers wrote:
>>> Test every metric and metricgroup with 'true' as a workload.
>>>
>>> Signed-off-by: Ian Rogers<irogers@google.com>
>> Reviewed-by: John Garry<john.garry@huawei.com>
>>
>> Note that I also had a local test for pmu events:
>> for e in `$PERF list --raw-dump pmu`; do
>>     echo "Testing $e"
>>     result=$($PERF stat -v -e "$e" perf bench internals synthesize)
>>     if [[ "$result" =~ "$e" ]]; then
>>       echo "Event not printed: $e"
>>       exit 1
>>     fi
>> done
>>
>> Is there any value in upstreaming this? I could not see same already
>> there. Or else make your new script generic, so that it accepts an
>> argument whether to test events or metrics or metricgroups
> It is not easy to make a generic script with the current shell test
> infrastructure. I made a variant of this test:
> https://lore.kernel.org/linux-perf-users/20210917184240.2181186-2-irogers@google.com/T/#u
> For skylake it ran for 1m15s and so it may be too slow. Perhaps we
> need to add to the test infrastructure with some kind of speed flag.

Hi Ian,

I suggested this before I realized that it would be called from "perf test".

You think that 1m15s could be considered too slow, but I think that it 
could be much slower to now run "perf test" on some other systems. Like 
my arm64 system - see series 
https://lore.kernel.org/linux-perf-users/1631795665-240946-1-git-send-email-john.garry@huawei.com/T/#t 
- where I mention that we have >700 HW PMU events (before applying that 
series to take advantage of the event merging). And each of those events 
would be tested individually - slow...

So firstly maybe a speed or test level flag could be added before we try 
this. Sorry for any inconvenience caused.

Thanks,
John
