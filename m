Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BE289E01
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035504; cv=none; b=FDNwYxvKCXHPllisaN4vWvIsZ+mv2xrAYTsFCvZv0FepSEIr3Dck4hbBhYnK85x9993R7v4myi1XgxEgJhz0I+Lt3076B46WJu8RjmbxhUfuJQeFsEJT/6T0L2rKztxD1aGR9NhDLXV0juBsRX3WFq4yt6ngCoTn2xLmT9DwLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035504; c=relaxed/simple;
	bh=HtEi870zwLq6ctFcnBRLp+ytP6nQssFq45sLuZd5sJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWEHS6h9aqItgDwDv8quACFOqz0uh2JTfXXg0q3DhbW+/n3N4ZiiNJmsQQjus1QRb1z5bEnBH9Q2gFACcHNRUBBrJlwiC3xpkwtRB5ajGBIL+jhg2Uorrz4XTPQxv2+tOnMvj562f3Y+0s4zPloIYXBQCCNyOLWRln5aEBbBWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwLixvBK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwLixvBK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a2b6c8ff2so146416a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035501; x=1746640301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QU4fF1ojZigMaeFSYqEf31ecZKLdrPKuyzN12ALOJyE=;
        b=dwLixvBK/mgYE9i8+2M55LRDSEgIpOqEXvEjc+1hzkGaOLZjn5Q2V+VfSbSm1mFCjt
         TY6DYZJpgumu2rgIOhDUOe4CFX/RO7HVUD+INn0tO5t27+f0AaazUaSG0pL1pgGmNZZ8
         0i0GdbSDmHzu1W99q5vemdFhAh+Js+vtMK+n0xHrcQl6dxRDpBOVbMfyNf8mSHslILCA
         9rSMpqzXZECcA39OEgxLS5I8stvEeqTX8G9IkOpHVAFBYg9kEuADlIsPtqeGtr+mMDuI
         2mLgOFO6gBp8dwC2ClQxrk0C84v6ttWIGik2oLxxhNYtj0IhyHyeUmCaKYcyqCcCzzQp
         71Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035501; x=1746640301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU4fF1ojZigMaeFSYqEf31ecZKLdrPKuyzN12ALOJyE=;
        b=KNEW9oTqdUWBzGtjdu516acfNp3qaeyIVTMf4cfBX+/dJ9GynwybjGUsR08Fx4ZsUf
         dd0z8xIpijpD+xpX+uSfdjiYR0bnvdVrkhkqoqlwDPTuBpFedgS+VXoYEIq4qfSNE34V
         YN6yvH1J/LqfYuHSqspo7H7L45WV1L3ngLJYMjjus+BS+I2V621juVG48DMEJspl9HpT
         FfvdzNn+x2wXiXQ765OM2EKUm6kH8JBcyXKbhAxXTvuAtkCAmH99glpEY+Nmys4U7whZ
         WY+aJRDsGSNUxKt+eV3hvtwtYrAzXy9soemdFkr+77/8WGNeVR9nAtS2FBXCKk2D6jNJ
         L6ew==
X-Forwarded-Encrypted: i=1; AJvYcCXemsLWLUc1iQCa6yiFe0kUZAfA6zrgrwjFGUxz2oGDOzlKjPqW50XWDETDHyMoZ/pQA5nTZUL83pRuuuw9RnC1@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFOMiMbOdd9YPiMPTRCUhqdIEshiZWZAJnYgsJiApLDu7C44E
	3FKngphDP0ipSC+j1hQqwctH0CKv4j+XgrPYgHMKtmhC4e/Etvw/gLHXze1MHTIYEepMYKk0Rg9
	1goD+rA==
X-Google-Smtp-Source: AGHT+IEyGPUBxMB6EpZfVFCzzx4iOi+6sy5uLJmR1hik9If22WqT2MHcyOSep4d8z+0agoaxbHwiyXwQLHex
X-Received: from pjk3.prod.google.com ([2002:a17:90b:5583:b0:2ef:7af4:5e8e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0d:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-30a3335ef40mr4881540a91.23.1746035501383; Wed, 30
 Apr 2025 10:51:41 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:10 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-23-irogers@google.com>
Subject: [PATCH v2 22/47] perf annotate: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c |  4 ++--
 tools/perf/util/annotate.c    | 22 +++++++++++-----------
 tools/perf/util/disasm.c      | 11 ++++++-----
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9833c2c82a2f..97943a12b6c9 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -157,7 +157,7 @@ static void process_branch_stack(struct branch_stack *bs, struct addr_location *
 	if (!bi)
 		return;
 
-	for (i = bs->nr - 1; i >= 0; i--) {
+	for (i = (int)bs->nr - 1; i >= 0; i--) {
 		/*
 		 * XXX filter against symbol
 		 */
@@ -880,7 +880,7 @@ int cmd_annotate(int argc, const char **argv)
 
 	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
-		return PTR_ERR(annotate.session);
+		return (int)PTR_ERR(annotate.session);
 
 	annotate.session->itrace_synth_opts = &itrace_synth_opts;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 264a212b47df..055f3da1b95b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -337,7 +337,8 @@ static int symbol__account_br_cntr(struct annotated_branch *branch,
 	unsigned int base = evsel__leader(evsel)->br_cntr_idx;
 	unsigned int off = offset * evsel->evlist->nr_br_cntr;
 	u64 *branch_br_cntr = branch->br_cntr;
-	unsigned int i, mask, width;
+	unsigned int i, width;
+	u64 mask;
 
 	if (!br_cntr || !branch_br_cntr)
 		return 0;
@@ -360,7 +361,7 @@ static int symbol__account_cycles(u64 addr, u64 start, struct symbol *sym,
 				  u64 br_cntr)
 {
 	struct annotated_branch *branch;
-	unsigned offset;
+	unsigned int offset;
 	int ret;
 
 	if (sym == NULL)
@@ -377,7 +378,7 @@ static int symbol__account_cycles(u64 addr, u64 start, struct symbol *sym,
 		if (start >= addr)
 			start = 0;
 	}
-	offset = addr - sym->start;
+	offset = (unsigned int)(addr - sym->start);
 	ret = __symbol__account_cycles(branch->cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
@@ -1563,7 +1564,7 @@ static int annotation__max_ins_name(struct annotation *notes)
 		if (al->offset == -1)
 			continue;
 
-		len = strlen(disasm_line(al)->ins.name);
+		len = (int)strlen(disasm_line(al)->ins.name);
 		if (max_name < len)
 			max_name = len;
 	}
@@ -2183,20 +2184,20 @@ static int annotation_options__add_disassemblers_str(struct annotation_options *
 {
 	while (str && *str != '\0') {
 		const char *comma = strchr(str, ',');
-		int len = comma ? comma - str : (int)strlen(str);
+		size_t len = comma ? (size_t)(comma - str) : strlen(str);
 		bool match = false;
 
 		for (u8 i = 0; i < ARRAY_SIZE(perf_disassembler__strs); i++) {
 			const char *dis_str = perf_disassembler__strs[i];
 
-			if (len == (int)strlen(dis_str) && !strncmp(str, dis_str, len)) {
+			if (len == strlen(dis_str) && !strncmp(str, dis_str, len)) {
 				annotation_options__add_disassembler(options, i);
 				match = true;
 				break;
 			}
 		}
 		if (!match) {
-			pr_err("Invalid disassembler '%.*s'\n", len, str);
+			pr_err("Invalid disassembler '%.*s'\n", (int)len, str);
 			return -1;
 		}
 		str = comma ? comma + 1 : NULL;
@@ -2406,7 +2407,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 			str++;
 	}
 
-	op_loc->offset = strtol(str, &p, 0);
+	op_loc->offset = (int)strtol(str, &p, 0);
 
 	p = strchr(p, arch->objdump.register_char);
 	if (p == NULL)
@@ -2516,8 +2517,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 				/* FIXME: Handle other segment registers */
 				if (!strncmp(insn_str, "%gs:", 4)) {
 					op_loc->segment = INSN_SEG_X86_GS;
-					op_loc->offset = strtol(insn_str + 4,
-								&p, 0);
+					op_loc->offset = (int)strtol(insn_str + 4, &p, 0);
 					if (p && p != insn_str + 4)
 						op_loc->imm = true;
 					continue;
@@ -2531,7 +2531,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			if (*s == arch->objdump.register_char)
 				op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
 			else if (*s == arch->objdump.imm_char) {
-				op_loc->offset = strtol(s + 1, &p, 0);
+				op_loc->offset = (int)strtol(s + 1, &p, 0);
 				if (p && p != s + 1)
 					op_loc->imm = true;
 			}
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 8f0eb56c6fc6..7e24851a3934 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -856,7 +856,7 @@ static int ins__cmp(const void *a, const void *b)
 
 static void ins__sort(struct arch *arch)
 {
-	const int nmemb = arch->nr_instructions;
+	const size_t nmemb = arch->nr_instructions;
 
 	qsort(arch->instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
@@ -864,7 +864,7 @@ static void ins__sort(struct arch *arch)
 static struct ins_ops *__ins__find(struct arch *arch, const char *name, struct disasm_line *dl)
 {
 	struct ins *ins;
-	const int nmemb = arch->nr_instructions;
+	const size_t nmemb = arch->nr_instructions;
 
 	if (arch__is(arch, "powerpc")) {
 		/*
@@ -1263,7 +1263,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	char *build_id_filename;
 	char *build_id_path = NULL;
 	char *pos;
-	int len;
+	size_t len;
 
 	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
@@ -1754,7 +1754,8 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 	u64 end = map__rip_2objdump(map, sym->end);
 	u64 len = end - start;
 	u64 offset;
-	int i, count;
+	int i;
+	ssize_t count;
 	u8 *buf = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
@@ -1823,7 +1824,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 
 out:
 	free(buf);
-	return count < 0 ? count : 0;
+	return count < 0 ? (int)count : 0;
 
 err:
 	count = -1;
-- 
2.49.0.906.g1f30a19c02-goog

