Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925D22331C;
	Wed,  9 Jul 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054299; cv=none; b=Dqzd+j9FbjaBHqTkHZWt3e5d1gojGWgrQBu0qYshXBKoYoJhz66F2casGQpAS2e2GCVXu0Wa4+DeCRA6JE3OJ2zIXFhW4jXE4qm7p2i/25SQ2zYpJT+X2e6E0tKwGygHZw+K1a0BWsyxlGFmlT4qAwtn9ze09Wvk55hvazd4bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054299; c=relaxed/simple;
	bh=5Uwm8AciybAtLqSa2UQmIj/q9IVonSbuazkxTlHhzeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnEHO27p5W4XHm6qdDcnL0vZNvd8yLrhTldOkvM08psHcZPnmsNZPcELtfw6zXsR6fWgj7wZFwWqkFAp2PE9OwEDU7h+4uCmXE0CsgLvw02XPZuIIwKKBPIZvCzct/wpb4wNUCRfALmdoQ9FNtlDcLU8+l9Oj73u7htdCYdJBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AJJYDtTj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJJYDtTj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uwP47kBvHW0N0lMgUnQIxKO9IkXP6Lxbg24vSAmFUko=; b=AJJYDtTjmhjTWTxH8pFrVBNhMV
	K7EdYj8mck4bOQyF/da7k5pc00nhZnX+i+A0cM3k8Zpfvu1B62tpGZ/xx/TmXWjqNJejCp6iQmxzV
	nnLoo7bI+PyxbfOMeU4Wz9YHMUeH5Yj9tauLsYj7+q81ToKdlPhnGjVVP1AUu/Jv9UBbEZLe0WbOB
	lDSg27Aj4/bPb/0zQHbwztfc0us5e8JFTHhhiXDRmQunKvl6iOCiLJErk7dCkiRgJXWV/p06uTL0J
	elahxSK4nui0szw/yQjoSt+2uqi5ymKPa8idaaKc6KcaSofsdTDXCrkwzpgvSZRs5H9GlhUXx9s88
	DxU0Mg0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZRMC-00000008qmJ-0afJ;
	Wed, 09 Jul 2025 09:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1E2130065D; Wed, 09 Jul 2025 11:44:51 +0200 (CEST)
Date: Wed, 9 Jul 2025 11:44:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/core: Fix WARN in perf_sigtrap()
Message-ID: <20250709094451.GI1613200@noisy.programming.kicks-ass.net>
References: <685af60a.a00a0220.2e5631.0092.GAE@google.com>
 <ed888189-dad4-47e1-bfc8-4f2213eda32d@I-love.SAKURA.ne.jp>
 <f8dee957-d286-421d-976a-c0c580454fb3@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8dee957-d286-421d-976a-c0c580454fb3@I-love.SAKURA.ne.jp>

On Sat, Jul 05, 2025 at 11:43:37PM +0900, Tetsuo Handa wrote:
> Since commit 4f6fc7821283 ("perf: Fix sample vs do_exit()") has moved
> perf_event_exit_task() call from after exit_task_work() to before
> exit_task_work(), 

> task_work_add() from perf_event_exit_task() now returns

There is no task_work_add() in perf_event_exit_task().

> 0 than -ESRCH, despite perf_event_exit_task_context() updates ctx->task
> to TASK_TOMBSTONE. As a result, event->ctx->task == current assumption
> no longer holds.

This changelog is confusing to the point that I've no idea what it is
trying to tell me.


Did you mean to say something like:

Because exit_task_work() now runs after perf_event_exit_task(), it is
possible for an already queued perf_pending_task()->perf_sigtrap() to
observe a dead task context.

> Reported-by: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=2fe61cb2a86066be6985
> Fixes: 4f6fc7821283 ("perf: Fix sample vs do_exit()")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> #syz test
> 
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7281230044d0..489f42defe3c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7208,7 +7208,8 @@ static void perf_sigtrap(struct perf_event *event)
>  	 * ctx->task or current has changed in the meantime. This can be the
>  	 * case on architectures that do not implement arch_irq_work_raise().
>  	 */
> -	if (WARN_ON_ONCE(event->ctx->task != current))
> +	if (WARN_ON_ONCE(event->ctx->task != current &&
> +			 event->ctx->task != TASK_TOMBSTONE))
>  		return;
>  

Also, isn't it better to simply swap the early exit tests in that
function like so:


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0db36b2b2448..22fdf0c187cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7203,6 +7203,13 @@ void perf_event_wakeup(struct perf_event *event)
 
 static void perf_sigtrap(struct perf_event *event)
 {
+	/*
+	 * Both perf_pending_task() and perf_pending_irq() can race with the
+	 * task exiting.
+	 */
+	if (current->flags & PF_EXITING)
+		return;
+
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the
@@ -7211,13 +7218,6 @@ static void perf_sigtrap(struct perf_event *event)
 	if (WARN_ON_ONCE(event->ctx->task != current))
 		return;
 
-	/*
-	 * Both perf_pending_task() and perf_pending_irq() can race with the
-	 * task exiting.
-	 */
-	if (current->flags & PF_EXITING)
-		return;
-
 	send_sig_perf((void __user *)event->pending_addr,
 		      event->orig_type, event->attr.sig_data);
 }
