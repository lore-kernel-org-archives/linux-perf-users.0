Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8332FE32F;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773592; cv=none; b=KgkO8bi3UXKzElSLRhTi18iVOVRJyBGFsgz4zh+CavsywZ8hFP1Wr/4NUumt14c5ierZT27vcKrEo5PJG3WVZ2XtLgflyOHl0OphiaqH3bBogey1zxIyGKJIitlBRbjNSuCpQ1l43hHaSfll4wLHReIB/IdqgIL/dc+cUJjqKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773592; c=relaxed/simple;
	bh=zu7q7dulevcxsLQMsjcxfn6mbuHIR1BIFYpRfwZePWM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ABFrTf+bLsQwxJEuclY+g6PF9TIxNV+M3ewArEhNbEPlKeYdnZuzDlzQ+kNHBhbDz3TjL9mJlpBIXfCE7BYh72d+JKMkulgUhYZlN7s20rSABRLNYc/477IGNn5nz4txmNDq9A9Ln/3+pB9QHqtIdEI4Lt5NLlvy0ow7GDy85Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hist6LnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hist6LnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC085C4CEFC;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773591;
	bh=zu7q7dulevcxsLQMsjcxfn6mbuHIR1BIFYpRfwZePWM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Hist6LnBxP8tJnU8MtSWx/BmPFhBvnz7ijLY+WL+/BCHXUIbyOIlcspDxYp7DqABX
	 UuGQ2X2NDjipte9a3/JtcacMZ/yKuxWd02qnUy3aD1Ir6K27Dh8QAv8HZ5iKLJTvBu
	 vYT4/ZciMQwia77zhJ7E6M+rm8wRcpt1mkkJJUBIMlxjzFOAEVukfguko3BAErHi4k
	 82x/D2OZZvRVga2tZhpS4/c5V9SBZmWqeaQd9iWHoTcu/R6w0n3SOYT9nl8hYfacyB
	 oOZJStVRpU8V+j6wnu0cT17Cu08QmHUYO2jRd7dHdfMsr0Tv+lEthjnUctQs0c1C6V
	 svg/7ZcerFdhw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucSU9-00000006bzi-2b9Q;
	Thu, 17 Jul 2025 13:33:33 -0400
Message-ID: <20250717173333.468514575@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 17 Jul 2025 13:31:28 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of
 current->mm == NULL
References: <20250717173125.434618999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & (PF_KTHREAD|PF_USER_WORKERi)) than to rely on
current->mm being NULL.  That is because some kernel tasks (io_uring
helpers) may have a mm field.

Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/all/20250624130744.602c5b5f@batman.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index cd0e3fc7ed05..5982d18f169b 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
+			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
 				regs = NULL;
+			else
+				regs = task_pt_regs(current);
 		}
 
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b2a53cabcb17..1fa554e2666d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7414,7 +7414,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & PF_KTHREAD)) {
+	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -8054,7 +8054,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2


