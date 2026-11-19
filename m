Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088402;
	b=stjEISBVmImF8HUNSXQBB8dyLwLf8zaJgG7A2aDReimuLKlEAxAA0r48fUmZJDZcUdqs
	 nwLB9s+uzJ8BymerQOTGp8YnKswjp9Gjj8ilE4Wq+4wUPtCUBP91lqzxVGkuzwf36oCPN
	 vN65Q4oBc7rwGSMwatReQGjCgy9VRmZXXFrnn2w171hdLLbtjYETvl48K61f0uBMHKCGO
	 Y0/rSV+hvj0nC3hMXw4KXL4TSJF/+y/GJUf6nODyPh5KAVrgSgmWkHcyQ5/IHDBrT6DfI
	 iLLYMESMCY9Y1MkCPefiU/VGDCp4G9DM0pJlk7DnU4Spo+x15Mm2l7KzVWDq6CeHOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088402;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nQChFNEB15AD4YGjkZsxF9JynHwfzvCzK6Q2wqWZFUI=;
	b=cQxgvu+cXpUc9n1NiQ1Pn2tF4O2SCj7rXEbS9hnVwAiJB2qSm78gf6/WeIi05BoWtV4e
	 7AqfG6sn9lW80ghqX+OanbV/MFGE6yCr9xM3TFcX87VsNn7OBDjKkKpXC3/yAAnVnRAOa
	 iYQNuRRK4qPamyjveIAY3VyzzV7fWFOWi3VrAYqSJZY/25Eex5ZkBReyJtlcjVY1J47Bt
	 grH00TBnIfbft0r/WVenGhjPnoAJa4T5/8Rfxq46blaCDHr5gSMNjFiMNALchuJydaCRu
	 d3VpSaht4kDwRmPDpEu8mzET34CAzW8HHoEqtauOYUBbQUycVYTmb9aF+qZUWD9wYTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52C606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 11:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D52C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jVc1g6fctz1rqZM
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:39:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 116F0405CC
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:39:58 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCHi_4M4P5qF6+VEw--.8133S2;
	Thu, 19 Nov 2026 19:39:58 +0800 (CST)
Message-ID: <7ad8221e-f451-4b97-bdf5-c953c0b9ac4e@huaweicloud.com>
Date: Thu, 19 Nov 2026 19:39:56 +0800
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
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <sashiko-outbox-222905@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-222905@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHi_4M4P5qF6+VEw--.8133S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDurW7JFWUWr43trWDArb_yoW5ZFyUpr
	W8ur1Skry5XF10qa15Ka1Uuw1xZw4rKFWDGw4DtFW3Ar4Y9wnxWFy7Gw45ZFs8Xr12yFy8
	K3yqvryDu34UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/19 18:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] perf/core: non-SMP-atomic local_t race on
>   ctx->nr_no_switch_fast
> --
> 
> commit 5e829db733e2fe49cdac7cb99bb9428db1c83359
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf/core: Disable context fast-swap for sigtrap events
> 
> This commit excludes sigtrap events from the context fast-swap path by
> incrementing and decrementing ctx->nr_no_switch_fast when adding and
> removing events with attr.sigtrap set.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index da86bc6e8be94..483ba8704d418 100644
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
> [Severity: Medium]
> Can concurrent local_inc() and local_dec() calls on ctx->nr_no_switch_fast
> from different CPUs race and lose updates?
> 
> ctx->nr_no_switch_fast is a local_t, so local_inc() and local_dec() are
> only atomic on a single CPU (for example, unlocked inc/dec on x86).  When
> installing a disabled sigtrap event into a non-empty task context,
> perf_install_in_context() runs add_event_to_ctx() directly on the
> installer CPU under ctx->lock without an IPI, while an already-active
> sigtrap event in that context can update ctx->nr_no_switch_fast on the
> target task's CPU without holding ctx->lock:
> 
> CPU0                              CPU1 (running ctx->task)
> perf_install_in_context()
>   raw_spin_lock(&ctx->lock)
>   add_event_to_ctx()
>     list_add_event()
>       local_inc(&ctx->nr_no_switch_fast)
>                                   __perf_event_overflow()
>                                     local_inc(&ctx->nr_no_switch_fast)
>                                       <-- non-SMP-atomic RMW race
>                                   ...
>                                   perf_pending_task()
>                                     local_dec(&ctx->nr_no_switch_fast)
> 
> A similar cross-CPU race is possible between list_del_event() in
> perf_remove_from_context() (when !ctx->is_active) and perf_pending_task().
> A lost increment allows ctx->nr_no_switch_fast to drop to 0 while a
> sigtrap event or pending task_work is still present, re-enabling the
> context fast-swap path and hitting WARN_ON_ONCE(event->ctx->task !=
> current) in perf_sigtrap().
> 

Same as this:

  https://lore.kernel.org/all/b5d10cd7-e3af-4e07-a19b-44544077db59@huaweicloud.com/

It is a pre-existing issue, so a separate patch will be submitted and it will not
be fixed within this patch series.

Thanks,
Tengda

