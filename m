Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970374;
	b=1vHVX9bYt13rjUNZXS7NqN1DmWnCDD5pFjJtL3XeQ7uFVipZ8koqZFnkp++lmc3Y+g4E
	 t61qQ6/8WREeZvsFPjvj9RrlvVSVEf6QkKdxVoRvg+We+ctsll4VsXLu0qidLaNN9jtzT
	 FPeoizU+JidvDdnDXzMpomyXatxb+p/z2HeSUGb3+Jz9DXqruL+PuJrJu3Vkyl02qTGZ5
	 oW1ciqjFg4a9pH9B8Qk0elnZe+oNJcqvAORCYOGG4b7C2L13n4ByrpNGgNJ09UFgdpWTG
	 NgCUjuM/6HqAEI9ciEWyEx+DlvJLJxO0XD1Ay/iA30rR8HLgMnNZ/mt0DHRgr3O0AiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970374;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=/hNxqzFaAgg276dZ4HjyFYhGhgR6UPsZj01QdReBSIc=;
	b=YwFP9U9qbCyOWueTU0J0ikzkYhWgmmjkMeE6wWseXQejlge8d3NbZnx7QIuPcmt9eFtQ
	 XoxKkucIH+/sziRCBkVO2xAnt91S9/EhXOoIQS7OJhXym9T436p6I0NsZ6YvpKwayf9ej
	 dgcfJCsRfg5SUuzM3ADaaUXomXAXWG8KPPv68vJ7zqG58USKNdwUMd3ISK5CVoOaLbzEi
	 ZZi1UYTmL8jjMfChU0eoFHiMpXDw4s8taJxI6S3DghF6MsXpqw89l20RgdpR4cuOuaaWD
	 jTwU/fgyoefiukFVVbzGQJPjdwAbiXAT5cJ3WJRI4+JUSz9RiQbORXbSFeGXnmfIPNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2C606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 02:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76C2C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jTmMq1mqjz1rqY9
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 10:51:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E06F940561
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 10:52:42 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBnnu35Ev1qwR8lEw--.21410S2;
	Wed, 18 Nov 2026 10:52:42 +0800 (CST)
Message-ID: <e940e69e-f7f6-4c37-a2f9-7caeaf9fb7c4@huaweicloud.com>
Date: Wed, 18 Nov 2026 10:52:41 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/core: Disable context fast-swap for sigtrap
 events
To: sashiko-reviews@lists.linux.dev,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org
References: <cover.1794914794.git.wutengda@huaweicloud.com>
 <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
 <sashiko-outbox-218736@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-218736@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnnu35Ev1qwR8lEw--.21410S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw1xAF4fXw13CFyfCrW7Jwb_yoW7GFWDpr
	W8Ars8KFWUXr12q3WYy3W293W8Xw4FqF4DJw4qkFWfAr4Ygr9xXFy7G3WYvFs8Arn7Aa4f
	tw4q93sru34UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/17 19:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] perf/core: list_del_event() drops nr_no_switch_fast before
>   perf_pending_task()
> --
> 
> commit a5820a5e4b514a31e08f42157caca3b1bf8abed1
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf/core: Disable context fast-swap for sigtrap events
> 
> This commit disables the context switch fast-swap path for contexts containing
> sigtrap events by accounting attr->sigtrap in nr_no_switch_fast during
> list_add_event() and list_del_event() instead of __perf_event_overflow() and
> perf_pending_task().
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index da86bc6e8be94..9fc8db14c6b83 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1999,7 +1999,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
>>  		ctx->nr_user++;
>>  	if (event->attr.inherit_stat)
>>  		ctx->nr_stat++;
>> -	if (has_inherit_and_sample_read(&event->attr))
>> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>>  		local_inc(&ctx->nr_no_switch_fast);
>>  
>>  	if (event->state > PERF_EVENT_STATE_OFF)
>> @@ -2225,7 +2225,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
>>  		ctx->nr_user--;
>>  	if (event->attr.inherit_stat)
>>  		ctx->nr_stat--;
>> -	if (has_inherit_and_sample_read(&event->attr))
>> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>>  		local_dec(&ctx->nr_no_switch_fast);
>>  
>>  	list_del_rcu(&event->event_entry);
> 
> [ ... ]
> 
>> @@ -7758,7 +7763,6 @@ static void perf_pending_task(struct callback_head *head)
>>  
>>  	if (smp_load_acquire(&event->pending_work)) {
>>  		perf_sigtrap(event);
>> -		local_dec(&event->ctx->nr_no_switch_fast);
>>  		/*
>>  		 * Ensure the pending work is fully handled before allowing
>>  		 * another overflow to queue it. See __perf_event_overflow().
>> @@ -10935,7 +10939,6 @@ static int __perf_event_overflow(struct perf_event *event,
>>  		 */
>>  		if (cmpxchg_acquire(&event->pending_work, 0, pending_id) == 0) {
>>  			if (!task_work_add(current, &event->pending_task, notify_mode)) {
>> -				local_inc(&event->ctx->nr_no_switch_fast);
>>  				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
>>  
>>  				event->pending_addr = 0;
> 
> [Severity: Medium]
> Can ctx->nr_no_switch_fast drop to zero while event->pending_task is still
> queued if the sigtrap event is detached before perf_pending_task() runs?
> 
> Detaching an event does not cancel or flush event->pending_task; instead,
> pending_task holds a reference to the event until the task returns to user
> space.  When a parent event with attr.inherit and attr.sigtrap is closed while
> a child event has pending_task queued, perf_event_release_kernel() detaches the
> child events from their cloned contexts without uncloning them:
> 
> CPU0 (task A)                     CPU1
> __perf_event_overflow(child_A)
>   task_work_add(A, &child_A->pending_task)
>                                   perf_event_release_kernel(parent)
>                                     perf_remove_from_context(child_A, ...)
>                                       list_del_event(child_A, ctx_A)
>                                         local_dec(&ctx_A->nr_no_switch_fast)
>                                     perf_remove_from_context(child_B, ...)
>                                       list_del_event(child_B, ctx_B)
>                                         local_dec(&ctx_B->nr_no_switch_fast)
> schedule() (A -> B)
>   perf_event_context_sched_out(A, B)
>     /* context_equiv(ctx_A, ctx_B) && nr_no_switch_fast == 0 */
>     WRITE_ONCE(ctx_A->task, B)
> ...
> perf_pending_task(&child_A->pending_task)
>   perf_sigtrap(child_A)
>     WARN_ON_ONCE(event->ctx->task != current)  <-- trips WARN, drops SIGTRAP
> 
> Keeping the increment in __perf_event_overflow() and decrement in
> perf_pending_task() alongside list_add_event() and list_del_event() would keep
> nr_no_switch_fast elevated until pending_task completes. 

It does appear that such a scenario exists.

The nr_no_switch_fast refcount distinguishes two types of states:

1. Whether the SIGTRAP event still has a pending_task that has not yet been executed. (Pre-existing)
2. Whether the SIGTRAP event is still attached to the context. (Newly added)

Among them:
Type 1 covers the scenario where nr_no_switch_fast goes from 1 to 0 at the end.
Type 2 covers the scenario where nr_no_switch_fast goes from 0 to 1 at the beginning.

Both have windows for taking the fast path, and an nr_no_switch_fast guard is needed.
Deleting 1 in this patch does indeed seem incorrect.

Hi Sebastian, what do you think?

If there's no problem, I will roll back the deleted counter (i.e., the v3 version
of this patch).

Thanks,
Tengda

>                                                            Note that because
> list_add_event() and list_del_event() can run on a remote CPU under ctx->lock
> while __perf_event_overflow() or perf_pending_task() runs on ctx->task's CPU
> without ctx->lock, nr_no_switch_fast would also need to be atomic_t rather than
> CPU-local local_t.
> 

