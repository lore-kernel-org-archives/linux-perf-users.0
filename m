Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658406;
	b=TzKwTS8Tv1b9Fg1anbnatYiYLaS++w5EQIOeiS58zcr2llPAF4DHBQs5zslwsrtEeF21
	 gp3XWHcg0Y4MvBsvtIlllyszhIEMl02OLkyH/wgYOVBIfXeB14sHL1kxUCyFC/YLHrSNd
	 k0Hq4oYC4myuIoB2tGH/7aywumHM6vVfe0f4wS82XUclwy/s8GFZ6d3nUD5xmSYf3i8FQ
	 m5mPJO2bMytka+Hx7ukLwPfL+fLqvKOM5uPSwKq5uEA4HLTsTb0iR9HR5UmLNwCPFTb5H
	 0XicAwzgxiEGs5bp7b8I6XKESpme61ZHPE9ibVnr34oLO7TyV3RFxZ3LrG1i+7qmdTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658406;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Srx5W+XV/kLzuLr7plGWomX4jJTsOkYWbuOKGME2XXg=;
	b=s7UCc8dwywypYfBy6V39WQL15UGpgUv72JKIBShlNStRm14mYzJfsfdVxB0pBZfKwciU
	 7aPBfaaBijBiL34qgI/hao6Ydst125Ni2IrCGCnO0z3MWAYVSybgXvNvjaTdirQi+WrlM
	 WGF95natSVnpNcCYEqfzazPMBw/cMlpqAV5Yhmm4bD4BhjgAjUOeecA/CSFub3IOojEiF
	 3XF8UyzKLZVek8ChfE4upX0nWpNpq3HHwRaJOUMJYAiHqigQk3NnWSFWc5z/GkhIIn+D0
	 zbpf9lLkn4LDYqlrvuJJOp7O4BPumyRB28Gvuoa94H1TGj8bYIZS/MsumGZ1S6VSkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF88606A326;
	Thu, 26 Nov 2026 02:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jZfrD1lFpz1rqxL;
	Thu, 26 Nov 2026 09:59:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7B46A40A32;
	Thu, 26 Nov 2026 10:00:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCHveyfkgdr9ytMFw--.17117S2;
	Thu, 26 Nov 2026 10:00:00 +0800 (CST)
Message-ID: <ea0a0fcf-0d96-416c-ba85-e98a8841cfb1@huaweicloud.com>
Date: Thu, 26 Nov 2026 09:59:59 +0800
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
 <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
 <20261125093836.GX2668804@noisy.programming.kicks-ass.net>
 <c9c2c4df-a748-4787-b686-1fe6bc6564db@huaweicloud.com>
 <6493eae2-9b36-4574-83ca-a139f4fbfb25@huaweicloud.com>
 <20261125133601.GC2668804@noisy.programming.kicks-ass.net>
 <20261125161342.GP2669272@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261125161342.GP2669272@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHveyfkgdr9ytMFw--.17117S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW5ZFWxKrykJw1ruF1ftFb_yoW5tw47pF
	WUCa9ayrW0qFyqq343t348Aw12qw48ta9xX34DK3ySy3Z09rykXFnFgr4UuFnYqrykC3y3
	Zr4jqrW2934UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/26 0:13, Peter Zijlstra wrote:
> On Wed, Nov 25, 2026 at 02:36:01PM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 25, 2026 at 06:09:04PM +0800, Tengda Wu wrote:
>>
>>>>> Ah, I'm currently running it on an SPR Xeon; do I need to use
>>>>> non-default arguments or just run the thing in a loop and drink tea
>>>>> until it goes pop?
>>>>
>>>> No need to pass any other arguments; running it as follows should be enough:
>>>>
>>>>   for i {1..100}; do ./fast_swap ; done
>>>>
>>>
>>> Correction: for i in {1..100}
>>
>> I used: while :; do ./perf-sigtrap-switch-poc; done
>>
>>> One more detail: I also specified a boot parameter (which might make it
>>> easier to reproduce?):
>>>   
>>>   preempt=none
>>
>> That option is no longer available.
>>

Uh, I tested on linux-next, base commit: 84abb955b101 (tag: next-20261113).
That option is still present at that commit.

>> Anyway, I've had it running for a few hours now; but no joy :-( -- this
>> is an unmodified tip/master kernel since I wanted to make sure I could
>> reproduce before trying to fix.
>>
>> I'll just leave it running ...
> 
> 7 hours and nothing :-(
> 
> I'm going to have to ask you to try and reproduce I'm afraid. 
> 

Strange. Maybe the SPR Xeon is too fast, or the PMU tracepoint just isn't
hitting? It's also possible that the old Intel machine I'm using locally
(a 2014-era old CPU) is so slow that the probability of taking the fastpath
is higher.

> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1236,6 +1236,7 @@ extern const struct perf_event_attr *per
>  extern void perf_event_print_debug(void);
>  extern void perf_pmu_disable(struct pmu *pmu);
>  extern void perf_pmu_enable(struct pmu *pmu);
> +extern bool perf_pmu_enabled(struct pmu *pmu);
>  extern void perf_sched_cb_dec(struct pmu *pmu);
>  extern void perf_sched_cb_inc(struct pmu *pmu);
>  extern int perf_event_task_disable(void);
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1366,6 +1366,12 @@ void perf_pmu_enable(struct pmu *pmu)
>  		pmu->pmu_enable(pmu);
>  }
>  
> +bool perf_pmu_enabled(struct pmu *pmu)
> +{
> +	int *count = &this_cpc(pmu)->pmu_disable_count;
> +	return *count == 0;
> +}
> +
>  static void perf_assert_pmu_disabled(struct pmu *pmu)
>  {
>  	int *count = &this_cpc(pmu)->pmu_disable_count;
> @@ -10955,7 +10961,7 @@ static int __perf_event_overflow(struct
>  		 * claim the pending_work before task_work_add() recurses.
>  		 */
>  		if (cmpxchg_local(&event->pending_work, 0, 1) == 0) {
> -			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> +			if (!task_work_add(event->ctx->task, &event->pending_task, notify_mode)) {
>  				event->pending_work = pending_id;
>  				local_inc(&event->ctx->nr_no_switch_fast);
>  				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> @@ -11151,6 +11157,9 @@ static int perf_swevent_match(struct per
>  				struct perf_sample_data *data,
>  				struct pt_regs *regs)
>  {
> +	if (!perf_pmu_enabled(event->pmu))
> +		return 0;
> +
>  	if (event->attr.type != type)
>  		return 0;
>  
> @@ -11531,6 +11540,9 @@ static int perf_tp_event_match(struct pe
>  				struct perf_raw_record *raw,
>  				struct pt_regs *regs)
>  {
> +	if (!perf_pmu_enabled(event->pmu))
> +		return 0;
> +
>  	if (event->hw.state & PERF_HES_STOPPED)
>  		return 0;
>  	/*


Hmm, I applied that patch to my local environment and tested it, and
I no longer see the warning. The issue should be resolved.

Tested-by: Tengda Wu <wutengda@huaweicloud.com>

Thanks,
Tengda

