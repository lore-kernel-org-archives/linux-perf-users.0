Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877061;
	b=JGhdNCkNsx7cycAgo4JaPlho/Zbxcilr06e/514Dr2Yq0Eev7ClOT6mO2uAXqpKbbPTB
	 d0m/gDht2c4pr07PiEFeIINDY3gwzBfSZCAMxCn84ur5qgAlZJtSrtl/pLnuWttA8dR0+
	 jzjGzC3G4UVJ8Wl2zj37UhlyhrVt+E8D32/DHcMvXUu1OSok62F8zpKJVGd4ImGt+C3CH
	 ag1zdBCZfaT5qCDABy19Kt7irpi25i8PW93NjfyntMw0cSQg0rN6XO2ysFVutHEkuGINh
	 akdnnmDegQYVI1qXv8PkM/wBPBxTIka3OJ/KXJKBEHFKiuU/bF7bK6VYAYy/VxP9bHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877061;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nLP8FjU8VeS2bAJGd+i5qRJ+HHyTms5Kv3wdCiRALfI=;
	b=4s56nct/k72wBd4Anrd5JK4+FjgpFO2fVC9/5huNMG5JWsw8UV56XX92ncy36T87Bizt
	 Ii7Q1wZn1TmZOwKAm1l6mhdJbgzd81rE4CqvkO2loo5aQIiKurXWgi4RP3Shx3AcMWVdo
	 ZfgnLIWoIbU2Xg3HRHahV4Qyr0mP+zqcd3gRUkRe4WkHY13981xjZVmiZRtgTL45f5DkH
	 AH2ELFVNQXCNF29h2Fnaqzp/nfxuLSKQAJpt2K/utafrGUE3ufzTP/60Ji/NGkl/aVxJL
	 CnqHzPStg1Ru6+JRcOiOpeZKirq+O1lCN+BRdiHm5KQGxPFqLHvL/zVAGi8+j94fIxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5444606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5444606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jL0351dSyz1c0lD
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 19:10:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 86426405B4
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 19:10:54 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCHjP89ZOxq+hWIDA--.60011S2;
	Thu, 05 Nov 2026 19:10:54 +0800 (CST)
Message-ID: <b5d10cd7-e3af-4e07-a19b-44544077db59@huaweicloud.com>
Date: Thu, 5 Nov 2026 19:10:53 +0800
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
Subject: Re: [PATCH v3 2/2] perf/core: Disable context fast-swap for sigtrap
 events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>
 <sashiko-outbox-198777@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-198777@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHjP89ZOxq+hWIDA--.60011S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw1ruw4UKr4rWr4fKr1Utrb_yoW7Xr1xpr
	WUCr4rtrW8XF1jqa15t3W09w18Xw4rKF4Duw1qkFW3Ar4Ygr9xWFyUGw1YvFn8Jrn2yFyx
	t3yqvrZ8C34UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/5 17:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf/core: non-SMP-atomic local_t race on ctx->nr_no_switch_fast
> --
> 
> commit 6723e8dad1dd2932a4b047f419d5e1deb0db8c7c
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf/core: Disable context fast-swap for sigtrap events
> 
> This commit excludes events with attr.sigtrap from the context switch
> fast-swap path by incrementing and decrementing ctx->nr_no_switch_fast in
> list_add_event() and list_del_event(). This prevents ctx->task from being
> swapped to another task while a sigtrap event is attached to the context.
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 5842552294c19..1d4b16dc190db 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1067,10 +1067,8 @@ struct perf_event_context {
>>  	 * should be avoided.
>>  	 *
>>  	 * Sum (event->pending_work + events with
>> -	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)))
>> -	 *
>> -	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
>> -	 * that until the signal is delivered.
>> +	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)) +
>> +	 *    events with attr->sigtrap)
>>  	 */
>>  	local_t				nr_no_switch_fast;
>>  };
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7aac14663c80c..6964cd1e6bfec 100644
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
> 
> [Severity: High]
> Can incrementing and decrementing ctx->nr_no_switch_fast here race across
> CPUs because nr_no_switch_fast is a local_t rather than an atomic_t?
> 
> In struct perf_event_context, nr_no_switch_fast is declared as local_t,
> where local_inc() and local_dec() are only CPU-local atomic (for example,
> unlocked incq/decq on x86) and do not serialize concurrent read-modify-write
> updates across different CPUs.
> 
> When installing a disabled sigtrap event into a non-empty task context,
> perf_install_in_context() takes the fast path on the caller's CPU without
> sending an IPI to the CPU running ctx->task:
> 
> kernel/events/core.c:perf_install_in_context() {
> 	...
> 	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF &&
> 	    ctx->nr_events && !is_cgroup_event(event)) {
> 		raw_spin_lock_irq(&ctx->lock);
> 		if (ctx->task == TASK_TOMBSTONE) {
> 			raw_spin_unlock_irq(&ctx->lock);
> 			return;
> 		}
> 		add_event_to_ctx(event, ctx);
> 		raw_spin_unlock_irq(&ctx->lock);
> 		return;
> 	}
> 	...
> }
> 
> This runs add_event_to_ctx() -> list_add_event() ->
> local_inc(&ctx->nr_no_switch_fast) on the installer CPU under ctx->lock.
> 
> Concurrently, on the CPU where ctx->task is running, an already-active
> sigtrap event in the same context can overflow in __perf_event_overflow() or
> complete task_work in perf_pending_task(), both of which modify
> ctx->nr_no_switch_fast without holding ctx->lock:
> 
> kernel/events/core.c:__perf_event_overflow() {
> 	...
> 			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> 				local_inc(&event->ctx->nr_no_switch_fast);
> 	...
> }
> 
> kernel/events/core.c:perf_pending_task() {
> 	...
> 	if (event->pending_work) {
> 		event->pending_work = 0;
> 		perf_sigtrap(event);
> 		local_dec(&event->ctx->nr_no_switch_fast);
> 	}
> 	...
> }
> 
> Similarly, if ctx becomes inactive (!ctx->is_active) while ctx->task still
> has pending task_work in flight, perf_remove_from_context() ->
> __perf_remove_from_context() -> list_del_event() can execute
> local_dec(&ctx->nr_no_switch_fast) on a remote CPU concurrently with
> perf_pending_task() executing local_dec(&event->ctx->nr_no_switch_fast) on
> ctx->task's CPU.
> 
> Could these concurrent cross-CPU local_inc() and local_dec() operations lose
> updates to ctx->nr_no_switch_fast, allowing the counter to drop to zero
> while a sigtrap event is still attached and re-enabling the fast-swap path?
> Should nr_no_switch_fast be converted from local_t to atomic_t?
> 

This looks like a pre-existing issue, so it's probably better to fix it
with a separate patch rather than expand this series.

Thanks,
Tengda

