Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A284ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Oct 2022 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJaNL7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiJaNL5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Oct 2022 09:11:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1DFD1B
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Oct 2022 06:11:55 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1D7X6lJZzHvWJ;
        Mon, 31 Oct 2022 21:11:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:11:54 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:11:53 +0800
Subject: Re: [PATCH -next] perf/core: Using kfree_rcu() to simplify the code
 in put_ctx()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-perf-users@vger.kernel.org>, <ravi.bangoria@amd.com>,
        <yangyingliang@huawei.com>
References: <20221029034027.2006045-1-yangyingliang@huawei.com>
 <Y1/CGIjCpWmou8nk@hirez.programming.kicks-ass.net>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <c63b58e5-7d84-a2aa-e9ae-fc20182a5c81@huawei.com>
Date:   Mon, 31 Oct 2022 21:11:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y1/CGIjCpWmou8nk@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On 2022/10/31 20:39, Peter Zijlstra wrote:
> On Sat, Oct 29, 2022 at 11:40:27AM +0800, Yang Yingliang wrote:
>> After commit 983bd8543b5a ("perf: Rewrite core context handling"),
>> the callback function of call_rcu() just calls a kfree(), so we
>> can use kfree_rcu() instead of call_rcu() + callback function.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   kernel/events/core.c | 10 +---------
>>   1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index ebd9ebd53238..9bb274dd2aa6 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1157,14 +1157,6 @@ static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
>>   		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
>>   }
>>   
>> -static void free_ctx(struct rcu_head *head)
>> -{
>> -	struct perf_event_context *ctx;
>> -
>> -	ctx = container_of(head, struct perf_event_context, rcu_head);
>> -	kfree(ctx);
>> -}
>> -
>>   static void put_ctx(struct perf_event_context *ctx)
>>   {
>>   	if (refcount_dec_and_test(&ctx->refcount)) {
>> @@ -1172,7 +1164,7 @@ static void put_ctx(struct perf_event_context *ctx)
>>   			put_ctx(ctx->parent_ctx);
>>   		if (ctx->task && ctx->task != TASK_TOMBSTONE)
>>   			put_task_struct(ctx->task);
>> -		call_rcu(&ctx->rcu_head, free_ctx);
>> +		kfree_rcu(ctx, rcu_head);
>>   	}
>>   }
> While valid; I think I prefer the explicit form. This makes it much
> easier to add some debug code for example.
Good point, thanks for replying.

Yang
>
> .
