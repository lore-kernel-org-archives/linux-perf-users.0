Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615531;
	b=CAWauCbDlHnW0jiHy/FEJM1WAEFSoeA/nTJZhj25uiVMPX1jDweUsZx8BFDgTy3+Z3Bq
	 +XfizEX9UjmE+4gsB91bugpXWwBAGL58G2XQSTa9i8Koz59dR5irbmAnhPIIzpGcs9g24
	 GCWSwBPqqx0HdQqAWK2x/CrspkYwmxoNS55gwuvauz1ZoUaYjcZKCtSC4iEinQK7xde8R
	 /RBzXLJ22XN83w5VdmI2RuZJkizXUF4sfkgHPgskR+W5LsJa4Yn/nH+rQFFCvVxlj2Fy5
	 OyMLe3vNwZBaMj437r0BJ0Ucuytnqkml7EzS0/RYLeqvhxorfL9vWlrROSlYYHfXCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TL91F9v5y+iVASSEgSyoU/mO9eBJEE/mzexNJMkj6kw=;
	b=2Z6E9i5l6d9pycPXYSpJBSKLZhHPlrNClHe3jc+XodJSRzXCtjjR4/5tpl92Jru4u/6y
	 I9Se8kp6S4KapbKDk50+FuYYrf7GT/nfFCojRwrlULoST9AVoswiwgvCjtjK5XhpYsdFP
	 RMJmTIujEbzzk/nfkniDVB12i5RWevZ+34p/NBJW4ydvYRU9PLfTqz8MS7mhOoqPcsBIS
	 QNwZijDzGFmnsW+6TUVvwgmkDVDWIU88Bd6kBf5e6NUwtvitVqpo+BVGjnXS+zlSa9Wdd
	 swhDIkis1eSGNm62ua1lW6x+PFQzHr9C16UyAgB1JA4I+I28jiprhSPM3gHhyzSBXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeFcb+CC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8B606A323;
	Sat, 14 Nov 2026 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeFcb+CC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52901F000C5;
	Sat, 14 Nov 2026 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615530;
	bh=TL91F9v5y+iVASSEgSyoU/mO9eBJEE/mzexNJMkj6kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WeFcb+CC/wJSw0oC3ElbhSPB6pyEvS0JvHHC0leghOZ6kDbQdkDWci/m30NbEX6qx
	 qEEi8ql/TtMK0sFL3QBfLWWtMWNgQTZ3SzRpWNNLRvz1Lm+qsyBV6DuJ8sZU3+iJBr
	 0/0CGRfTYqTctISkH5WD20tnV+38papDstKGpqDBHPxPXVevdJGvp4xLSWn0xlCTUF
	 ITCKKAuAierlgiIUDLMrtbPqWrZ2Ntvn7Mv6zJhuoRqDuVzRpjnPULzbjlIv/GKbvg
	 FruZZwJL7xQ4FVyb1YPEPxcYfBbOf0SMNZmDeSJqOlIaLybT4dGyzt5G/Tjohdnqz1
	 j8c6wuZvb1kmQ==
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
Subject: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice in caller-regs callchains
Date: Fri, 13 Nov 2026 16:18:44 -0800
Message-ID: <20261114001846.873499-2-andrii@kernel.org>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261114001846.873499-1-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org>
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
the function it is used in (CALLER_ADDR0), but points regs->regs[29]
at that function's own frame record, whose saved LR is that same
return address. perf_callchain_kernel() reports regs->pc and then
unwinds from the frame record at x29, so the caller shows up twice at
the top of every kernel callchain built from perf_fetch_caller_regs():
tracepoint events, software events emitted by __perf_sw_event_sched()
(context-switches, cgroup-switches, cpu-migrations), and
bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
tp_btf and fentry/fexit programs. E.g., for a tracepoint program
attached to sched_process_fork:

  __traceiter_sched_process_fork+0x44
  __traceiter_sched_process_fork+0x44
  kernel_clone+0x250
  ...

Use __builtin_frame_address(1), the caller's frame record, the same
way kunwind_init_from_caller() does, so that pc and x29 describe the
same frame.

x86 had the same duplicate entry, fixed by commit 6d08340d1e35
("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").

Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kernel tracepoint events")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/arm64/include/asm/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index ee45b4e77347..13efb46f0fe8 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -15,7 +15,7 @@
 
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->pc = (__ip);    \
-	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
+	(regs)->regs[29] = (unsigned long) __builtin_frame_address(1); \
 	(regs)->sp = current_stack_pointer; \
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
-- 
2.53.1-Meta

