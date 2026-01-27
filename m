Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187A34EF1B;
	Tue, 27 Jan 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527362; cv=none; b=dxtDZYOmM9BXQAxPGpG8L9UG+clD6C1xWRjVlQyxHIjnDx0WoyP1T3Vwu3RCzEDo2HDOKviRscv8mGqqBTaBrjOHuSh8yk/kGjXEdekys/FCzdgsDuDuYrHk7h+O8eSxhy/a8mMVrF0a/Y7InkwhUqW+DkZrLDPCjpZTbp5Pbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527362; c=relaxed/simple;
	bh=Hou3k/YcDUMSmtvqCulcR2nRe7AtIjNjZF4uNZFK+O0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4b0bBN60YmeKbd78SLq5OGqFSMR+k+OmvxNK7Q6GwdEwpPRVSMH4+IcnPQBazfyKi4LcW9sJBGns0XYWqEnOpT4YUaytZgtuNlQ3YjyBAIfj5CgkbqNs6BkYlkyIAcOhQh35/O1b9wODfjj1pDKpEPpO94B9P1LL23WD0WxNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D832814012A;
	Tue, 27 Jan 2026 15:22:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 56F3D2D;
	Tue, 27 Jan 2026 15:22:29 +0000 (UTC)
Date: Tue, 27 Jan 2026 10:22:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
Message-ID: <20260127102234.755d8c4e@gandalf.local.home>
In-Reply-To: <27f9a957-67c7-4c88-b320-0f8725e9b03d@roeck-us.net>
References: <20250820180338.701352023@kernel.org>
	<20250820180428.592367294@kernel.org>
	<0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
	<20260126120553.2fa79048@gandalf.local.home>
	<20260126121803.4a90c959@gandalf.local.home>
	<27f9a957-67c7-4c88-b320-0f8725e9b03d@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 56F3D2D
X-Stat-Signature: y3dht6s46cac557phezgp57ms64ubspr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sMSEd3/nbnTD7cCLRgruhuMiDCGUh7no=
X-HE-Tag: 1769527349-467222
X-HE-Meta: U2FsdGVkX19wi/5GZpUyP+BSQqWhDYL1T8dLa8uCE/dr9JD+jG8FrH4NY/oBVpREvELdR+pwpbkOCwYRHXdEsBbcLLLL9JK6ggA3qt7XtISl0TjDmR/QlsXYbUxXpqHpZ+WRaUIejWaeYKdeT8f4404wgwewi04i8n099PiYGuo0ZH82lI5Y0zVTUGe38P7B8cfeSBrQiqp26M++DmKtmzzYHPJ2gfuxQi2nUMcQZJVMe/fYkQ1AjiVDKIs2U7PQoLkecNqnRhVxiAOUQdf62aGZdGeHJQMT//TmszS9OELshDiZw/ATy+pzUestxrsyOo6dnF+OkmV/UUcWXzlogFWrVT+ObvGS31OFUkKvspcvpw+IqhhhTif/XJRC5AljdNfzuHPgrzcrZFC23q7tK43hBlsegpo3u+C1UNw12QVVdhlWK97glND0jPaGku7QbRCcnS2oBR+ELzp3G9ogeA==

On Mon, 26 Jan 2026 17:32:35 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Still crashing, though not as often and with a slightly different backtrace.
> I added the backtrace to the bug report @ Google.

I figured there would be other locations. A while ago I had a patch to wrap
the checks in a "is_user_thread()" helper function[1], but Ingo had issues
with it. It seems now it's biting us in the butt and let's see if it would
help now. I modified it slightly.

[1] https://lore.kernel.org/linux-trace-kernel/20250425204313.616425861@goodmis.org/

If the below fixes it, I'll resend it, but now as a real bug fix.

-- Steve

diff --git a/include/linux/sched.h b/include/linux/sched.h
index da0133524d08..5f00b5ed0f3b 100644
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
index 1f6589578703..9d24b6e0c91f 100644
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
index a0fa488bce84..8cca80094624 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7460,7 +7460,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	} else if (is_user_task(current)) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -8100,7 +8100,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		if (is_user_task(current)) {
 			struct page *p;
 
 			pagefault_disable();
@@ -8215,7 +8215,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user &&
-		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
+		is_user_task(current);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
