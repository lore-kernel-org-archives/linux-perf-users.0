Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D928FFCF;
	Wed,  9 Jul 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058066; cv=none; b=VfHbiPdN/CHr+vSeezkJXqmTzytQHxAV2IALXwH/t8ShksyGl+BdqKgRMaUVd7YCms+Ff1ilYQLmQDE1PdWjdNJ5IxudcAUnA1YlGuX3v1K9/jyhITZfF/GEB66c6J8J/uHILHZU1pnBECeoUqDefNTM8l3dPZgaSxkkRnRQ7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058066; c=relaxed/simple;
	bh=N5RddZ43sa6/RjgAUY884RBPCeWsxJa240R3Lu04KQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th89a3bK+J0lwgw67yfS3wxK/RBq93IMs1aQDrkmghXgWMzwvFmZvA2ewjkDETh6vc3PJZSflpejSg1zhBMSpGcqm8TyqUd/okTpBtOtk6HG6FCPZpcuDKu5i5mY9vdxFhINOblebmF7IHihfpFTzlc1RyDz3VLvcc6m42nJqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569AlUAM000428;
	Wed, 9 Jul 2025 19:47:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569AlTuH000425
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 19:47:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1412f058-17e2-4345-a8ad-e8c968d57184@I-love.SAKURA.ne.jp>
Date: Wed, 9 Jul 2025 19:47:29 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix WARN in perf_sigtrap()
To: Peter Zijlstra <peterz@infradead.org>
Cc: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>,
        linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <685af60a.a00a0220.2e5631.0092.GAE@google.com>
 <ed888189-dad4-47e1-bfc8-4f2213eda32d@I-love.SAKURA.ne.jp>
 <f8dee957-d286-421d-976a-c0c580454fb3@I-love.SAKURA.ne.jp>
 <20250709094451.GI1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250709094451.GI1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/09 18:44, Peter Zijlstra wrote:
> On Sat, Jul 05, 2025 at 11:43:37PM +0900, Tetsuo Handa wrote:
>> Since commit 4f6fc7821283 ("perf: Fix sample vs do_exit()") has moved
>> perf_event_exit_task() call from after exit_task_work() to before
>> exit_task_work(), 
> 
>> task_work_add() from perf_event_exit_task() now returns
> 
> There is no task_work_add() in perf_event_exit_task().

Since the function which triggers BUG_ON() is perf_sigtrap(), I guessed
that the location that queued the task work is task_work_add() in
__perf_event_overflow(). But since testing again with

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10324,6 +10324,7 @@ static int __perf_event_overflow(struct perf_event *event,
 
                if (!event->pending_work &&
                    !task_work_add(current, &event->pending_task, notify_mode)) {
+                       BUG_ON(event->ctx && event->ctx->task == TASK_TOMBSTONE);
                        event->pending_work = pending_id;
                        local_inc(&event->ctx->nr_no_switch_fast);
                        WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));

did not trigger, it seems that __perf_event_overflow() is not called from
perf_event_exit_task() path.



> Did you mean to say something like:
> 
> Because exit_task_work() now runs after perf_event_exit_task(), it is
> possible for an already queued perf_pending_task()->perf_sigtrap() to
> observe a dead task context.

Yes.



> Also, isn't it better to simply swap the early exit tests in that
> function like so:

Yes, that will be OK if you prefer it
( https://lkml.kernel.org/r/ed888189-dad4-47e1-bfc8-4f2213eda32d@I-love.SAKURA.ne.jp ).

