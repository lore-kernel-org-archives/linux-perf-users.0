Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAC2222D2
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531925; cv=none; b=Yi1TFqNYnjuG3XHqN66tLIP30SNf2aQxPfciPn/vj93vvbp2FDxU+dFM+u3vlZOGPwCftAV1uAfFheW9si+ZQiINxZt2K9PE6WXQOcezvPGz1f8jdrIxUuP/OZL8eLcbw98oeZ620Pf+lAUMwf+L75gut6iOurHhYwa+WUwGR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531925; c=relaxed/simple;
	bh=t4HpEKSieHMVUwdEDlATrqBNHL+SdNbdZvpQJmyECXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R/baiCA4AISL9Kkn2Fn751QSfBRzl5/fmhyJb5IOVsAZcttHIBYgoobsiD59LOq6gexEZp+Z40ZpGim5ZKZ8t4Bnc4AuPa81KRA0FXUwnE2s+ttG/WGRKbOEYNp4Lwut1T3IXk3D3w9tPOBqHLC9ZcLlLOPQUrIQkzG56K02fG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDTy+s3f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDTy+s3f"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224347aef79so160799065ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531923; x=1744136723; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=823XinDHeG+XrMmCNIY0vqG2lfpNgcB8RbHYxnOFvTw=;
        b=eDTy+s3fzmOm8hepPkwF8/U42Jjv4qDw39kiYqJlcYvqH8LhvzNdqR938TXElFVRqs
         JK3FFkgHjzIiGPs9uPj/XWo2uZvL0mjQg3wZcWWEzdVJUlZAFr0ucQJnBF8RiEZ95h3B
         uuIAdQWip6ekK0iI+I0j6Zh6myRO28zHqHFx1Jd8FjSN8FBLU2ko4p8qibuZWufBv0Ic
         osEUR1M0q4pz/Bjvvs+e47onnkDW+MNE/pgUQU+kUGSlYawuC0dLRmZcil5m7OHMRJqI
         dp3/1soK6qMWROgXV8RnuQ6EjfRUB9sEQBWT2xWQ5xhXqoIBHEcZZjDVP4GjwsdAo6ed
         PcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531923; x=1744136723;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=823XinDHeG+XrMmCNIY0vqG2lfpNgcB8RbHYxnOFvTw=;
        b=tLi7UdBwmDNUK0cWbiqMTsI9HjCEKEsLaUgiXbI9WlHYkRvv+EN7+jNfZHA4ufM815
         IvdTT4S2jJWZZrvybWbziXRnWY1z/ftE1vnMXYEAK4QkjzCk1RVG7bxWQLY2sR5jBRSH
         lu6YhgXwitJlNJqtK4zo1JZSl+yfGHtFbQatCUtUiWyBzFU7kaxyOxEKgSv0EF9UoVFp
         4q8XWxiz5irprxIgg82SXVsHG8JW8dFY0lFQDSPuVl20jckqWzQdBiUkwL8LwCzgQaWN
         JfG+QljWB88X6BoHOOCuCOlZ0QTrHpkioK2jYwsURaYm952Dq/ErC7hsqUNRcmeKBeFO
         IZSA==
X-Forwarded-Encrypted: i=1; AJvYcCVBOmD1ZtFaYCK1Fq8I4CAuAKWmGKao40Jo+UiE7YgPooeanQ4iWpPRhJDiGA7KfyUKPI/z+9pKuIJOVZqXMzGF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yfApbH7RyNfa85IeWVzVjOHZFJoh+jhYiuTOljRBdgOCNZLd
	CEJNltXZ6Cdj8KiyyOJqneoaMS0+EjuxtLAPsTH5XxCMXz8Or5tJlX4KzT321AyxdZl9b0QvfV1
	DfOZl5A==
X-Google-Smtp-Source: AGHT+IHEy9LXSmI9P8wsEmOpH7R+FJ1KOlnv6WssH2meAhH8o5gBcQQpgs70KPc3GeKjqcWiFTxuiUNmdeE4
X-Received: from plgb17.prod.google.com ([2002:a17:902:d511:b0:223:faee:f527])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da91:b0:220:f795:5f14
 with SMTP id d9443c01a7336-2292f974a45mr190872445ad.27.1743531922818; Tue, 01
 Apr 2025 11:25:22 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:21 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-24-irogers@google.com>
Subject: [PATCH v1 23/48] perf annotate: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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
index 1e59b9e5339d..c582e0ecb86f 100644
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
+		size_t len = comma ? comma - str : strlen(str);
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
@@ -2405,7 +2406,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 			str++;
 	}
 
-	op_loc->offset = strtol(str, &p, 0);
+	op_loc->offset = (int)strtol(str, &p, 0);
 
 	p = strchr(p, arch->objdump.register_char);
 	if (p == NULL)
@@ -2515,8 +2516,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 				/* FIXME: Handle other segment registers */
 				if (!strncmp(insn_str, "%gs:", 4)) {
 					op_loc->segment = INSN_SEG_X86_GS;
-					op_loc->offset = strtol(insn_str + 4,
-								&p, 0);
+					op_loc->offset = (int)strtol(insn_str + 4, &p, 0);
 					if (p && p != insn_str + 4)
 						op_loc->imm = true;
 					continue;
@@ -2530,7 +2530,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
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
2.49.0.504.g3bcea36a83-goog

