Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281F2FE367;
	Thu, 17 Jul 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773592; cv=none; b=fJ2Da37zrpAo5NTtbj60RzgW+KOE/DJd4aKQpjYSaRZa6EMmK+VjfiLi71w0jVtwug6tHw+qM+QAE4jaSbFp0tI4fxxyLbVt7a+ExmIFqVupOXcGNq/SJylu4RgW9jxCfEqXhTFH0VoIdsNfGCVgMzzsykJhr42QxdZllicBvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773592; c=relaxed/simple;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UJOHriRM4WeTp3YEznvktMoyVg/KZiVO9/bqlWXZoDy1Y0Jn3mjGm8ubWv58Sha6j7H3K0gQ4sE1+/8F4TWmxpY41vqeUwTK29uMTQuAnHqqO05A5h4H5UIoZxk6WZAOEIQTi3N8qBc3VWieA8lvCgzAuJcjwRYo9apD1L+lu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3OQv33z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3OQv33z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D79C4CEFE;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773592;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=r3OQv33zG9EH3FJTIkc37C4sXROaoegHw4rTEoxf4eIAZWPJOZB6toEQ6dRBdgvnY
	 kV4K+M9vUPjUDCnwydJTlZfdTXvtJJUzT5RneqBuuQ3cvEL23BM20Z3mtGuRfUwOmD
	 7tX4Dl40I8j9wMyMspd4Zx4ZLvPUkhKtZmJNXNofcaSIpdqCiXUpIx71lrMfc1BbM+
	 55aSsN46pckorVCaefWkkTlIezyx9QMUBzi/s4G6XRVbbsrMmgXP0sYDZcOMZ9QOvt
	 u3++mxjdupZaKfhACxndtULIj2dfRcSkm/jwJZ12jWavwDWpisBqPnezUBE5X3Jxzw
	 qRcQR/Nd+tfvA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucSU9-00000006c0C-3JSk;
	Thu, 17 Jul 2025 13:33:33 -0400
Message-ID: <20250717173333.639908993@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 17 Jul 2025 13:31:29 -0400
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
Subject: [PATCH 4/5] perf: Simplify get_perf_callchain() user logic
References: <20250717173125.434618999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 5982d18f169b..808c0d7a31fa 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -247,21 +247,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				regs = NULL;
-			else
-				regs = task_pt_regs(current);
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			start_entry_idx = entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx = entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2


