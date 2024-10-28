Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E371EBA1F;
	Mon, 28 Oct 2024 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152094; cv=none; b=WmEXaVGLo7K8GpZlSKZ46II4eFpoZwBsZ6t86JAMhv7yikxo1ag+4THsAsO9OzG0pZuMeLXiXh/jvlGuvt02XaUBRDqKrsf5h9pxpmEZVUPzHC+Q+gH9aQWr7O9q/qP5pYZKqrMoP0/UZM1ApP91Hm1lTbRZ/KsZIDopHV7NXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152094; c=relaxed/simple;
	bh=gpI5P01K7cWgBTfY/PtSLZYGYq/sI/onO0R36v3clI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGpWf7/GtTQDDdVzHDG/RQFh+Zyl/7v6Ug0J4GWeXYDn1VFfZjk1IuN1cdbw8+LJCeVoTUaSyC5Igmtj/yhRWjf5p7wKULWZu+sLtdDvywKN4mQgSZNrbZuQkNoJl4H/xeeQ3GrQ2YoisO76HWOVZMFvPz/13u6hOEyGJwCgl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjGmLxKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjGmLxKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70CFC4CEC3;
	Mon, 28 Oct 2024 21:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152093;
	bh=gpI5P01K7cWgBTfY/PtSLZYGYq/sI/onO0R36v3clI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjGmLxKl8HadoeeAKp/1ru5lfMKMqt/lP4MrO9O4AIm9fzh4vm1OmpnttSuy/lkq9
	 3ffUOG089sdFiXPxtO+5QbT4nhj/h0sellyhl+Fi38RCgkhRHLG/Alx6PfRve3TP/2
	 smnfeENGMSficShCTjkrZjFj5E5I6oxyZm0FWFfCh5R+dcbWncGBPJrclNZ5p3zzZT
	 Zt/Tr0nsbxvfpooYzymezL5R6gPbo0m4zu6wlatUigC1qVcDrENpyldoC2StwozmZ+
	 mVu5JYok+3fyaLEarSHewngqF3m4PCHjIeLi9ScW+PJRSFCxGTpFxLbEH/VteojmYP
	 vc5uv1EZjPzAQ==
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
Subject: [PATCH v3 04/19] x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
Date: Mon, 28 Oct 2024 14:47:31 -0700
Message-ID: <3263d60b868f244d7624ad5223644a6bd8c7bc81.1730150953.git.jpoimboe@kernel.org>
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

Use SYM_FUNC_{START,END} instead of all the boilerplate.  No functional
change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/vdso/vdso32/system_call.S | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index d33c6513fd2c..bdc576548240 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -9,11 +9,7 @@
 #include <asm/alternative.h>
 
 	.text
-	.globl __kernel_vsyscall
-	.type __kernel_vsyscall,@function
-	ALIGN
-__kernel_vsyscall:
-	CFI_STARTPROC
+SYM_FUNC_START(__kernel_vsyscall)
 	/*
 	 * Reshuffle regs so that all of any of the entry instructions
 	 * will preserve enough state.
@@ -79,7 +75,5 @@ SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
 	CFI_RESTORE		ecx
 	CFI_ADJUST_CFA_OFFSET	-4
 	RET
-	CFI_ENDPROC
-
-	.size __kernel_vsyscall,.-__kernel_vsyscall
+SYM_FUNC_END(__kernel_vsyscall)
 	.previous
-- 
2.47.0

