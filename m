Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20A29551F
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035522; cv=none; b=NKViQUlqi9YAPKQlGJCyqp0K9G39yCurCUSEL9sN8/j34I4OJ6UY6cGHufs2B2FACmXT6/qq3SdS/CEafuHB1otaLPi0WSqofMQ3D5uwg2xF6DSoL4kE0Xagt5uYddFcu8wzBUtr2hTajtn4xoAwLklxzQ+T95QIBbDxSWBEj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035522; c=relaxed/simple;
	bh=r5dyt7WULPT6TwZ8GkpsBnLtWgUyrYqxUVqGjZbdg6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3TdnGFSsSxcxAWG7w1IKO/ipre+lkqG0wqL11nfLlYXZ7d7yZgzNhfcwF2eQRzQOGx9aODym/ROQ83gvd6/WUnd43fPqBnADNEDOQC4MS+rUxt7BxzaQ7RkQuA07t0vR5rbrRMQlD7jvEYU/AKQoDurVJvz/4qCtN0FQSsACVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1x4GAmn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1x4GAmn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso128940a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035520; x=1746640320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJDGTrAXLYH4hGYuUKjDOU1yDsQb9jT4XvyOCJsmDmM=;
        b=W1x4GAmngPuGTP7IiWCW++sEJyV8+Oe/ypwtj874SmF7gSWWFjy1wmsxElHezznrbu
         W7qsuNuKdkZX4Pc9vkgABJhea2joFiJxu3M1G8zGW8B7VknoHETTONrWac3D5dWepPIo
         /NA/Q4IhF765DWja1olx14LhqWpKNdhDkAJf5mKaNU4nB2Ymm9DHnaQyYh9WE7nF669t
         BdF9a/1lmPjJOw+3XYb4tPwe0Rk+5SKmEXf6FmnrbkKHQQcrTR9dg2lLyOpjfUETIej7
         Qx4t6MhWEXEmET6FZaq8YDtprKSJ/jtTINNe4Rq12LfvYGrRvvA6Cjyw9mq+mBWru23n
         voCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035520; x=1746640320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJDGTrAXLYH4hGYuUKjDOU1yDsQb9jT4XvyOCJsmDmM=;
        b=vybnVabWh/gIuH5RnbWYIxBlLytv6tlKnGlrj5a5erauJvqFocX8yLr/aiyZI3zGU1
         zUgjg93tdCwjDhHK9okweNSNy5NQVQ+1yVbuKY95Dbw9mtliKNwHtvKWeLpCH2mOrrrB
         QKAMa8mtiwt/XxizhESJeDyGdxhwkKnAFd7nNbAuRtmrbwUKMJLGAK4xjIO7p5n7hB3n
         t6jTl7c03YZsbVS/Ttq9oDMYBJRA/oa+yRikZZVq0k6tQTeljQFt+lMz+7kxljq1fEd9
         JCSt35EKSSGIwWycyT3LNgScDc547x5ZKPbfH2cvudm0LVq1ZYCMfXLIkE4DYMn4eI8s
         nDBg==
X-Forwarded-Encrypted: i=1; AJvYcCWQqCu8HchTlUomvpdyyGnqP4t8mXifVwNwY01TweJG4hRKDtvHmNcBfI8jPYY9gDgblbxwAxwnQpl/95UDKlRS@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL28YAuyDR5hs6GtXLcN9oJ6+XL+2PWTmpjRDqfFPeP7SuYYy
	yw7t00Y9NiLCbgD3sGpOtA0rA6LuMIo8eocwecvAzcHFaRDrJbvqAMYr0w0amDfR+KyZeLTPALT
	99Vh8Dw==
X-Google-Smtp-Source: AGHT+IGpMdCcZwC8lu20bnUel1JwqffOM2cVPf2gSFSm5sX+qsnG32WRPx6BVsGF8ae+jTxBwJ7hUdoImMJ7
X-Received: from pjbee6.prod.google.com ([2002:a17:90a:fc46:b0:2ff:852c:ceb8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548f:b0:2fe:8282:cb9d
 with SMTP id 98e67ed59e1d1-30a33359527mr5858439a91.28.1746035519920; Wed, 30
 Apr 2025 10:51:59 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:19 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-32-irogers@google.com>
Subject: [PATCH v2 31/47] perf script: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-script.c    | 39 ++++++++++++++++++----------------
 tools/perf/util/print_binary.c | 13 ++++++------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9b16df881af8..bb997f2ceb62 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -724,7 +724,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, const char *arch,
 				     FILE *fp)
 {
-	unsigned i = 0, r;
+	size_t i = 0, r;
 	int printed = 0;
 
 	if (!regs || !regs->regs)
@@ -734,7 +734,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, cons
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, arch), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name((int)r, arch), val);
 	}
 
 	return printed;
@@ -1150,7 +1150,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	if (len <= 0)
 		pr_debug("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
 			start, end);
-	ret = len;
+	ret = (int)len;
 out:
 	addr_location__exit(&al);
 	return ret;
@@ -1270,7 +1270,8 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 
 	if (PRINT_FIELD(BRCNTR)) {
 		struct evsel *pos = evsel__leader(evsel);
-		unsigned int i = 0, j, num, mask, width;
+		unsigned int i = 0, width;
+		size_t mask, num;
 
 		perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
 		mask = (1L << width) - 1;
@@ -1283,10 +1284,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 
 			num = (br_cntr >> (i++ * width)) & mask;
 			if (!verbose) {
-				for (j = 0; j < num; j++)
+				for (size_t j = 0; j < num; j++)
 					printed += fprintf(fp, "%s", pos->abbr_name);
-			} else
-				printed += fprintf(fp, "%s %d ", pos->name, num);
+			} else {
+				printed += fprintf(fp, "%s %zu ", pos->name, num);
+			}
 		}
 		printed += fprintf(fp, "\t");
 	}
@@ -1328,9 +1330,9 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 		goto out;
 
 	if (al.addr < al.sym->end)
-		off = al.addr - al.sym->start;
+		off = (int)(al.addr - al.sym->start);
 	else
-		off = al.addr - map__start(al.map) - al.sym->start;
+		off = (int)(al.addr - map__start(al.map) - al.sym->start);
 	printed += fprintf(fp, "\t%s", al.sym->name);
 	if (off)
 		printed += fprintf(fp, "%+d", off);
@@ -1365,7 +1367,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 	if (!(br && br->nr))
 		return 0;
-	nr = br->nr;
+	nr = (int)br->nr;
 	if (max_blocks && nr > max_blocks + 1)
 		nr = max_blocks + 1;
 
@@ -1645,14 +1647,14 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 static int perf_sample__fprintf_ipc(struct perf_sample *sample,
 				    struct evsel *evsel, FILE *fp)
 {
-	unsigned int ipc;
+	u64 ipc;
 
 	if (!PRINT_FIELD(IPC) || !sample->cyc_cnt || !sample->insn_cnt)
 		return 0;
 
 	ipc = (sample->insn_cnt * 100) / sample->cyc_cnt;
 
-	return fprintf(fp, " \t IPC: %u.%02u (%" PRIu64 "/%" PRIu64 ") ",
+	return fprintf(fp, " \t IPC: %" PRIu64 ".%02" PRIu64 " (%" PRIu64 "/%" PRIu64 ") ",
 		       ipc / 100, ipc % 100, sample->insn_cnt, sample->cyc_cnt);
 }
 
@@ -2036,7 +2038,7 @@ static int evlist__max_name_len(struct evlist *evlist)
 	int max = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
-		int len = strlen(evsel__name(evsel));
+		int len = (int)strlen(evsel__name(evsel));
 
 		max = MAX(len, max);
 	}
@@ -2147,7 +2149,7 @@ static bool show_event(struct perf_sample *sample,
 		       struct addr_location *al,
 		       struct addr_location *addr_al)
 {
-	int depth = thread_stack__depth(thread, sample->cpu);
+	int depth = (int)thread_stack__depth(thread, sample->cpu);
 
 	if (!symbol_conf.graph_function)
 		return true;
@@ -2163,13 +2165,14 @@ static bool show_event(struct perf_sample *sample,
 		u64 ip;
 		const char *name = resolve_branch_sym(sample, evsel, thread, al, addr_al,
 				&ip);
-		unsigned nlen;
+		size_t nlen;
 
 		if (!name)
 			return false;
 		nlen = strlen(name);
 		while (*s) {
-			unsigned len = strcspn(s, ",");
+			size_t len = strcspn(s, ",");
+
 			if (nlen == len && !strncmp(name, s, len)) {
 				thread__set_filter(thread, true);
 				thread__set_filter_entry_depth(thread, depth);
@@ -2952,7 +2955,7 @@ static int parse_scriptname(const struct option *opt __maybe_unused,
 {
 	char spec[PATH_MAX];
 	const char *script, *ext;
-	int len;
+	size_t len;
 
 	if (strcmp(str, "lang") == 0) {
 		list_available_languages();
@@ -4097,7 +4100,7 @@ int cmd_script(int argc, const char **argv)
 	script.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	if (header || header_only) {
 		script.tool.show_feat_hdr = SHOW_FEAT_HEADER;
diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
index 13fdc51c61d9..6894fb5e7865 100644
--- a/tools/perf/util/print_binary.c
+++ b/tools/perf/util/print_binary.c
@@ -7,8 +7,7 @@ int binary__fprintf(unsigned char *data, size_t len,
 		    size_t bytes_per_line, binary__fprintf_t printer,
 		    void *extra, FILE *fp)
 {
-	size_t i, j, mask;
-	int printed = 0;
+	size_t mask, printed = 0;
 
 	if (!printer)
 		return 0;
@@ -17,7 +16,7 @@ int binary__fprintf(unsigned char *data, size_t len,
 	mask = bytes_per_line - 1;
 
 	printed += printer(BINARY_PRINT_DATA_BEGIN, 0, extra, fp);
-	for (i = 0; i < len; i++) {
+	for (unsigned int i = 0; i < len; i++) {
 		if ((i & mask) == 0) {
 			printed += printer(BINARY_PRINT_LINE_BEGIN, -1, extra, fp);
 			printed += printer(BINARY_PRINT_ADDR, i, extra, fp);
@@ -26,19 +25,19 @@ int binary__fprintf(unsigned char *data, size_t len,
 		printed += printer(BINARY_PRINT_NUM_DATA, data[i], extra, fp);
 
 		if (((i & mask) == mask) || i == len - 1) {
-			for (j = 0; j < mask-(i & mask); j++)
+			for (unsigned int j = 0; j < mask-(i & mask); j++)
 				printed += printer(BINARY_PRINT_NUM_PAD, -1, extra, fp);
 
 			printer(BINARY_PRINT_SEP, i, extra, fp);
-			for (j = i & ~mask; j <= i; j++)
+			for (unsigned int j = i & ~mask; j <= i; j++)
 				printed += printer(BINARY_PRINT_CHAR_DATA, data[j], extra, fp);
-			for (j = 0; j < mask-(i & mask); j++)
+			for (unsigned int j = 0; j < mask-(i & mask); j++)
 				printed += printer(BINARY_PRINT_CHAR_PAD, i, extra, fp);
 			printed += printer(BINARY_PRINT_LINE_END, -1, extra, fp);
 		}
 	}
 	printed += printer(BINARY_PRINT_DATA_END, -1, extra, fp);
-	return printed;
+	return (int)printed;
 }
 
 int is_printable_array(char *p, unsigned int len)
-- 
2.49.0.906.g1f30a19c02-goog

