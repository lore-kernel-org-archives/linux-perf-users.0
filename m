Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DF192D8E;
	Sat,  8 Feb 2025 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739014748; cv=none; b=TiVLpIVzhn6C5noofd57WTpOev/jfYLRh5u67oRbww85xMUFiE9Te+Z1ibjM53QgpIEiA2lRhq44gN1Md1mfRkJqAzRH4pc9yFzhI9TqevpqBr6Mqhq/CK9gPZ88An73qEjvKT9D+twkcVk24o4lbh3Dt52GBn5WGvxCeLDKaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739014748; c=relaxed/simple;
	bh=zioSV5FoyqQ1wMxljuDUquhhC8wslPi7gyKxYv740Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRPP9MxRAds1WlXyEbFs357nefkN4NdUSxVHH1/2QzAAHeS5rXeRZeUE5vAktDl6hoMoVH50YS44kqynRl+ozYFyI6UTnOKADVxB/ohissFj6bYSsg4cyvY2C7CP6sgylXyTgYawJ7TGzV5iqO7whe8laYVSoYbSAdwCc7eXBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yqpkk2fQJz4f3jcn;
	Sat,  8 Feb 2025 19:38:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 92A8E1A1733;
	Sat,  8 Feb 2025 19:38:59 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2BQQqdnhbwJDQ--.2631S3;
	Sat, 08 Feb 2025 19:38:57 +0800 (CST)
Message-ID: <4efc66e7-8dd3-49d4-8f5d-1034536e2fcd@huaweicloud.com>
Date: Sat, 8 Feb 2025 19:38:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix warning due to unordred pmu_ctx_list
Content-Language: en-US
To: peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2BQQqdnhbwJDQ--.2631S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUKw1UKr43Gr1DGw1rJFb_yoW5Zr47pr
	WkArnayFWkKr10vayaya1DXw1YgryfXr4DWwn8C34FyFW3WFWDGa17Gw15JF909rs7WFy2
	yw4jqF17t3yDta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/1/22 15:33, Luo Gengkun wrote:
> Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
> perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
> perf_event_pmu_context, but not in the same order.
>
> The problem is that the order of pmu_ctx_list for the parent is impacted by
> the time when an event/pmu is added. While the order for a child is
> impacted by the event order in the pinned_groups and flexible_groups. So
> the order of pmu_ctx_list in the parent and child may be different.
>
> To fix this problem, insert the perf_event_pmu_context to proper place
> after iteration of pmu_ctx_list.
>
> The follow testcase can trigger above warning:
>
>   # perf record -e cycles --call-graph lbr -- taskset -c 3 ./a.out &
>   # perf stat -e cpu-clock,cs -p xxx // xxx is the pid of a.out
>
> test.c
>
> void main() {
>          int count = 0;
>          pid_t pid;
>
>          printf("%d running\n", getpid());
>          sleep(30);
>          printf("running\n");
>
>          pid = fork();
>          if (pid == -1) {
>                  printf("fork error\n");
>                  return;
>          }
>          if (pid == 0) {
>                  while (1) {
>                          count++;
>                  }
>          } else {
>                  while (1) {
>                          count++;
>                  }
>          }
> }
>
> The testcase first open a lbr event, so it will alloc task_ctx_data, and
> then open tracepoint and software events, so the parent ctx will have 3
> different perf_event_pmu_contexts. When doing inherit, child ctx will
> insert the perf_event_pmu_context in another order then the warning will
> trigger.
>
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 1. update commit message.
> 2. modify annotation style.
> 3. add reviewed by.
> Link to v2: https://lore.kernel.org/all/20250121130802.1813928-1-luogengkun@huaweicloud.com/
> Link to v1: https://lore.kernel.org/all/20250120114344.632474-1-luogengkun@huaweicloud.com
>
> ---
>   kernel/events/core.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..3f68fbbf3de0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4950,7 +4950,7 @@ static struct perf_event_pmu_context *
>   find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>   		     struct perf_event *event)
>   {
> -	struct perf_event_pmu_context *new = NULL, *epc;
> +	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
>   	void *task_ctx_data = NULL;
>   
>   	if (!ctx->task) {
> @@ -5007,12 +5007,19 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>   			atomic_inc(&epc->refcount);
>   			goto found_epc;
>   		}
> +		/* Make sure the pmu_ctx_list is sorted by pmu */
> +		if (!pos && epc->pmu->type > pmu->type)
> +			pos = epc;
>   	}
>   
>   	epc = new;
>   	new = NULL;
>   
> -	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
> +	if (!pos)
> +		list_add_tail(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
> +	else
> +		list_add(&epc->pmu_ctx_entry, pos->pmu_ctx_entry.prev);
> +
>   	epc->ctx = ctx;
>   
>   found_epc:

ping.  Does this patch look ready? If so, perhaps we can merge this patch.

Thanks,

Gengkun

