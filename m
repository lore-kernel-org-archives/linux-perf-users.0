Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851002;
	b=vql92izolnWOzpAgKMT4Mn3Rga5n5lE+NLAZVhOHCXyP57f9l8r9FVK6ArlPZQpYAkQu
	 qxtFYjLc0TXVz0A0cWDc8OQM1squu2Lcxq3rG0mVdyh84rKRDwOM47N3FS6jmzEEmoxg6
	 iDAe3x2P2qTTOBwwJMvoWXUoruVraxcLBTxFdKQc6CvRR+fg0l334AFzwGuiRF1P7zch9
	 NbMjtrMLbxpVyHZE/vRUKZCOzTvm/seYA5/FXPr4Eoqx2MHVfVRwBZYtNB2Xv/T3gVdWs
	 7p/66w71Ebc/tEs5hwVNjpuoLuVO5KtRUkyhppJ3ZTDTP8Fz9U0oZgglU7YojqutCtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851002;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zeOBlw2dACG/NTSb5D5vsEa8meFYCr2XZLjiYJZ10jE=;
	b=fuW+AwQDaMMDXz4tgimPERxkq2oy+5uTaO8KCDvgUKzl3G7JQMHVsSIkrk3wLh2qugCR
	 X5yMP7PExPqPZaHT0LlntkLBd88ZPYnnHFeAhzFkS1xm3wUfe6dlE5KI5tX0xj1nAe+Vd
	 7/Wi30yRgX42oMl22zU8UTmrIVkIYoc8dreaah/EFNWcOgEsu/Medrj6eZpS93YeqoMxs
	 2Mfz1ueu4m+2dxu2d9diWnggI3VyXdJ7qTkHMObl3zLdr6yuKgZrEAQJGDNudfZHOw7sH
	 m03T24dsOjU0Ka0GxMDx96lHiLkTafuCpldjsiP0btOo+a9FnwEjKQwQxV7yoAwv9JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8273606A33E;
	Thu,  5 Nov 2026 03:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8273606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jKpPt6rQlz1rqZW;
	Thu,  5 Nov 2026 11:56:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3C9D64056D;
	Thu,  5 Nov 2026 11:56:31 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDnN81t_utquzBfDA--.43465S2;
	Thu, 05 Nov 2026 11:56:30 +0800 (CST)
Message-ID: <8496ef89-b094-4b60-8565-9c65e3256615@huaweicloud.com>
Date: Thu, 5 Nov 2026 11:56:29 +0800
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
Subject: Re: [PATCH] perf/core: Prevent duplicate sigtrap task work enqueue
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261031114520.642476-1-wutengda@huaweicloud.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261031114520.642476-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnN81t_utquzBfDA--.43465S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1Dury3Ww1rGF4xGr4xCrg_yoW5Kry7pr
	WftrsIya1UXrnFq345tws7Ar18Ww40qan8Cr4kC34fAF4YvF9rXay7G3W5XFW5ArnrAayf
	Xw4j9rZrC34jqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

After applying the following patch, we found another warning that
is unrelated to the current fix patch, but both are related to
perf sigtrap. I will explain it together in the v3 version.

Thanks,
Tengda


On 2026/10/31 19:45, Tengda Wu wrote:
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
> 
> The re-entrant call path is:
> 
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
>           __perf_event_overflow()
>             task_work_add()
> 
> The nested invocation can enqueue pending_task before the
> outer invocation does. When the outer invocation resumes, it
> inserts the same task_work entry again, potentially creating
> a cycle in the task work list.
> 
> This causes perf_pending_task() to be executed repeatedly
> and leads to unbalanced event reference counting.
> 
> Use cmpxchg() to atomically claim pending_work before calling
> task_work_add(). This ensures that only one invocation can
> enqueue the pending_task, even when interrupted by an NMI.
> 
> If task_work_add() fails, clear the pending_work claim so that
> a subsequent overflow can retry.
> 
> Also use READ_ONCE() when checking pending_work in the
> exclude_kernel warning path to avoid an unsynchronized read.
> 
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/events/core.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 457d75ea7142..f1e4e153c49a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10925,16 +10925,18 @@ static int __perf_event_overflow(struct perf_event *event,
>  
>  		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>  
> -		if (!event->pending_work &&
> -		    !task_work_add(current, &event->pending_task, notify_mode)) {
> -			event->pending_work = pending_id;
> -			local_inc(&event->ctx->nr_no_switch_fast);
> -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -
> -			event->pending_addr = 0;
> -			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> -				event->pending_addr = data->addr;
> -
> +		if (cmpxchg(&event->pending_work, 0, pending_id) == 0) {
> +			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> +				event->pending_work = pending_id;
> +				local_inc(&event->ctx->nr_no_switch_fast);
> +				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> +
> +				event->pending_addr = 0;
> +				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> +					event->pending_addr = data->addr;
> +			} else {
> +				cmpxchg(&event->pending_work, pending_id, 0);
> +			}
>  		} else if (event->attr.exclude_kernel && valid_sample) {
>  			/*
>  			 * Should not be able to return to user space without
> @@ -10948,7 +10950,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  			 *     To approximate progress (with false negatives),
>  			 *     check 32-bit hash of the current IP.
>  			 */
> -			WARN_ON_ONCE(event->pending_work != pending_id);
> +			WARN_ON_ONCE(READ_ONCE(event->pending_work) != pending_id);
>  		}
>  	}
>  

