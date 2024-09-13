Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B116F2EB;
	Fri, 13 Sep 2024 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268580; cv=none; b=Qzod5jw/I1Y/2irfvkEiDhvK0pWScPK+08S0UoTthADNtWS/lvEJRncpVY+/+T80F0YCOmjyahR1vcBawb0pWOSwy89n4M9PjBJkYI8tlhF7mErXwJ3pZbl52S/Zox0mgrlybLkRkB/v85lMiyPlAUyEKMPWnhyFoBTTR0P81j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268580; c=relaxed/simple;
	bh=UrdTg7XX5CHxZ4JxxT04nUldvsddNuXUWipjWZSoCrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBBxsCJM3AnB1930CALR8j0bs2IOcdOpG+x9i5CHT9vYm7ga4ECtFes2I0KeAwRAF7Ya3eXopgyqnFBHZEmZ4bIadaVGDcMMulzqBu1ytJilyNwO4fcIqzdGhXp6tNxx2kUIcQacmzsY8lSRbVuRlpEFFuvQ0efqKYy/2cemKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJBI2HJ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJBI2HJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54574C4CECC;
	Fri, 13 Sep 2024 23:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268579;
	bh=UrdTg7XX5CHxZ4JxxT04nUldvsddNuXUWipjWZSoCrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJBI2HJ80rWuyaYOHIYKXsOsOmQJ2QglVEMYHtnjzlCj2/IsdBpWI7iGDE3CUOVQi
	 KB9ZxKKRDqhT+WXesm+5HQ86l8jw9/9fXBAbC9mNROAlQtQkXtmUUdQV72ZhndDGXP
	 qdkf8R205yavpl1Y4DkaFlPJ4dpxL7uwHIEqVeDJJtd2XcFcQoLcmVz+Pyc7U2H0sc
	 WhX93ApSPgnJa2JMV2YuItd5XFtu0GumGOBYy7B7D5jLuNR1enjyiiFqQZo6uBR3lR
	 xnJf5juTQUrazpyfJ4RsFaCzHS7xhG8ghTYTGpE5RkUUvJBT1J2z4oi6THVPaQX/oa
	 I748qOrUAKQZw==
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
Subject: [PATCH v2 01/11] unwind: Introduce generic user space unwinding interface
Date: Sat, 14 Sep 2024 01:02:03 +0200
Message-ID: <f55f7f0b1410b4d75133e059646c4fc72b8cb581.1726268190.git.jpoimboe@kernel.org>
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

Introduce a user space unwinder interface which will provide a generic
way for architectures to unwind different user space stack frame types.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                |  3 ++
 include/linux/user_unwind.h | 31 ++++++++++++++
 kernel/Makefile             |  1 +
 kernel/unwind/Makefile      |  1 +
 kernel/unwind/user.c        | 81 +++++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+)
 create mode 100644 include/linux/user_unwind.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/user.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..b1002b2da331 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -425,6 +425,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config HAVE_USER_UNWIND
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/user_unwind.h b/include/linux/user_unwind.h
new file mode 100644
index 000000000000..0a19ac6c92b2
--- /dev/null
+++ b/include/linux/user_unwind.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_USER_UNWIND_H
+#define _LINUX_USER_UNWIND_H
+
+#include <linux/types.h>
+
+enum user_unwind_type {
+	USER_UNWIND_TYPE_AUTO,
+	USER_UNWIND_TYPE_FP,
+};
+
+struct user_unwind_frame {
+	s32 cfa_off;
+	s32 ra_off;
+	s32 fp_off;
+	bool use_fp;
+};
+
+struct user_unwind_state {
+	unsigned long ip, sp, fp;
+	enum user_unwind_type type;
+	bool done;
+};
+
+extern int user_unwind_start(struct user_unwind_state *state, enum user_unwind_type);
+extern int user_unwind_next(struct user_unwind_state *state);
+
+#define for_each_user_frame(state, type) \
+	for (user_unwind_start(state, type); !state.done; user_unwind_next(state))
+
+#endif /* _LINUX_USER_UNWIND_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..259581df82dd 100644
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
index 000000000000..eb466d6a3295
--- /dev/null
+++ b/kernel/unwind/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HAVE_USER_UNWIND) += user.o
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
new file mode 100644
index 000000000000..5d16f9604a61
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Generic interface for unwinding user space
+*
+* Copyright (C) 2024 Josh Poimboeuf <jpoimboe@kernel.org>
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/user_unwind.h>
+#include <linux/uaccess.h>
+#include <asm/user_unwind.h>
+
+static struct user_unwind_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+int user_unwind_next(struct user_unwind_state *state)
+{
+	struct user_unwind_frame _frame;
+	struct user_unwind_frame *frame = &_frame;
+	unsigned long cfa, fp, ra;
+	int ret = -EINVAL;
+
+	if (state->done)
+		return -EINVAL;
+
+	switch (state->type) {
+	case USER_UNWIND_TYPE_FP:
+		frame = &fp_frame;
+		break;
+	default:
+		BUG();
+	}
+
+	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
+
+	if (frame->ra_off && get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		goto the_end;
+
+	if (frame->fp_off && get_user(fp, (unsigned long *)(cfa + frame->fp_off)))
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
+	return ret;
+}
+
+int user_unwind_start(struct user_unwind_state *state,
+		      enum user_unwind_type type)
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
+	switch (type) {
+	case USER_UNWIND_TYPE_AUTO:
+	case USER_UNWIND_TYPE_FP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	state->sp = user_stack_pointer(regs);
+	state->ip = instruction_pointer(regs);
+	state->fp = frame_pointer(regs);
+
+	return user_unwind_next(state);
+}
-- 
2.46.0

