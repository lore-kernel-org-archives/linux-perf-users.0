Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510570;
	b=xdUezPmbPBJub6Sk1eiv+KOsZZje5hD6yPrqPVGd5af9srmdCra0ucw78ETcCa2BRuVD
	 ldtyB3akb0flFiVgxISmjqadIRCCQSkpYqlEe25O6jRLtQ3puufwUhoRlnXv65G1XXQS2
	 FthaQDwO3pkocmecutqORGrwOEMydsxDOyr5cVcYzw6gz4nOBYhoQ0uwt5/NEmihMRRrV
	 cSVdCMR3USGxHuoCiSICUlp5WhDYMZ2rV8LVRfJEWh1XtNaRVQr/5S/vylzXT9EwMDgp1
	 E8wbSsoBxeuJ96bQvRXetUqbdXmv5mh8gApFOroU92pPJBPnJ7Q6Oq51XbAlHAS8OAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qKiDNdcM5kB7oFfApEbRvc3EIzPQh/Mfzhj7PLGh4G8=;
	b=d64FwGchwbIOIAOD9njuV/a6nNH/Jz5Hy9xzjxIBEGLw7wk82zNqXShIhmrUaxL5V0Kx
	 0p/NBvhFPqadeIiispRyRCpTXKX1R3lIZpDgPemIvYucPWk06IEmbCbDPYP2uy93WRKUl
	 JyMgfqHNAvxCZRTKnmQ2P1CkFX6KHx+lWEnHv7SsHq2SOB4cVxzNDD98jkpOu5PlPbNZz
	 WcdqwkO9g+PXoqHawagolswD5LcTJqDZEIZPWQqRfKde4L3rXZSWGsnECuGyQTQY26tyN
	 TtMpu2jEcGHx/O26SxU2tAYyihLGyr2XFvyVNo7Vdb2OZUoTpCj14sncfH+YQ9Adm9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hz7JFhqq;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB960A2631
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFDB960A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hz7JFhqq
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdd9e925075so86100a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 11:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510569; x=1795115369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKiDNdcM5kB7oFfApEbRvc3EIzPQh/Mfzhj7PLGh4G8=;
        b=hz7JFhqq+xxhecYw17z9V5TBTrn4X4OolPiN9AOCXk+KWr4/jJtSGGE6DQ1+uICR5d
         R5P+ifk6+aGQunoN+E+Fqu+TpRMw4PyBLknE9AGtmtgrnOGpeRLUGHyUqd18j25pick3
         v0jlNLUk/zisOx0O+AujKoOSu1ztiaNkPTlZoDPLty40ZAXHxnm9GWOjv44BdtLlIHwx
         ZJquGynG6nnCoE4bjvQGvM6O5edgW2FsZWaq6wP7iiw8Sid+M3jQV5tBsk/pJSCJfVBY
         Khqnb+sIoIGIV1gDBZV//UcLBou/07dvUeXqK1HdZkw68N1gVZRO11p706UyK5wsKaHV
         ukPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510569; x=1795115369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qKiDNdcM5kB7oFfApEbRvc3EIzPQh/Mfzhj7PLGh4G8=;
        b=dTlqdB3z7CYosFpg0jaRGg/Sy0O3+q7WHVdtBj7fhuJIbDmo5y2nyfxwWN8/fXDr7D
         Aayoc78VXnUE1lglFlQ1wQ21gwuNxpqpXuvkKS9VrtJtsdYkj1kJnhhNaxcIOpQLFB2r
         7tmhTo+MyfJcGZao+zHBWcqUgxGgMHNML8fDeO4euK5+jtUZha0bVjueCyZPRv/glrS+
         CKTXDlBb0oUpNUdxXn+VNcerOf63rp0x+KXyUe9lpekAr53IQJdnZyyiRE71uMcrul84
         sO54mj/2VPGyDLoHgCsOJ4KnIXXqyDsiKBweZKeOJ6x1Fkx8N4F92YkJfHxn4tZu0LJ+
         Sbew==
X-Forwarded-Encrypted: i=1; AL+hErGzb3l4P4pTX+5BUYJKGUGn4PFyx9p30VzoXuE7rzxGcqHiOGSvw5FIKL67eauq5940lcJOFmTUyaeezYXwFCtq@vger.kernel.org
X-Gm-Message-State: APuU4Z+zzcXNe2yj7zKNi/fijA+Ie5idC5VGtzdjWAgAUnd/bep24o6R
	PSKqZkufvzJ9zlIvynWJINlMlQxyhXOVI+bn/FUbR5/mW3y8Jqiaq8W5
X-Gm-Gg: AYBFou1cks1MgYnbdL+4fPpRrI4cZH/A2F1x+A9ukDamZcOWtxooxYiAZiPmhM6V9hC
	KXVclMOur5JtyjpRiy/u5HEAW7dj6aQShP95WqkFu4tzig5trVi5e6zy3gXuoNyFbEp0crrLdaT
	bzigs9eLJe3u+VM3xlUgyBjweEXRJLRUw+YdHoj8u899Pm0QCbTtMpRZRRjBqBan3il9X2tJ8Iz
	8H7lNpTsTn/EAwPa0SMF9smZdCEGH7TX5cYtYB4prn9Fsxd463LU93Fy9/g/sl9TqS0fYlYYSVH
	ojSZnm6GndgtHfjNZvWrSlotoMaresPHisZx/m7cE8pKGBVIJfXe07NU2+D3pXU9hDm1FYA1IPI
	PlkhEHJyqcNwXbx3WTAmMRVc26yk+MPGKcW2SISjwLTvotelLjWCn1KEuFUj3Oz0gPQIlDU5x8l
	3j0GuMpk3THuXm5ET0ZMBIeppVGywbCZt7bDIC4Pd5Z2YBLOf7AXLkBvDA37UT5fi7+h0j7siqP
	KaYJiUcpYQ8jeax0yNHxqt+xYH6skch77VEJ8X6zXG3iYSvkNa7EOitYqGa2AFp8q6DPobzWEWq
	J0nIwSF1JslbkAgEVwQLcckLTbP9DQ==
X-Received: by 2002:a05:693c:41c7:20b0:371:ede8:3e9b with SMTP id 5a478bee46e88-379680cf32amr73747eec.36.1794510568954;
        Thu, 12 Nov 2026 11:09:28 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm395674eec.26.2026.11.12.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:09:28 -0800 (PST)
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
Subject: [PATCH 2/3] MIPS: perf: Add SB1 userspace callchain unwinding
Date: Thu, 12 Nov 2026 11:09:15 -0800
Message-ID: <20261112190916.3725141-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112190916.3725141-1-f.fainelli@gmail.com>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
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
 arch/mips/kernel/perf_event.c | 106 ++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 5d7a9c03903b..811ac8f03cab 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -13,15 +13,113 @@
 
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
+
+	if (current_cpu_type() != CPU_SB1 && current_cpu_type() != CPU_SB1A)
+		return;
+	do {
+		if (perf_callchain_store(entry, frame.pc))
+			break;
+	} while (sb1_unwind_user(&frame));
+}
 
 static void save_raw_perf_callchain(struct perf_callchain_entry_ctx *entry,
 				    unsigned long reg29)
-- 
2.53.0

