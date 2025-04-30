Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981A289E28
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035506; cv=none; b=eudoJMH8ARYk2dTTQ/sd/cV0xpAlrD+tdC9lgzlki4nCS9rFP6DKLbbVjleqpEv8Dv232UqNEeyNJ5mWrQJJPl4JDkmTkybzah9LKQB7qKma2XvcewlddqFeJz5GhMEoKe/U/wJuFBVzaqDdL+sYoEHrKTFh6rSHGq7Sy4iaaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035506; c=relaxed/simple;
	bh=qYxyPi6RkviI4bX+6bORVAMTvoU1dSPnFuXQJ++clR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjmtVHYFbjaTxBx20S5NUecAjwsc0UujUVOa9F0udiI+kr3TBIB8MGtlz0Dr1E+BWQOG0nKQ5e4dE6YlE3ijtIcfYmZnA0nHMTvMexlHA6l/cx/bR6RCwHMmsFK5a8IS7Yh9lOene9JJ5J/EiQxiy4u6a+S64lWwTUvbairW0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/Nbq0/7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/Nbq0/7"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b19226b5f7dso100224a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035504; x=1746640304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2GFrTv5xjFh/L7If88NMoXB+NztpoP+PMoIikktuv4=;
        b=f/Nbq0/7gOnIfKqcjTsE1N+BJwGuvJVtyllZbw1WcURxUD58HqfrhHriJI/VUv3L5X
         +CtJ+10zomUadxYR9D4IIi0cCvx5N8KYsfVI5pAtRv8/QrhWKZZbchuG6RKvuzgCwLgd
         b4vqXh2rlHfiW6dVo3BViKXdybLXimzs15+cYdcBotPTWXogLymNGzReEX4qg6eCPP/o
         4+GdFT15wSm9J9mrr+zAB2QvgeThCxOOnG36p1i2IMZ2b0cyxxU/5XJT5s/ed7h4UgWy
         49guyNQtaoXkgJ/gQN5vFSormzbQ3eL77V13KjDYMwxOGAOZ7GbfLYIXSlms0/M8nQTH
         Z+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035504; x=1746640304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2GFrTv5xjFh/L7If88NMoXB+NztpoP+PMoIikktuv4=;
        b=kHp06dxjcAyTO+ZAGbdIgPctoYfY94x1GCyKFL7mRxBjaIdMwY8K/HTKgKJ7Sgg5Ep
         MqREInycmEXeJA9OrdineutLH8dg/Nvs+GgWtPWIKsGuDUExOfYy5lKCYMKG9fekqUHX
         gh6XNiwJu931u9j5lgNjZnhxu+7EvePblAmEzZa4m+CV63Es5/rGUfGK3ykMHmNna7jp
         TypURrjBXzsLfQ8+SMH4o1ZmRRvvMsjZO8rO1m4s+ra6gbG4P/w1y/lEliP4t5dwSjco
         WpatjFDoghdjBDk9Gr6pxnYpGMerHrqbIUMaTGUNLRywOC4sarLYi6Nof32qoDmLcJZm
         WndA==
X-Forwarded-Encrypted: i=1; AJvYcCWUXSu5i+0f+c+v0jvoWDmEEU6ddCbgO2wjZlhO0SHO7+Lp5C5tAQWMikymaoqO2d6egf0qIHp/oX68KiLr0nT3@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbJN/gLatOJqxmOYIazPg3WndTGg366WlVNRZD1va4VTYmOK5
	EA+fbY70a9+s1Y4CGVoc1PohXTicgQU4aYRewORzKYocdHNZWad6JE4OlNXzrgC+J4UpwVSvLHf
	X0z+lJw==
X-Google-Smtp-Source: AGHT+IGv2W/7VpCyNYDC1NVo2pEj4o3KLFYg0roQUo8v41bXyZlRs19Lsz8lL/tQOofmbcRVbLIJwW0fQB8/
X-Received: from pjuw16.prod.google.com ([2002:a17:90a:d610:b0:2e9:38ea:ca0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc4:b0:2fa:1e56:5d82
 with SMTP id 98e67ed59e1d1-30a3f0ae2demr585709a91.17.1746035503469; Wed, 30
 Apr 2025 10:51:43 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:11 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-24-irogers@google.com>
Subject: [PATCH v2 23/47] perf report: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-report.c |  4 ++--
 tools/perf/util/callchain.c | 12 ++++++------
 tools/perf/util/callchain.h |  2 +-
 tools/perf/util/srccode.c   |  6 +++---
 tools/perf/util/srcline.c   |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f0299c7ee025..9c10209d7b57 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -800,7 +800,7 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
-		u32 count = event->lost_samples.lost;
+		u32 count = (u32)event->lost_samples.lost;
 
 		if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF)
 			hists__inc_nr_dropped_samples(hists, count);
@@ -1602,7 +1602,7 @@ int cmd_report(int argc, const char **argv)
 
 	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session)) {
-		ret = PTR_ERR(session);
+		ret = (int)PTR_ERR(session);
 		goto exit;
 	}
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d7b7eef740b9..c3206b9d7b52 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -214,7 +214,7 @@ __parse_callchain_report_opt(const char *arg, bool allow_record_opt)
 
 			if (get_stack_size(tok, &size) < 0)
 				return -1;
-			callchain_param.dump_size = size;
+			callchain_param.dump_size = (u32)size;
 			try_stack_size = false;
 		} else if (!minpcnt_set) {
 			/* try to get the min percent */
@@ -224,7 +224,7 @@ __parse_callchain_report_opt(const char *arg, bool allow_record_opt)
 			minpcnt_set = true;
 		} else {
 			/* try print limit at last */
-			callchain_param.print_limit = strtoul(tok, &endptr, 0);
+			callchain_param.print_limit = (u32)strtoul(tok, &endptr, 0);
 			if (tok == endptr)
 				return -1;
 		}
@@ -295,7 +295,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 				unsigned long size = 0;
 
 				ret = get_stack_size(tok, &size);
-				param->dump_size = size;
+				param->dump_size = (u32)size;
 			}
 		} else if (!strncmp(name, "lbr", sizeof("lbr"))) {
 			if (!strtok_r(NULL, ",", &saveptr)) {
@@ -332,7 +332,7 @@ int perf_callchain_config(const char *var, const char *value)
 		int ret;
 
 		ret = get_stack_size(value, &size);
-		callchain_param.dump_size = size;
+		callchain_param.dump_size = (u32)size;
 
 		return ret;
 	}
@@ -817,7 +817,7 @@ split_add_child(struct callchain_node *parent,
 {
 	struct callchain_node *new;
 	struct list_head *old_tail;
-	unsigned int idx_total = idx_parents + idx_local;
+	u64 idx_total = idx_parents + idx_local;
 
 	/* split */
 	new = create_child(parent, true);
@@ -1027,7 +1027,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	struct callchain_node *child;
 	struct callchain_list *list, *next_list;
 	struct rb_node *n;
-	int old_pos = cursor->nr;
+	u64 old_pos = cursor->nr;
 	int err = 0;
 
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86ed9e4d04f9..7a2abff6d0a5 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -65,7 +65,7 @@ struct callchain_node {
 	struct rb_node		rb_node;    /* to sort nodes in an output tree */
 	struct rb_root		rb_root_in; /* input tree of children */
 	struct rb_root		rb_root;    /* sorted output tree of children */
-	unsigned int		val_nr;
+	u64			val_nr;
 	unsigned int		count;
 	unsigned int		children_count;
 	u64			hit;
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index 476e99896d5e..f5f8cdfd00c1 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -37,7 +37,7 @@ static LIST_HEAD(srcfile_list);
 static long map_total_sz;
 static int num_srcfiles;
 
-static int countlines(char *map, int maplen)
+static int countlines(char *map, size_t maplen)
 {
 	int numl;
 	char *end = map + maplen;
@@ -136,7 +136,7 @@ static struct srcfile *find_srcfile(char *fn)
 	h->lines = calloc(h->numlines, sizeof(char *));
 	if (!h->lines)
 		goto out_map;
-	fill_lines(h->lines, h->numlines, h->map, h->maplen);
+	fill_lines(h->lines, h->numlines, h->map, (int)h->maplen);
 	list_add(&h->nd, &srcfile_list);
 	hlist_add_head(&h->hash_nd, &srcfile_htab[hval]);
 	map_total_sz += h->maplen;
@@ -166,6 +166,6 @@ char *find_sourceline(char *fn, unsigned line, int *lenp)
 	if (!l)
 		return NULL;
 	p = memchr(l, '\n', sf->map + sf->maplen - l);
-	*lenp = p - l;
+	*lenp = (int)(p - l);
 	return l;
 }
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index f32d0d4f4bc9..b2003c5490a2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -443,7 +443,7 @@ static int filename_split(char *filename, unsigned int *line_nr)
 	sep = strchr(filename, ':');
 	if (sep) {
 		*sep++ = '\0';
-		*line_nr = strtoul(sep, NULL, 0);
+		*line_nr = (unsigned int)strtoul(sep, NULL, 0);
 		return 1;
 	}
 	pr_debug("addr2line missing ':' in filename split\n");
-- 
2.49.0.906.g1f30a19c02-goog

