Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F537B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXp+s9E0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A3BC433AD;
	Thu,  9 Nov 2023 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699490624;
	bh=f/u46cSAc9qsUaWdoxS6P4+cNiKWEhTEIbvF7580Ups=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXp+s9E0fNS9MJQQqIe6YpNebFG18Lo8YkTcYXLLlRVDororUiczYubXEBB5TMmxZ
	 igB/cg7yUP7U6IN88bh4PrX4H5zCOHAVoE4csA+6C7pXpWLk0XLX5ygnwFvQveZwUL
	 uh7nQskU7YkdxiSGMcaCXV/XBEAy2qYkRsmtqFbSFFoirqMhOCdCalk+CWsIHRp0UQ
	 ykKxHb9W2V3AMbCt5JxBSFUtXSNRT+GYwlmfzEQSjl7E/xGd/G4uEbzT1zz9mRaAx8
	 wcDfJHLM7X4hNHTTsFpVfdzrHP6PKko7wdXFtDqPbg0mF/gKUuHEP3+8eo+DYt1C/t
	 4ObatLhGGLFkw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 08/10] perf/x86: Use user_unwind interface
Date: Wed,  8 Nov 2023 16:41:13 -0800
Message-ID: <d212366c37804931c188b2433ba42ed42f0cb46a.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify __perf_callchain_user() and prepare for sframe user space
unwinding by switching to the generic user unwind interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/events/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ae264437f794..5c41a11f058f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/nospec.h>
 #include <linux/static_call.h>
+#include <linux/user_unwind.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -2856,8 +2857,7 @@ static inline int __perf_callchain_user32(struct pt_regs *regs,
 void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs, bool atomic)
 {
-	struct stack_frame frame;
-	const struct stack_frame __user *fp;
+	struct user_unwind_state state;
 
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
@@ -2870,8 +2870,6 @@ void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	if (regs->flags & (X86_VM_MASK | PERF_EFLAGS_VM))
 		return;
 
-	fp = (void __user *)regs->bp;
-
 	perf_callchain_store(entry, regs->ip);
 
 	if (atomic && !nmi_uaccess_okay())
@@ -2883,17 +2881,9 @@ void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	if (__perf_callchain_user32(regs, entry))
 		goto done;
 
-	while (entry->nr < entry->max_stack) {
-		if (!valid_user_frame(fp, sizeof(frame)))
-			break;
-
-		if (__get_user(frame.next_frame, &fp->next_frame))
-			break;
-		if (__get_user(frame.return_address, &fp->return_address))
-			break;
-
-		perf_callchain_store(entry, frame.return_address);
-		fp = (void __user *)frame.next_frame;
+	for_each_user_frame(state, USER_UNWIND_TYPE_AUTO) {
+		if (perf_callchain_store(entry, state.ip))
+			goto done;
 	}
 done:
 	if (atomic)
-- 
2.41.0

