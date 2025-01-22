Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAB1BD9FA;
	Wed, 22 Jan 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513125; cv=none; b=rVWA1T8tEeKJzZiBMyHCvWSZdZX1RPU9h2Zv37WB+il2QnN5O1mZwv6gBJsM38MadTV5g9i3vHQGJS0RSa5eZjaEFYfKfRWV3KhSaXuFDgsKmy2s7N7t/UEemO4+CMrDTDa7M1mNbKIC48P0DhVBGG9s48UftYYWyUSgqP6xNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513125; c=relaxed/simple;
	bh=NjIdqBVmYAQ7mWEQSrSZ02FTmhQECUp5P6XRtsIceGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrrYsXFpbqBOWb2oqWyMXRkiF4QZ7C0qE8fZZJsUz6EfhmA5Oa6hab0vJxF8Mlsz8r0R/5MAZiggJ0sol0y6Z0kYVsnagT6HKb/AgLVaMgzNJA21HoMep56NDJbb35TuTK+9S1tN8nqgKCXeBWK0EMdBjUe+UQUC4vmrIpPMw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pckVlrQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pckVlrQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18D0C4CEE7;
	Wed, 22 Jan 2025 02:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513124;
	bh=NjIdqBVmYAQ7mWEQSrSZ02FTmhQECUp5P6XRtsIceGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pckVlrQ1vgKOpT0BbFE97cjfgOkHHWnebyOfei5aVlM170fXzkmOAfMBzUb6kWE2z
	 uJkw3IZYZ8238jnksj44OY0h8/m/xOVR7Qpv8YQUWTY1zMrV5UGsOWM0oe38zeP/Av
	 zhGGURsI7lrnGLJSG358a/2Z01TuBss2o1PYU8XAa3lI89aL3/YQa2uWmkqxb5ldVl
	 I90m6IwWzfxss7JHZ+Uo4EJe1X+9wMhE25ZtYNwRxlVkr0JpM+bJ56ZRWhs0XbDPO4
	 7XN7p8pSEA47/CenVpcERxc9jA3dC36LaM+BC/TahLjZ6KBmIkdVyE38s/D2Jmn1j0
	 ck0Mn157WDzDA==
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
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 12/39] unwind_user: Add frame pointer support
Date: Tue, 21 Jan 2025 18:31:04 -0800
Message-ID: <10b92f2fd065b67e6e3fd473ca145c34ea74b73a.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional support for user space frame pointer unwinding.  If
supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_FP and
define ARCH_INIT_USER_FP_FRAME.

By encoding the frame offsets in struct unwind_user_frame, much of this
code can also be reused for future unwinder implementations like sframe.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                      |  4 +++
 include/asm-generic/unwind_user.h |  9 ++++++
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 49 +++++++++++++++++++++++++++++--
 4 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 include/asm-generic/unwind_user.h

diff --git a/arch/Kconfig b/arch/Kconfig
index c6fa2b3ecbc6..cf996cbb8142 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -438,6 +438,10 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 config UNWIND_USER
 	bool
 
+config HAVE_UNWIND_USER_FP
+	bool
+	select UNWIND_USER
+
 config AS_SFRAME
 	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
 
diff --git a/include/asm-generic/unwind_user.h b/include/asm-generic/unwind_user.h
new file mode 100644
index 000000000000..832425502fb3
--- /dev/null
+++ b/include/asm-generic/unwind_user.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_H
+#define _ASM_GENERIC_UNWIND_USER_H
+
+#ifndef ARCH_INIT_USER_FP_FRAME
+ #define ARCH_INIT_USER_FP_FRAME
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 6ed1b4ae74e1..65bd070eb6b0 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -6,6 +6,7 @@
 
 enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
+	UNWIND_USER_TYPE_FP,
 };
 
 struct unwind_stacktrace {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 456539635e49..73fd4e150dfd 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,6 +6,18 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/uaccess.h>
+#include <asm/unwind_user.h>
+
+static struct unwind_user_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+static inline bool fp_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
+	       state->type == UNWIND_USER_TYPE_FP;
+}
 
 int unwind_user_next(struct unwind_user_state *state)
 {
@@ -13,8 +25,36 @@ int unwind_user_next(struct unwind_user_state *state)
 	struct unwind_user_frame *frame = &_frame;
 	unsigned long cfa = 0, fp, ra = 0;
 
-	/* no implementation yet */
-	-EINVAL;
+	if (state->done)
+		return -EINVAL;
+
+	if (fp_state(state))
+		frame = &fp_frame;
+	else
+		goto the_end;
+
+	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
+
+	/* stack going in wrong direction? */
+	if (cfa <= state->sp)
+		goto the_end;
+
+	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		goto the_end;
+
+	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+		goto the_end;
+
+	state->ip = ra;
+	state->sp = cfa;
+	if (frame->fp_off)
+		state->fp = fp;
+
+	return 0;
+
+the_end:
+	state->done = true;
+	return -EINVAL;
 }
 
 int unwind_user_start(struct unwind_user_state *state)
@@ -28,7 +68,10 @@ int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	state->type = UNWIND_USER_TYPE_NONE;
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+		state->type = UNWIND_USER_TYPE_FP;
+	else
+		state->type = UNWIND_USER_TYPE_NONE;
 
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
-- 
2.48.1

