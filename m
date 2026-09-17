Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3844E66F;
	Thu, 17 Sep 2026 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686563; cv=none; b=ldM9Px1B8wuqoiDQnzXOhIfaR93U1wZdwGr6gJ7gtXjyBASUyODJQlk7PdnNrYN+AQGPFe9R4rZ36X52a0TM9nHkYILDuVHREHuOfSe94kkMIFd+oaOjwzKQpQyE68fpzZWCXkbe1kaFQFuZDwSERo16GfjQwzV97OYyvbIPeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686563; c=relaxed/simple;
	bh=q1xTOyMnmJKrBp8+O1am10uF2wop3eu4gR9VFDZnYXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrcXhzNNXzJBDICzdf4PzbE2gy5c9eJ0iyuPy1g+jLk78Vd7pAR3mmWnSXO/aCyrC2OajyGgGlsYALfRxw5G6TaXLk1/WszeSg2AbucAJyGIu+Cm0Y551lWTwopFioGWeRixIaRINYm68ZUF/BkVS97gY0Ip/4vEfZxULD1lOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 0E5575E89D;
	Fri, 18 Sep 2026 01:01:52 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 81F521622AB; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/11] ptwrite uprobes: Add support to tracing infrastructure
Date: Thu, 17 Sep 2026 16:00:31 -0700
Message-ID: <20260917230127.924985-5-ak@kernel.org>
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

Hook up the low level x86 ptwrite uprobes code to the generic trace
uprobes events parser, so that the new probes can be set up. The
interface is similar to classic probes, but there is new ptw: syntax
and various restrictions.

Add minimal docs.

Architectures without the ptwrite backend are handled by weak stubs.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 Documentation/trace/uprobetracer.rst |  46 +++++-
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/uprobes.h       |  12 +-
 include/linux/uprobes.h              |   4 +
 kernel/trace/Kconfig                 |   6 +
 kernel/trace/trace_uprobe.c          | 219 +++++++++++++++++++++++++--
 6 files changed, 272 insertions(+), 16 deletions(-)

diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 01f6a780fb04..56d951d1fa5b 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -19,8 +19,8 @@ However unlike kprobe-event tracer, the uprobe event interface expects the
 user to calculate the offset of the probepoint in the object.
 
 You can also use /sys/kernel/tracing/dynamic_events instead of
-uprobe_events. That interface will provide unified access to other
-dynamic events too.
+uprobe_events. That interface provides unified access to other event types
+too.
 
 Synopsis of uprobe_tracer
 -------------------------
@@ -29,6 +29,7 @@ Synopsis of uprobe_tracer
   p[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a uprobe
   r[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
   p[:[GRP/][EVENT]] PATH:OFFSET%return [FETCHARGS] : Set a return uprobe (uretprobe)
+  ptw[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a trap-free ptwrite uprobe
   -:[GRP/][EVENT]                           : Clear uprobe or uretprobe event
 
   GRP           : Group name. If omitted, "uprobes" is the default value.
@@ -76,6 +77,47 @@ offset, and container-size (usually 32). The syntax is::
 For $comm, the default type is "string"; any other type is invalid.
 
 
+ptwrite uprobes (ptw:)
+----------------------
+
+See ptwrite-uprobes.rst for more details.
+
+A ``ptw:`` probe emits values into an Intel Processor Trace data stream.
+It is faster than standard uprobes, but has restrictions. The Intel Processor
+Trace recording must be configured separately.
+
+Requirements and restrictions:
+
+- Intel CPU with PTWRITE support (``/sys/devices/intel_pt/format/ptw`` must exist)
+- Entry probes only: ``r:``/``%return`` and the SDT reference counter
+  ``(REF)`` are rejected.
+- The probe site must be a 5-byte NOP or a punnable instruction (see
+  ptwrite-uprobes.rst). For five ``0x90`` bytes from GCC's
+  ``-fpatchable-function-entry=5``, append ``%multinop`` to the offset.
+- The event does not produce ring-buffer records. It provides a type registry
+  (``events/GRP/EVENT/format``) and the wire ``event_id``
+  (``events/GRP/EVENT/id``) for an external decoder. Filters and perf
+  attach are rejected because filtering would need kernel entry.
+
+Wire format: each probe hit emits a 64-bit header word ``event_id<<48 |
+nargs<<40 | 0x5054525731`` followed by ``nargs`` PTWRITE payloads. Perf
+exposes each payload through its existing ``u64`` field.  Decode with
+``perf script`` and ``tools/perf/scripts/python/uprobe-ptwrite-decode.py``:
+
+::
+
+  perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -o perf.data -- ./app
+  perf script --itrace=qwe -s uprobe-ptwrite-decode.py
+
+``fup_on_ptw=1`` increases the overhead, but improves decoding reliability
+because the exact IP of each probe is logged.
+
+Example::
+
+  echo 'ptw:t /bin/app:0x1234 %rdi %rsi \0x42' > /sys/kernel/tracing/uprobe_events
+  echo 1 > /sys/kernel/tracing/events/uprobes/t/enable
+
+
 Event Profiling
 ---------------
 You can check the total number of probe hits per event via
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7fda5edb0c06..4c67ff306950 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -423,6 +423,7 @@ config HAVE_INTEL_TXT
 
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
+	select UPROBE_EVENTS_PTWRITE if X86_64 && UPROBE_EVENTS
 
 config FIX_EARLYCON_MEM
 	def_bool y
diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 20d086a945c5..b51907c1d465 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -29,6 +29,14 @@ enum {
 
 struct uprobe_xol_ops;
 
+/*
+ * Stub block array size. Worst case = 250 B (8 MEM args, rsp bases, fault
+ * table); 288 leaves 38 B slack. A file-scope static_assert in
+ * arch/x86/kernel/uprobes.c re-derives the worst case; prepare() also
+ * enforces it with -E2BIG at runtime.
+ */
+#define UPROBE_PTWRITE_STUB_SIZE	288
+
 /*
  * ptwrite probe state. The stub template (code + data slots) is built
  * once at registration (mm-independent except the final jmp's rel32, patched
@@ -36,8 +44,8 @@ struct uprobe_xol_ops;
  *   [ptwriteq hdr(%rip)] [arg emissions] [jmp probe+5] [u64 slots: header, imms]
  */
 struct uprobe_ptwrite_arch {
-	u8	stub[256];
-	u8	stub_len;	/* code + data, whole block */
+	u8	stub[UPROBE_PTWRITE_STUB_SIZE];
+	u16	stub_len;	/* code + data + fault table, whole block */
 	u8	jmp_off;	/* offset of the final jmp's rel32 field */
 	u8	ndata;		/* number of u64 data slots */
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 6b20d61cf737..6cea2944ca8b 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -205,8 +205,12 @@ struct uprobes_state {
 enum uprobe_ptwrite_src {
 	UPROBE_PTW_SRC_REG,	/* value = live GPR (index in .reg) */
 	UPROBE_PTW_SRC_IMM,	/* value = constant (.val), stored in stub data slot */
+	UPROBE_PTW_SRC_MEM,	/* value = [.reg + disp32] (v2); requires ALLOW_MEM */
 };
 
+/* uprobe_ptwrite_desc.flags */
+#define UPROBE_PTWRITE_FL_ALLOW_MEM	BIT(0) /* SRC_MEM args enabled */
+
 struct uprobe_ptwrite_arg {
 	u8	src;		/* enum uprobe_ptwrite_src */
 	u8	reg;		/* x86-64 GPR index (0=rax..15=r15) for SRC_REG */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0ab5916575a9..edbae5aa8dd3 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -848,6 +848,12 @@ config UPROBE_EVENTS
 	  This option is required if you plan to use perf-probe subcommand
 	  of perf tools on user space applications.
 
+config UPROBE_EVENTS_PTWRITE
+	bool
+	depends on UPROBE_EVENTS
+	help
+	  ptwrite uprobes ("ptw:" tracefs event type).
+
 config EPROBE_EVENTS
 	bool "Enable event-based dynamic events"
 	depends on TRACING
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 22cc3c8181b8..ab8ad3f6083d 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/fs.h>
 #include <linux/uprobes.h>
 
 #include "trace.h"
@@ -66,6 +67,9 @@ struct trace_uprobe {
 	unsigned long			offset;
 	unsigned long			ref_ctr_offset;
 	unsigned long __percpu		*nhits;
+	bool				is_ptwrite;
+	struct uprobe_ptwrite_desc	ptwrite_desc;
+	/* tp.args[] is a flex array and must remain the last member */
 	struct trace_probe		tp;
 };
 
@@ -275,7 +279,7 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
-	return trace_probe_is_enabled(&tu->tp);
+	return trace_probe_is_enabled(&tu->tp) || tu->uprobe;
 }
 
 static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
@@ -510,7 +514,8 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	old_tu = find_probe_event(trace_probe_name(&tu->tp),
 				  trace_probe_group_name(&tu->tp));
 	if (old_tu) {
-		if (is_ret_probe(tu) != is_ret_probe(old_tu)) {
+		if (is_ret_probe(tu) != is_ret_probe(old_tu) ||
+		    tu->is_ptwrite != old_tu->is_ptwrite) {
 			trace_probe_log_set_index(0);
 			trace_probe_log_err(0, DIFF_PROBE_TYPE);
 			return -EEXIST;
@@ -535,9 +540,85 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, free_trace_uprobe(_T))
 
+/*
+ * Compile one parsed fetch arg into a ptwrite descriptor entry. The
+ * arch-independent part: decode the fetch chain, reject shapes the
+ * scratch-free stub cannot emit, and hand the rest to the arch hook.
+ */
+static int ptwrite_compile_arg(struct trace_uprobe *tu, int i)
+{
+	struct fetch_insn *code = tu->tp.args[i].code;
+	struct uprobe_ptwrite_arg *a = &tu->ptwrite_desc.args[i];
+	struct uprobe_ptwrite_fetch f;
+
+	if (code[1].op == FETCH_OP_ST_MEM || code[1].op == FETCH_OP_ST_UMEM) {
+		if (code[2].op != FETCH_OP_END)
+			return -EINVAL;
+		if (code[0].op != FETCH_OP_REG) {
+			/*
+			 * +off($stackN): the STACK op derefs [rsp+8N] to a
+			 * POINTER, and ST_MEM derefs that pointer (load-of-
+			 * load). The scratch-free stub has no register to
+			 * hold the intermediate pointer, so reject.
+			 */
+			return -EINVAL;
+		}
+		if (tu->tp.args[i].type->size != 4 &&
+		    tu->tp.args[i].type->size != 8)
+			return -EINVAL;	/* memory derefs are u32 or u64 */
+		f.kind = UPROBE_PTW_FETCH_MEMREG;
+		f.reg = code[0].param;
+		f.imm = code[1].offset;
+		goto compile;
+	}
+
+	/*
+	 * $stackN: [STACK, ST_RAW, END], the deref is folded inside the
+	 * STACK op (get_user_stack_nth reads [rsp + 8N]).
+	 */
+	if (code[0].op == FETCH_OP_STACK &&
+	    code[1].op == FETCH_OP_ST_RAW && code[2].op == FETCH_OP_END) {
+		if (tu->tp.args[i].type->size != 4 &&
+		    tu->tp.args[i].type->size != 8)
+			return -EINVAL;	/* stack slots are u32 or u64 */
+		f.kind = UPROBE_PTW_FETCH_STACKN;
+		f.imm = 8L * code[0].param;
+		goto compile;
+	}
+
+	if (code[1].op != FETCH_OP_ST_RAW || code[2].op != FETCH_OP_END)
+		return -EINVAL;
+
+	switch (code->op) {
+	case FETCH_OP_REG:	/* %reg */
+		f.kind = UPROBE_PTW_FETCH_REG;
+		f.reg = code->param;
+		break;
+	case FETCH_OP_STACKP:	/* $stack: SP value, never faults */
+		f.kind = UPROBE_PTW_FETCH_STACKP;
+		break;
+	case FETCH_OP_IMM:	/* \IMM */
+		f.kind = UPROBE_PTW_FETCH_IMM;
+		f.imm = code->immediate;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+compile:
+	if (f.kind == UPROBE_PTW_FETCH_MEMREG ||
+	    f.kind == UPROBE_PTW_FETCH_STACKN)
+		tu->ptwrite_desc.flags |= UPROBE_PTWRITE_FL_ALLOW_MEM;
+	if (arch_uprobe_ptwrite_fetch(a, &f))
+		return -EINVAL;
+	a->size = tu->tp.args[i].type->size;
+	return 0;
+}
+
 /*
  * Argument syntax:
  *  - Add uprobe: p|r[:[GRP/][EVENT]] PATH:OFFSET[%return][(REF)] [FETCHARGS]
+ *  - Add ptwrite uprobe: ptw[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS]
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
@@ -553,10 +634,17 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	char *buf __free(kfree) = NULL;
 	enum probe_print_type ptype;
 	bool is_return = false;
-	int i, ret;
+	bool is_ptwrite = false;
+	int i, ret, arg_start = 2;
 
 	ref_ctr_offset = 0;
 
+	if (!strncmp(argv[0], "ptw:", 4) || !strcmp(argv[0], "ptw")) {
+		if (!IS_ENABLED(CONFIG_UPROBE_EVENTS_PTWRITE))
+			return -EOPNOTSUPP;	/* no arch backend configured */
+		is_ptwrite = true;
+	}
+
 	switch (argv[0][0]) {
 	case 'r':
 		is_return = true;
@@ -572,13 +660,17 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	trlog = trace_probe_log_init("trace_uprobe", argc, argv);
 
-	if (argc - 2 > MAX_TRACE_ARGS) {
+	if (argc - 2 > MAX_TRACE_ARGS ||
+	    (is_ptwrite && argc - 2 > UPROBE_PTWRITE_MAX_ARGS)) {
 		trace_probe_log_set_index(2);
 		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
 	}
 
-	if (argv[0][1] == ':')
+	if (is_ptwrite)
+		event = argv[0][3] == ':' && argv[0][4] ?
+			&argv[0][4] : NULL;
+	else if (argv[0][1] == ':')
 		event = &argv[0][2];
 
 	if (!strchr(argv[1], '/'))
@@ -608,6 +700,10 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* Parse reference counter offset if specified. */
 	rctr = strchr(arg, '(');
+	if (rctr && is_ptwrite) {
+		trace_probe_log_err(rctr - filename, BAD_REFCNT);
+		return -EINVAL;	/* SDT ref-counting needs kernel updates */
+	}
 	if (rctr) {
 		rctr_end = strchr(rctr, ')');
 		if (!rctr_end) {
@@ -632,7 +728,10 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* Check if there is %return suffix */
 	tmp = strchr(arg, '%');
-	if (tmp) {
+	if (tmp && is_ptwrite) {
+		trace_probe_log_err(tmp - filename, BAD_ADDR_SUFFIX);
+		return -EINVAL;
+	} else if (tmp) {
 		if (!strcmp(tmp, "%return")) {
 			*tmp = '\0';
 			is_return = true;
@@ -677,7 +776,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
-		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
+		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx",
+			 is_ptwrite ? 't' : 'p', tail, offset);
 		event = buf;
 		kfree(tail);
 	}
@@ -712,6 +812,25 @@ static int __trace_uprobe_create(int argc, const char **argv)
 			return ret;
 	}
 
+	if (is_ptwrite) {
+		if (!argc) {
+			trace_probe_log_set_index(2);
+			trace_probe_log_err(0, NO_ARG_BODY);
+			return -EINVAL;	/* core rejects desc->nargs == 0 */
+		}
+		tu->is_ptwrite = true;
+		tu->ptwrite_desc.nargs = argc;
+		tu->ptwrite_desc.flags = 0;
+		for (i = 0; i < argc; i++) {
+			ret = ptwrite_compile_arg(tu, i);
+			if (ret) {
+				trace_probe_log_set_index(i + arg_start);
+				trace_probe_log_err(0, BAD_FETCH_ARG);
+				return ret;
+			}
+		}
+	}
+
 	ptype = is_ret_probe(tu) ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tu->tp, ptype);
 	if (ret < 0)
@@ -754,9 +873,24 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
-	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, trace_probe_group_name(&tu->tp),
-			trace_probe_name(&tu->tp), tu->filename,
-			(int)(sizeof(void *) * 2), tu->offset);
+	if (tu->is_ptwrite) {
+		seq_printf(m, "ptw:%s/%s %s:0x%0*lx",
+			   trace_probe_group_name(&tu->tp),
+			   trace_probe_name(&tu->tp), tu->filename,
+			   (int)(sizeof(void *) * 2), tu->offset);
+		if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_NO_LEAD_PACE) {
+			seq_puts(m, "%nopace");
+			if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN)
+				seq_putc(m, ' ');
+		}
+		if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN)
+			seq_puts(m, "%multinop");
+	} else {
+		seq_printf(m, "%c:%s/%s %s:0x%0*lx", c,
+			   trace_probe_group_name(&tu->tp),
+			   trace_probe_name(&tu->tp), tu->filename,
+			   (int)(sizeof(void *) * 2), tu->offset);
+	}
 
 	if (tu->ref_ctr_offset)
 		seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
@@ -1107,9 +1241,26 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
 	struct inode *inode = d_real_inode(tu->path.dentry);
 	struct uprobe *uprobe;
+	struct file *file;
 
-	tu->consumer.filter = filter;
-	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
+	if (tu->is_ptwrite) {
+		if (filter) {
+			/* PTWRITE probes have no kernel entry to evaluate a filter. */
+			return -EINVAL;
+		}
+		file = dentry_open(&tu->path, O_RDONLY, current_cred());
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+		tu->ptwrite_desc.event_id =
+			trace_probe_event_call(&tu->tp)->event.type;
+		uprobe = uprobe_register_ptwrite(inode, file, tu->offset,
+						 &tu->consumer, &tu->ptwrite_desc);
+		fput(file);
+	} else {
+		tu->consumer.filter = filter;
+		uprobe = uprobe_register(inode, tu->offset,
+					 tu->ref_ctr_offset, &tu->consumer);
+	}
 	if (IS_ERR(uprobe))
 		return PTR_ERR(uprobe);
 
@@ -1148,6 +1299,28 @@ static int probe_event_enable(struct trace_event_call *call,
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
+	tu = container_of(tp, struct trace_uprobe, tp);
+
+	if (tu->is_ptwrite) {
+		if (filter || !file || file->filter)
+			return -EINVAL;
+		enabled = trace_probe_is_enabled(tp);
+		ret = trace_probe_add_file(tp, file);
+		if (ret < 0)
+			return ret;
+		if (enabled)
+			return 0;
+		list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
+			ret = trace_uprobe_enable(tu, NULL);
+			if (ret) {
+				__probe_event_disable(tp);
+				trace_probe_remove_file(tp, file);
+				return ret;
+			}
+		}
+		return 0;
+	}
+
 	enabled = trace_probe_is_enabled(tp);
 
 	/* This may also change "enabled" state */
@@ -1201,11 +1374,22 @@ static void probe_event_disable(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
 	struct trace_probe *tp;
+	struct trace_uprobe *tu;
 
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return;
 
+	tu = container_of(tp, struct trace_uprobe, tp);
+	if (tu->is_ptwrite) {
+		if (trace_probe_remove_file(tp, file) < 0)
+			return;
+		if (trace_probe_is_enabled(tp))
+			return;	/* other instances still enabled */
+		__probe_event_disable(tp);
+		return;
+	}
+
 	if (!trace_probe_is_enabled(tp))
 		return;
 
@@ -1493,6 +1677,13 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 }
 #endif	/* CONFIG_PERF_EVENTS */
 
+static bool ptwrite_event(struct trace_event_call *call)
+{
+	struct trace_uprobe *tu = trace_uprobe_primary_from_call(call);
+
+	return tu && tu->is_ptwrite;
+}
+
 static int
 trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 		      void *data)
@@ -1516,9 +1707,13 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 		return 0;
 
 	case TRACE_REG_PERF_OPEN:
+		if (ptwrite_event(event))
+			return -EINVAL;	/* no perf attach to ptwrite events */
 		return uprobe_perf_open(event, data);
 
 	case TRACE_REG_PERF_CLOSE:
+		if (ptwrite_event(event))
+			return -EINVAL;
 		return uprobe_perf_close(event, data);
 
 #endif
-- 
2.54.0

