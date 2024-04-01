Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37279548E1
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Apr 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005782; cv=none; b=O2EVTOAZ2fk+EiomPlyPaKN2gu+A6L1Acw2v14HSAyKVoa/HyJRI2wjt8fnIe1W7cKTsPgYPudpOy11pCtrtj19+gk+WAh6AUGtzIe0LDLb/Z4NXY9RJyUbbISHQhD0LgHv/MTh1RL2Wrk0/GlxK6b0FYtkoUh8dt4bqTLAggJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005782; c=relaxed/simple;
	bh=Pr18TUxT/RGkBfSN4y1FU4Qj/IyOOGeTi1uM66NRAQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwdJYB1h23kaI+T1sxy4b7iNDGfMdXdH7KZMObsZuEgrW2XCdnnY33ytGwa/NA3wrTr/9VNl0YFnrMmeoGsjQE1L2EYojAnqGzc1VM3DDSuYaWrlUU55MLOqCZGtVq7SQaLdM9ccJ2c5mqEwBR9/fXLMK6284ThY9qYYZUgJ6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Si3eKaVc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Si3eKaVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712005780; x=1743541780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pr18TUxT/RGkBfSN4y1FU4Qj/IyOOGeTi1uM66NRAQ4=;
  b=Si3eKaVcgE3QDlvK/2h84eLpk0gpHp40szispP/QJQcrCY1K3OtoM80T
   VHxWd76TLGByJkzIZ2+x2ZqwfzY+o4cWff/ycnD85BPxR5mgI7Y7vBhmB
   CYf1pnnWevkJYYWuC/WDPW8NOpD3dnkLXOtf3EIm+di14dAtq3Cx7Wk05
   YaSVg4kzxEZfKZdymWBcIIrAcCygDlR5iB2bSMnNl8XajmuHwUyqXWlcU
   PaUtzhvYJTk9gpW5kHpOl3jd1Sx6Ovb7JIKimwyP5XjjdmCKK6RSe+Wba
   yPJIgfmrEo8vMb+PbpaE8drnbahw6SB1AwzsWotoCuSPgPnTgV8Ahjzyz
   g==;
X-CSE-ConnectionGUID: /TOjvVDHTS6ArMBkTXVQSA==
X-CSE-MsgGUID: JlAhj6bwTGuE5pUgoNnD8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7015551"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7015551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="55283633"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:09:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 3/3] perf script: Consolidate capstone print functions
Date: Mon,  1 Apr 2024 14:08:05 -0700
Message-ID: <20240401210925.209671-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401210925.209671-1-ak@linux.intel.com>
References: <20240401210925.209671-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

Consolidate capstone print functions, to reduce duplication. Amend call
sites to use a file pointer for output, which is consistent with most
perf tools print functions. Add print_opts with an option to print also
the hex value of a resolved symbol+offset.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c  |  43 ++++++++++-----
 tools/perf/util/print_insn.c | 103 ++++++++++++-----------------------
 tools/perf/util/print_insn.h |   7 ++-
 3 files changed, 67 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3acc0b79e988..d8a3d2bde46a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1165,18 +1165,29 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 	return ret;
 }
 
-static const char *any_dump_insn(struct perf_event_attr *attr __maybe_unused,
-			struct perf_insn *x, uint64_t ip,
-			u8 *inbuf, int inlen, int *lenp)
+static int any_dump_insn(struct perf_event_attr *attr __maybe_unused,
+			 struct perf_insn *x, uint64_t ip,
+			 u8 *inbuf, int inlen, int *lenp,
+			 FILE *fp)
 {
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	if (PRINT_FIELD(BRSTACKDISASM)) {
-		const char *p = cs_dump_insn(x, ip, inbuf, inlen, lenp);
-		if (p)
-			return p;
+		int printed = fprintf_insn_asm(x->machine, x->thread, x->cpumode, x->is64bit,
+					       (uint8_t *)inbuf, inlen, ip, lenp,
+					       PRINT_INSN_IMM_HEX, fp);
+
+		if (printed > 0)
+			return printed;
 	}
 #endif
-	return dump_insn(x, ip, inbuf, inlen, lenp);
+	return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp));
+}
+
+static int add_padding(FILE *fp, int printed, int padding)
+{
+	if (printed >= 0 && printed < padding)
+		printed += fprintf(fp, "%*s", padding - printed, "");
+	return printed;
 }
 
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
@@ -1186,8 +1197,10 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct thread *thread)
 {
 	int ilen = 0;
-	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
-			      any_dump_insn(attr, x, ip, inbuf, len, &ilen));
+	int printed = fprintf(fp, "\t%016" PRIx64 "\t", ip);
+
+	printed += add_padding(fp, any_dump_insn(attr, x, ip, inbuf, len, &ilen, fp), 30);
+	printed += fprintf(fp, "\t");
 
 	if (PRINT_FIELD(BRSTACKINSNLEN))
 		printed += fprintf(fp, "ilen: %d\t", ilen);
@@ -1330,8 +1343,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				break;
 			} else {
 				ilen = 0;
-				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
-						   any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen));
+				printed += fprintf(fp, "\t%016" PRIx64 "\t", ip);
+				printed += any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen, fp);
 				if (PRINT_FIELD(BRSTACKINSNLEN))
 					printed += fprintf(fp, "\tilen: %d", ilen);
 				printed += fprintf(fp, "\n");
@@ -1378,8 +1391,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		if (len <= 0)
 			goto out;
 		ilen = 0;
-		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
-			any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen));
+		printed += fprintf(fp, "\t%016" PRIx64 "\t", sample->ip);
+		printed += any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen, fp);
 		if (PRINT_FIELD(BRSTACKINSNLEN))
 			printed += fprintf(fp, "\tilen: %d", ilen);
 		printed += fprintf(fp, "\n");
@@ -1389,8 +1402,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	}
 	for (off = 0; off <= end - start; off += ilen) {
 		ilen = 0;
-		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
-				   any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen));
+		printed += fprintf(fp, "\t%016" PRIx64 "\t", start + off);
+		printed += any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen, fp);
 		if (PRINT_FIELD(BRSTACKINSNLEN))
 			printed += fprintf(fp, "\tilen: %d", ilen);
 		printed += fprintf(fp, "\n");
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 8825330d435f..931a2c5293c9 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -72,59 +72,8 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
 	return 0;
 }
 
-static void dump_insn_x86(struct thread *thread, cs_insn *insn, struct perf_insn *x)
-{
-	struct addr_location al;
-	bool printed = false;
-
-	if (insn->detail && insn->detail->x86.op_count == 1) {
-		cs_x86_op *op = &insn->detail->x86.operands[0];
-
-		addr_location__init(&al);
-		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, x->cpumode, op->imm, &al) &&
-		    al.sym &&
-		    al.addr < al.sym->end) {
-			snprintf(x->out, sizeof(x->out), "%s %s+%#" PRIx64 " [%#" PRIx64 "]", insn[0].mnemonic,
-					al.sym->name, al.addr - al.sym->start, op->imm);
-			printed = true;
-		}
-		addr_location__exit(&al);
-	}
-
-	if (!printed)
-		snprintf(x->out, sizeof(x->out), "%s %s", insn[0].mnemonic, insn[0].op_str);
-}
-
-const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
-			 u8 *inbuf, int inlen, int *lenp)
-{
-	int ret;
-	int count;
-	cs_insn *insn;
-	csh cs_handle;
-
-	ret = capstone_init(x->machine, &cs_handle, x->is64bit);
-	if (ret < 0)
-		return NULL;
-
-	count = cs_disasm(cs_handle, (uint8_t *)inbuf, inlen, ip, 1, &insn);
-	if (count > 0) {
-		if (machine__normalized_is(x->machine, "x86"))
-			dump_insn_x86(x->thread, &insn[0], x);
-		else
-			snprintf(x->out, sizeof(x->out), "%s %s",
-					insn[0].mnemonic, insn[0].op_str);
-		*lenp = insn->size;
-		cs_free(insn, count);
-	} else {
-		return NULL;
-	}
-	return x->out;
-}
-
-static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
-			     cs_insn *insn, FILE *fp)
+static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
+			     int print_opts, FILE *fp)
 {
 	struct addr_location al;
 	size_t printed = 0;
@@ -134,9 +83,11 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
 
 		addr_location__init(&al);
 		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
+		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
 			printed += fprintf(fp, "%s ", insn[0].mnemonic);
 			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
+			if (print_opts & PRINT_INSN_IMM_HEX)
+				printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
 			addr_location__exit(&al);
 			return printed;
 		}
@@ -159,39 +110,53 @@ static bool is64bitip(struct machine *machine, struct addr_location *al)
 		machine__normalized_is(machine, "s390");
 }
 
-size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
-				struct machine *machine, FILE *fp,
-				struct addr_location *al)
+ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
+			 bool is64bit, const uint8_t *code, size_t code_size,
+			 uint64_t ip, int *lenp, int print_opts, FILE *fp)
 {
-	csh cs_handle;
+	size_t printed;
 	cs_insn *insn;
+	csh cs_handle;
 	size_t count;
-	size_t printed = 0;
 	int ret;
-	bool is64bit = is64bitip(machine, al);
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
 	ret = capstone_init(machine, &cs_handle, is64bit);
-	if (ret < 0) {
-		/* fallback */
-		return sample__fprintf_insn_raw(sample, fp);
-	}
+	if (ret < 0)
+		return ret;
 
-	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
-			  sample->ip, 1, &insn);
+	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
 		if (machine__normalized_is(machine, "x86"))
-			printed += print_insn_x86(sample, thread, &insn[0], fp);
+			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
 		else
-			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+		if (lenp)
+			*lenp = insn->size;
 		cs_free(insn, count);
 	} else {
-		printed += fprintf(fp, "illegal instruction");
+		printed = -1;
 	}
 
 	cs_close(&cs_handle);
 	return printed;
 }
+
+size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
+				struct machine *machine, FILE *fp,
+				struct addr_location *al)
+{
+	bool is64bit = is64bitip(machine, al);
+	ssize_t printed;
+
+	printed = fprintf_insn_asm(machine, thread, sample->cpumode, is64bit,
+				   (uint8_t *)sample->insn, sample->insn_len,
+				   sample->ip, NULL, 0, fp);
+	if (printed < 0)
+		return sample__fprintf_insn_raw(sample, fp);
+
+	return printed;
+}
 #else
 size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
 				struct thread *thread __maybe_unused,
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index c2a6391a45ce..07d11af3fc1c 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -10,10 +10,13 @@ struct thread;
 struct machine;
 struct perf_insn;
 
+#define PRINT_INSN_IMM_HEX		(1<<0)
+
 size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
 				struct machine *machine, FILE *fp, struct addr_location *al);
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
-const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
-                         u8 *inbuf, int inlen, int *lenp);
+ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
+			 bool is64bit, const uint8_t *code, size_t code_size,
+			 uint64_t ip, int *lenp, int print_opts, FILE *fp);
 
 #endif /* PERF_PRINT_INSN_H */
-- 
2.44.0

