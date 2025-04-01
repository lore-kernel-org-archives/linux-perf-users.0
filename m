Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0A221DAE
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531917; cv=none; b=H+7Wf7QzWWoKx6SouxNwzRdxQbIke/iZSKU4TnLB0ThKEjn63nR8ssaLNI4/oDLNUo2jaVEIKdx+fLBaEKzC6KqEXjRHdBAfCj3iq1wqGh34UvPUCXpHt0P44yGGipWC4ynA0/ASvB9d7ZK88vj3z/S0X3OFZgvjhARUsCZAzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531917; c=relaxed/simple;
	bh=aBPkQXixO3M0cdrydBjxudnkZEJYVoo2mFaStMse8lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R4AaYoCvVX8ZHwOO5w+uUTYFbK56VS9UiwXhyndtYxGqx4+HHWmWn1fI+75HD2L9kV1ARZR3B+pZrG/XwybN3ahlgOoPE+iO+RN9fmTmtpeAaDq1r0o9vNih4+i8JMYYaN74lfaEUqMdDxAzgPQ1GaxWR/gnWpCTJDNqrUGLv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EF3JUXCh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EF3JUXCh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso11065328a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531915; x=1744136715; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWLsVb2nHYRUSeH0q6KqSGJVp30MQT3KgSPSmOv1X5g=;
        b=EF3JUXChhBgNcj2mGWmOsf3sr5cjrUl72JHRgql96Nle2Ik9QDcyJVInL/6GCX/ql8
         D35+f9v+Au4TBqy0fxT/a4vkgyIShxpTsPaNk0AUCt6fr9mvMt3wtlfutctjNbF/vFjE
         E3CzEpR18BsVElTmJ58fMwGRcwNEzGxTa1vxTsE7QqvA/gRQxwddMhXB782zuPMtQleG
         huzCdoDE50VyiPaxTQeRaQJyr0szbvrrypk8zD/cb0pMTWmiECyuRKIEx7L+pP38wsYM
         UDUsCEPhm69Zwrs51Jwpydt/+WUWhdNoQkB/TD6EgWhcKqXV81d7BQWMnCxmTnWmPmtV
         ELjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531915; x=1744136715;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWLsVb2nHYRUSeH0q6KqSGJVp30MQT3KgSPSmOv1X5g=;
        b=NBJ77GatkxFeV1QVN44erRGiAhpi/hs5xdms64KuNZndm0AtTcL/FMFcs4Y7CoMFJ9
         k+6w7vqhPqe+2XRrDPfwK3/xZsNB7cYaapsAkmaV05Z651ImqqlfVaydmhOBxJn9jRiK
         Nun3gsAOfiGCPfaO8LzT/VTOz4GmN67zya2tLmbAR06Tus0dJ8tEY4Z8BgZLUUi9O/s6
         0x1v5mqTzGhiT+P2Rhu0SpaAwwOOIZ7iJ30YhkVz85Fijzou99XwI3DrgXyvB520K/UX
         hqBxZJXHqEe9/VmOO3F615mw/FZmATCFtLHTZeKJLwlM5I94QRvaIc6+U5OOrI1wnlPb
         AwzA==
X-Forwarded-Encrypted: i=1; AJvYcCVVFZxWiVbiwZb0ESHLcTK+2xEang8ylYP7BPNExfQwkKiMZSYdWrmudqtwbsf5dB57FbFYMMMPJOvgaeMbgdQw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UF4Bx4q7BBOTu2juKLD6+3TSDQ6j5QaMX1doq/9oKtvNacP1
	SCqQNX+tVt5VcoQJ0g6LA7NLjaJtYaOMyxTWVIyF4jPjJmbmpysts9CO+qBm3PvyjIXfDNOIY/T
	c4C5aCw==
X-Google-Smtp-Source: AGHT+IGj7YkqrbDyup/KuLeb3AZ/P8HTzGtHUP1SULJ5EGEg5Fjd8pSVBH+ABj6fvvcr1nB84DffOnbaJUGo
X-Received: from pjbmj3.prod.google.com ([2002:a17:90b:3683:b0:305:2d68:2be6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384b:b0:2ee:863e:9ffc
 with SMTP id 98e67ed59e1d1-305320b2429mr18702506a91.21.1743531914866; Tue, 01
 Apr 2025 11:25:14 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:17 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-20-irogers@google.com>
Subject: [PATCH v1 19/48] perf stat: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-stat.c      |  6 +++---
 tools/perf/util/metricgroup.c  | 15 +++++++--------
 tools/perf/util/stat-display.c | 10 +++++-----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68ea7589c143..3d1171d03d32 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -833,7 +833,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		l = strlen(counter->unit);
 		if (l > stat_config.unit_width)
-			stat_config.unit_width = l;
+			stat_config.unit_width = (unsigned int)l;
 
 		if (evsel__should_store_id(counter) &&
 		    evsel__store_ids(counter, evsel_list)) {
@@ -2101,7 +2101,7 @@ static int __cmd_record(const struct option stat_options[], struct opt_aggr_mode
 	session = perf_session__new(data, NULL);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	init_features(session);
@@ -2283,7 +2283,7 @@ static int __cmd_report(int argc, const char **argv)
 
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 46920ebadfd1..1e07dcaed3d7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -256,12 +256,10 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 	return NULL;
 }
 
-static bool contains_metric_id(struct evsel **metric_events, int num_events,
+static bool contains_metric_id(struct evsel **metric_events, size_t num_events,
 			       const char *metric_id)
 {
-	int i;
-
-	for (i = 0; i < num_events; i++) {
+	for (size_t i = 0; i < num_events; i++) {
 		if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
 			return true;
 	}
@@ -355,7 +353,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 
 static bool match_metric(const char *metric_or_groups, const char *sought)
 {
-	int len;
+	size_t len;
 	char *m;
 
 	if (!sought)
@@ -570,7 +568,7 @@ static int encode_metric_id(struct strbuf *sb, const char *x)
 			if (ret)
 				break;
 
-			ret = strbuf_addch(sb, '0' + (c - code_characters));
+			ret = strbuf_addch(sb, '0' + (int)(c - code_characters));
 			if (ret)
 				break;
 		} else {
@@ -1145,7 +1143,8 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	const struct metric *left = container_of(l, struct metric, nd);
 	const struct metric *right = container_of(r, struct metric, nd);
 	struct expr_id_data *data;
-	int i, left_count, right_count;
+	int i;
+	size_t left_count, right_count;
 
 	left_count = hashmap__size(left->pctx->ids);
 	tool_pmu__for_each_event(i) {
@@ -1159,7 +1158,7 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 			right_count--;
 	}
 
-	return right_count - left_count;
+	return (int)right_count - (int)left_count;
 }
 
 /**
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..0aa172cf5e39 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -622,7 +622,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = config->metric_only_len;
+	size_t mlen = config->metric_only_len;
 	const char *color = metric_threshold_classify__color(thresh);
 
 	if (!valid_only_metric(unit))
@@ -635,7 +635,7 @@ static void print_metric_only(struct perf_stat_config *config,
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
 	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
-	fprintf(out, "%*s ", mlen, str);
+	fprintf(out, "%*s ", (int)mlen, str);
 	os->first = false;
 }
 
@@ -954,7 +954,7 @@ static void evsel__uniquify_counter(struct evsel *counter)
 
 	config = strchr(name, '/');
 	if (config) {
-		int len = config - name;
+		int len = (int)(config - name);
 
 		if (config[1] == '/') {
 			/* case: event// */
@@ -967,7 +967,7 @@ static void evsel__uniquify_counter(struct evsel *counter)
 		config = strchr(name, ':');
 		if (config) {
 			/* case: event:.. */
-			int len = config - name;
+			int len = (int)(config - name);
 
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
 		} else {
@@ -1493,7 +1493,7 @@ static int get_precision(double num)
 	if (num > 1)
 		return 0;
 
-	return lround(ceil(-log10(num)));
+	return (int)lround(ceil(-log10(num)));
 }
 
 static void print_table(struct perf_stat_config *config,
-- 
2.49.0.504.g3bcea36a83-goog

