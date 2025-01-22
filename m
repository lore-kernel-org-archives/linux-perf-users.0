Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478101C2304;
	Wed, 22 Jan 2025 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513127; cv=none; b=H3Tn/WxT0561kKjf/kI3wCLpEo/tI6FgPmNglBqOVsWVhD1V2fn0ssnP7UVjOqkVp44C5RvTe/NTKmvXBaYsWqUjpfjsWauj0Y1qXg7tEd/bZazpXVjxwQ0v5hCzl1qYQq2xT3KFQsVeWb2zbNTl8lxwKbdDXpmyRQr7OwSLqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513127; c=relaxed/simple;
	bh=GXuPggdOdnrO7sypEn586aKnLMgz6Grse8Wk7Tzz2xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ2umTpam248s/7I/ERzhwuQDPl6AnNIdSRjjMDdRMLGAH4RSQApdbiZLGej/FBh4i1XQbvGXeUEl82zCOPPtayM/JgWpsXHTHrGys9cScqXmcmS1+/n3Jx2892eD0NZZpwnTfCuk5wSTXy70VM7+TceBjl4UaNsDJTxinQRORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd+hZewj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd+hZewj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD98DC4CEE0;
	Wed, 22 Jan 2025 02:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513126;
	bh=GXuPggdOdnrO7sypEn586aKnLMgz6Grse8Wk7Tzz2xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dd+hZewjudMKRsvbtsDX3Q6bDYlpOmRBdrM8soW2pRqP151QF/RJmRnvhkZnHjMGv
	 UR13luqOtqrGAfvEcxZaBmGz23L8ZskIWY13W+XrdgOBAR3G6EEs92Qx90Yw2lcW7y
	 WaLlGl+JTvG4GHY5vVirFq4M2z4hNxOPvB+fiaFxTqPDjcJvRNvNch4GWCYkZ7rRrC
	 M8kz7zq+GUpS0spYKqvVWI4IBFXpXoM5hMP+yfW1RJin5EDqzQgz+VjQxftcuRGWt2
	 nAMMbvkTHPYFG2Owh+/Q4Wl/uig1RNBWCNDHNQGdWYlXjQj3RP++7Hszi4Xm2CDZen
	 QvmLsHM7jdM2w==
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
Subject: [PATCH v4 14/39] perf/x86: Rename get_segment_base() and make it global
Date: Tue, 21 Jan 2025 18:31:06 -0800
Message-ID: <e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>
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

get_segment_base() will be used by the unwind_user code, so make it
global and rename it so it doesn't conflict with a KVM function of the
same name.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/events/core.c            | 10 +++++-----
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c75c482d4c52..23ac6343cf86 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2790,7 +2790,7 @@ valid_user_frame(const void __user *fp, unsigned long size)
 	return __access_ok(fp, size);
 }
 
-static unsigned long get_segment_base(unsigned int segment)
+unsigned long segment_base_address(unsigned int segment)
 {
 	struct desc_struct *desc;
 	unsigned int idx = segment >> 3;
@@ -2874,8 +2874,8 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	if (user_64bit_mode(regs))
 		return 0;
 
-	cs_base = get_segment_base(regs->cs);
-	ss_base = get_segment_base(regs->ss);
+	cs_base = segment_base_address(regs->cs);
+	ss_base = segment_base_address(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
@@ -2994,11 +2994,11 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 		return 0x10 * regs->cs;
 
 	if (user_mode(regs) && regs->cs != __USER_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #else
 	if (user_mode(regs) && !user_64bit_mode(regs) &&
 	    regs->cs != __USER32_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #endif
 	return 0;
 }
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index d95f902acc52..75956c68356f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -639,4 +639,6 @@ static __always_inline void perf_lopwr_cb(bool lopwr_in)
 
 #define arch_perf_out_copy_user copy_from_user_nmi
 
+unsigned long segment_base_address(unsigned int segment);
+
 #endif /* _ASM_X86_PERF_EVENT_H */
-- 
2.48.1

