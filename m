Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841224;
	b=d+J71CJjAs6HLldJ5PclThvSW+QYInpQpFU4Olu2f3kb7rE9YFC+xBqazA/3fYBTkWu2
	 CJLXMapKrihi/hM9lH98JvzNIGMtv3mpMEPMBgbGaJ9pkq9Tpl0qG4SkpNMo/RYFTLdoZ
	 lbfQSCdk0ISu+28n196/Vgf0cfQvBh7v272G+VRzzKxZbWlFgOlaqlGcqMhvqCLN9sTTb
	 65zKapsEAnyKuEPasG2W/khZ96kNhFl8MtlfAKpwBswgo+/jVi6oPdG8V1dPkUHy5jJ1d
	 2I09wnIuj0lqYl4qiQ6kSq94jhH2ICA8mGIwmdPyZbxfrKYk9qdEF3w/W78gjDFFO1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841224;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=6vXeoSRVpAmCFFIYEk5DFqHsPl35CVOsvOWiLh063mo=;
	b=ONJinPpP6bBnBRyG+d7MEwwcwq4kWPqQZ0QjS/wZFDGLN3ZuVsOr5zLSVGGq8PHBk86k
	 wy801+TH0xWPAFWhKkLY79txeQgiH3bM9w7ldvJneytIIcoqsrKv6Pz6HrbPuW+0Nhc4+
	 u/QDMTbSCiXDTGj+GB1zykQACPr4kgHcqGPZcmxSaDFN38XOqb/+mWXJ7TziIbgdYCAII
	 l6oYR0bLuUhN6uHatZUdrUtaR4vw8+GLkzIu7MdI4iN4TdNfzl+4YWGno4QIkODUXiYNE
	 5h7fIbvqKEUvJPQ3R6xKmAooL8E6hjSyhzqmfcyaBkSztAaHZeUQZe/1Q6sP0x2BNjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56671606A32A;
	Mon, 16 Nov 2026 15:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56671606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jSrcM0w9Dz1rqCH;
	Mon, 16 Nov 2026 22:59:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 16CB64056B;
	Mon, 16 Nov 2026 23:00:20 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCHwvGDGvtq2ylhEg--.19855S2;
	Mon, 16 Nov 2026 23:00:19 +0800 (CST)
Message-ID: <c1f5c334-7668-403a-98a0-782184367113@huaweicloud.com>
Date: Mon, 16 Nov 2026 23:00:19 +0800
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>
 <20261116101742.11G-Kmmb@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261116101742.11G-Kmmb@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHwvGDGvtq2ylhEg--.19855S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrur4UJr4ftF1rAF4rAFb_yoW5WF47pr
	WkCr15KrykXr12v3ZxKa1qg34rWw4rKr4DWw4vvay3Aw45XwnaqFW7J3WYgFn8Ar1Iya4r
	t3yvvrZ3u34UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p
	9UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/16 18:17, Sebastian Andrzej Siewior wrote:
> On 2026-11-05 09:30:44 [+0000], Tengda Wu wrote:
>> perf_sigtrap() contains:
>>
>> 	WARN_ON_ONCE(event->ctx->task != current)
>>
>> The warning assumes that an event's ctx->task always matches the task
>> that ends up running the pending task_work. That assumption can be
>> broken by the context fast-swap path.
>>
>> The failure sequence is:
>>
>>   1. A -> B switch, perf_event_context_sched_out() takes the fast path
>>      and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
>>      An NMI then hits while the context is swapped, and
>>      __perf_event_overflow() queues pending task_work on the *current*
>>      task (A), even though the event now belongs to B's swapped-in
>>      context view.
>>
>>   2. B -> A switch. Because A now has pending task_work,
>>      nr_no_switch_fast is non-zero, so the slow path is taken and
>>      ctx->task is *not* swapped back.
>>
>>   3. A returns to user mode, task_work runs perf_pending_task() ->
>>      perf_sigtrap(), and event->ctx->task no longer equals current,
>>      tripping the WARN_ON_ONCE().
>>
>> The context fast-swap path was already excluded for events that need
>> stable task association (inherit + sample read). sigtrap events have
>> the same requirement: the SIGTRAP is targeted at ctx->task and must not
>> be delivered after ctx->task has been swapped to another task.
>>
>> Fix this by also excluding events with attr->sigtrap from the fast-swap
>> path, i.e. bump nr_no_switch_fast for sigtrap events in
>> list_add_event()/list_del_event(), and update the comment describing
>> the invariant accordingly.
>>
>> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  include/linux/perf_event.h | 6 ++----
>>  kernel/events/core.c       | 9 +++++++--
>>  2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1999,7 +1999,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
>>  		ctx->nr_user++;
>>  	if (event->attr.inherit_stat)
>>  		ctx->nr_stat++;
>> -	if (has_inherit_and_sample_read(&event->attr))
>> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>>  		local_inc(&ctx->nr_no_switch_fast);
> 
> This is already done in __perf_event_overflow() while the event is
> added. You are saying this is not enough/ too late. This is required to
> be done/ disabled once the event is created if I understand it.
> If so, do we need to keep this nr_no_switch_fast inc/dec in
> __perf_event_overflow() and perf_pending_task()?
> 
> Sebastian

Indeed, the now-redundant nr_no_switch_fast updates in __perf_event_overflow()
and perf_pending_task() can be removed.

Thanks,
Tengda

