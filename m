Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8719006A;
	Fri, 13 Sep 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268595; cv=none; b=a3wmI/RExK7lNYNzBXn2UUWrPbsg4S8NSGN37aCXjNWoNpkV63jMOePjGrG4wWCD60dXEduvbC6LZzmuGvdlkLqX/jU5VhuoeTjDNRrtfL5HnoITZf2DABjZsyS8Z3tH39ReyDH5b+wwFA5PvrSrP1osbt4eAbEbsc2nDAu7hZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268595; c=relaxed/simple;
	bh=JS+sjdrUxMebxJ308crpqT2b6bsP1SFrOCMYC7oexSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffcXh5xDVN5qLQYil9RDhSQKAx13aoYEJR/7Ny4Db003WiyMF5C42c3H3pXAZUXsudnS6hw2lbT6gH4D0v3It2MyHGT0JusC62LUzQ+gxHTTXDgN6Gy7icraR15A248w7Z2reyyepLoz2+vbgUlkuEjP18vHnDGXVMvYEiHz3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXPqKfe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXPqKfe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016A3C4CECD;
	Fri, 13 Sep 2024 23:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268595;
	bh=JS+sjdrUxMebxJ308crpqT2b6bsP1SFrOCMYC7oexSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXPqKfe9ROTxunWuKafuKnOM/0I4RB7y2Yg02dG8/Rnw/dDlH5FoUBqF2BU8RjH7t
	 El3Z9u0Bj6VL6vXds0cx8ZBQDf1aUMNuJBnVQ3KpLIy6Ucy/VbKleBmNX56rRW2aDX
	 lGX90UGqJ2fxNnsVrJ843BbhRe1uHn3njjBEEfWoIlhr7jRC588LPhIk53CaqbcmzF
	 e+MpY1uYp8NsT0KenCP57q4u3gxtWQw5mW9SdJJh3nBTOxO7LB9Inq5rbRrhKCR5to
	 MjTJp/JZTLsEdukXRKlTkbu3E6XSnkGgO6I9lyABL6bfoYH4cYkUbLZM2xkJKDjIN5
	 f64ajUXmWckXg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 05/11] perf/x86: Use user_unwind interface
Date: Sat, 14 Sep 2024 01:02:07 +0200
Message-ID: <daf3f59e0d14ee11b45ad6735b8a211a3c7534dc.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify __perf_callchain_user() and prepare to enable deferred sframe
unwinding by switching to the generic user unwind interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/events/core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index be01823b1bb4..e82aadf99d9b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/nospec.h>
 #include <linux/static_call.h>
+#include <linux/user_unwind.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -2862,8 +2863,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
-	struct stack_frame frame;
-	const struct stack_frame __user *fp;
+	struct user_unwind_state state;
 
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
@@ -2876,8 +2876,6 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 	if (regs->flags & (X86_VM_MASK | PERF_EFLAGS_VM))
 		return;
 
-	fp = (void __user *)regs->bp;
-
 	perf_callchain_store(entry, regs->ip);
 
 	if (!nmi_uaccess_okay())
@@ -2887,18 +2885,12 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		return;
 
 	pagefault_disable();
-	while (entry->nr < entry->max_stack) {
-		if (!valid_user_frame(fp, sizeof(frame)))
-			break;
 
-		if (__get_user(frame.next_frame, &fp->next_frame))
+	for_each_user_frame(&state, USER_UNWIND_TYPE_FP) {
+		if (perf_callchain_store(entry, state.ip))
 			break;
-		if (__get_user(frame.return_address, &fp->return_address))
-			break;
-
-		perf_callchain_store(entry, frame.return_address);
-		fp = (void __user *)frame.next_frame;
 	}
+
 	pagefault_enable();
 }
 
-- 
2.46.0

