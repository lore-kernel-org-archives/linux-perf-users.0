Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850732;
	b=I/Ghiu7XJRH6VnIrr8fOleyOBKPHl6C5AFeiauvxS3gP3pYaYbvGs8lHODF9z0BBKl1r
	 ajl7zMiUcQ49//1RlxaJbA9hMyEKao7Iwux67m7fYGzOTdUKnWiVUY+Yhj2sscq3VtvI9
	 kYHSYPowxyf8DuKCiJh6D0eZw8QOgxiazeCgUmDXGetatN/+FwijO6Y1qLZZu1RQ67iip
	 pNjlZXHu+2JIyBe6aXq67QpfxuDMzQfPHn35vN4PQBoBNlq0kKM6uvpESn43cj0493VuE
	 acSLnCkDtr641OsbX2uDo5b42B5JzWf6lXVfghbjzkpOr1T4/0JqdAzKBW4LJnW6kUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SzqhHzIyUkPcykE/zhmvkeMuT8irPjp2F6ctpeBwX0E=;
	b=3/AFePvaTsqO2mEcGDTKsabelL1WBz8lJmh+QOeQTC/3MvVLnqiIIEclgZlXNd3fXevV
	 PBUCOaSCMC/WqOkI45w3K3+XmEeuqsua3i560gbgQoZDHI0UBzZGbyZZBFLhbmwEIk71Z
	 2jhxn8k05X7U40Knd+HSmTUTieM3EphIFcHB0pYG9RGSrSOILyIdf25mYtzTcvqLx4FuL
	 sVporoj3jo5OvDDkpHwm7oGvDjL9E8+fxkZJKuYdvSEyu7VERbrZfTJO0k65W7xt3jWU9
	 /kzeLAH3lw5RctUZee4JkM4ann/BEctGo86VxGvVqnBBNCcdFrkAlhVBjX0ouOG3tYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkDP4afW;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F6606A334
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 17:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0F6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkDP4afW
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3712b6d9843so3039156eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850731; x=1795455531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzqhHzIyUkPcykE/zhmvkeMuT8irPjp2F6ctpeBwX0E=;
        b=mkDP4afWDnm6Q8euc90fQxPyW3tf5NJCSGfzpquBMBvdl/KSNeOpat8X6UcltgzKdh
         jhy0FFqCSDkZSnpR3geXQaJOh0mihLC4jB7JWkbyk/X04AGcd/tp71Etv7m0wpfysxbv
         tPhFUKaN1OVlvWggzm8AUMvcbZC/TNKqbMSSKXSN9AtsHcttgkKLIe4hIgdxSAlZCWU0
         mRHSWx342KenTfsK4kr+jWaOPUxDCTOfRqxMhQbEx1BU2q7PWTzFAz7BSQjy1uPtloIl
         tdySxAid+j5Tb+GYO1uqA6fomqfVDKuOPpKu3EZUKIJq2SYbm4z0dvDNu8L4fWmCKwBL
         7JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850731; x=1795455531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzqhHzIyUkPcykE/zhmvkeMuT8irPjp2F6ctpeBwX0E=;
        b=sipdDGJI/dObccwZ8I/q/BODLQWiOCdwbz2LN6vMmnXilxoxcDg8WqVy0ZCLpTimji
         EbehgRAEAWGTQXh+XtnPbj0CPnAQD19abL6l3bdLmY8mbR+eeg7Q2U8Hs4nCwNVG5stC
         RIxEHGG77Wtk8j+idFkyLkZzb4OE769ozmUSgrtUa9XF8sQsKEuKY0zroyU3IbnxAwRV
         E2WEWah/FKDX9u0yHecPFtPuLjwV2dVaJBgDM9i9ioaajycJLFkqHwVcaAbkM5PYiwbE
         f4veNNs4HSkl43N9ic1W0aJFg5SMjCIn424lh3PJPMLCOgKa8oMm1eOVUJ8pu9PBpHbz
         twig==
X-Forwarded-Encrypted: i=1; AL+hErFjnrUJsfrYmHypbaAZtf8lMNQp0e8i2knK5fM1E18j3FDQa01u6O7931NpzP3udBiBlOvTVNhIEvHY8owGopjT@vger.kernel.org
X-Gm-Message-State: APuU4Z9FwHSpRNB2AtcZOoKPG89GgnrnsBPcfOZzvaAcNkBqY109rmmt
	Ldj9QnWkOoxNJmiaNV4upl7vSTKFzvGiWV/cm4EmJno5K3EHdht3v8F9
X-Gm-Gg: AYBFou1SlcXXMAV9uDYBpuVya018wSJN2oAtG8koCIyEdTeyCAZU8IeVAY6j5ah9Lbg
	Zdvy/f1CkJO8Nn7+YhzHsmDy5aNpLe9uartx8Cnd2RdMPNAB07s0GDslEOmFiJTapXlVza/Z4xa
	ZiYTXIWEWgy7h1gbgE+km6LW4BFYhVstoPqoNsLBLNE+nkT10pFZuKjl3oB60QTS4tRQJcUYISz
	kZtJBFKZLZjvzZahmpMBn9UpR04s38BWRuOZwBKAQL4xvvoBRZY/PzRm2KyyOR7Vy2nLno0atLj
	Gt1mZSATVbolnTLs+n/Lar+Jfgw1DLRfnH9Z98hNmoj7RNHmPbu4Nc1ytgpw3Vr7xNk+4jIHbng
	FPLxZKrRh3aflOrdsVw0+oxFn0c9HW//N3KQ9VJMtvBeIHX1LuGThk4PQqa/4cICCduyLM/VC+g
	32N9hQ1NgMiOYVFT1FSz5UF7KggljYEA9/J8GX151dYe52Xc5PR2+1tDau+JWlt0tj9CK2zVOzN
	APrV/NimFiHn5hdqBsY9h1advwYAsXVO/HpXdXJDGhmdubzWuw0+w1fBUXyuRI6koyMPzNEPfa2
	411m9BaRlJtE939cXhCO+MQneeg7JA==
X-Received: by 2002:a05:693c:8852:b0:36a:1452:8dad with SMTP id 5a478bee46e88-37966f32039mr11206896eec.20.1794850731028;
        Mon, 16 Nov 2026 09:38:51 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm36635215eec.15.2026.11.16.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:38:50 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v3 2/3] MIPS: perf: Add SB1 userspace callchain unwinding
Date: Mon, 16 Nov 2026 09:38:37 -0800
Message-ID: <20261116173843.911523-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173843.911523-1-f.fainelli@gmail.com>
References: <20261116173843.911523-1-f.fainelli@gmail.com>
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

Restore the userspace callchain capability formerly available through
MIPS OProfile, exposing it through perf for SB1 and SB1A. Commit
5f307491f3a0 ("MIPS: oprofile: Add callgraph support") introduced an
in-kernel userspace prologue scanner, which disappeared with the removal
of MIPS OProfile support in e258958945c6 ("arch: mips: Remove CONFIG_OPROFILE
support"). The MIPS perf userspace callchain hook remained unimplemented.

Follow the former OProfile approach of examining instructions before the
sampled PC to find standard MIPS stack adjustments and saved return
addresses. Bound each scan to 128 instructions, use nofault user reads,
validate frame data and stack progress, and stop at the perf stack limit.
Handle o32, n32 and n64 address widths and the actual sw/sd return-address
slot widths, rather than relying on the kernel's unsigned long size.
Allow the sampled leaf to use the live return-address register, and permit
repeated return PCs when the stack advances so recursion is not truncated.

This complements the existing MIPS DWARF callchain mechanism, enabled by
1ddc96bd42da ("MIPS: kernel: Support extracting off-line stack traces from
user-space with perf") and b5f184fbdb03 ("perf tools: Support MIPS unwinding
and dwarf-regs"). With --call-graph dwarf, the kernel records user registers
and a stack snapshot for the perf tool to unwind using DWARF information.
The new walker instead produces PERF_SAMPLE_CALLCHAIN entries in the
kernel for ordinary perf -g/--call-graph fp sampling, without requiring
DWARF unwind information or a userspace unwinding library. It does not
change or replace the DWARF path, which can handle frames beyond the
standard prologues recognized by this best-effort scanner.

Limit enablement to SB1 and SB1A, whose standard instruction encoding is
handled here and which have neither MIPS16 nor microMIPS. Other MIPS CPU
types retain their existing userspace callchain behavior. Nonstandard
prologues, dynamic stack adjustments and signal trampolines can truncate
chains.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/perf_event.c | 110 ++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 5d7a9c03903b..cb2099416ac6 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -13,15 +13,117 @@
 
 #include <linux/perf_event.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uaccess.h>
 
+#include <asm/cpu-type.h>
+#include <asm/inst.h>
 #include <asm/stacktrace.h>
 
 /* Callchain handling code. */
 
-/*
- * Leave userspace callchain empty for now. When we find a way to trace
- * the user stack callchains, we will add it here.
- */
+struct sb1_user_frame {
+	unsigned long pc;
+	unsigned long sp;
+	unsigned long ra;
+};
+
+static unsigned long sb1_user_address(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_64BIT) && test_thread_flag(TIF_32BIT_ADDR))
+		return (u32)addr;
+	return addr;
+}
+
+/* Best-effort prologue unwinding, as provided by the former MIPS OProfile. */
+static bool sb1_unwind_user(struct sb1_user_frame *frame)
+{
+	unsigned long pc = frame->pc, caller = frame->ra;
+	unsigned int frame_size = 0, ra_size = 0, ra_offset = 0, n;
+	union mips_instruction insn;
+
+	/* SB1 has neither MIPS16 nor microMIPS instructions. */
+	if ((pc & 3) || (frame->sp & 3))
+		return false;
+
+	for (n = 0; n < 128 && pc >= sizeof(insn); n++) {
+		pc -= sizeof(insn);
+		if (copy_from_user_nofault(&insn, (void __user *)pc, sizeof(insn)))
+			break;
+		if (insn.i_format.rs == 29 && insn.i_format.rt == 29 &&
+		    (insn.i_format.opcode == addiu_op ||
+		     insn.i_format.opcode == daddiu_op)) {
+			/* A positive adjustment belongs to an epilogue. */
+			if (insn.i_format.simmediate >= 0)
+				break;
+			frame_size = -insn.i_format.simmediate;
+			break;
+		}
+		if (insn.i_format.rs == 29 && insn.i_format.rt == 31 &&
+		    insn.i_format.simmediate >= 0) {
+			if (insn.i_format.opcode == sw_op)
+				ra_size = sizeof(u32);
+			else if (insn.i_format.opcode == sd_op)
+				ra_size = sizeof(u64);
+			else
+				continue;
+			ra_offset = insn.i_format.simmediate;
+		}
+		/* Do not scan into the preceding function through a return. */
+		if (insn.r_format.opcode == spec_op &&
+		    insn.r_format.func == jr_op)
+			break;
+	}
+
+	if (ra_size) {
+		u64 ra64;
+		u32 ra32;
+		void __user *slot = (void __user *)(frame->sp + ra_offset);
+
+		if (!frame_size || ra_offset + ra_size > frame_size)
+			return false;
+		if (ra_size == sizeof(ra32)) {
+			if (copy_from_user_nofault(&ra32, slot, sizeof(ra32)))
+				return false;
+			caller = ra32;
+		} else {
+			if (copy_from_user_nofault(&ra64, slot, sizeof(ra64)))
+				return false;
+			caller = ra64;
+		}
+	}
+
+	caller = sb1_user_address(caller);
+	if (!caller || (caller == frame->pc && !frame_size) || (caller & 3) ||
+	    !access_ok((void __user *)caller, sizeof(insn)) ||
+	    frame->sp + frame_size < frame->sp)
+		return false;
+	frame->sp += frame_size;
+	frame->pc = caller;
+	/* Only the sampled leaf may use the live return-address register. */
+	frame->ra = 0;
+	return true;
+}
+
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
+{
+	struct sb1_user_frame frame = {
+		.pc = sb1_user_address(regs->cp0_epc),
+		.sp = sb1_user_address(regs->regs[29]),
+		.ra = sb1_user_address(regs->regs[31]),
+	};
+	unsigned long saved_baduaddr;
+
+	if (current_cpu_type() != CPU_SB1 && current_cpu_type() != CPU_SB1A)
+		return;
+	/* Nofault reads must not clobber an interrupted usercopy's fault address. */
+	saved_baduaddr = current->thread.cp0_baduaddr;
+	do {
+		if (perf_callchain_store(entry, frame.pc))
+			break;
+	} while (sb1_unwind_user(&frame));
+	current->thread.cp0_baduaddr = saved_baduaddr;
+}
 
 static void save_raw_perf_callchain(struct perf_callchain_entry_ctx *entry,
 				    unsigned long reg29)
-- 
2.53.0

