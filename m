Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B2287254;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773592; cv=none; b=Gw99CxSRIdvjdS41DEbJ2aubBS5/MM4D/tSPPNBts2yBeY21/u8SmFpqyr2SgdZGgSIrKyQDYfQy0LEIAdEcm2agkFSXnawKXbDWmSSLZewuOwO5oTNh5dzZetwISUvtPIV/Gu7DQ8I911lR+9Jf7CUqUzcBLmoYWjbV54pbX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773592; c=relaxed/simple;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KJVP9BJGE1HNgokvcfKiwhH8LU8F6My5OtnDO9R7ZjN4IZQ9ZiDpWl7SvuJ6hw4fp49Oem/1fQxJaCGcO6l9+OyMK9E00lky/q9QlLj3qnClLr6IDSxEV5vJQ3Wt7dQFHtmqa5kGXuzKVOyhTXLjyUrpHIekHLwCt6cUjojkBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+SQYSfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+SQYSfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99191C4CEF0;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773591;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=E+SQYSfo8cOkeiMMf6XhkfIxjcuVpAyAonrzeus8W9rkoyqG5jIm+cKpg1XNpQY9z
	 p0hPkQq8wxJh2E1TTED8azhsdsrclLfY8l2rLmEpoajA51XVpWs2e7krNS4v8SupTd
	 lbXpi6hW7jrBQZ77qBNBrDFpfjixRp4F87P7w2oyvZzkywf8erSCK43o+BdCZOINC4
	 apfBzlQbANz4RlXnDqPbE/ZwJvsAf7xfLwU1d+jdzkQkv//3pQSquzqDRyf2Vo/Vri
	 EABgYPzfRYizoN05p6k8w4r74Ka3zYACg6NYsss/sPMdf2hWJxVYCPg56aUw+sy8jm
	 0p/NhgaVom98g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucSU9-00000006bzE-1sXh;
	Thu, 17 Jul 2025 13:33:33 -0400
Message-ID: <20250717173333.301777520@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 17 Jul 2025 13:31:27 -0400
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
Subject: [PATCH 2/5] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250717173125.434618999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b0f5bd228cd8..cd0e3fc7ed05 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user && !kernel)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
@@ -240,7 +244,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		perf_callchain_kernel(&ctx, regs);
 	}
 
-	if (user) {
+	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if  (current->mm)
 				regs = task_pt_regs(current);
@@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2


