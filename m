Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1827CB04;
	Wed, 20 Aug 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713066; cv=none; b=OyTeucoUVZk1iUO5GPDJPY9IIF/PyNOX3SSr7Ai7sgmitBPMyZaF1jUwU4mAMNUve7/v/t4YoM3JO55QAkqo+1yU3ED4r4PgmfHYIlQg+4UGTngCBe63AYSkw3OKNIo7yRxriZkJD4CQsTZh9nYisqwmruOl7JiWLMfCSNjuCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713066; c=relaxed/simple;
	bh=mHbF4+q1ErlU4eyF5kJRPdSwNKPbHxuYmpdQVQQMw8g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b1WA55ZHI+JL5lJmCKZnzdBz83nPnzZ76Hd6vZamM6xSeGFT60PKgrI2IgfS4jEepYoy1e+qoILfkMWGRmTGYFzEDTvJF6AoZlMxIC7Aob13R3Kt+ke7Oo41xi9dl+xC3hU8f7jxk9pMOmUq+ZMfIbCt37NHsDiMJXJEGXoLDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTppM/T/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTppM/T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0938C19425;
	Wed, 20 Aug 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713065;
	bh=mHbF4+q1ErlU4eyF5kJRPdSwNKPbHxuYmpdQVQQMw8g=;
	h=Date:From:To:Cc:Subject:References:From;
	b=YTppM/T/13nHLTQ91ofyhORHDnPvQsRC8jRl3ekOalM8sFzVZd5wOusRW00j5xv+Y
	 4Kr24xaVO0iNUhHviybMcLQKLsMPv+iKwC66i0emoKLeIa1+HktUXPggtyrnCfVlSn
	 SjdAr+Zdb2nOhjhjpWf0/ksx0ptNStS1MzocRICVUvh3e6A7pt/fHRu5wFdohZsKXj
	 YyDPSqi9Uu9eyuZCvdlmum9O3s3UJ4iXFDCt+h5GnQGIZhX+wz3SJbsA/gS6X3D1+i
	 CL6RB289sYGP4cNVoucfaA1SIMxEZzD7pcLRFG5dMM/i5EjsD6JALTBN43xVn0FloD
	 rrwL6+NMoAhuw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uonAi-00000000ruE-36PA;
	Wed, 20 Aug 2025 14:04:28 -0400
Message-ID: <20250820180428.592367294@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 14:03:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [RESEND][PATCH 3/5] perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of
 current->mm == NULL
References: <20250820180338.701352023@kernel.org>
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
index bade8e0fced7..f880cec0c980 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7446,7 +7446,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & PF_KTHREAD)) {
+	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -8086,7 +8086,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.50.1


