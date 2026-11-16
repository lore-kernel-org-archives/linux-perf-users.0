Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809575;
	b=fX4ORqKak73nFIp8qO01Ym11FZRGeKS35xpasDXDO9ZLXp7HMxfNu3HG2WOEP/pA59QJ
	 govVaIi4mbwgX4KKy+wQp+UbcrPrFV8TPLluj75xatXqPC+oFutU9bCcErNmbIW69f4yo
	 X3vMHcJqqZxb9AqLmiimO7UTt539xphra/ZJF8XuC5XjA5tPZYK2ctMs1cNFFvs9xM+S9
	 wZPTgsgO86wdYGUOtvTepwMGSpGkwYwLyHz0oqx/sP+/EoZti+APpsG366PtG9whPoZUE
	 StkQT/4NTcX2CFYwainBGdexx2VMKPUGXEkDXsfIIKFS++YOmf8QvMebrBRm/Lnviag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809575;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=AzcwurnxvgVQyVUEUuJ8r5yV+fu5uhMOXQvuAxcek8c=;
	b=z+ctwL8tTbPXj2UdW55VwcANFJgXLCMYyeP9FLZkzwfU6vFvpqvrWBG1OSa/gxqMlL8Z
	 EInedHO+zqnkYLzpzfNSk4DsDIbBqiMMumTTs7DYD97E5Lqvn8NdtLYRLybIvaoVD6+jU
	 7iy9VvAixJqMJu6Z1rGTS9wGNACH5lt82KffEhmu1mGXp+ual42KesDuHfikUpT2/qK+h
	 h7RQpPHZ7mJR2J28gvACT/G3RMaiRS8HehGyoEphTGKhY6EH4WKYdJeJIEt8PbK4Trq4b
	 x4fe0AWNN/zC+YpQzOCe5OCdO+qXLkV9Pdw7/PI14eReXhzwKKuyFJnZpP7AGv0nV0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28582606A335;
	Mon, 16 Nov 2026 06:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28582606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jScvc0Tlrz1c0Qv;
	Mon, 16 Nov 2026 14:11:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D47F84070B;
	Mon, 16 Nov 2026 14:12:44 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAn+O3bnvpqP_YBEg--.43654S2;
	Mon, 16 Nov 2026 14:12:44 +0800 (CST)
Message-ID: <13443f76-38d6-4d52-9d86-285568c9e290@huaweicloud.com>
Date: Mon, 16 Nov 2026 14:12:43 +0800
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
Subject: Re: [PATCH v3 0/2] perf/core: Fix sigtrap task_work races
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793870900.git.wutengda@huaweicloud.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <cover.1793870900.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAn+O3bnvpqP_YBEg--.43654S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyruF1fGFy7Gw4kGw4Durg_yoW8Ary8pF
	43ur1Skw48GrWIva1avw48Aa1ruw4Fqa13Grs3Kw1jyF45ZFy5XFW7Kr4Y9F4UCr92yFyI
	yw4vvFWkur1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

Friendly ping. 
This has been pending for ~10 days. Any chance you could take a look?

Thanks,
Tengda

On 2026/11/5 17:30, Tengda Wu wrote:
> Two fixes for sigtrap task_work handling since the switch to always
> enqueue SIGTRAP via task_work.
> 
> The warning splats and PoCs for both patches are too long to inline in
> the commit messages. They are sent as separate replies to this cover
> letter, one per patch.
> 
> Patch 1 fixes a re-entrancy race in __perf_event_overflow(): pending_work
> was set only after task_work_add(), so an NMI could re-enter and enqueue
> the same pending_task twice, creating a cycle in the task work list and
> unbalancing the event refcount. Claim pending_work with cmpxchg() before
> enqueuing, and clear it if the enqueue fails.
> 
> Patch 2 fixes a WARN_ON_ONCE() in perf_sigtrap() triggered by the context
> fast-swap path swapping ctx->task while a sigtrap event has pending task
> work. SIGTRAP is targeted at ctx->task, so exclude sigtrap events from
> fast-swap alongside inherit+sample-read events.
> 
> Changelog
> =========
> v2 -> v3:
>   - v2: https://lore.kernel.org/all/20261102021355.650671-1-wutengda@huaweicloud.com/
>   - Added Patch 2 to fix WARN_ON_ONCE() in perf_sigtrap()
> v1 -> v2:
>   - v1: https://lore.kernel.org/all/20261031114520.642476-1-wutengda@huaweicloud.com/
>   - Drop the redundant event->pending_work assignment. (Sashiko)
> 
> Tengda Wu (2):
>   perf/core: Prevent duplicate sigtrap task work enqueue
>   perf/core: Disable context fast-swap for sigtrap events
> 
>  include/linux/perf_event.h |  6 ++----
>  kernel/events/core.c       | 30 ++++++++++++++++++------------
>  2 files changed, 20 insertions(+), 16 deletions(-)
> 

