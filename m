Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587417;
	b=WQgo19vzPIYC99JXIM8Hzo/kRMYHa387EmqjEf1ewLyK2gi7VpwHx4tX2PKIf57W/ANW
	 geIDrNmV4X1Q2PC+tT43JAE92pvDhR+FDGIR88w3VTZNSeqiAB96LmcGwj549HEn1qEAl
	 zQFAw8OQLRqEwsmbw5ab2LeuvS5FhFM9/V8BBiRx0Ex0+/ha50hKt83NunH5fSPuqdNHp
	 CDavOdaoAdK+4W6pnNBBOVwmRjob3CM4t19r5YXvX4ezLakjwWhZkaVpg9t05WXSiNvwY
	 gH8vZRTbqGd3B4KK6qJUqSl8Cg5w5HQlfazFlRmjrf/AtkqgLsYiWgejRf4kfkNEUug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7idd1vMoQrkJGtb4Pai7PHauPn4l7yH4Zzs++IrNt10=;
	b=gnZqQJ+QDReos5xbych1iBLtKM6yU97EliECi6ZR9MGiem3qYb9z4dHROpY7Wq2QaieW
	 y4NnbLVc2y7ysm4KS1Vjlj+bLXwhgLZ1Okes02rNDXSP36jWKUOXCJ3p4Q9dJAAF7a3Ts
	 lekY+ZWGtJcgJ7vHYl+V+GdTnmxmmCzdWNVdLh6IVJFg+9CpBg2Ssef7OGqYS6FCLCYhi
	 42duhwEppTpM1lUjmhr8OOaEb76hXI2XE3p4ePhI8unZqczhUlojrqQpLbpMo2awVyn8n
	 gW1UhplTKI/xjqolNANko+l3+nLOcu8RW/r2g0f9E0Wq4Rv6XF5AdEhU0iAYu49mTsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V2lsAUu3;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D1606BCA2
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670D1606BCA2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V2lsAUu3
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb45b4ed6bso226624a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587416; x=1796192216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7idd1vMoQrkJGtb4Pai7PHauPn4l7yH4Zzs++IrNt10=;
        b=V2lsAUu3WlGFUGT83AVN4MD991vr6f5cwdVAhpoxVj2nW+U7KmmYcy2pP1CAcruhBl
         wbVFOWsiIP3FEt5+C4WBk2s9xmTRsFCng8+KoB6Ikj6XmXKr6Bwo5pkptaIyzCGmE3NS
         T3+R6GNQwXMOmtlnDNU0BJ9q8bzoiQ/qbtpachLVDelV1tD+gp/bbm61hlyLtlih27+9
         bwR5E+H5ZDMXqWSah0OHINcnHAzp0mHh/fxFI4nEXhE8jW1TzJQtrXUx6K/0SsTG81S5
         uK8WjhPpf2WsoRWZRqU8SzPi07UXTHP3hSfQxup4jSTzHxiXVW1TS6HL/K8VtlaS0NtJ
         GnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587416; x=1796192216;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7idd1vMoQrkJGtb4Pai7PHauPn4l7yH4Zzs++IrNt10=;
        b=Q2Wy5/E5De0jQ7RnGUSG99O26x0Vl0O8k22B5Tm7Q5fKhH0l0JX68nEqHItG/8IQbA
         EKI5bgeZZ6nj9ovJuThD7AZJjDkSYlaRfJUadOR7+R4TLs25jRL8dMCswsBLp1dWL6ls
         bFAz6yx9qiWLSnVH+7C3uDABmmaN7m+OCjV2mm8hKKjTnRbPeKDidzYGHL8mXtWcqkmS
         SPa7CWSjikkiUhIc7P7vDvV+lei7peJl5U2bPzNM+eLJYpGrbBvUHlenXciE+qzLZwqi
         0sosyCrk+7O8xAkIivjNkxCHWPuNP8YzRQgQzCQVTyn5tqKBjFLVi795BkN4gd1QHo9m
         qlUg==
X-Forwarded-Encrypted: i=1; AL+hErH0NG/Zm734ZvIWUjdiXgLzLQar7rMycWlAVbYpCOqtV9Aw5vPdY17Sc5fZcEf9tbQVb6lhFLoyf/xNMlfY9ZEf@vger.kernel.org
X-Gm-Message-State: APuU4Z9RvPwsWQ5PHpcsCuVELPTPSGdhBgBE2MmJEb8zy7FjQ5907WD2
	GOz8Rr3FnfMqCJzsPOerjBgKGd4AOCO4IGktSZ69szDbf8Jf3nLjWrRiZ6jwmln1xnRuWjtnFQH
	ccj4WzbM8jQ==
X-Received: from plbjw23.prod.google.com ([2002:a17:903:2797:b0:2f0:6eae:f018])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4f:b0:2ef:f0cc:17ce
 with SMTP id d9443c01a7336-2f03f1ceec3mr187359255ad.11.1795587415506; Tue, 24
 Nov 2026 22:16:55 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:22 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-30-irogers@google.com>
Subject: [RFC PATCH v2 29/30] tools/unwind: Add x86-64 ORC cross-check oracle
 to verify_cfi
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add verifyOracle3Orc() in tools/unwind/verify_orc.cpp using
<asm/orc_types.h> and enable -DHAVE_VERIFY_ORC in tools/unwind/Makefile,
cross-checking objtool's ORC_TYPE_CALL entries in .orc_unwind /
.orc_unwind_ip directly against Minimal DWARF CFI across every
instruction covered by an FDE (matching identically on 99.9823% of
4,468,154 x86-64 vmlinux instructions, with 0 BP diffs).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/unwind/Makefile       |   5 +-
 tools/unwind/verify_orc.cpp | 205 ++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 tools/unwind/verify_orc.cpp

diff --git a/tools/unwind/Makefile b/tools/unwind/Makefile
index c0a8d477dc13..d368b9ed90ee 100644
--- a/tools/unwind/Makefile
+++ b/tools/unwind/Makefile
@@ -79,7 +79,7 @@ TOOLS_INCLUDES := -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
 SHIM_CFLAGS := -O2 -g -Wall -Wextra -Wno-unused-parameter -Wno-maybe-uninitialized \
 	$(TOOLS_INCLUDES)
 
-VERIFY_CXXFLAGS := -O2 -g -Wall -Wextra -std=gnu++20 $(LLVM_CXXFLAGS) -DHAVE_VERIFY_INSN \
+VERIFY_CXXFLAGS := -O2 -g -Wall -Wextra -std=gnu++20 $(LLVM_CXXFLAGS) -DHAVE_VERIFY_INSN -DHAVE_VERIFY_ORC \
 	-I$(CURDIR) $(TOOLS_INCLUDES) $(CXXFLAGS)
 VERIFY_LDFLAGS  := $(LLVM_LDFLAGS) $(LDFLAGS)
 
@@ -89,7 +89,8 @@ KERNEL_CFI_DEPS := $(srctree)/kernel/unwind/dwarf_cfi.c \
 VERIFY_OBJS := $(OUTPUT)dwarf_cfi_host.o \
 		 $(OUTPUT)verify_cfi.o \
 		 $(OUTPUT)verify_insn_arch.o \
-		 $(OUTPUT)verify_insn.o
+		 $(OUTPUT)verify_insn.o \
+		 $(OUTPUT)verify_orc.o
 
 ifeq ($(HAS_LIBLLVM),1)
 all: $(OUTPUT)verify_cfi
diff --git a/tools/unwind/verify_orc.cpp b/tools/unwind/verify_orc.cpp
new file mode 100644
index 000000000000..629849f3187e
--- /dev/null
+++ b/tools/unwind/verify_orc.cpp
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Oracle 3: Direct x86-64 .orc_unwind / .orc_unwind_ip comparison against
+ * kernel/unwind/dwarf_cfi.c.
+ */
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+#include "llvm/MC/MCInst.h"
+#include "llvm/Support/Endian.h"
+#include "llvm/Support/raw_ostream.h"
+#pragma GCC diagnostic pop
+
+#include "verify_cfi.hpp"
+
+#include <algorithm>
+#include <cinttypes>
+#include <cstdio>
+
+extern "C" {
+#include <asm/orc_types.h>
+}
+
+using namespace llvm;
+
+/**
+ * verifyOracle3Orc() - Cross-check x86-64 .orc_unwind against Minimal DWARF CFI
+ * @AS: Target architecture specification (x86_64).
+ * @eh_hdr_vma: Virtual address of .eh_frame_hdr.
+ * @eh_hdr_bytes: Raw contents of .eh_frame_hdr.
+ * @orc_bytes: Raw contents of .orc_unwind (6-byte &struct orc_entry records).
+ * @orc_ip_bytes: Raw contents of .orc_unwind_ip (PC-relative s32 offsets).
+ * @orc_ip_vma: Virtual address of .orc_unwind_ip.
+ * @exec_secs: Executable ELF sections.
+ * @func_syms: Deduplicated STT_FUNC symbol list.
+ * @Disasm: x86-64 LLVM MCDisassembler.
+ * @STI: Target subtarget info for instruction printing.
+ * @InstPrinter: Disassembly formatter for mismatch diagnostics.
+ * @opts: CLI verification options.
+ * @st: Aggregated verification counters and diagnostic samples.
+ *
+ * Evaluates every instruction inside STT_FUNC symbols whose active ORC record
+ * has type %ORC_TYPE_CALL and a defined SP base register, mapping `<asm/
+ * orc_types.h>` `ORC_REG_*` encodings directly to `DWARF_CFI_BASE_*` and
+ * `DWARF_CFI_RULE_*` fields.
+ */
+void verifyOracle3Orc(const ArchSpec &AS, uint64_t eh_hdr_vma,
+		      StringRef eh_hdr_bytes, StringRef orc_bytes,
+		      StringRef orc_ip_bytes, uint64_t orc_ip_vma,
+		      const std::vector<ExecSec> &exec_secs,
+		      const std::vector<FuncSym> &func_syms,
+		      const MCDisassembler &Disasm, const MCSubtargetInfo &STI,
+		      MCInstPrinter &InstPrinter, const VerifyOptions &opts,
+		      VerifyStats &st)
+{
+	st.has_orc = true;
+	constexpr size_t kOrcEntSz = 6;
+	size_t n_orc = orc_bytes.size() / kOrcEntSz;
+	size_t n_ip = orc_ip_bytes.size() / 4;
+	size_t n = std::min(n_orc, n_ip);
+	const uint8_t *orc_raw =
+		reinterpret_cast<const uint8_t *>(orc_bytes.data());
+	const uint8_t *ip_raw =
+		reinterpret_cast<const uint8_t *>(orc_ip_bytes.data());
+
+	std::vector<std::pair<uint64_t, size_t>> sorted_orc;
+	sorted_orc.reserve(n);
+	for (size_t i = 0; i < n; i++) {
+		int32_t rel = (int32_t)support::endian::read32le(ip_raw + i * 4);
+		uint64_t epc = orc_ip_vma + i * 4 + (uint64_t)(int64_t)rel;
+		sorted_orc.push_back({epc, i});
+	}
+	std::stable_sort(sorted_orc.begin(), sorted_orc.end(),
+			 [](const auto &a, const auto &b) {
+				 return a.first < b.first;
+			 });
+
+	auto lookupOrcIdx = [&](uint64_t pc, size_t &idx_out) -> bool {
+		auto it = std::upper_bound(
+			sorted_orc.begin(), sorted_orc.end(), pc,
+			[](uint64_t val, const std::pair<uint64_t, size_t> &e) {
+				return val < e.first;
+			});
+		if (it == sorted_orc.begin())
+			return false;
+		--it;
+		idx_out = it->second;
+		return true;
+	};
+
+	for (const FuncSym &fn : func_syms) {
+		if (!fn.size)
+			continue;
+		ArrayRef<uint8_t> code =
+			findExecBytes(exec_secs, fn.addr, fn.size);
+		if (code.empty())
+			continue;
+
+		uint64_t off = 0;
+		while (off < code.size()) {
+			uint64_t pc = fn.addr + off;
+			MCInst MI;
+			uint64_t InsnSize = 0;
+			auto DStat = Disasm.getInstruction(
+				MI, InsnSize, code.slice(off), pc, nulls());
+			if (DStat != MCDisassembler::Success || InsnSize == 0) {
+				off++;
+				continue;
+			}
+			off += InsnSize;
+
+			size_t oidx = 0;
+			if (!lookupOrcIdx(pc, oidx))
+				continue;
+			const uint8_t *ep = orc_raw + oidx * kOrcEntSz;
+			int16_t sp_offset =
+				(int16_t)support::endian::read16le(ep + 0);
+			int16_t bp_offset =
+				(int16_t)support::endian::read16le(ep + 2);
+			uint16_t flags = support::endian::read16le(ep + 4);
+
+			unsigned o_sp_reg = flags & 0xf;
+			unsigned o_bp_reg = (flags >> 4) & 0xf;
+			unsigned o_type = (flags >> 8) & 0x7;
+			if (o_type != ORC_TYPE_CALL ||
+			    o_sp_reg == ORC_REG_UNDEFINED)
+				continue;
+
+			st.orc_call_insns++;
+			dwarf_cfi_row row{};
+			if (dwarf_cfi_unwind_user_eh_frame_hdr(
+				    (unsigned long)eh_hdr_vma,
+				    eh_hdr_bytes.size(), (unsigned long)pc,
+				    &AS.karch, &row) != 0) {
+				st.orc_no_fde++;
+				continue;
+			}
+
+			bool cfa_ok = false;
+			if (o_sp_reg == ORC_REG_SP) {
+				cfa_ok = (row.cfa_base == DWARF_CFI_BASE_SP &&
+					  row.cfa_off == sp_offset);
+			} else if (o_sp_reg == ORC_REG_BP) {
+				cfa_ok = (row.cfa_base == DWARF_CFI_BASE_FP &&
+					  row.cfa_off == sp_offset);
+			} else if (o_sp_reg == ORC_REG_BP_INDIRECT) {
+				cfa_ok = (row.cfa_base ==
+						  DWARF_CFI_BASE_FP_INDIRECT &&
+					  row.cfa_off == sp_offset);
+			} else if (o_sp_reg == ORC_REG_SP_INDIRECT) {
+				cfa_ok = (row.cfa_base ==
+						  DWARF_CFI_BASE_SP_INDIRECT &&
+					  row.cfa_off == sp_offset);
+			} else if (row.cfa_base == DWARF_CFI_BASE_REG) {
+				int exp_dreg = (o_sp_reg == ORC_REG_AX) ? 0 :
+					       (o_sp_reg == ORC_REG_DX) ? 1 :
+					       (o_sp_reg == ORC_REG_DI) ? 5 :
+					       (o_sp_reg == ORC_REG_R10) ? 10 :
+					       (o_sp_reg == ORC_REG_R13) ? 13 :
+					       -1;
+				cfa_ok = (row.cfa_reg == exp_dreg &&
+					  row.cfa_off == sp_offset);
+			}
+
+			bool bp_ok = false;
+			if (o_bp_reg == ORC_REG_UNDEFINED) {
+				bp_ok = (row.fp_rule == DWARF_CFI_RULE_SAME);
+			} else if (o_bp_reg == ORC_REG_PREV_SP) {
+				bp_ok = (row.fp_rule == DWARF_CFI_RULE_OFFSET &&
+					 row.fp_off == bp_offset);
+			} else if (o_bp_reg == ORC_REG_BP) {
+				bp_ok = (row.fp_rule ==
+						 DWARF_CFI_RULE_FP_OFFSET &&
+					 row.fp_off == bp_offset);
+			}
+
+			if (cfa_ok && bp_ok) {
+				st.orc_matched++;
+			} else {
+				if (!cfa_ok)
+					st.orc_cfa_mismatch++;
+				if (!bp_ok)
+					st.orc_bp_mismatch++;
+				if (st.sample_orc_diffs.size() <
+				    opts.max_samples * 3) {
+					std::string dis_str;
+					raw_string_ostream rso(dis_str);
+					InstPrinter.printInst(&MI, pc, "", STI,
+							      rso);
+					char b[256];
+					snprintf(b, sizeof(b),
+						 "%s+0x%" PRIx64 " (0x%" PRIx64
+						 ")%s | ORC(sp=%u:%+d bp=%u:%+d)"
+						 " vs CFI(cfa=%u:%+d fp=%u:%+d)",
+						 fn.name.c_str(), pc - fn.addr,
+						 pc, rso.str().c_str(), o_sp_reg,
+						 sp_offset, o_bp_reg, bp_offset,
+						 row.cfa_base, row.cfa_off,
+						 row.fp_rule, row.fp_off);
+					st.sample_orc_diffs.push_back(b);
+				}
+			}
+		}
+	}
+}
-- 
2.56.1.831.g720f3f5937-goog

