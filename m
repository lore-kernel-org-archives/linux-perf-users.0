Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E41B6CE0;
	Wed, 22 Jan 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513126; cv=none; b=BKzJ1eHiWMNJse6uwH35hpHlXd+3paGnFNZ1nHUS+nB3tqaMsymsjayWiqVkB1QqbAPMZ1yCPTQIbzTy+UU5X+HXKAaIGfGL+Ts5wSSU1GoWs0nMZEUxP16YR0MVYu/FO1OsH3DiSL9WdKlq9iHo8JrUqxcbpfUzzxmwsIWu2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513126; c=relaxed/simple;
	bh=rLJ7KZsRwojmk/ejrgM3MQsN9tDy+0R5j1wM8gUNGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rap1zCUqRUwPOzdNAjpiTsojXbu1TF4FF+E/cAL2Sc6knv1pXuTb86e+6zEDf4T2l8y7YeiwIBu4SxJ6wDgb8u/SQ3TJT5v17cVy48aR7hwSEjfwSmfNhj4QsD0yO+3EZWt2W1Tr9ZP4K40iTN/moJAWNfwF5uvqYFmqKRojBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFVuknDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFVuknDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DFCC4CEE9;
	Wed, 22 Jan 2025 02:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513125;
	bh=rLJ7KZsRwojmk/ejrgM3MQsN9tDy+0R5j1wM8gUNGQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFVuknDXNZ+8il6w7f6ksU+OCs2tR4iE5Tvn8UaSWPOwyaWBOAfxp9Q4nKTPovAYD
	 YN/azRavYZ6DC95cZ0VDRx7gl4K4Z05A+qsPurWBIN83t5u8RivmGMIAMZCOk1rsHe
	 ZLeZEeGMQUvMQm8Veqki974p0ssevzOBBOThEyqLQiXO1c7IiEZ3z2ZoOYj7f1n9l5
	 1P7IBkA2WkjXA4sFaVZNmhdz5eXqc/XS7Nl5u5DoD9e3rwXvtphhnHkv2WUmYfgsnf
	 3Dub6p0YFIXEzNzb1x30A6y2ISJDxR0bV2quydbpVCaxfFIqVy/eplYEjauMf9Azcb
	 ul4lZABjNzb3g==
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
Subject: [PATCH v4 13/39] unwind_user/x86: Enable frame pointer unwinding on x86
Date: Tue, 21 Jan 2025 18:31:05 -0800
Message-ID: <bda3f987f9dcd8128e8cb4692e5be974d2767aa7.1737511963.git.jpoimboe@kernel.org>
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

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
unwind_user interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef6cfea9df73..f938b957a927 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -291,6 +291,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
new file mode 100644
index 000000000000..8597857bf896
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME							\
+	.cfa_off	= (s32)sizeof(long) *  2,				\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */
-- 
2.48.1

