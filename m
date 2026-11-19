Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046477;
	b=BN6Ium5uaszb2sXchn212NiyxN87eP1KChzBEl1s6bcXO+l3zB/9bzABRNN/ji+Ts+qk
	 2ATUEYofnHXI11Qaq2i3GeeptfbJgkEXgXMV/lf88rZ11ghFwYeb3GIfciFQidatRmc3z
	 uwoVhzIdDjFZLzJ3MOiTQzU9kR0gO2UbbfjSOSOzlBU0YtJbSRiuve2d9fqSVmapOpVZY
	 yGi2HiF89KXhAcaqF2Bh0ubdwYwX0uWMT6rkX2Cu8n1brAeDFnDCD6l+5MX18H6uJVLl6
	 sa2H4H1bFN0v/PKcsUbvA2cWKKueoqA2xaXiReZicmJiLgLqgjP4cY2U/BTzbOsnXWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046477;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=trtLB8r/fahuF36Shh8QQA5qcdNHOIUos7dZSGhQIc0=;
	b=O65dLUVCeGTL/yzaDUHLqam2o3cTV5jUppw8/gUaOqO6ZA2oCFTZM9qh8VtBrI4xmveS
	 SW3Iiz0GtcQMfSm7/tZlIO0sk9XiCMCBhrOn3aMuZ51iwVBTmI0HGkqUwTXqtt3ezROkN
	 2nBdGpCRwMXNALRL7b7iBb6ezdZIXH9JW6Xx3hkYPT9Q2w3hhF74/zY7EvVWPuPPb2eqs
	 L53e2F1tXA/HfisEuO+cnnVWNPqtAV81G15wvvDVEsiv04SbqPnyVi+ED/07FDxmH/YQ9
	 Pjpw62HNie4fUMKgMu86GEfsYupGQf/G3rnPcd25mu0m66aa2+NO7DwytsinFcVa3QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msKGQpQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD612606A331;
	Thu, 19 Nov 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msKGQpQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564661F000C7;
	Thu, 19 Nov 2026 00:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046477;
	bh=trtLB8r/fahuF36Shh8QQA5qcdNHOIUos7dZSGhQIc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=msKGQpQA4zGhpTkU4DYSGrlvG9EZ0L/9/Q/c06KlytxgCaP5otPzjjk65baBYc5dp
	 KLeKiSrQobgEB6ZA+Py9fK+eH+WiseD/Pg/2ZJzcwhTnYf/oxt9RrEfEfL2PhFSzB4
	 HddT0xi4S930mhMXBPUjLBFrTFBGBwVG8uSePGyarJmx/ZMfqKelwS1Jqyz5Qv8PBp
	 tAmeASJm3sz+W3TRMHSn+baltActGQp/uBZ2+NR9Lfbqc+5pvbSVoffnhui31xcsVV
	 PtpVXyKwvhWiSN0bFks+EALUTCNn+H4CNfMr9iI1jo9tzEGsGMIcZWe0SnjIULO2L8
	 wQ4c1kimiiqyQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	peterz@infradead.org,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 1/3] arm64: perf: Don't report the caller twice in caller-regs callchains
Date: Wed, 18 Nov 2026 16:01:10 -0800
Message-ID: <20261119000112.2377949-2-andrii@kernel.org>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119000112.2377949-1-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_arch_fetch_caller_regs() sets regs->pc to the return address of
the function it is used in (CALLER_ADDR0) and points regs->regs[29] at
that function's own frame record, whose saved LR is that same return
address. perf_callchain_kernel() reports regs->pc and then unwinds from
the frame record at x29, so the caller shows up twice at the top of
every kernel callchain built from perf_fetch_caller_regs(): tracepoint
events, software events emitted by __perf_sw_event_sched()
(context-switches, cgroup-switches, cpu-migrations), and
bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
tp_btf and fentry/fexit programs. E.g., for a tracepoint program
attached to sched_process_fork:

  __traceiter_sched_process_fork+0x44
  __traceiter_sched_process_fork+0x44
  kernel_clone+0x250
  ...

x86 tells such regs apart in perf_callchain_kernel() with
perf_hw_regs(): perf_arch_fetch_caller_regs() sets regs->flags to 0,
while hardware-saved RFLAGS always has X86_EFLAGS_FIXED set, and
regs->ip is not reported for regs that fail the check.

Do the same on arm64. Set pstate to PSR_MODE_EL1t, which exceptions
taken from the kernel never have (the kernel runs in EL1h, or EL2h
with VHE), and skip the leaf regs->pc in perf_callchain_kernel() for
regs with that mode. The unwind still starts from regs, with the frame
record at x29 walked by the unwinder.

regs->pstate of software events emitted by __perf_sw_event_sched(),
which BPF perf_event programs see in bpf_perf_event_data::regs, changes
from PSR_MODE_EL1h to PSR_MODE_EL1t.

x86 had the same duplicate entry, fixed by commit 6d08340d1e35
("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").

Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kernel tracepoint events")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/arm64/include/asm/perf_event.h |  2 +-
 arch/arm64/kernel/perf_callchain.c  | 33 ++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index ee45b4e77347..b3e7c24a5aab 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -17,7 +17,7 @@
 	(regs)->pc = (__ip);    \
 	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
 	(regs)->sp = current_stack_pointer; \
-	(regs)->pstate = PSR_MODE_EL1h;	\
+	(regs)->pstate = PSR_MODE_EL1t;	\
 }
 
 #endif
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 9b7f26b128b5..3e956c4b0798 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -28,6 +28,31 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	arch_stack_walk_user(callchain_trace, entry, regs);
 }
 
+/*
+ * Determine whether the regs were taken from an exception handler rather than
+ * from perf_arch_fetch_caller_regs().
+ */
+static bool perf_hw_regs(struct pt_regs *regs)
+{
+	return (regs->pstate & PSR_MODE_MASK) != PSR_MODE_EL1t;
+}
+
+struct caller_regs_callchain {
+	struct perf_callchain_entry_ctx *entry;
+	bool skip_leaf;
+};
+
+static bool caller_regs_callchain_trace(void *data, unsigned long pc)
+{
+	struct caller_regs_callchain *cc = data;
+
+	if (cc->skip_leaf) {
+		cc->skip_leaf = false;
+		return true;
+	}
+	return callchain_trace(cc->entry, pc);
+}
+
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
@@ -36,5 +61,11 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 		return;
 	}
 
-	arch_stack_walk(callchain_trace, entry, current, regs);
+	if (perf_hw_regs(regs)) {
+		arch_stack_walk(callchain_trace, entry, current, regs);
+	} else {
+		struct caller_regs_callchain cc = { .entry = entry, .skip_leaf = true };
+
+		arch_stack_walk(caller_regs_callchain_trace, &cc, current, regs);
+	}
 }
-- 
2.53.1-Meta

