Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C61F130B;
	Mon, 28 Oct 2024 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152118; cv=none; b=lxVuOVQkBMipi4Ldi62A9j5bRep7RLcDZ0re+UslHrDTk8LaTHrlND56AWenL2msiZ9pmZzxCMQpqVkauBRFP9My19g58ZgU3761mluKsf5VcZxnvw7x2QSrUYiGkdaLxIA+GPjozxxC58fLXkLYnGUoSAgemQNwwWjRaObD2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152118; c=relaxed/simple;
	bh=VOfrwUxGBFkmAPsGRr9pXslEtwzpKwt151vnBogM1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McNGowocVzYc2A7pOUEMzuj5x7mnHGPzcml0FHJhYw53JK2zT2M2F/PpdfA374yPw1jOQolA9ibCY6xmcAPIV3Yz8DuOokfpYFFYEB01crQoU56WqLaoMNcP7bsMZfVnLVsFYEHAf5e2+knRQqROUJpQe7U0N0LuArK+pa8U6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXrGJhHX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXrGJhHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A146AC4CEE7;
	Mon, 28 Oct 2024 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152118;
	bh=VOfrwUxGBFkmAPsGRr9pXslEtwzpKwt151vnBogM1nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXrGJhHXd/fB3hzcmhRBmG3x8aoTlrm25yRMm8wVXfrZ5wJtNSdDft7oDtf/7+6ip
	 EGYc08uCp/qbnL7NPoY8EoCxtmIX3x2lpRVfPU88LZhoezvkPnCl1nXTPg4zLa0dBm
	 iqnCay6iFgJlVNZzPNNJ/z3aQoFCgGuMwC5+nYxkNUy4fBJSZ77nSI5exTw2v1xvBu
	 PBeEw7mbK1HaaADzuN8o8i7bCuOgMjbgOVldcULgTMIrHppfhBQbOCeNpMiF4RnDjt
	 ND1fS0LEVOhYLahfUn8MMpRk6DnV/Vzg+dgQ/W9dOFiy5iVZvQYF7Vnh4MHf7PuGyB
	 gSmw1VgcMxdhg==
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
Subject: [PATCH v3 08/19] unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_FP
Date: Mon, 28 Oct 2024 14:47:55 -0700
Message-ID: <2354d43022bd336c390e1e77f7cee68126d5f8c8.1730150953.git.jpoimboe@kernel.org>
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
Message-ID: <20241028214755.bborRoiWkn6qhWpu8yY5B5RnFfuazhdzaNGESW2QQyk@z>

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
index 0bdb7a394f59..f91098d6f535 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -289,6 +289,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
new file mode 100644
index 000000000000..19df26a65132
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME							\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.cfa_off	= (s32)sizeof(long) * 2,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */
-- 
2.47.0

