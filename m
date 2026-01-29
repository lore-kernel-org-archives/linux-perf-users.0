Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCD3191C0;
	Thu, 29 Jan 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700506; cv=none; b=pDyGOkBGfiRcbh8jm21k3ygBgVehqo38+MJ9kBTDBZ+qMaDfVlThXEY0RxKTFQwT+2JE/4BK7WR40jm+BuVDNxDJ3hmZJidL5N+T9aPZTFfu13/SFDzoxWL5f+Mt5A6bgSf2uEG5abtI5HQ9KAet6TP1UfTmcQ9uqZOli6Uvh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700506; c=relaxed/simple;
	bh=jIUz84h8NpknCoCKer98gGhkUtY4yP88mwSL06t66Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I5EjUyzYng2XUNOPkGoy6O9waoaX2YZCLUlNXWkdJ84ua4iAf8CF6eDORZ6MLFkZWOr+TLzvdenvflHugoyfCNIDxeeGmWR6TaB0q/1OAjVUjSNp3zwJH+Rsf1qhDL2jSxRLka0rgh3brEZJUqeTdeifX1Ys1M6E4tBKe3L1N68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 828881401DE;
	Thu, 29 Jan 2026 15:28:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id B6EF020012;
	Thu, 29 Jan 2026 15:28:09 +0000 (UTC)
Date: Thu, 29 Jan 2026 10:28:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Guenter
 Roeck <linux@roeck-us.net>, Ian Rogers <irogers@google.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] perf: sched: Fix perf crash with new is_user_task() helper
Message-ID: <20260129102821.46484722@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B6EF020012
X-Stat-Signature: 6f4xe3n3sy64h8j83wxap6838jfyi1xk
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18s5DsNJarFzjHYIZlHVcllmYy6uaey7uo=
X-HE-Tag: 1769700489-570781
X-HE-Meta: U2FsdGVkX197N4Z4jt36RlEyw64DYuzOwg4kfEGQnpA7/FAnG9ifXyTmhmsPPnMO6MJqRBnuo+UEoprIP02XtpzGvEQlmbeTXbUsmdBISZ6OHh09mMAGp4RN0ouGGO0PBaEdT/LjgPDCdn2nWXqMxtJLKwDJ3pSIXQ8zYA5D5ROjIIb/R/VpGIx9W8UTJZt+WHPacFZv+UKcKvpM4wqQGKyaqCpLuzAYak3+Us3/fxgNNMo0ZnVzWxg6J1RU26s8wix8Y1wXAmmzDCwyc6fCJNNvWM02jIeMqZLizgGkBKA5ivevpgrp88W5Ar9Xled7h9k0GtiIqzBm0wOoiXRkWriEXsNXhGvevu0xXUb7iuhGgEpWiXGsbrh/o7xIZquQCE55G53aCR9w5WFRqzbMdwJrnqJrgZ+t7vhMtC20YwRFsST1Es/Wvn8GM38lreY1SLt8Bli7ECn+vVFkQCflpA==

From: Steven Rostedt <rostedt@goodmis.org>

In order to do a user space stacktrace the current task needs to be a user
task that has executed in user space. It use to be possible to test if a
task is a user task or not by simply checking the task_struct mm field. If
it was non NULL, it was a user task and if not it was a kernel task.

But things have changed over time, and some kernel tasks now have their
own mm field.

An idea was made to instead test PF_KTHREAD and two functions were used to
wrap this check in case it became more complex to test if a task was a
user task or not[1]. But this was rejected and the C code simply checked
the PF_KTHREAD directly.

It was later found that not all kernel threads set PF_KTHREAD. The io-uring
helpers instead set PF_USER_WORKER and this needed to be added as well.

But checking the flags is still not enough. There's a very small window
when a task exits that it frees its mm field and it is set back to NULL.
If perf were to trigger at this moment, the flags test would say its a
user space task but when perf would read the mm field it would crash with
at NULL pointer dereference.

Now there are flags that can be used to test if a task is exiting, but
they are set in areas that perf may still want to profile the user space
task (to see where it exited). The only real test is to check both the
flags and the mm field.

Instead of making this modification in every location, create a new
is_user_task() helper function that does all the tests needed to know if
it is safe to read the user space memory or not.

[1] https://lore.kernel.org/all/20250425204120.639530125@goodmis.org/

Cc: stable@vger.kernel.org
Fixes: 90942f9fac05 ("perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h     | 5 +++++
 kernel/events/callchain.c | 2 +-
 kernel/events/core.c      | 6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d395f2810fac..f29ebeeac970 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1776,6 +1776,11 @@ static __always_inline bool is_percpu_thread(void)
 		(current->nr_cpus_allowed  == 1);
 }
 
+static __always_inline bool is_user_task(struct task_struct *task)
+{
+	return task->mm && !(task->flags & (PF_KTHREAD | PF_USER_WORKER));
+}
+
 /* Per-process atomic flags. */
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b9c7e00725d6..636ffa5e5364 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,7 +246,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			if (!is_user_task(current))
 				goto exit_put;
 			regs = task_pt_regs(current);
 		}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index da013b9a595f..1a06adebd2f2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7745,7 +7745,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	} else if (is_user_task(current)) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -8383,7 +8383,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		if (is_user_task(current)) {
 			struct page *p;
 
 			pagefault_disable();
@@ -8498,7 +8498,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user &&
-		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
+		is_user_task(current);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
-- 
2.51.0

