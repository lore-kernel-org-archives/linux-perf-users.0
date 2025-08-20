Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6927C872;
	Wed, 20 Aug 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713066; cv=none; b=pej3EcNZ7FUt/qLe3tRMQAMRscYLqewH7qZSw5Cg5c8qTZ9zFgNQLAcTAqyCwRjKkCXtLYhm02N/YkQGYtj3penqNC/iafa4OhKx5KukMiPMZeEdy02RXGdGX7ny3peJyZc77Ip3/TFiSudMVUl3Q1jt5J/iTCH071B2CcgyHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713066; c=relaxed/simple;
	bh=Z7OW0MtPk3QyuYDWTldLdNqRvinvYbppGe1x78veJ7o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VrIrSudCur1/YDNDUbsFdaQsN8EjRaCeoACdDYBIf5GtZ7TNbxNvOTOTB/Pjdn9jH2OAq3fqFx4q5FBtRPxK2zzeKnIkUaByLtDGB+nVqwGPZ9WMkFk87DvG/SNLEr4+nmGecSRSyXUdo3r8QPRJjUWU8qAB2Kv122XM9MDLypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bpz84XRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bpz84XRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7130C2BC87;
	Wed, 20 Aug 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713066;
	bh=Z7OW0MtPk3QyuYDWTldLdNqRvinvYbppGe1x78veJ7o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Bpz84XRT5ALy8Djc7hyIAbaJz4C4p3b7eptwJeFpJifQhKrRcWsb1FsSSg0aRpSgv
	 EWmyuUNEtrY/WPnPdgXEV8LoczYrNK/35PM/PozNS0eKxg0fxShtK8pA7PGP9ryl+v
	 S1niuM5RS0ZVBZrZrr7kB/5iI6C6PEDIaxlNW/q+eS0HzCZ9EijH+YqWfPDDvCdQNw
	 dIMGvR7Zxd+Q5O/6ZPfXrO3ou4HcCuHzNFLf83UT/TCGsw9DNRlZ2tCRWk6QeXmde5
	 bsC5DfUVCDhlnWA5g7jgeR/TyVUArLs1RK8Vc+430B/NIYExWSJ3tmE+dGqAHFfY8y
	 uuQCXzO7PaRdg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uonAi-00000000rui-3p1h;
	Wed, 20 Aug 2025 14:04:28 -0400
Message-ID: <20250820180428.760066227@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 14:03:42 -0400
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
Subject: [RESEND][PATCH 4/5] perf: Simplify get_perf_callchain() user logic
References: <20250820180338.701352023@kernel.org>
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
2.50.1


