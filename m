Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D98C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C428360FE9
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 11:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFVMAv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 08:00:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3300 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFVMAr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 08:00:47 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G8PmY70gwz6H71c;
        Tue, 22 Jun 2021 19:48:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 13:58:29 +0200
Received: from [10.47.89.126] (10.47.89.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 22 Jun
 2021 12:58:28 +0100
Subject: Re: perf tool: About tests debug level
To:     Ian Rogers <irogers@google.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Jin Yao" <yao.jin@linux.intel.com>
References: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
 <CAP-5=fUxQZ+rxLEn6jeRNVMf48BaPNdaUdoMs8LY4P-GROiOnw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cd501541-deb5-f2f5-e086-cca44b40c87d@huawei.com>
Date:   Tue, 22 Jun 2021 12:52:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUxQZ+rxLEn6jeRNVMf48BaPNdaUdoMs8LY4P-GROiOnw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.126]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/06/2021 06:04, Ian Rogers wrote:
>> ---- end ----
>> Parse and process metrics: FAILED!
>>
>> Note that the "FAILED" messages from the test code come from pr_debug().
>>
>> In a way, I feel that pr_debug()/err from the test is more important
>> than pr_debug() from the core code (when running a test).
>>
>> Any opinion on this or how to improve (if anyone agrees with me)? Or am
>> I missing something? Or is it not so important?
> Hi John,
> 

Hi Ian,

> I think the issue is that in the parsing you don't know it's broken
> until something goes wrong. Putting everything on pr_err would cause
> spam in the not broken case.

Right, I would not suggest using pr_err everywhere.

> Improving the parsing error handling is a
> big task with lex and yacc to some extent getting in the way. Perhaps
> a middle way is to have a parameter to the parser that logs more, and
> recursively call this in the parser when parsing fails. I guess there
> is also a danger of a performance hit.

So I am thinking that for running a test, -v means different levels logs 
for test code and for core (non-test code). For example, -v prints 
pr_warn() and higher for test logs, but nothing for core logs. And then 
-vv for running a test gives pr_debug and above for test logs, and 
pr_warn and above for core logs. Or something like that.

Maybe that is not a good idea. But I'm just saying that it's hard to 
debug currently at -v for tests.

Thanks,
John
