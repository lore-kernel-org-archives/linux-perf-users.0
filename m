Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A82FE368;
	Thu, 17 Jul 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773592; cv=none; b=SNs8MkurAhHziLVJq7Y39EmNJGIkkAU8IbgQYSK0lCRW1Epdz1i0riwNNBBoY1pQFssS1fs9O1L74m9ZJUSKjKJTDgpzq64+uXsLwNcrfEfD25ZLT4+1l6ICw0fWxI8mNb3cRbpiRJNppytxckzy/R1iQZAtyFUiTmr/v2UlCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773592; c=relaxed/simple;
	bh=PrLV5/6t/jDNDZv13dJ+tk4FMXWbDNxrkHMrhIU764A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MgtXYVhczvQWIJBkv5rPWbVGF+dVUtw6fUsJMdUZYYe1WgdYbQgQ8zkxR3U7x7tpVgLLyEX+vu6ErE/9lz6YhKGFkr1S3PbkdyYDz9jIFrbKfxgg0VM1y4+fag7jme9SipSpvEHFJZ1ZnjL7ZHYBt1Wj/55xsyG5NEuIev0dPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMhKkBQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMhKkBQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304D5C4CEED;
	Thu, 17 Jul 2025 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773592;
	bh=PrLV5/6t/jDNDZv13dJ+tk4FMXWbDNxrkHMrhIU764A=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QMhKkBQ7wCz+KWRiWhE3QT9BE3z9z7zT19nsr/tl3qIoptT57DNxI/cR9wif+US7m
	 UrPnsGfJHaa1wS2wMnrOAUzcP5q+9zd8XOzaeNVtI6SLQyn3sfflvwnXVBV6m8BOZx
	 +euu2foBS8A9iSqNOw2wXF9eBikKJ5EwXLFwWyrei8tcmPa7VdUeoM54dNSXZVMLeU
	 WsKju9WlzLqtDO3nWwO9e5KtFk3rveP/YCeqLU37yO3yEPLEyJiFj7fI0P0WeXrinv
	 0HwIzXcjPnOeu7lVmG5Pw26+HoC8eZaqkN/eSmDgbvt7BBcpQ3LgWwSJ/9yOQ7SpSN
	 7MG0EkL7+JLmg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucSU9-00000006c0g-42Ag;
	Thu, 17 Jul 2025 13:33:33 -0400
Message-ID: <20250717173333.809101137@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 17 Jul 2025 13:31:30 -0400
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
Subject: [PATCH 5/5] perf: Skip user unwind if the task is a kernel thread
References: <20250717173125.434618999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1fa554e2666d..bd0a33f389d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8166,7 +8166,8 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
-	bool user   = !event->attr.exclude_callchain_user;
+	bool user   = !event->attr.exclude_callchain_user &&
+		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
-- 
2.47.2


