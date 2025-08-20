Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653C27EFF1;
	Wed, 20 Aug 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713066; cv=none; b=ioWsBX5bm1uge0WMWlhgMKH4ozk5VNeybRaVyAFdJtUz6VA5jzOlZ72rL9JfCXEZmCiCCEBUcr9B5mx2XY1WvRtscujuTIOmE3nVQ6LgF7t3Njt4EIsYz67gt9YHFq3AOakcEzdxG/W5LEjlZKyoylp3FTx88ESC6ZTv72VoPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713066; c=relaxed/simple;
	bh=FD0EJ8+cUesEx3BIgE1WisKxGgEGkMQBMuyAb5sxtAg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eycpxz/bJGIIGLiYzqkFi39p4NSYqyI3AjVQRjyvkNIMNwg6jOFymLER1ftxgf76nyBwNX/UvRFCPJWv4cVRwoXYhkTYBn9ws0r2TbE0K32XJCiJ+RXLymbNbnVQS6lC8A6JNu2QfuQzvjESyvmN3WBAJrA8Vp230wg8EDieKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngex5nso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngex5nso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F845C116C6;
	Wed, 20 Aug 2025 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713066;
	bh=FD0EJ8+cUesEx3BIgE1WisKxGgEGkMQBMuyAb5sxtAg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ngex5nsolHfM597TaDXyV3Bzqp8R9w2//2W5sYbpdX3JVGIMJouuIx7UgR6NfxNkb
	 +7Uybuu76zqshglzV860PkAKGZ6C84oAr9fQLEZbR2s2qnviGirCGLVjh/+XQ05xdu
	 lARbK1Fb+eRqDFHG6tUomMYr0dZiA0eDcFAZqaQOLNIWvLtBQXtpc5wQ1Jlzbg+iRe
	 tZRg6ZMs+WTr2Dmy11sgvnO+UAnh7jD99X0JkZIOPcXJTGs1mvP8qB/mdJm5NCSk+h
	 wceOdI3aQTpvbh0ht+q+6XOugFzOmbDmvx4qQIo9cVQq1Dk7lALJ3wJC1YT5dPs3//
	 8dFMPfe+IKHsw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uonAj-00000000rvC-0KK9;
	Wed, 20 Aug 2025 14:04:29 -0400
Message-ID: <20250820180428.930791978@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 14:03:43 -0400
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
Subject: [RESEND][PATCH 5/5] perf: Skip user unwind if the task is a kernel thread
References: <20250820180338.701352023@kernel.org>
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
index f880cec0c980..28de3baff792 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8198,7 +8198,8 @@ struct perf_callchain_entry *
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
2.50.1


