Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CDB51E441;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188835; cv=none; b=UDf1cao858RVZeLBYoLebxfMLYoirRReTnV22NYUJriGy0bFxnlDzmVQxPkef9IcSuP0OkOIiPhcI6QEJM4RbCf8ScHqgaz/Z+pDtOKYN230XqyKfUCzQ1H9SFFVI1xOFs0no+9JDBV6aBgcHKELXit89iuTDSoqFSEtmkTtDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188835; c=relaxed/simple;
	bh=tCuBz2tow3wSwKOTr7sRMMWOK1i4uX9Aa7ctKXhqzOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhvFyVjmxP8CtG7xDpdE4a9qAPu5Vjt5H5IWu33j1NlGhdonORvBWYhVFsK4vABLQS1rwwA6eTqf9AQz2kkhBUqbyoeAse7iMFhPfhKirIvl0vfNDMd6L92iuCF5KjrzSmybT3pGmT2HJm/RkpTmO2xUJxSKb9ppFyYWKffw108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id C6E1C63F8C;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 19B2F162293; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
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
Subject: [RFC v1 11/19] ptwrite uprobes: Add multinop support
Date: Mon, 31 Aug 2026 08:04:47 -0700
Message-ID: <20260831150651.1134594-12-ak@kernel.org>
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

GCC's -fpatchable-function-entry=5 may emit five one-byte NOPs. Normally
that's not safe to patch because some might jump into a later nop.
But for the gcc case it's safe because nobody jumps into the nops.
Add a %multinop that allows the user opting into patching these sites.
This way patching for the gcc instrumentation works.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/uprobes.h               |  1 +
 arch/x86/kernel/uprobes.c                    |  4 +-
 include/linux/uprobes.h                      |  1 +
 kernel/trace/trace_uprobe.c                  | 42 ++++++++++++++------
 samples/uprobe-ptwrite/uprobe_ptwrite_test.c |  6 +++
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index efffdc44f00a..4fc98eafbd5a 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -50,6 +50,7 @@ struct uprobe_ptwrite_arch {
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
 	u16	ft_off;	/* fault table offset within the block (0 if none) */
 	u8	nft;		/* number of fault entries */
+	u8	allow_nop_run;	/* accept a five-byte run of 0x90 */
 };
 
 /* Per-mm page holding generated ptwrite stub blocks (mirrors trampolines). */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 90e702a4a8e9..e17e0397eaae 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1401,7 +1401,8 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		return -EINVAL;
 	if (desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
 		return -E2BIG;
-	if (desc->flags & ~UPROBE_PTWRITE_FL_ALLOW_MEM)
+	if (desc->flags & ~(UPROBE_PTWRITE_FL_ALLOW_MEM |
+			     UPROBE_PTWRITE_FL_ALLOW_NOP_RUN))
 		return -EINVAL;
 
 	/* The generic registration path copied these bytes before this hook. */
@@ -1567,6 +1568,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	ptw->ndata = 1 + n_imm + (n_mem ? 1 : 0);
 	ptw->ft_off = n_mem ? ft_off : 0;
 	ptw->nft = n_mem;
+	ptw->allow_nop_run = !!(desc->flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN);
 	return 0;
 }
 #undef PTW_NEED
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index c0d189bef8bd..b93ab24173c7 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -210,6 +210,7 @@ enum uprobe_ptwrite_src {
 
 /* uprobe_ptwrite_desc.flags */
 #define UPROBE_PTWRITE_FL_ALLOW_MEM	BIT(0) /* SRC_MEM args enabled */
+#define UPROBE_PTWRITE_FL_ALLOW_NOP_RUN	BIT(2) /* accept five 1-byte NOPs */
 
 struct uprobe_ptwrite_arg {
 	u8	src;		/* enum uprobe_ptwrite_src */
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c457c89afd73..b54cc2057329 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -645,6 +645,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	enum probe_print_type ptype;
 	bool is_return = false;
 	bool is_ptwrite = false;
+	bool is_nop_run = false;
 	int i, ret, arg_start = 2;
 
 	ref_ctr_offset = 0;
@@ -670,12 +671,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	trlog = trace_probe_log_init("trace_uprobe", argc, argv);
 
-	if (argc - 2 > MAX_TRACE_ARGS ||
-	    (is_ptwrite && argc - 2 > UPROBE_PTWRITE_MAX_ARGS)) {
-		trace_probe_log_set_index(2);
-		trace_probe_log_err(0, TOO_MANY_ARGS);
-		return -E2BIG;
-	}
 
 	if (is_ptwrite)
 		event = argv[0][4] ? &argv[0][4] : NULL;	/* after "ptw:" */
@@ -738,8 +733,13 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	/* Check if there is %return suffix */
 	tmp = strchr(arg, '%');
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
@@ -756,6 +756,19 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		trace_probe_log_err(arg - filename, BAD_UPROBE_OFFS);
 		return ret;
 	}
+	if (is_ptwrite) {
+		while (arg_start < argc && !strcmp(argv[arg_start], "%multinop")) {
+			is_nop_run = true;
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
@@ -791,8 +804,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		kfree(tail);
 	}
 
-	argc -= 2;
-	argv += 2;
+	argc -= arg_start;
+	argv += arg_start;
 
 	tu = alloc_trace_uprobe(group, event, argc, is_return);
 	if (IS_ERR(tu)) {
@@ -815,7 +828,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
-		trace_probe_log_set_index(i + 2);
+		trace_probe_log_set_index(i + arg_start);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
 		if (ret)
 			return ret;
@@ -823,13 +836,14 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
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
 		for (i = 0; i < argc; i++) {
 			ret = ptwrite_compile_arg(tu, i);
 			if (ret) {
@@ -888,6 +902,8 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 			   trace_probe_group_name(&tu->tp),
 			   trace_probe_name(&tu->tp), tu->filename,
 			   (int)(sizeof(void *) * 2), tu->offset);
+		if (tu->ptwrite_desc.flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN)
+			seq_puts(m, "%multinop");
 	} else
 		seq_printf(m, "%c:%s/%s %s:0x%0*lx", c,
 			   trace_probe_group_name(&tu->tp),
diff --git a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
index 5eafc26104ad..b09521e5cd16 100644
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
@@ -35,6 +36,10 @@ static ushort event_id = 0x1234;
 module_param(event_id, ushort, 0444);
 MODULE_PARM_DESC(event_id, "event id carried in the PTW header word");
 
+static bool allow_nop_run;
+module_param(allow_nop_run, bool, 0444);
+MODULE_PARM_DESC(allow_nop_run, "accept five one-byte NOPs at the site");
+
 static char *args = "r0";
 module_param(args, charp, 0444);
 MODULE_PARM_DESC(args, "comma-separated args: r<N> GPR, i<hex> immediate, m<N>[:disp][:4|8] memory");
@@ -151,6 +156,7 @@ static int __init uprobe_ptwrite_test_init(void)
 	int ret;
 
 	desc.event_id = event_id;
+	desc.flags = allow_nop_run ? UPROBE_PTWRITE_FL_ALLOW_NOP_RUN : 0;
 	ret = parse_probe_args();
 	if (ret)
 		return ret;
-- 
2.54.0

