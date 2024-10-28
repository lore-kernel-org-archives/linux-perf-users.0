Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B11D959B;
	Mon, 28 Oct 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118102; cv=none; b=JeOe5u7YjrTrtsh5ftrYmjqaKNtrwXpy0eygON80YBgdF9k7KDv6fq0FZq97tOPQZAV4//bdO/hw6IBO8C5Q+ACx2+RPPVE38il/NzV7UMEQxj2y0we9qPQWUesjYwklGqF5CF3VQ5AvdSGNbnqT9FrY+tyyPCH3SleJ98HWZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118102; c=relaxed/simple;
	bh=JKM0ShELTOKoSqHWt3M5BDy+zBaQnH4xCraeC4T6Av0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5QKCfYZWi9zy8m0ftDUi8LqY8tLNtDsoyQw4FHrI1zbYZRQB9PavXxg0rV+uS2MqGlDCHmIWmOPSDBCRei9k1sFO/R9fbv2XBjnvd2j8lWfoaS/fM0calV8R0GjzUx6Slp1kf/KulXSC8+xg/jWcGraUUzfnNqhnpxw7fqRJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li/h3x9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li/h3x9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE5C4CEE4;
	Mon, 28 Oct 2024 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730118102;
	bh=JKM0ShELTOKoSqHWt3M5BDy+zBaQnH4xCraeC4T6Av0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=li/h3x9cAlRKxXqbtpqPOdWohkw358jNpkm5W7iT78GU7ghspb/W+n7WESsaaS+bF
	 Fay1kDVsRRhAaIsCIZEbD3YIOdIjGlF7mDKB4S6rWD3F3MoCahd0/wUIc89Pp10v48
	 iNveh0QPfxrUf8ur6vPb+mTNd+wJvnlVXi7M4akFjWIOr6SITi6oLyjAxLZaom6KUx
	 MFfYnNtKWNsKmRzlzN/qmsByJLnNyOdHa7TALo5XzRN7H13RMkrX5rUKXhBeJ4DXo6
	 L3/LcNTCGrnhDFp53FvSUfyY7Y6Z5bkSpKgIJT7m2Lwc6BMFrEcf+IB6KyRlDw510N
	 ZWWnw3+qcAP2g==
Date: Mon, 28 Oct 2024 13:21:39 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <Zx-B0wK3xqRQsCOS@localhost.localdomain>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zx9Losv4YcJowaP/@ly-workstation>

Le Mon, Oct 28, 2024 at 04:30:26PM +0800, Lai, Yi a écrit :
> [  300.651268] INFO: task repro:671 blocked for more than 147 seconds.
> [  300.651706]       Not tainted 6.12.0-rc4-42f7652d3eb5+ #1
> [  300.652006] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.652430] task:repro           state:D stack:0     pid:671   tgid:671   ppid:670    flags:0x00004002
> [  300.652939] Call Trace:
> [  300.653088]  <TASK>
> [  300.653221]  __schedule+0xe13/0x33a0
> [  300.653474]  ? __pfx___schedule+0x10/0x10
> [  300.653704]  ? lock_release+0x441/0x870
> [  300.653946]  ? __pfx_lock_release+0x10/0x10
> [  300.654184]  ? trace_lock_acquire+0x139/0x1b0
> [  300.654439]  ? lock_acquire+0x80/0xb0
> [  300.654651]  ? schedule+0x216/0x3f0
> [  300.654859]  schedule+0xf6/0x3f0
> [  300.655083]  _free_event+0x531/0x14c0
> [  300.655317]  perf_event_release_kernel+0x648/0x870
> [  300.655597]  ? __pfx_perf_event_release_kernel+0x10/0x10
> [  300.655899]  ? trace_hardirqs_on+0x51/0x60
> [  300.656176]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
> [  300.656474]  ? __pfx_perf_release+0x10/0x10
> [  300.656697]  perf_release+0x3a/0x50
> [  300.656916]  __fput+0x414/0xb60
> [  300.657163]  ____fput+0x22/0x30
> [  300.657335]  task_work_run+0x19c/0x2b0

Ah the perf_pending_task work is pending but perf_pending_task_sync()
fails to cancel there:

	/*
	 * If the task is queued to the current task's queue, we
	 * obviously can't wait for it to complete. Simply cancel it.
	 */
	if (task_work_cancel(current, head)) {
		event->pending_work = 0;
		local_dec(&event->ctx->nr_no_switch_fast);
		return;
	}

And that's because the work is not anymore on the task work
list in task->task_works. Instead it's in the executing list
in task_work_run(). It's a blind spot for task_work_cancel()
if the current task is already running the task works. And it
does since it's running the fput delayed work.

Something like this untested?

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 449dd64ed9ac..035580fa2c81 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1163,6 +1163,7 @@ struct task_struct {
 	unsigned int			sas_ss_flags;
 
 	struct callback_head		*task_works;
+	struct callback_head		*task_works_running;
 
 #ifdef CONFIG_AUDIT
 #ifdef CONFIG_AUDITSYSCALL
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index cf5e7e891a77..fdd70f09a7f0 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
 bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
+bool task_work_cancel_current(struct callback_head *cb);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4287cb..1b15f3c83595 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5305,7 +5305,7 @@ static void perf_pending_task_sync(struct perf_event *event)
 	 * If the task is queued to the current task's queue, we
 	 * obviously can't wait for it to complete. Simply cancel it.
 	 */
-	if (task_work_cancel(current, head)) {
+	if (task_work_cancel_current(head)) {
 		event->pending_work = 0;
 		local_dec(&event->ctx->nr_no_switch_fast);
 		return;
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..1b898701d888 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2450,6 +2450,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->pdeath_signal = 0;
 	p->task_works = NULL;
+	p->task_works_running = NULL;
 	clear_posix_cputimers_work(p);
 
 #ifdef CONFIG_KRETPROBES
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5d14d639ac71..2efa81a6cbf6 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -184,6 +184,26 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
 	return ret == cb;
 }
 
+bool task_work_cancel_current(struct callback_head *cb)
+{
+	struct callback_head **running;
+
+	if (task_work_cancel(current, cb))
+		return true;
+
+	running = &current->task_works_running;
+	while (*running) {
+		if (*running == cb) {
+			*running = cb->next;
+			return true;
+		}
+		running = &(*running)->next;
+	}
+
+	return false;
+}
+
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
@@ -195,7 +215,7 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
 void task_work_run(void)
 {
 	struct task_struct *task = current;
-	struct callback_head *work, *head, *next;
+	struct callback_head *work, *head;
 
 	for (;;) {
 		/*
@@ -223,10 +243,11 @@ void task_work_run(void)
 		raw_spin_lock_irq(&task->pi_lock);
 		raw_spin_unlock_irq(&task->pi_lock);
 
+		WARN_ON_ONCE(task->task_works_running);
 		do {
-			next = work->next;
+			task->task_works_running = work->next;
 			work->func(work);
-			work = next;
+			work = task->task_works_running;
 			cond_resched();
 		} while (work);
 	}

