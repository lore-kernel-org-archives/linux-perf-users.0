Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882F4B1464;
	Thu, 17 Sep 2026 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686132; cv=none; b=kJ6eqQ42gB7nQ+1wmKP7Lkbbbo3NK1bTdkeI6wL7ccx5jHzWDR9KluG/SP311qWwRpRNyMhB0HpNKafkePQmam5Uo/woi04FsgfQWcr4zXPgZ2xXPBn7uwKHFQSVdLJKYU7pbkChSM3qAgunuwUAQq1k7/FYOeYpERgnLpsbxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686132; c=relaxed/simple;
	bh=SRJWxYAjRX28DDmOMCqu1WWQpU3fWKiz31xeoNrfP9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIQJuAzTgT7vHl9l1orqu40899mZjKIzIq8JeqdA4w8b8TswzYM+Y8WWlIb2E/Vjs1ermT4dxJmDfkKthXFT+mXAy9KIeE5XabmeICcMgzW2ze4G5BHFN0bgjZjYXDsXyA6FVzMuAXozBkXEYDAJXB7JkAKPOWXW3nUoO5d2ATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 066B45E8A8;
	Fri, 18 Sep 2026 01:01:55 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 8B4901622BD; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC PATCH v2 07/11] ptwrite uprobes: Add multinop support
Date: Thu, 17 Sep 2026 16:00:34 -0700
Message-ID: <20260917230127.924985-8-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917230127.924985-1-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC's -fpatchable-function-entry=5 may emit five one-byte NOPs. Normally
that's not safe to patch because some might jump into a later nop.
But for the gcc case it's safe because nobody jumps into the nops.
Add a %multinop that allows the user opting into patching these sites.
This way patching for the gcc instrumentation works.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/uprobes.h               | 24 ++++++--
 arch/x86/kernel/uprobes.c                    | 63 +++++++++++++++++---
 include/linux/uprobes.h                      |  2 +
 kernel/trace/trace_uprobe.c                  | 58 +++++++++++++-----
 samples/uprobe-ptwrite/uprobe_ptwrite_test.c |  6 ++
 5 files changed, 126 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index e5a668ba5ad6..c46b3fe09025 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -30,12 +30,23 @@ enum {
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
+
+/*
+ * Word pacing: insert this many LFENCEs between emitted ptwrite words and
+ * before the first word, unless UPROBE_PTWRITE_FL_NO_LEAD_PACE is requested.
+ */
+#define UPROBE_PTWRITE_SERIALIZE_LFENCES	1	/* LFENCEs per word gap */
+/* The encoded LFENCE instruction occupies three bytes. */
+#define UPROBE_PTWRITE_LFENCE_SIZE	3
 
 /*
  * ptwrite probe state. The stub template (code + data slots) is built
@@ -49,6 +60,9 @@ struct uprobe_ptwrite_arch {
 	u8	jmp_off;	/* offset of the final jmp's rel32 field */
 	u8	ndata;		/* number of u64 data slots */
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
+	u16	ft_off;		/* fault table offset within the block (0 if none) */
+	u8	nft;		/* number of fault entries */
+	bool	allow_nop_run;	/* accept a five-byte run of 0x90 */
 };
 
 /* Per-mm page holding generated ptwrite stub blocks, like tramp_mapping. */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0029b66cd64e..f915dda8bcb4 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1323,6 +1323,24 @@ static int ptwrite_emit_riprel(u8 *p, s32 disp)
 	return 9;
 }
 
+static int ptwrite_emit_lfence(u8 *p)
+{
+	*p++ = 0x0f;
+	*p++ = 0xae;
+	*p++ = 0xe8;	/* LFENCE */
+	return UPROBE_PTWRITE_LFENCE_SIZE;
+}
+
+/* The default pacing: one or more fences per word gap. */
+static int ptwrite_emit_lfences(u8 *p)
+{
+	int i;
+
+	for (i = 0; i < UPROBE_PTWRITE_SERIALIZE_LFENCES; i++)
+		p += ptwrite_emit_lfence(p);
+	return UPROBE_PTWRITE_SERIALIZE_LFENCES *
+		UPROBE_PTWRITE_LFENCE_SIZE;
+}
 bool arch_uprobe_ptwrite_supported(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -1411,13 +1429,20 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 }
 
 /*
- * Worst-case stub block: header ptwriteq (9) + max memory args (10 bytes
- * each, including a SIB byte) + final jmp (5), rounded up; data adds one
- * header slot and one slot per immediate. Keep the bound below the stub size.
+ * Worst-case paced stub before instruction punning: a 9-byte header, one
+ * lead fence, one fence after the header, one fence between each argument,
+ * the largest memory form (10 bytes), and the return jump. Data adds one
+ * header slot and one slot per immediate.
  */
-static_assert((((9 + UPROBE_PTWRITE_MAX_ARGS * 10 + 5 + 7) & ~7) +
-	       8 * (1 + UPROBE_PTWRITE_MAX_ARGS)) <= UPROBE_PTWRITE_STUB_SIZE,
-	       "worst-case ptwrite stub block exceeds UPROBE_PTWRITE_STUB_SIZE");
+static_assert((((9 + UPROBE_PTWRITE_SERIALIZE_LFENCES *
+				  UPROBE_PTWRITE_LFENCE_SIZE +
+			  UPROBE_PTWRITE_MAX_ARGS *
+				  (10 + UPROBE_PTWRITE_SERIALIZE_LFENCES *
+				   UPROBE_PTWRITE_LFENCE_SIZE) +
+			  5 + 7) & ~7) +
+		       8 * (1 + UPROBE_PTWRITE_MAX_ARGS)) <=
+		      UPROBE_PTWRITE_STUB_SIZE,
+		      "worst-case ptwrite stub block exceeds UPROBE_PTWRITE_STUB_SIZE");
 
 static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 {
@@ -1439,6 +1464,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	unsigned int data_off;
 	unsigned int hdr_off = 0;
 	unsigned int imm_idx = 0, n_imm = 0;
+	bool paced = false;
 	u64 hdr;
 	int i;
 
@@ -1446,7 +1472,9 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		return -EINVAL;
 	if (desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
 		return -E2BIG;
-	if (desc->flags & ~UPROBE_PTWRITE_FL_ALLOW_MEM)
+	if (desc->flags & ~(UPROBE_PTWRITE_FL_ALLOW_MEM |
+			     UPROBE_PTWRITE_FL_NO_LEAD_PACE |
+			     UPROBE_PTWRITE_FL_ALLOW_NOP_RUN))
 		return -EINVAL;
 
 	/* The generic registration path copied these bytes before this hook. */
@@ -1477,9 +1505,22 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		}
 	}
 
+	paced = !(desc->flags & UPROBE_PTWRITE_FL_NO_LEAD_PACE);
+	if (paced) {
+		PTW_NEED(UPROBE_PTWRITE_SERIALIZE_LFENCES *
+			 UPROBE_PTWRITE_LFENCE_SIZE);
+		p += ptwrite_emit_lfences(p);
+	}
+
 	/* header word emission (disp32 patched below) */
 	PTW_NEED(9);
+	hdr_off = p - code;
 	p += ptwrite_emit_riprel(p, 0);
+	if (paced) {
+		PTW_NEED(UPROBE_PTWRITE_SERIALIZE_LFENCES *
+			 UPROBE_PTWRITE_LFENCE_SIZE);
+		p += ptwrite_emit_lfences(p);
+	}
 
 	for (i = 0; i < desc->nargs; i++) {
 		switch (desc->args[i].src) {
@@ -1515,9 +1556,14 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 			break;
 		}
 		}
+		if (paced && i + 1 < desc->nargs) {
+			PTW_NEED(UPROBE_PTWRITE_SERIALIZE_LFENCES *
+				 UPROBE_PTWRITE_LFENCE_SIZE);
+			p += ptwrite_emit_lfences(p);
+		}
 	}
 
-	/* final jmp back to probe+5; rel32 patched per-mm at install */
+	/* final jmp back to probe+len; rel32 patched per-mm at install */
 	PTW_NEED(5);
 	*p++ = 0xe9;
 	if (p - code > U8_MAX)
@@ -1549,6 +1595,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 
 	ptw->stub_len = data_off + 8 * (1 + n_imm);
 	ptw->ndata = 1 + n_imm;
+	ptw->allow_nop_run = desc->flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN;
 	return 0;
 }
 #undef PTW_NEED
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f6ffb0637991..5f16799c9fb9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -210,6 +210,8 @@ enum uprobe_ptwrite_src {
 
 /* uprobe_ptwrite_desc.flags */
 #define UPROBE_PTWRITE_FL_ALLOW_MEM	BIT(0) /* SRC_MEM args enabled */
+#define UPROBE_PTWRITE_FL_NO_LEAD_PACE	BIT(1) /* don't slow down probes */
+#define UPROBE_PTWRITE_FL_ALLOW_NOP_RUN	BIT(2) /* accept five 1-byte NOPs */
 
 struct uprobe_ptwrite_arg {
 	u8	src;		/* enum uprobe_ptwrite_src */
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index ab8ad3f6083d..a226b89e5b9a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -635,6 +635,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	enum probe_print_type ptype;
 	bool is_return = false;
 	bool is_ptwrite = false;
+	bool is_nopace = false;
+	bool is_nop_run = false;
 	int i, ret, arg_start = 2;
 
 	ref_ctr_offset = 0;
@@ -660,13 +662,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	trlog = trace_probe_log_init("trace_uprobe", argc, argv);
 
-	if (argc - 2 > MAX_TRACE_ARGS ||
-	    (is_ptwrite && argc - 2 > UPROBE_PTWRITE_MAX_ARGS)) {
-		trace_probe_log_set_index(2);
-		trace_probe_log_err(0, TOO_MANY_ARGS);
-		return -E2BIG;
-	}
-
 	if (is_ptwrite)
 		event = argv[0][3] == ':' && argv[0][4] ?
 			&argv[0][4] : NULL;
@@ -728,9 +723,19 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* Check if there is %return suffix */
 	tmp = strchr(arg, '%');
+	if (tmp && is_ptwrite && !strcmp(tmp, "%nopace")) {
+		*tmp = '\0';
+		is_nopace = true;
+		tmp = NULL;
+	}
 	if (tmp && is_ptwrite) {
-		trace_probe_log_err(tmp - filename, BAD_ADDR_SUFFIX);
-		return -EINVAL;
+		if (!strcmp(tmp, "%multinop")) {
+			*tmp = '\0';
+			is_nop_run = true;
+		} else {
+			trace_probe_log_err(tmp - filename, BAD_ADDR_SUFFIX);
+			return -EINVAL;
+		}
 	} else if (tmp) {
 		if (!strcmp(tmp, "%return")) {
 			*tmp = '\0';
@@ -747,6 +752,28 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		trace_probe_log_err(arg - filename, BAD_UPROBE_OFFS);
 		return ret;
 	}
+	if (is_ptwrite && arg_start < argc &&
+	    !strcmp(argv[arg_start], "%nopace")) {
+		is_nopace = true;
+		arg_start++;
+	}
+	if (is_ptwrite) {
+		while (arg_start < argc && !strcmp(argv[arg_start], "%multinop")) {
+			is_nop_run = true;
+			arg_start++;
+		}
+		if (arg_start < argc && !strcmp(argv[arg_start], "%nopace")) {
+			is_nopace = true;
+			arg_start++;
+		}
+	}
+
+	if (argc - arg_start > MAX_TRACE_ARGS ||
+	    (is_ptwrite && argc - arg_start > UPROBE_PTWRITE_MAX_ARGS)) {
+		trace_probe_log_set_index(arg_start);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
+		return -E2BIG;
+	}
 
 	/* setup a probe */
 	trace_probe_log_set_index(0);
@@ -782,8 +809,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		kfree(tail);
 	}
 
-	argc -= 2;
-	argv += 2;
+	argc -= arg_start;
+	argv += arg_start;
 
 	tu = alloc_trace_uprobe(group, event, argc, is_return);
 	if (IS_ERR(tu)) {
@@ -806,7 +833,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
-		trace_probe_log_set_index(i + 2);
+		trace_probe_log_set_index(i + arg_start);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
 		if (ret)
 			return ret;
@@ -814,13 +841,16 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	if (is_ptwrite) {
 		if (!argc) {
-			trace_probe_log_set_index(2);
+			trace_probe_log_set_index(arg_start);
 			trace_probe_log_err(0, NO_ARG_BODY);
 			return -EINVAL;	/* core rejects desc->nargs == 0 */
 		}
 		tu->is_ptwrite = true;
 		tu->ptwrite_desc.nargs = argc;
-		tu->ptwrite_desc.flags = 0;
+		tu->ptwrite_desc.flags = is_nop_run ?
+			UPROBE_PTWRITE_FL_ALLOW_NOP_RUN : 0;
+		if (is_nopace)
+			tu->ptwrite_desc.flags |= UPROBE_PTWRITE_FL_NO_LEAD_PACE;
 		for (i = 0; i < argc; i++) {
 			ret = ptwrite_compile_arg(tu, i);
 			if (ret) {
diff --git a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
index 55e23ff27dd5..ca28d511b60c 100644
--- a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
+++ b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
@@ -17,6 +17,7 @@
  *                        m<N>[:<disp>][:<size>] = memory arg [reg + disp32],
  *                        size 4 (u32 load) or 8 (u64 load, default)
  *   event_id=0x1234      identifier carried in the PTW header word
+ *   allow_nop_run=1      accept five one-byte NOPs at the site
  */
 #include <linux/module.h>
 #include <linux/uprobes.h>
@@ -36,6 +37,10 @@ static ushort event_id = 0x1234;
 module_param(event_id, ushort, 0444);
 MODULE_PARM_DESC(event_id, "event id carried in the PTW header word");
 
+static bool allow_nop_run;
+module_param(allow_nop_run, bool, 0444);
+MODULE_PARM_DESC(allow_nop_run, "accept five one-byte NOPs at the site");
+
 static char *args = "r0";
 module_param(args, charp, 0444);
 MODULE_PARM_DESC(args, "comma-separated args: r<N> GPR, i<hex> immediate, m<N>[:disp][:4|8] memory");
@@ -142,6 +147,7 @@ static int __init uprobe_ptwrite_test_init(void)
 	int ret;
 
 	desc.event_id = event_id;
+	desc.flags = allow_nop_run ? UPROBE_PTWRITE_FL_ALLOW_NOP_RUN : 0;
 	ret = parse_probe_args();
 	if (ret)
 		return ret;
-- 
2.54.0

