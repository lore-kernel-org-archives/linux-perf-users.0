Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F9135A53;
	Tue, 21 Jan 2025 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737424764; cv=none; b=M0QC2uh4HHEjUqlllTLRRiM+54QHDL0fNs2UPiOj35G2Y5zlWpI7sBW+uVmCTjl1rBKUV3IQ9NqGz5k8U3Le/1iU99Zt/Y5iVFr/rrQJ7b6f3MFak59WA7uh+Ol/oxJ49eIZYZiKC9VPnaHFCmpVDurcQHl+hg0w8lcKXKqMjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737424764; c=relaxed/simple;
	bh=nuz+xUUUjXNAOrQYUHfMRxthWx8M9fqXr6x0apnyxDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsZg802hhs01EZ7Ok6PtM6ko+5iLUD2fnWBF/gLD0BCtH9wiYR/vzFrgO0bBu2+x2qdURkdqnEkh2ZHrJ+d7y3QABRlbumW2wVw9OWhrPrr8KSYRTf44GeB8a7tB0EMLwiX6kQeVReSpin+bZSdGlC/kh61PltbSverGq9OOQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcVkD3jhwz4f3jqw;
	Tue, 21 Jan 2025 09:59:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E50A31A0B8A;
	Tue, 21 Jan 2025 09:59:15 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2By_45nIGcpBg--.31461S3;
	Tue, 21 Jan 2025 09:59:15 +0800 (CST)
Message-ID: <a6a9a81a-3479-4d77-a71f-35f35d391482@huaweicloud.com>
Date: Tue, 21 Jan 2025 09:59:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix warning warning due to unordred
 pmu_ctx_list
Content-Language: en-US
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120114344.632474-1-luogengkun@huaweicloud.com>
 <fac5bb75-8bce-4181-8278-c971d35b8b3a@linux.intel.com>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <fac5bb75-8bce-4181-8278-c971d35b8b3a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHK2By_45nIGcpBg--.31461S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rWF4UZF4kJw17uFW3KFg_yoWrZF13pF
	WkCFsayFWktw1vva43tan8Xwn8Kr1fXrZ8GwnxG34FyayfWFyUGFWUJF4YkF98urn3WFyY
	vw4jqF17Aa4qqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/1/21 4:49, Liang, Kan wrote:
> A redundant "warning" is in the title.
>
> On 2025-01-20 6:43 a.m., Luo Gengkun wrote:
>> Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
>> perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
>> perf_event_pmu_context, but not in the same order.
>>
>> The problem is that when inheritance is performed, it traverses the ordered
>> groups of events, and inserts the new perf_event_pmu_context into
>> child_ctx->pmu_ctx_list which is unordered. So the order of pmu_ctx_list in
>> the parent and child may be different.
> I think the order of pmu_ctx_list for the parent should be impacted by
> the time when an event/pmu is added.
> While the order for a child should be impacted by the event order in the
> pinned_groups and flexible_groups.

Yes, so the order of pmu_ctx_list for the parent and child maybe 
different because

of this point. I will make it clear in the commit message.

>> The follow testcase can trigger above warning:
>>
>>   # perf record -e cycles --call-graph lbr -- taskset -c 3 ./a.out &
>>   # perf stat -e cpu-clock,cs -p xxx // xxx is the pid of a.out
>>
>> test.c
>>
>> void main() {
>>          int count = 0;
>>          pid_t pid;
>>
>>          printf("%d running\n", getpid());
>>          sleep(30);
>>          printf("running\n");
>>
>>          pid = fork();
>>          if (pid == -1) {
>>                  printf("fork error\n");
>>                  return;
>>          }
>>          if (pid == 0) {
>>                  while (1) {
>>                          count++;
>>                  }
>>          } else {
>>                  while (1) {
>>                          count++;
>>                  }
>>          }
>> }
>>
>> The testcase first open a lbr event, so it will alloc task_ctx_data, and
>> then open tracepoint and software events, so the parent ctx will have 3
>> different perf_event_pmu_contexts. When doing inherit, child ctx will
>> insert the perf_event_pmu_context in another order then the warning will
>> trigger.
>>
>> To fix this problem, add pmu_ctx_insertion_sort to make sure the
>> pmu_ctx_list is ordered.
>>
>> Fixes: bd2756811766 ("perf: Rewrite core context handling")
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
>>   kernel/events/core.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 95b01a51139d..1bdff3ef0ce2 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4953,6 +4953,24 @@ find_get_context(struct task_struct *task, struct perf_event *event)
>>   	return ERR_PTR(err);
>>   }
>>   
>> +/*
>> + * This function ensures that ctx->pmu_ctx_list is ordered, so that no warning
>> + * is triggered due to prev_epc->pmu != next_epc->pmu.
>> + */
>> +static void pmu_ctx_insertion_sort(struct perf_event_pmu_context *new,
>> +				   struct perf_event_context *ctx)
>> +{
>> +	struct perf_event_pmu_context *epc;
>> +
>> +	lockdep_assert_held(&ctx->lock);
>> +
>> +	list_for_each_entry(epc, &ctx->pmu_ctx_list, pmu_ctx_entry) {
>> +		if (epc->pmu > new->pmu)
>> +			break;
>> +	}
>> +	list_add(&new->pmu_ctx_entry, epc->pmu_ctx_entry.prev);
>> +}
>> +
>>   static struct perf_event_pmu_context *
>>   find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>>   		     struct perf_event *event)
>> @@ -4974,7 +4992,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>>   		if (!epc->ctx) {
>>   			atomic_set(&epc->refcount, 1);
>>   			epc->embedded = 1;
>> -			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
>> +			pmu_ctx_insertion_sort(epc, ctx);
> The CPU event and per-task event should have a different ctx.
> The warning should only be triggered for the per-task event, right?
> If so, I don't think a sort is required here.
Yes, the ctx is extracted from task, so only sort the task ctx should 
fix this problem.
>
>>   			epc->ctx = ctx;
>>   		} else {
>>   			WARN_ON_ONCE(epc->ctx != ctx);
>> @@ -5021,7 +5039,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>>   	printk(KERN_INFO
>>   		"lgk: ctx %p insert pmu ctx %p, pmu is %p!\n", ctx, epc, epc->pmu);
> Seems your debug code. Please send a clean patch.
Sorry about this.
>>   
>> -	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
>> +	pmu_ctx_insertion_sort(epc, ctx);
> I think the pmu_ctx_list has already traversed to find a matched pmu
> right before. The traverse in the pmu_ctx_insertion_sort() can be avoided.
>
> Thanks,
> Kan
Thanks for the review, I will send PATCH v2 later.
>>   	epc->ctx = ctx;
>>   
>>   found_epc:

