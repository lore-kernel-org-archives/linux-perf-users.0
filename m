Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D2204F73;
	Mon, 28 Oct 2024 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152118; cv=none; b=iB7bJbzollSjEOz2LE0lCJbpkWwH85tMij5Rer2YMTB2pYjl/urqex0opS+g26y+toHHi5eXee00qnEhCeXVo5ActPNdI0OPsGbklFayGypXRyzAltTXQDUuSGJaMqDoaV+H3bdFDyxzqJQlEgnJ4atAQNRj57dIKFc+liYFJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152118; c=relaxed/simple;
	bh=tFz0jCfBxp5+ANCGDurYSkakpQpnUMZjNRHlpxS7hNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SseyNiAojnMMxcbiv62gZaqbuajKZvnVOXpVJ3r13dLEmIAnFblw+6dbCqrjdoVmQ/jWbkkKPH0U+QyEZW4slBabaLz5rPwB78rGkwlG5v45Zjwtpt2DTjG94KH537zwoYpTjGTELZn27cICMuFn+05wGFUpw0HVwfWpjK1cu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq3ZE4Z+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq3ZE4Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820FEC4CEEC;
	Mon, 28 Oct 2024 21:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152117;
	bh=tFz0jCfBxp5+ANCGDurYSkakpQpnUMZjNRHlpxS7hNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gq3ZE4Z+8P+K2q+unYPpjbzj13un1GsLe9T90zNsBooSyKFbyiMeM4ZiC+i3E9odL
	 GS6cMHWlZPIe8bRaQocs1CeU6+t+QA3ps+CCSWfPTriO/HE9MDWTTVanl/Wd2hx1Dr
	 wExWU20WYteq7Rpg6hnGGX6SvWnMS3pAod8YaBRp/vr9pBStDRddruqjU82HaqN+mh
	 mLlX3ujTFOY76KNcXHsBvXxTUMXKCbjDLPCIybq29VNSlJsAp//M+Lf9j69uEHEJjG
	 iOxZqX6pqNWcrefq9w+WZ6/maS3yINM1Zf2BiMW8uzY/TTO67AtKr2B4C/e3CowsaM
	 bnd+gjg/8YPCA==
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
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 07/19] unwind: Add user space unwinding API
Date: Mon, 28 Oct 2024 14:47:54 -0700
Message-ID: <f89a9137e983902f22611e5379606062a64b2382.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241028214754.KtR7HbQ6yj58_RZaAjfZGud_w6Msm7zxPUlWthWHytU@z>

Introduce a user space unwinder API which provides a generic way to
unwind user stacks.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                |  7 +++
 include/linux/unwind_user.h | 41 +++++++++++++++
 kernel/Makefile             |  1 +
 kernel/unwind/Makefile      |  1 +
 kernel/unwind/user.c        | 99 +++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/user.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 7a95c1052cd5..ee8ec97ea0ef 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config UNWIND_USER
+	bool
+
+config HAVE_UNWIND_USER_FP
+	bool
+	select UNWIND_USER
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
new file mode 100644
index 000000000000..9d28db06f33f
--- /dev/null
+++ b/include/linux/unwind_user.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_H
+#define _LINUX_UNWIND_USER_H
+
+#include <linux/types.h>
+
+enum unwind_user_type {
+	UNWIND_USER_TYPE_FP,
+};
+
+struct unwind_stacktrace {
+	unsigned int	nr;
+	unsigned long	*entries;
+};
+
+struct unwind_user_frame {
+	s32 cfa_off;
+	s32 ra_off;
+	s32 fp_off;
+	bool use_fp;
+};
+
+struct unwind_user_state {
+	unsigned long ip;
+	unsigned long sp;
+	unsigned long fp;
+	enum unwind_user_type type;
+	bool done;
+};
+
+/* Synchronous interfaces: */
+
+int unwind_user_start(struct unwind_user_state *state);
+int unwind_user_next(struct unwind_user_state *state);
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
+
+#define for_each_user_frame(state) \
+	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))
+
+#endif /* _LINUX_UNWIND_USER_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..6cb4b0e02a34 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
new file mode 100644
index 000000000000..349ce3677526
--- /dev/null
+++ b/kernel/unwind/Makefile
@@ -0,0 +1 @@
+ obj-$(CONFIG_UNWIND_USER) += user.o
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
new file mode 100644
index 000000000000..54b989810a0e
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Generic interfaces for unwinding user space
+*
+* Copyright (C) 2024 Josh Poimboeuf <jpoimboe@kernel.org>
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_user.h>
+#include <linux/uaccess.h>
+#include <asm/unwind_user.h>
+
+static struct unwind_user_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+int unwind_user_next(struct unwind_user_state *state)
+{
+	struct unwind_user_frame _frame;
+	struct unwind_user_frame *frame = &_frame;
+	unsigned long prev_ip, cfa, fp, ra = 0;
+
+	if (state->done)
+		return -EINVAL;
+
+	prev_ip = state->ip;
+
+	switch (state->type) {
+	case UNWIND_USER_TYPE_FP:
+		frame = &fp_frame;
+		break;
+	default:
+		BUG();
+	}
+
+	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
+
+	if (frame->ra_off && get_user(ra, (unsigned long __user *)(cfa + frame->ra_off)))
+		goto the_end;
+
+	if (ra == prev_ip)
+		goto the_end;
+
+	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+		goto the_end;
+
+	state->sp = cfa;
+	state->ip = ra;
+	if (frame->fp_off)
+		state->fp = fp;
+
+	return 0;
+
+the_end:
+	state->done = true;
+	return -EINVAL;
+}
+
+int unwind_user_start(struct unwind_user_state *state)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	memset(state, 0, sizeof(*state));
+
+	if (!current->mm) {
+		state->done = true;
+		return -EINVAL;
+	}
+
+	state->type = UNWIND_USER_TYPE_FP;
+
+	state->sp = user_stack_pointer(regs);
+	state->ip = instruction_pointer(regs);
+	state->fp = frame_pointer(regs);
+
+	return 0;
+}
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
+{
+	struct unwind_user_state state;
+
+	trace->nr = 0;
+
+	if (!max_entries)
+		return -EINVAL;
+
+	if (!current->mm)
+		return 0;
+
+	for_each_user_frame(&state) {
+		trace->entries[trace->nr++] = state.ip;
+		if (trace->nr >= max_entries)
+			break;
+	}
+
+	return 0;
+}
-- 
2.47.0

