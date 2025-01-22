Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D318C936;
	Wed, 22 Jan 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513120; cv=none; b=pJ29Pe1pdsBQ/NL5PWyDWU33OIy4scAtVF6fAzlZ6aGIBA7KuOZ/bUjl3U2ut3wmjy5tCLzvfATQlFC9HQ0Rll05ZBwhMY1p7+BKT2yUDmInbingIAGAj3wXcgMAsN6eSpscG7+4ZeZHMu17qnEuFD6r4dHtbSgv6at6BK7NGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513120; c=relaxed/simple;
	bh=OfVdBysbrIhFvkBQECz1nIAHL1MaijSMXmygC3lhj8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIKy/3k/LpNL0TkT9SEaBDR5KJ3IRaP3gfEDq+f7wb8+OCj/GouQLmNE1auHqGo5AQdBJfXl+xebdJIDsXUb84740OCogIF8rH/27+8ezp0Dw43RvnSUn9fBHpvKMkPBOUqQSAeBCbcAZ6skulRZSXBJTzUQhKbFpsxB+rW5CrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLq3709R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLq3709R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CCDC4CEE2;
	Wed, 22 Jan 2025 02:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513119;
	bh=OfVdBysbrIhFvkBQECz1nIAHL1MaijSMXmygC3lhj8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLq3709RcEAFENn+N/qu0k2YlUUNpNpAEUhIjTfg6+7ey8x9Phjb3QPupCvr/yLzY
	 FHgyvNt6KlvKTt3co4hG7F/P96roepnqetfbD5+FPoMm8R1L7JkgO21s21ip8ZyZ1p
	 FaA+1XAQrHVNyTGs4qdOMbiX2vnMCP3wEtHsTkkd1FRj52Iyo6wo+ENLOXMzzE7v3i
	 CWJCL7G/keP+AfBisOgkxH2lxtNAWzmS1VWaIpx9goObaHO68o/r+p26EX0cRrKtle
	 NOfgGC2PfEtrOUMx9wwjg80lQ6PSuyXQZweu2FThxmRLduP4DAzlQGFdgkQhkmjNOo
	 N30wLdUGKDhrg==
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
Subject: [PATCH v4 07/39] x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
Date: Tue, 21 Jan 2025 18:30:59 -0800
Message-ID: <524fd06bc23b29719b22f8a23f1db802f871bfaa.1737511963.git.jpoimboe@kernel.org>
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
2.48.1

