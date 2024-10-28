Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D62200C83;
	Mon, 28 Oct 2024 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152098; cv=none; b=sXRmG4bFZB2Z5HvUOdneDhlnkwdeYdBkGw2uPLGEARPs6DPlXZIa79z/YyqEiPzNSoK55Zv0qCJ8b+xfJyOOIY/CqX3uSQ7SKkQQb6yKOYheBCMEIwVqE5XJf1uSDVJFwcUjqlhD5YDQGygKGGr0H7LGXxPCGlo2EQ0qQIbEkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152098; c=relaxed/simple;
	bh=VOfrwUxGBFkmAPsGRr9pXslEtwzpKwt151vnBogM1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlN7WrSciDx4JtEFcZjlyIUvMqfbp3XX78Fd2hP7zv114TpLUvnwfuYipjzsl6jLN5geWZBOOKMJ930aLewBK+PgFJZ1E6U1h18JzJ1071kC10N2nfBpgMu6GBy1tiQqRc6P6RTMTau/gCIuJ5cmKq/ybAd/tToaZCCtzv/XS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQhget1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQhget1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53D2C4AF10;
	Mon, 28 Oct 2024 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152097;
	bh=VOfrwUxGBFkmAPsGRr9pXslEtwzpKwt151vnBogM1nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQhget1D2EOOQSBZjcBsI/p5Sttn5AO9zVzTB1BPIiiNLqB2cIWHcVNe+VmdnBRrO
	 SEWcZI+6BNVp4uIOpEk3+gJRKDZJrFH8XADV3/ZzqbxL4E6cGf8xPlPYML/Ugbpg3q
	 xD+v9acET0SnuHBj8pOs+1hsEJ3JdmeIiJWnFOP5jPhcVbWltx4EJgS7c7JklPnJl2
	 GxPb1lP72AryN8m0DjyI6urGDMWCai/nslEGlerJpQ0YTp9jMVcFxkT98cvlXr+rRs
	 bbJZ15iSivf41NsiYuAhCbZ5M26PUAlcEzGl5uTn7lefB9tr29G4uz7Evm7Le/biP8
	 h65yv0zq4PObg==
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
Date: Mon, 28 Oct 2024 14:47:35 -0700
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

