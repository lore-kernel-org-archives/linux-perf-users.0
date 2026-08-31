Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086051E428;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188834; cv=none; b=qP54DJCrytMNfw0hmpq3CSVhy704bBcMRbbb3t2tJDQ2kYg8rBe4tnnxVsiNR/Gj+3grd1cliVVIfN8CbFKfB1p67BsUGEjZP8EijPHvZ3OunfpbA2Xvodhrc8RF6od0fDs2rFByBk0uZVnv/DDrVfJAdZC8kR2f2yi2kqXPqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188834; c=relaxed/simple;
	bh=VYLjx6VyYm+XRPwrP0rI1+ddnJWbseuSLhMTigTsJSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMk6QVwaBloCHTJKdpH5nirxNeYQIzYKXfKbcP1426vXcj3C+AKvlEgcHPaEiGmJvJKnTOP4xRbMOyRRW2KQoFd9OqDRs1F8Mo6X5OroWGT8qZOWr/kEppfPe14GFcWx3ij+3jjRzboUC5nmfThtqq0t1dzZRjq0/Nh2OKTbWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 9A4E863F87;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 1C00D162297; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 12/19] ptwrite uprobes: Add pacing to the probes
Date: Mon, 31 Aug 2026 08:04:48 -0700
Message-ID: <20260831150651.1134594-13-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When PTWRITEs are too tightly spaced they can lose data. While the decoder
makes some effort to recover from this it can be still annoying for the
user. This patch adds LFENCEs between the individual instructions to
mimimize (mostly avoid) this problem. It can still happen with parallel
branch collection or if a high frequency of timing packets are configured.
The extend also depends on the core-type.

It can be still disabled with %nopace. This is useful when the user knows
the probes are not too tightly spaced. It is usually still needed
with many arguments.

This patch generates LFENCEs for the probes unless disabled.

Compared with %nopace, default pacing increases probe cost by roughly 272%
with PT off, 227% with full tracing, and 48% in snapshot mode on Alder Lake.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/uprobes.h | 21 ++++++++---
 arch/x86/kernel/uprobes.c      | 64 +++++++++++++++++++++++++++++-----
 include/linux/uprobes.h        |  1 +
 kernel/trace/trace_uprobe.c    | 22 ++++++++++++
 4 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 4fc98eafbd5a..2800372b2f5a 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -29,12 +29,23 @@ enum {
 struct uprobe_xol_ops;
 
 /*
- * Stub block array size. Worst case = 250 B (8 MEM args, rsp bases, fault
- * table); 288 leaves 38 B slack. A file-scope static_assert in
- * arch/x86/kernel/uprobes.c re-derives the worst case; prepare() also
- * enforces it with -E2BIG at runtime.
+ * Stub block size. Conservative worst case is 298 bytes: 9-byte header,
+ * one lead fence, eight 21-byte memory forms with one 3-byte fence each,
+ * a 16-byte original-instruction copy, a 5-byte return jump, alignment,
+ * and 66 bytes of data/fault metadata. 384 leaves room. A static_assert in
+ * arch/x86/kernel/uprobes.c checks the bound; prepare() also checks it with
+ * -E2BIG.
  */
-#define UPROBE_PTWRITE_STUB_SIZE	288
+#define UPROBE_PTWRITE_STUB_SIZE	384
+
+/* the out-of-line original-instruction copy slot (x86 max insn length) */
+#define UPROBE_PTWRITE_COPY_SIZE	MAX_UINSN_BYTES
+
+/*
+ * Word pacing: insert this many LFENCEs between emitted ptwrite words and
+ * before the first word, unless UPROBE_PTWRITE_FL_NO_LEAD_PACE is requested.
+ */
+#define UPROBE_PTWRITE_SERIALIZE_LFENCES	1	/* LFENCEs per word gap */
 
 /*
  * ptwrite probe state. The stub template (code + data slots) is built
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index e17e0397eaae..20557423690f 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1278,6 +1278,25 @@ static int ptwrite_emit_riprel32(u8 *p, s32 disp)
 	return 8;
 }
 
+static int ptwrite_emit_lfence(u8 *p)
+{
+	*p++ = 0x0f;
+	*p++ = 0xae;
+	*p++ = 0xe8;	/* lfence */
+	return 3;
+}
+
+/* the default pacing: one or more fences per word gap. */
+static int ptwrite_emit_lfences(u8 *p)
+{
+	int i;
+
+	for (i = 0; i < UPROBE_PTWRITE_SERIALIZE_LFENCES; i++)
+		p += ptwrite_emit_lfence(p);
+	return UPROBE_PTWRITE_SERIALIZE_LFENCES * 3;
+}
+
+
 bool arch_uprobe_ptwrite_supported(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -1359,15 +1378,19 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 
 
 /*
- * Worst-case stub block: header ptwriteq (9) + max args of the largest form
- * (MEM: 5 opcode + SIB + 4 disp + 2 short jmp + 9 fixup = 21 B) + final jmp
- * (5) -> code; data: header + fault-word slots (16); fault table
- * [nft][{start,end,fixup} x nft] (2 + 6*nft). Must fit UPROBE_PTWRITE_STUB_SIZE;
- * prepare() also enforces it with -E2BIG at runtime.
+ * Conservative worst-case stub block: code is 9-byte header plus one lead
+ * fence, eight 21-byte memory forms plus one fence per argument, the
+ * 16-byte original-instruction copy, and a 5-byte return jump, rounded up;
+ * data and metadata add 16 + 2 + 6 * 8 bytes. This is 298 bytes with the
+ * current fence count and must remain below UPROBE_PTWRITE_STUB_SIZE.
  */
-static_assert((((9 + UPROBE_PTWRITE_MAX_ARGS * 21 + 5 + 7) & ~7) +
-	       16 + 2 + 6 * UPROBE_PTWRITE_MAX_ARGS) <= UPROBE_PTWRITE_STUB_SIZE,
-	       "worst-case ptwrite stub block exceeds UPROBE_PTWRITE_STUB_SIZE");
+static_assert((((9 + UPROBE_PTWRITE_SERIALIZE_LFENCES * 3 +
+		UPROBE_PTWRITE_MAX_ARGS * (21 +
+			UPROBE_PTWRITE_SERIALIZE_LFENCES * 3) +
+		UPROBE_PTWRITE_COPY_SIZE + 5 + 7) & ~7) +
+		16 + 2 + 6 * UPROBE_PTWRITE_MAX_ARGS) <=
+		UPROBE_PTWRITE_STUB_SIZE,
+		"worst-case ptwrite stub block exceeds UPROBE_PTWRITE_STUB_SIZE");
 
 static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 {
@@ -1375,6 +1398,7 @@ static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 		       sizeof(((struct uprobe_ptwrite_arch *)0)->stub) - len;
 }
 
+
 #define PTW_NEED(_len) do { \
 		if (!ptwrite_has_room(code, p, (_len))) \
 			return -E2BIG; \
@@ -1394,6 +1418,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	unsigned int data_off, flt_off, ft_off;
 	unsigned int hdr_off = 0;
 	unsigned int imm_idx = 0, n_imm = 0, mem_idx = 0, n_mem = 0;
+	bool paced = false;
 	u64 hdr;
 	int i;
 
@@ -1441,9 +1466,26 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		}
 	}
 
+	/* Slow down the probes to avoid PT overflow. */
+#define PTW_NEED(_len) do { \
+		if (!ptwrite_has_room(code, p, (_len))) \
+			return -E2BIG; \
+	} while (0)
+
+	paced = !(desc->flags & UPROBE_PTWRITE_FL_NO_LEAD_PACE);
+	if (paced) {
+		PTW_NEED(UPROBE_PTWRITE_SERIALIZE_LFENCES * 3);
+		p += ptwrite_emit_lfences(p);
+	}
+
 	/* header word emission (disp32 patched below) */
 	PTW_NEED(9);
+	hdr_off = p - code;
 	p += ptwrite_emit_riprel(p, 0);
+	if (paced) {
+		PTW_NEED(UPROBE_PTWRITE_SERIALIZE_LFENCES * 3);
+		p += ptwrite_emit_lfences(p);
+	}
 
 	for (i = 0; i < desc->nargs; i++) {
 		switch (desc->args[i].src) {
@@ -1498,9 +1540,13 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 			break;
 		}
 		}
+		if (paced && i + 1 < desc->nargs) {
+			PTW_NEED(UPROBE_PTWRITE_SERIALIZE_LFENCES * 3);
+			p += ptwrite_emit_lfences(p);
+		}
 	}
 
-	/* final jmp back to probe+5; rel32 patched per-mm at install */
+	/* final jmp back to probe+len; rel32 patched per-mm at install */
 	PTW_NEED(5);
 	*p++ = 0xe9;
 	if (p - code > U8_MAX)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b93ab24173c7..b39abd1b057d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -210,6 +210,7 @@ enum uprobe_ptwrite_src {
 
 /* uprobe_ptwrite_desc.flags */
 #define UPROBE_PTWRITE_FL_ALLOW_MEM	BIT(0) /* SRC_MEM args enabled */
+#define UPROBE_PTWRITE_FL_NO_LEAD_PACE	BIT(1) /* don't slow down probes */
 #define UPROBE_PTWRITE_FL_ALLOW_NOP_RUN	BIT(2) /* accept five 1-byte NOPs */
 
 struct uprobe_ptwrite_arg {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b54cc2057329..7625ee8c7efc 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -645,6 +645,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	enum probe_print_type ptype;
 	bool is_return = false;
 	bool is_ptwrite = false;
+	bool is_nopace = false;
 	bool is_nop_run = false;
 	int i, ret, arg_start = 2;
 
@@ -732,6 +733,11 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* Check if there is %return suffix */
 	tmp = strchr(arg, '%');
+	if (tmp && is_ptwrite && !strcmp(tmp, "%nopace")) {
+		*tmp = '\0';
+		is_nopace = true;
+		tmp = NULL;
+	}
 	if (tmp && is_ptwrite) {
 		if (!strcmp(tmp, "%multinop")) {
 			*tmp = '\0';
@@ -756,11 +762,20 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		trace_probe_log_err(arg - filename, BAD_UPROBE_OFFS);
 		return ret;
 	}
+	if (is_ptwrite && arg_start < argc &&
+	    !strcmp(argv[arg_start], "%nopace")) {
+		is_nopace = true;
+		arg_start++;
+	}
 	if (is_ptwrite) {
 		while (arg_start < argc && !strcmp(argv[arg_start], "%multinop")) {
 			is_nop_run = true;
 			arg_start++;
 		}
+		if (arg_start < argc && !strcmp(argv[arg_start], "%nopace")) {
+			is_nopace = true;
+			arg_start++;
+		}
 	}
 
 	if (argc - arg_start > MAX_TRACE_ARGS ||
@@ -844,6 +859,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		tu->ptwrite_desc.nargs = argc;
 		tu->ptwrite_desc.flags = is_nop_run ?
 			UPROBE_PTWRITE_FL_ALLOW_NOP_RUN : 0;
+		if (is_nopace)
+			tu->ptwrite_desc.flags |= UPROBE_PTWRITE_FL_NO_LEAD_PACE;
 		for (i = 0; i < argc; i++) {
 			ret = ptwrite_compile_arg(tu, i);
 			if (ret) {
@@ -902,6 +919,11 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 			   trace_probe_group_name(&tu->tp),
 			   trace_probe_name(&tu->tp), tu->filename,
 			   (int)(sizeof(void *) * 2), tu->offset);
+		if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_NO_LEAD_PACE) {
+			seq_puts(m, "%nopace");
+			if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN)
+				seq_putc(m, ' ');
+		}
 		if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN)
 			seq_puts(m, "%multinop");
 	} else
-- 
2.54.0

