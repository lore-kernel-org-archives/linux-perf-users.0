Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F9274FDB;
	Wed, 20 Aug 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713066; cv=none; b=tR8mmKgm3P3AzdqpG3MzzIjS5TPg8ucKDqijXhh5eew48md7JmrOGlIv7CBQ8041GS+6swu3h2ntQmOO42UQ2tbqfKA05hrFl1NmXhW9uLUImkJL9ECvHuswFUEevvDU3rCg9yUqnkkaB/VDrKI0qxDI2zopilUc8SfOUGeadp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713066; c=relaxed/simple;
	bh=HYMOKiuvWZIARhalCg5/2gfv0nY8DKh4v2z1eG0URbY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AIkpgP+rzu1cYv3yAUrx0SYJ11xb0WMrhf1WRIk6FI0UJwQOJ1TsypRTOOcyNzYyS0bkTW5nonn07XnjIb4qb3aEgqyi6Qj0dVVIp3pOgnN1KVp+wZpuMaWsKl59Vb1uqc9IBjSlNWmTCeEr9dlYLWSOpDSVOqxWW4DkEHd0AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBr5Qv5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBr5Qv5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C624C116B1;
	Wed, 20 Aug 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713065;
	bh=HYMOKiuvWZIARhalCg5/2gfv0nY8DKh4v2z1eG0URbY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=aBr5Qv5vT1iNhFJiG7N5rCYu8Kp8kM11pmZdUNTOBrigBC3BqfCN/Q6wDduUItNA+
	 VdaP3e2afrpVVazDuFgdrBkwgrkJYcd3FWE3yhJ2t/uxaw9XdIXR+DpR1TshenV5fo
	 SvbDgxXCLbJ83VvWqlcGOJSVR/fVGUCq+GG9JTOJ0m7uAREL1UOk7kuA6lZuQcZ+IA
	 QL9LTYJkQjSvbY/rDFD6wKQ6m/e5muBXcw87zAsO6xJiplPvX7ZX3qc12t/hNA6EfZ
	 w4L45iYN9WtD633xOpN8a1gYDDdW6NbRnSpn3PF+MZDmDnOk8eY7h5vWyGkiV1W7wX
	 dymHEPRfittaQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uonAi-00000000rtk-2OyE;
	Wed, 20 Aug 2025 14:04:28 -0400
Message-ID: <20250820180428.426423415@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 14:03:40 -0400
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
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [RESEND][PATCH 2/5] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250820180338.701352023@kernel.org>
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
2.50.1


