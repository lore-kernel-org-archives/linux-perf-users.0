Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA53220F5A
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086291; cv=none; b=ab6qg9fJiSy/ddhJQpGhHovtTOIHxS39ZtUi8pQrxidjZWHqP6H4hI7+54lru+IrJ3rxlG7OMUJPntH9nmjpqNo3l89OUf8MjDAenxZ+EpIoNiOrySgRMnSABNE1a+ld0yOLCVxi00Ee+TId30GgHLKoZd8Dx8RVPZRbcDuANmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086291; c=relaxed/simple;
	bh=xqmvalg+u4nxOm2xePsnh49T1VypsVG5YhQTwsTcUAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=I80/dl8rrPfq5EA9HCyphyknE1Gtz7nMbRADFsElpcf8AanHeIv8rrFss7NH/hEFD+/Ke23i+FC6MQd7dWHFzl99KpqiHcwcH9GTGJ1ijF7nuHrtY+Qsa0cou5SsgiNYV9TYbLY1ozp1Yq1momib7fapwdCDXvCrFjdaHZgUSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Clzktt/G; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Clzktt/G"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0f807421c9so1955505a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086289; x=1751691089; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqNYOJJr7TdYpxM37GBRppdBcCl0XQUl/XgR+B47l2U=;
        b=Clzktt/GzFp1j82K2oRYVrlRJ1il3YXnKla+axBZgHkzJCaxcxSe8XD7DzasWD0IK0
         cCwhoZHSclwlOpBs1W0XDTSrTbzJUVcN35CXrbl67JEaX9Jhu6b8pbvoLnFFvBRos8ak
         0FOchiMY+ZhqGFizJEsS4IoVRWprKGbvjFhuct2a3nSachyXUbMsHfodu3XgItnAUqQ4
         Rvc4RpKjXB+t0xKWBniygL00oq1Pn4xFRjENYwmcLma/w9Xl9t0azYxJWoYmRhhdCIRK
         am+7GGKDadaFGuZdghnHJXwyOOMraYVn2frvtlr11UDYkZsCVju4INmSRT5MidBtCbo6
         NpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086289; x=1751691089;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqNYOJJr7TdYpxM37GBRppdBcCl0XQUl/XgR+B47l2U=;
        b=M2LxXHeRTgrtZcbtgNr5+BvHLkq2J8ZaJHS/qPjx9tV8MarmGnNrSdyaL+5tOtHp3g
         wbcaOFEA3Bn7t1c2FrCwZur3bQwBn5MXHsnxEgrMNlH9z/j8UORLhjxPmAqNr2oXFViH
         tPJPfeS0eagKuFZwZPc2k3Zo2n14JIl40v6nyf2ll7l0SI8ysqG6ntr8g2MJw7HlbrOJ
         Jfs6FySRstKCHcmuMY48VLtG6JEQz/a+CLEb015DRp6JywpvmxineylX0TDnHDX9kF3B
         /T4IACZtuFZLXGoRRsHNDRG5RhzIG9juQ0789nagTbSH192ilirdai3SC6ltzES7yO5g
         Ma9w==
X-Forwarded-Encrypted: i=1; AJvYcCXSB8rIdubaXa9Ic9b/RxTrUJvRdquVcKBdZMUPISaq+qFlJzwVwoApaipW3NBRqA5fYFcWEeJStWXupsMcR+Tp@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfjXKerYeuKcWDSW3pLCena4zKP8Ip2TAYAn80BU3wuP+YjhF
	7HPiUs9i6F9DhFctI9DOgDkyO+hd6pM7mWSt+8OKegvUk0DutvtpUUSc+jRlOaYlc9cPXZ6AVXh
	LIhasdLPPfg==
X-Google-Smtp-Source: AGHT+IFaE6w9PzRkniqIOCgT0eACbVgk+ooIihEYWWdeVnQPSMZYtY0TuBndMmfBmfHrQ5dbtkf18u0+o26n
X-Received: from pjx7.prod.google.com ([2002:a17:90b:5687:b0:311:46e:8c26])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc4:b0:315:af43:12ee
 with SMTP id 98e67ed59e1d1-318c9231818mr9666895a91.16.1751086288862; Fri, 27
 Jun 2025 21:51:28 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:17 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-24-irogers@google.com>
Subject: [PATCH v5 23/23] perf sort: Use perf_env to set arch sort keys and header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously arch_support_sort_key and arch_perf_header_entry used a
weak symbol to compile as appropriate for x86 and powerpc. A
limitation to this is that the handling of a data file could vary in
cross-platform development. Change to using the perf_env of the
current session to determine the architecture kind and set the sort
key and header entries as appropriate.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/Build   |  1 -
 tools/perf/arch/powerpc/util/event.c | 34 ----------------
 tools/perf/arch/x86/util/event.c     | 19 ---------
 tools/perf/builtin-annotate.c        |  2 +-
 tools/perf/builtin-c2c.c             | 53 +++++++++++++-----------
 tools/perf/builtin-diff.c            |  2 +-
 tools/perf/builtin-report.c          |  2 +-
 tools/perf/builtin-top.c             | 22 +++++-----
 tools/perf/tests/hists_cumulate.c    |  8 ++--
 tools/perf/tests/hists_filter.c      |  8 ++--
 tools/perf/tests/hists_link.c        |  8 ++--
 tools/perf/tests/hists_output.c      | 10 ++---
 tools/perf/util/event.h              |  3 --
 tools/perf/util/sort.c               | 61 ++++++++++++++++++++--------
 tools/perf/util/sort.h               |  5 ++-
 15 files changed, 107 insertions(+), 131 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/event.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index ed82715080f9..fdd6a77a3432 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -5,7 +5,6 @@ perf-util-y += mem-events.o
 perf-util-y += pmu.o
 perf-util-y += sym-handling.o
 perf-util-y += evsel.o
-perf-util-y += event.o
 
 perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/powerpc/util/event.c
deleted file mode 100644
index 024ac8b54c33..000000000000
--- a/tools/perf/arch/powerpc/util/event.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-
-#include "../../../util/event.h"
-#include "../../../util/synthetic-events.h"
-#include "../../../util/machine.h"
-#include "../../../util/tool.h"
-#include "../../../util/map.h"
-#include "../../../util/debug.h"
-#include "../../../util/sample.h"
-
-const char *arch_perf_header_entry(const char *se_header)
-{
-	if (!strcmp(se_header, "Local INSTR Latency"))
-		return "Finish Cyc";
-	else if (!strcmp(se_header, "INSTR Latency"))
-		return "Global Finish_cyc";
-	else if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
-		return "Dispatch Cyc";
-	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
-		return "Global Dispatch_cyc";
-	return se_header;
-}
-
-int arch_support_sort_key(const char *sort_key)
-{
-	if (!strcmp(sort_key, "p_stage_cyc"))
-		return 1;
-	if (!strcmp(sort_key, "local_p_stage_cyc"))
-		return 1;
-	return 0;
-}
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 576c1c36046c..3cd384317739 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -91,22 +91,3 @@ int perf_event__synthesize_extra_kmaps(const struct perf_tool *tool,
 }
 
 #endif
-
-const char *arch_perf_header_entry(const char *se_header)
-{
-	if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
-		return "Local Retire Latency";
-	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
-		return "Retire Latency";
-
-	return se_header;
-}
-
-int arch_support_sort_key(const char *sort_key)
-{
-	if (!strcmp(sort_key, "p_stage_cyc"))
-		return 1;
-	if (!strcmp(sort_key, "local_p_stage_cyc"))
-		return 1;
-	return 0;
-}
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 326593862998..5d57d2913f3d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -947,7 +947,7 @@ int cmd_annotate(int argc, const char **argv)
 			annotate_opts.show_br_cntr = true;
 	}
 
-	if (setup_sorting(NULL) < 0)
+	if (setup_sorting(/*evlist=*/NULL, perf_session__env(annotate.session)) < 0)
 		usage_with_options(annotate_usage, options);
 
 	ret = __cmd_annotate(&annotate);
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 8cb36d9433f8..9e9ff471ddd1 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -195,12 +195,14 @@ static struct hist_entry_ops c2c_entry_ops = {
 
 static int c2c_hists__init(struct c2c_hists *hists,
 			   const char *sort,
-			   int nr_header_lines);
+			   int nr_header_lines,
+			   struct perf_env *env);
 
 static struct c2c_hists*
 he__get_c2c_hists(struct hist_entry *he,
 		  const char *sort,
-		  int nr_header_lines)
+		  int nr_header_lines,
+		  struct perf_env *env)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *hists;
@@ -214,7 +216,7 @@ he__get_c2c_hists(struct hist_entry *he,
 	if (!hists)
 		return NULL;
 
-	ret = c2c_hists__init(hists, sort, nr_header_lines);
+	ret = c2c_hists__init(hists, sort, nr_header_lines, env);
 	if (ret) {
 		free(hists);
 		return NULL;
@@ -350,7 +352,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 		mi = mi_dup;
 
-		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2);
+		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);
 		if (!c2c_hists)
 			goto free_mi;
 
@@ -1966,7 +1968,8 @@ static struct c2c_fmt *get_format(const char *name)
 	return c2c_fmt;
 }
 
-static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
+static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name,
+				  struct perf_env *env __maybe_unused)
 {
 	struct c2c_fmt *c2c_fmt = get_format(name);
 	int level = 0;
@@ -1980,14 +1983,14 @@ static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
 	return 0;
 }
 
-static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
+static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name, struct perf_env *env)
 {
 	struct c2c_fmt *c2c_fmt = get_format(name);
 	struct c2c_dimension *dim;
 
 	if (!c2c_fmt) {
 		reset_dimensions();
-		return sort_dimension__add(hpp_list, name, NULL, 0);
+		return sort_dimension__add(hpp_list, name, /*evlist=*/NULL, env, /*level=*/0);
 	}
 
 	dim = c2c_fmt->dim;
@@ -2008,7 +2011,7 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
 										\
 		for (tok = strtok_r((char *)_list, ", ", &tmp);			\
 				tok; tok = strtok_r(NULL, ", ", &tmp)) {	\
-			ret = _fn(hpp_list, tok);				\
+			ret = _fn(hpp_list, tok, env);				\
 			if (ret == -EINVAL) {					\
 				pr_err("Invalid --fields key: `%s'", tok);	\
 				break;						\
@@ -2021,7 +2024,8 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
 
 static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 			   const char *output_,
-			   const char *sort_)
+			   const char *sort_,
+			   struct perf_env *env)
 {
 	char *output = output_ ? strdup(output_) : NULL;
 	char *sort   = sort_   ? strdup(sort_) : NULL;
@@ -2052,7 +2056,8 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 
 static int c2c_hists__init(struct c2c_hists *hists,
 			   const char *sort,
-			   int nr_header_lines)
+			   int nr_header_lines,
+			   struct perf_env *env)
 {
 	__hists__init(&hists->hists, &hists->list);
 
@@ -2066,15 +2071,16 @@ static int c2c_hists__init(struct c2c_hists *hists,
 	/* Overload number of header lines.*/
 	hists->list.nr_header_lines = nr_header_lines;
 
-	return hpp_list__parse(&hists->list, NULL, sort);
+	return hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
 }
 
 static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 			     const char *output,
-			     const char *sort)
+			     const char *sort,
+			     struct perf_env *env)
 {
 	perf_hpp__reset_output_field(&c2c_hists->list);
-	return hpp_list__parse(&c2c_hists->list, output, sort);
+	return hpp_list__parse(&c2c_hists->list, output, sort, env);
 }
 
 #define DISPLAY_LINE_LIMIT  0.001
@@ -2207,8 +2213,9 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 	return 0;
 }
 
-static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
+static int resort_cl_cb(struct hist_entry *he, void *arg)
 {
+	struct perf_env *env = arg;
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
 	bool display = he__display(he, &c2c.shared_clines_stats);
@@ -2222,7 +2229,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 		c2c_he->cacheline_idx = idx++;
 		calc_width(c2c_he);
 
-		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort);
+		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
 
 		hists__collapse_resort(&c2c_hists->hists, NULL);
 		hists__output_resort_cb(&c2c_hists->hists, NULL, filter_cb);
@@ -2334,7 +2341,7 @@ static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 	return 0;
 }
 
-static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
+static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb, void *arg)
 {
 	struct rb_node *next = rb_first_cached(&hists->entries);
 	int ret = 0;
@@ -2343,7 +2350,7 @@ static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
 		struct hist_entry *he;
 
 		he = rb_entry(next, struct hist_entry, rb_node);
-		ret = cb(he, NULL);
+		ret = cb(he, arg);
 		if (ret)
 			break;
 		next = rb_next(&he->rb_node);
@@ -2449,7 +2456,7 @@ static void print_cacheline(struct c2c_hists *c2c_hists,
 	hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, false);
 }
 
-static void print_pareto(FILE *out)
+static void print_pareto(FILE *out, struct perf_env *env)
 {
 	struct perf_hpp_list hpp_list;
 	struct rb_node *nd;
@@ -2474,7 +2481,7 @@ static void print_pareto(FILE *out)
 			    "dcacheline";
 
 	perf_hpp_list__init(&hpp_list);
-	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
+	ret = hpp_list__parse(&hpp_list, cl_output, /*evlist=*/NULL, env);
 
 	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
 		return;
@@ -2539,7 +2546,7 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	fprintf(out, "=================================================\n");
 	fprintf(out, "#\n");
 
-	print_pareto(out);
+	print_pareto(out, perf_session__env(session));
 }
 
 #ifdef HAVE_SLANG_SUPPORT
@@ -3097,7 +3104,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_session;
 	}
 
-	err = c2c_hists__init(&c2c.hists, "dcacheline", 2);
+	err = c2c_hists__init(&c2c.hists, "dcacheline", 2, perf_session__env(session));
 	if (err) {
 		pr_debug("Failed to initialize hists\n");
 		goto out_session;
@@ -3181,13 +3188,13 @@ static int perf_c2c__report(int argc, const char **argv)
 	else if (c2c.display == DISPLAY_SNP_PEER)
 		sort_str = "tot_peer";
 
-	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
+	c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
 	hists__collapse_resort(&c2c.hists.hists, NULL);
 	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
-	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb);
+	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
 
 	ui_progress__finish();
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ae490d58af92..53d5ea4a6a4f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -2003,7 +2003,7 @@ int cmd_diff(int argc, const char **argv)
 		sort__mode = SORT_MODE__DIFF;
 	}
 
-	if (setup_sorting(NULL) < 0)
+	if (setup_sorting(/*evlist=*/NULL, perf_session__env(data__files[0].session)) < 0)
 		usage_with_options(diff_usage, options);
 
 	setup_pager();
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ada8e0166c78..6f24540bdee9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1790,7 +1790,7 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
-	    (setup_sorting(session->evlist) < 0)) {
+	    (setup_sorting(session->evlist, &session->header.env) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
 		if (field_order)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d84daeae291b..608f58c753d8 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1759,7 +1759,17 @@ int cmd_top(int argc, const char **argv)
 
 	setup_browser(false);
 
-	if (setup_sorting(top.evlist) < 0) {
+	top.session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+					  /*trace_event_repipe=*/false,
+					  &host_env);
+	if (IS_ERR(top.session)) {
+		status = PTR_ERR(top.session);
+		top.session = NULL;
+		goto out_delete_evlist;
+	}
+	top.evlist->session = top.session;
+
+	if (setup_sorting(top.evlist, perf_session__env(top.session)) < 0) {
 		if (sort_order)
 			parse_options_usage(top_usage, options, "s", 1);
 		if (field_order)
@@ -1834,16 +1844,6 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
-	top.session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
-					  /*trace_event_repipe=*/false,
-					  &host_env);
-	if (IS_ERR(top.session)) {
-		status = PTR_ERR(top.session);
-		top.session = NULL;
-		goto out_delete_evlist;
-	}
-	top.evlist->session = top.session;
-
 	if (!evlist__needs_bpf_sb_event(top.evlist))
 		top.record_opts.no_bpf_event = true;
 
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 1e0f5a310fd5..3eb9ef8d7ec6 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -295,7 +295,7 @@ static int test1(struct evsel *evsel, struct machine *machine)
 	symbol_conf.cumulate_callchain = false;
 	evsel__reset_sample_bit(evsel, CALLCHAIN);
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 	callchain_register_param(&callchain_param);
 
 	err = add_hist_entries(hists, machine);
@@ -442,7 +442,7 @@ static int test2(struct evsel *evsel, struct machine *machine)
 	symbol_conf.cumulate_callchain = false;
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 	callchain_register_param(&callchain_param);
 
 	err = add_hist_entries(hists, machine);
@@ -500,7 +500,7 @@ static int test3(struct evsel *evsel, struct machine *machine)
 	symbol_conf.cumulate_callchain = true;
 	evsel__reset_sample_bit(evsel, CALLCHAIN);
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 	callchain_register_param(&callchain_param);
 
 	err = add_hist_entries(hists, machine);
@@ -684,7 +684,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
 	symbol_conf.cumulate_callchain = true;
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 
 	callchain_param = callchain_param_default;
 	callchain_register_param(&callchain_param);
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 4b2e4f2fbe48..1cebd20cc91c 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -131,10 +131,6 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	/* default sort order (comm,dso,sym) will be used */
-	if (setup_sorting(NULL) < 0)
-		goto out;
-
 	machines__init(&machines);
 
 	/* setup threads/dso/map/symbols also */
@@ -145,6 +141,10 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 	if (verbose > 1)
 		machine__fprintf(machine, stderr);
 
+	/* default sort order (comm,dso,sym) will be used */
+	if (setup_sorting(evlist, machine->env) < 0)
+		goto out;
+
 	/* process sample events */
 	err = add_hist_entries(evlist, machine);
 	if (err < 0)
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 5b6f1e883466..996f5f0b3bd1 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -303,10 +303,6 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 		goto out;
 
 	err = TEST_FAIL;
-	/* default sort order (comm,dso,sym) will be used */
-	if (setup_sorting(NULL) < 0)
-		goto out;
-
 	machines__init(&machines);
 
 	/* setup threads/dso/map/symbols also */
@@ -317,6 +313,10 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 	if (verbose > 1)
 		machine__fprintf(machine, stderr);
 
+	/* default sort order (comm,dso,sym) will be used */
+	if (setup_sorting(evlist, machine->env) < 0)
+		goto out;
+
 	/* process sample events */
 	err = add_hist_entries(evlist, machine);
 	if (err < 0)
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 33b5cc8352a7..ee5ec8bda60e 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -146,7 +146,7 @@ static int test1(struct evsel *evsel, struct machine *machine)
 	field_order = NULL;
 	sort_order = NULL; /* equivalent to sort_order = "comm,dso,sym" */
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 
 	/*
 	 * expected output:
@@ -248,7 +248,7 @@ static int test2(struct evsel *evsel, struct machine *machine)
 	field_order = "overhead,cpu";
 	sort_order = "pid";
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 
 	/*
 	 * expected output:
@@ -304,7 +304,7 @@ static int test3(struct evsel *evsel, struct machine *machine)
 	field_order = "comm,overhead,dso";
 	sort_order = NULL;
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 
 	/*
 	 * expected output:
@@ -378,7 +378,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
 	field_order = "dso,sym,comm,overhead,dso";
 	sort_order = "sym";
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 
 	/*
 	 * expected output:
@@ -480,7 +480,7 @@ static int test5(struct evsel *evsel, struct machine *machine)
 	field_order = "cpu,pid,comm,dso,sym";
 	sort_order = "dso,pid";
 
-	setup_sorting(NULL);
+	setup_sorting(/*evlist=*/NULL, machine->env);
 
 	/*
 	 * expected output:
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index b13385a6068b..e40d16d3246c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -391,9 +391,6 @@ extern unsigned int proc_map_timeout;
 #define PAGE_SIZE_NAME_LEN	32
 char *get_page_size_name(u64 size, char *str);
 
-const char *arch_perf_header_entry(const char *se_header);
-int arch_support_sort_key(const char *sort_key);
-
 static inline bool perf_event_header__cpumode_is_guest(u8 cpumode)
 {
 	return cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0ba2ce1b1c07..f3a565b0e230 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2530,19 +2530,44 @@ struct sort_dimension {
 	int			taken;
 };
 
-int __weak arch_support_sort_key(const char *sort_key __maybe_unused)
+static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
+	const char *arch = perf_env__arch(env);
+
+	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+		if (!strcmp(sort_key, "p_stage_cyc"))
+			return 1;
+		if (!strcmp(sort_key, "local_p_stage_cyc"))
+			return 1;
+	}
 	return 0;
 }
 
-const char * __weak arch_perf_header_entry(const char *se_header)
-{
+static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
+{
+	const char *arch = perf_env__arch(env);
+
+	if (!strcmp("x86", arch)) {
+		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
+			return "Local Retire Latency";
+		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
+			return "Retire Latency";
+	} else if (!strcmp("powerpc", arch)) {
+		if (!strcmp(se_header, "Local INSTR Latency"))
+			return "Finish Cyc";
+		else if (!strcmp(se_header, "INSTR Latency"))
+			return "Global Finish_cyc";
+		else if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
+			return "Dispatch Cyc";
+		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
+			return "Global Dispatch_cyc";
+	}
 	return se_header;
 }
 
-static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
+static void sort_dimension_add_dynamic_header(struct sort_dimension *sd, struct perf_env *env)
 {
-	sd->entry->se_header = arch_perf_header_entry(sd->entry->se_header);
+	sd->entry->se_header = arch_perf_header_entry(sd->entry->se_header, env);
 }
 
 #define DIM(d, n, func) [d] = { .name = n, .entry = &(func) }
@@ -3594,7 +3619,7 @@ int hpp_dimension__add_output(unsigned col, bool implicit)
 }
 
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
-			struct evlist *evlist,
+			struct evlist *evlist, struct perf_env *env,
 			int level)
 {
 	unsigned int i, j;
@@ -3607,7 +3632,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 	 */
 	for (j = 0; j < ARRAY_SIZE(arch_specific_sort_keys); j++) {
 		if (!strcmp(arch_specific_sort_keys[j], tok) &&
-				!arch_support_sort_key(tok)) {
+		    !arch_support_sort_key(tok, env)) {
 			return 0;
 		}
 	}
@@ -3620,7 +3645,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 
 		for (j = 0; j < ARRAY_SIZE(dynamic_headers); j++) {
 			if (sd->name && !strcmp(dynamic_headers[j], sd->name))
-				sort_dimension_add_dynamic_header(sd);
+				sort_dimension_add_dynamic_header(sd, env);
 		}
 
 		if (sd->entry == &sort_parent && parent_pattern) {
@@ -3716,13 +3741,13 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 }
 
 /* This should match with sort_dimension__add() above */
-static bool is_hpp_sort_key(const char *key)
+static bool is_hpp_sort_key(const char *key, struct perf_env *env)
 {
 	unsigned i;
 
 	for (i = 0; i < ARRAY_SIZE(arch_specific_sort_keys); i++) {
 		if (!strcmp(arch_specific_sort_keys[i], key) &&
-		    !arch_support_sort_key(key)) {
+		    !arch_support_sort_key(key, env)) {
 			return false;
 		}
 	}
@@ -3744,7 +3769,7 @@ static bool is_hpp_sort_key(const char *key)
 }
 
 static int setup_sort_list(struct perf_hpp_list *list, char *str,
-			   struct evlist *evlist)
+			   struct evlist *evlist, struct perf_env *env)
 {
 	char *tmp, *tok;
 	int ret = 0;
@@ -3773,7 +3798,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 		}
 
 		if (*tok) {
-			if (is_hpp_sort_key(tok)) {
+			if (is_hpp_sort_key(tok, env)) {
 				/* keep output (hpp) sort keys in the same level */
 				if (prev_was_hpp) {
 					bool next_same = (level == next_level);
@@ -3786,7 +3811,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 				prev_was_hpp = false;
 			}
 
-			ret = sort_dimension__add(list, tok, evlist, level);
+			ret = sort_dimension__add(list, tok, evlist, env, level);
 			if (ret == -EINVAL) {
 				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
 					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
@@ -3915,7 +3940,7 @@ static char *setup_overhead(char *keys)
 	return keys;
 }
 
-static int __setup_sorting(struct evlist *evlist)
+static int __setup_sorting(struct evlist *evlist, struct perf_env *env)
 {
 	char *str;
 	const char *sort_keys;
@@ -3955,7 +3980,7 @@ static int __setup_sorting(struct evlist *evlist)
 		}
 	}
 
-	ret = setup_sort_list(&perf_hpp_list, str, evlist);
+	ret = setup_sort_list(&perf_hpp_list, str, evlist, env);
 
 	free(str);
 	return ret;
@@ -4191,16 +4216,16 @@ static int __setup_output_field(void)
 	return ret;
 }
 
-int setup_sorting(struct evlist *evlist)
+int setup_sorting(struct evlist *evlist, struct perf_env *env)
 {
 	int err;
 
-	err = __setup_sorting(evlist);
+	err = __setup_sorting(evlist, env);
 	if (err < 0)
 		return err;
 
 	if (parent_pattern != default_parent_pattern) {
-		err = sort_dimension__add(&perf_hpp_list, "parent", evlist, -1);
+		err = sort_dimension__add(&perf_hpp_list, "parent", evlist, env, -1);
 		if (err < 0)
 			return err;
 	}
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a742ab7f3c67..d7787958e06b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -6,6 +6,7 @@
 #include "hist.h"
 
 struct option;
+struct perf_env;
 
 extern regex_t parent_regex;
 extern const char *sort_order;
@@ -130,7 +131,7 @@ extern struct sort_entry sort_thread;
 
 struct evlist;
 struct tep_handle;
-int setup_sorting(struct evlist *evlist);
+int setup_sorting(struct evlist *evlist, struct perf_env *env);
 int setup_output_field(void);
 void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
@@ -145,7 +146,7 @@ bool is_strict_order(const char *order);
 int hpp_dimension__add_output(unsigned col, bool implicit);
 void reset_dimensions(void);
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
-			struct evlist *evlist,
+			struct evlist *evlist, struct perf_env *env,
 			int level);
 int output_field_add(struct perf_hpp_list *list, const char *tok, int *level);
 int64_t
-- 
2.50.0.727.gbf7dc18ff4-goog

