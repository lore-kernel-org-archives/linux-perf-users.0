Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89468229B36
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531978; cv=none; b=CnFreXU1ewta+OoaopT4rgJLhxS5lWE5v0+KIZOIZRaRRCqaFHeva7gPkV+FqsQQapDDkixrSHh2nHr85/Xk8HqeBoBM1RtZJQlUdBO8CxWKouPS66mPgqCWNi8d2e/JQysJWjOJ7d2/6cLU7oQzyY1QJ40ojkQf+aPF1JssdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531978; c=relaxed/simple;
	bh=JH5IYw1XLUdsjJtnvPI0verzfyIExYV2qDPtVuYm074=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BcNTKF/71F0MuXAt3oXRuI5Vd4us8S+8FAjchFljPX1CMY5CHURoNHx1WaRyWd5l76m4JtQ89qB6acObyqxzmCbyecUBoeURPyOn4ARXPjKbanju6koyM0yOoayMS9Le6AV6PAUXB0h7EvscdAjSfRNDjwkrX8ETGPLh5TQfpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4cMhVuQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4cMhVuQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so8327580a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531974; x=1744136774; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPhysvgPSu3+WhFKX3Vrd0yYhQilxaKDEP5OdoVpUVA=;
        b=t4cMhVuQS0Wl4wlHAgsH+pRtzPNvuK6B9FZf7tveWJL8aVaJ9PWY/+I9TbYhGAOpLu
         fRhdbBCyz6vCwNpjUeDUz29J22EbQlGGT4mcKNi3s6C+jcySM0saIx6TLWbfQZD3SSUL
         TF0kAHH0xADPqp18IuP1gLuCU59CNhbjcPD0uNj5PbLACLfLDCmWEf1ubKZSu7RSUVsI
         wFhINR4f10/RNwmGwTf64AmiT7CImRGSQKmJupLOSqn9KhwF2hRzk9dB0HNJn4khdBIl
         hZz8j5Jeh7MejAzBh6sBrT5zUE6ies6W9Ti1tT3KOMjptDfysWNEZuyRkMZQSz1i+MoN
         De/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531974; x=1744136774;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPhysvgPSu3+WhFKX3Vrd0yYhQilxaKDEP5OdoVpUVA=;
        b=ZSWqyMufPGa6UsxZQiZ7Pug6/sPBPBFoleeE9s/9y+rJP9ffKFYVr4VnZpcNQChNLv
         Lk9nqN4dG6QKg4b9iXcQz1CsEqnzBXlvSnAsUO0sCCrSteWodpV7wAlOTDtFu27sUrB1
         dvyH0oxAu0vB4p77e5sceX9I1AOT9fLCGBNI9a998iCej54NcFTTEUmZXBOEIa3vEt2Y
         SfDEHxhoLkkt2h5IA6n4Mqku4Fh8C4+kPcMBiqasr0e9Ih7RqyPu/jj0McwIckJ1sgcJ
         AJF/51ZmdAbFXC6vGaWwev6wVkZjTEei1+wzw1QcvlzlXwCxAXTepBDFGx1WAysxMYNi
         51HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv23qz8Pq8MhbnssGq3KC+8bmWWBXfSfNWRY++wW9rL34hSAPKyKuccG+enl2PtrAxnIG7ktVwjjXCTG9brlre@vger.kernel.org
X-Gm-Message-State: AOJu0YybKSryzIDLeDFTVWQcWHLfp8NGbJk68PvBRjqlzk63aEfC9p79
	ZKdAzt3OyTaR3foITOt4TDLFcGDaJGLjRV45ajPcj4JbRxE5LqIOPl4ZSqpc9OPZNCdXJaoXi1y
	y5tx6bQ==
X-Google-Smtp-Source: AGHT+IGASQJESQh0P5WocUZzTVsuPYeMntTSxEaM9deIUgGCJYYaAmhumcox7D9ILdKo/OIFvvRilGZiYCz6
X-Received: from pfkq16.prod.google.com ([2002:a05:6a00:850:b0:736:9d24:ae31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1509:b0:1ee:d06c:cddc
 with SMTP id adf61e73a8af0-2009f75c535mr27397490637.30.1743531973749; Tue, 01
 Apr 2025 11:26:13 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:46 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-49-irogers@google.com>
Subject: [PATCH v1 48/48] perf: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/perf.c                  |  2 +-
 tools/perf/util/bpf-event.c        |  2 +-
 tools/perf/util/env.c              |  2 +-
 tools/perf/util/event.c            |  4 +--
 tools/perf/util/header.c           | 54 ++++++++++++++++--------------
 tools/perf/util/hist.c             |  7 ++--
 tools/perf/util/machine.c          | 14 ++++----
 tools/perf/util/map.c              |  4 +--
 tools/perf/util/maps.c             |  6 ++--
 tools/perf/util/parse-events.c     | 16 ++++-----
 tools/perf/util/session.c          | 29 ++++++++--------
 tools/perf/util/sort.c             | 20 +++++------
 tools/perf/util/synthetic-events.c | 22 ++++++------
 tools/perf/util/target.c           |  2 +-
 tools/perf/util/thread-stack.c     |  2 +-
 tools/perf/util/thread.c           |  4 +--
 tools/perf/util/thread_map.c       |  6 ++--
 tools/perf/util/tool.c             |  2 +-
 tools/perf/util/values.c           |  4 +--
 19 files changed, 104 insertions(+), 98 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index f0617cc41f5f..2e98a29df3b2 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -476,7 +476,7 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd = "perf-help";
 
-	srandom(time(NULL));
+	srandom((unsigned int)time(NULL));
 
 	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
 	config_exclusive_filename = getenv("PERF_CONFIG");
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index c81444059ad0..3cf7d1a2b624 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -332,7 +332,7 @@ process_bpf_image(char *name, u64 addr, struct kallsyms_parse *data)
 			.size = offsetof(struct perf_record_ksymbol, name),
 		},
 		.addr      = addr,
-		.len       = page_size,
+		.len       = (__u32)page_size,
 		.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
 		.flags     = 0,
 	};
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 36411749e007..8238a9a609ab 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -596,7 +596,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap)
 {
 	char *cap_eq;
-	int cap_size;
+	size_t cap_size;
 	char **ptr;
 	int i, j;
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c23b77f8f854..edd7e2fccf60 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -156,7 +156,7 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 		switch (event->data[i].tag) {
 #define CASE(__term, __val)					\
 		case PERF_STAT_CONFIG_TERM__##__term:		\
-			config->__val = event->data[i].val;	\
+			config->__val = (typeof(config->__val))event->data[i].val; \
 			break;
 
 		CASE(AGGR_MODE,  aggr_mode)
@@ -190,7 +190,7 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
 	u32 nr_namespaces, idx;
 
 	ns_link_info = event->namespaces.link_info;
-	nr_namespaces = event->namespaces.nr_namespaces;
+	nr_namespaces = (u32)event->namespaces.nr_namespaces;
 
 	ret += fprintf(fp, " %d/%d - nr_namespaces: %u\n\t\t[",
 		       event->namespaces.pid,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..e364dea9e243 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -185,7 +185,7 @@ static int do_write_string(struct feat_fd *ff, const char *str)
 	u32 len, olen;
 	int ret;
 
-	olen = strlen(str) + 1;
+	olen = (u32)strlen(str) + 1;
 	len = PERF_ALIGN(olen, NAME_ALIGN);
 
 	/* write len, incl. \0 */
@@ -286,7 +286,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
-	set = bitmap_zalloc(size);
+	set = bitmap_zalloc((int)size);
 	if (!set)
 		return -ENOMEM;
 
@@ -1369,7 +1369,9 @@ static int memory_node__sort(const void *a, const void *b)
 	const struct memory_node *na = a;
 	const struct memory_node *nb = b;
 
-	return na->node - nb->node;
+	if (na->node == nb->node)
+		return 0;
+	return na->node < nb->node ? -1 : 1;
 }
 
 static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
@@ -2144,7 +2146,7 @@ static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 	str = ff->ph->env.pmu_mappings;
 
 	while (pmu_num) {
-		type = strtoul(str, &tmp, 0);
+		type = (u32)strtoul(str, &tmp, 0);
 		if (*tmp != ':')
 			goto error;
 
@@ -2214,10 +2216,10 @@ static void memory_node__fprintf(struct memory_node *n,
 	char buf_map[100], buf_size[50];
 	unsigned long long size;
 
-	size = bsize * bitmap_weight(n->set, n->size);
+	size = bsize * bitmap_weight(n->set, (unsigned int)n->size);
 	unit_number__scnprintf(buf_size, 50, size);
 
-	bitmap_scnprintf(n->set, n->size, buf_map, 100);
+	bitmap_scnprintf(n->set, (unsigned int)n->size, buf_map, 100);
 	fprintf(fp, "#  %3" PRIu64 " [%s]: %s\n", n->node, buf_size, buf_map);
 }
 
@@ -2782,7 +2784,7 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
-	size_t ret = -1;
+	int ret = -1;
 	u32 i, nr, nr_groups;
 	struct perf_session *session;
 	struct evsel *evsel, *leader = NULL;
@@ -2996,7 +2998,7 @@ static int process_mem_topology(struct feat_fd *ff,
 
 	ff->ph->env.memory_bsize    = bsize;
 	ff->ph->env.memory_nodes    = nodes;
-	ff->ph->env.nr_memory_nodes = nr;
+	ff->ph->env.nr_memory_nodes = (int)nr;
 	ret = 0;
 
 out:
@@ -3489,7 +3491,8 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	int fd = perf_data__fd(session->data);
 	struct stat st;
 	time_t stctime;
-	int ret, bit;
+	int ret;
+	size_t bit;
 
 	hd.fp = fp;
 	hd.full = full;
@@ -3586,15 +3589,15 @@ static int perf_header__adds_write(struct perf_header *header,
 				   struct evlist *evlist, int fd,
 				   struct feat_copier *fc)
 {
-	int nr_sections;
+	size_t nr_sections;
 	struct feat_fd ff = {
 		.fd  = fd,
 		.ph = header,
 	};
 	struct perf_file_section *feat_sec, *p;
-	int sec_size;
+	size_t sec_size;
 	u64 sec_start;
-	int feat;
+	size_t feat;
 	int err;
 
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
@@ -3611,8 +3614,8 @@ static int perf_header__adds_write(struct perf_header *header,
 	lseek(fd, sec_start + sec_size, SEEK_SET);
 
 	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
-		if (do_write_feat(&ff, feat, &p, evlist, fc))
-			perf_header__clear_feat(header, feat);
+		if (do_write_feat(&ff, (int)feat, &p, evlist, fc))
+			perf_header__clear_feat(header, (int)feat);
 	}
 
 	lseek(fd, sec_start, SEEK_SET);
@@ -3821,9 +3824,9 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 						 int feat, int fd, void *data))
 {
 	struct perf_file_section *feat_sec, *sec;
-	int nr_sections;
-	int sec_size;
-	int feat;
+	size_t nr_sections;
+	size_t sec_size;
+	size_t feat;
 	int err;
 
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
@@ -3843,7 +3846,7 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 		goto out_free;
 
 	for_each_set_bit(feat, header->adds_features, HEADER_LAST_FEATURE) {
-		err = process(sec++, header, feat, fd, data);
+		err = process(sec++, header, (int)feat, fd, data);
 		if (err < 0)
 			goto out_free;
 	}
@@ -4183,7 +4186,7 @@ static int evsel__prepare_tracepoint_event(struct evsel *evsel, struct tep_handl
 		return -1;
 	}
 
-	event = tep_find_event(pevent, evsel->core.attr.config);
+	event = tep_find_event(pevent, (int)evsel->core.attr.config);
 	if (event == NULL) {
 		pr_debug("cannot find event format for %d\n", (int)evsel->core.attr.config);
 		return -1;
@@ -4221,8 +4224,8 @@ int perf_session__read_header(struct perf_session *session)
 	struct perf_file_header	f_header;
 	struct perf_file_attr	f_attr;
 	u64			f_id;
-	int nr_attrs, nr_ids, i, j, err;
-	int fd = perf_data__fd(data);
+	u64 nr_attrs, nr_ids;
+	int err, fd = perf_data__fd(data);
 
 	session->evlist = evlist__new();
 	if (session->evlist == NULL)
@@ -4271,7 +4274,7 @@ int perf_session__read_header(struct perf_session *session)
 	nr_attrs = f_header.attrs.size / f_header.attr_size;
 	lseek(fd, f_header.attrs.offset, SEEK_SET);
 
-	for (i = 0; i < nr_attrs; i++) {
+	for (u64 i = 0; i < nr_attrs; i++) {
 		struct evsel *evsel;
 		off_t tmp;
 
@@ -4308,7 +4311,7 @@ int perf_session__read_header(struct perf_session *session)
 
 		lseek(fd, f_attr.ids.offset, SEEK_SET);
 
-		for (j = 0; j < nr_ids; j++) {
+		for (int j = 0; j < (int)nr_ids; j++) {
 			if (perf_header__getbuffer64(header, fd, &f_id, sizeof(f_id)))
 				goto out_errno;
 
@@ -4537,7 +4540,8 @@ int perf_event__process_tracing_data(struct perf_session *session,
 		return -1;
 	}
 	if (session->trace_event_repipe) {
-		int retw = write(STDOUT_FILENO, buf, padding);
+		ssize_t retw = write(STDOUT_FILENO, buf, padding);
+
 		if (retw <= 0 || retw != padding) {
 			pr_err("%s: repiping tracing data padding", __func__);
 			return -1;
@@ -4551,7 +4555,7 @@ int perf_event__process_tracing_data(struct perf_session *session,
 
 	evlist__prepare_tracepoint_events(session->evlist, session->tevent.pevent);
 
-	return size_read + padding;
+	return (int)(size_read + padding);
 }
 #endif
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index d65228c11412..37469da4afc2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -700,7 +700,8 @@ static unsigned random_max(unsigned high)
 {
 	unsigned thresh = -high % high;
 	for (;;) {
-		unsigned r = random();
+		unsigned int r = (unsigned int)random();
+
 		if (r >= thresh)
 			return r % high;
 	}
@@ -929,7 +930,7 @@ iter_prepare_branch_entry(struct hist_entry_iter *iter, struct addr_location *al
 		return -ENOMEM;
 
 	iter->curr = 0;
-	iter->total = sample->branch_stack->nr;
+	iter->total = (int)sample->branch_stack->nr;
 
 	iter->bi = bi;
 	return 0;
@@ -2770,7 +2771,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (int i = bs->nr - 1; i >= 0; i--) {
+			for (int i = (int)bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles, evsel,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf..0881b83532fd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -809,7 +809,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 
 	if (dso) {
 		u8 *new_bytes = event->text_poke.bytes + event->text_poke.old_len;
-		int ret;
+		ssize_t ret;
 
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
@@ -2306,7 +2306,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	struct branch_stack *lbr_stack = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	u8 cpumode = PERF_RECORD_MISC_USER;
-	int lbr_nr = lbr_stack->nr;
+	int lbr_nr = (int)lbr_stack->nr;
 	struct branch_flags *flags;
 	int err, i;
 	u64 ip;
@@ -2472,7 +2472,7 @@ static bool has_stitched_lbr(struct thread *thread,
 	 *
 	 * Starts from the base-of-stack of current sample.
 	 */
-	for (i = distance, j = cur_stack->nr - 1; (i >= 0) && (j >= 0); i--, j--) {
+	for (i = (int)distance, j = (int)cur_stack->nr - 1; (i >= 0) && (j >= 0); i--, j--) {
 		if ((prev_entries[i].from != cur_entries[j].from) ||
 		    (prev_entries[i].to != cur_entries[j].to) ||
 		    (prev_entries[i].flags.value != cur_entries[j].flags.value))
@@ -2488,7 +2488,7 @@ static bool has_stitched_lbr(struct thread *thread,
 	 * and the base-of-stack of current sample into lbr_stitch->lists.
 	 * These LBRs will be stitched later.
 	 */
-	for (i = prev_stack->nr - 1; i > (int)distance; i--) {
+	for (i = (int)prev_stack->nr - 1; i > (int)distance; i--) {
 
 		if (!lbr_stitch->prev_lbr_cursor[i].valid)
 			continue;
@@ -2687,7 +2687,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	u64 leaf_frame_caller;
 
 	if (chain)
-		chain_nr = chain->nr;
+		chain_nr = (int)chain->nr;
 
 	if (evsel__has_branch_callstack(evsel)) {
 		struct perf_env *env = evsel__env(evsel);
@@ -2783,7 +2783,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 check_calls:
 	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
-					&cpumode, chain->nr - first_call, symbols);
+					&cpumode, (int)(chain->nr - first_call), symbols);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
@@ -2794,7 +2794,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		if (callchain_param.order == ORDER_CALLEE)
 			j = i;
 		else
-			j = chain->nr - i - 1;
+			j = (int)(chain->nr - i - 1);
 
 #ifdef HAVE_SKIP_CALLCHAIN_IDX
 		if (j == skip_idx)
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d729438b7d65..57e22e49e65c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -74,8 +74,8 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		if (!(ndk && app))
 			return false;
 
-		ndk_length = strlen(ndk);
-		app_length = strlen(app);
+		ndk_length = (int)strlen(ndk);
+		app_length = (int)strlen(app);
 
 		if (!(ndk_length && app_length && app_abi_length))
 			return false;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 0b40d901675e..8101a3e3810b 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -396,7 +396,7 @@ static unsigned int maps__by_address_index(const struct maps *maps, const struct
 				sizeof(*mapp), map__start_cmp);
 
 		if (mapp)
-			return mapp - maps_by_address;
+			return (unsigned int)(mapp - maps_by_address);
 	} else {
 		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
 			if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
@@ -417,7 +417,7 @@ static unsigned int maps__by_name_index(const struct maps *maps, const struct ma
 				sizeof(*mapp), map__strcmp);
 
 		if (mapp)
-			return mapp - maps_by_name;
+			return (unsigned int)(mapp - maps_by_name);
 	} else {
 		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
 			if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
@@ -1134,7 +1134,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 			if (mapp) {
 				result = map__get(*mapp);
-				i = mapp - maps__maps_by_name(maps);
+				i = (unsigned int)(mapp - maps__maps_by_name(maps));
 				RC_CHK_ACCESS(maps)->last_search_by_name_idx = i;
 			}
 			done = true;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..5e697091c820 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -317,7 +317,7 @@ static int parse_aliases(const char *str, const char *const names[][EVSEL__MAX_A
 	*longest = -1;
 	for (int i = 0; i < size; i++) {
 		for (int j = 0; j < EVSEL__MAX_ALIASES && names[i][j]; j++) {
-			int n = strlen(names[i][j]);
+			int n = (int)strlen(names[i][j]);
 
 			if (n > *longest && !strncasecmp(str, names[i][j], n))
 				*longest = n;
@@ -532,8 +532,8 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 					       !parse_state->fake_tp);
 
 	if (IS_ERR(evsel)) {
-		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
-		return PTR_ERR(evsel);
+		tracepoint_error(err, (int)PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
+		return (int)PTR_ERR(evsel);
 	}
 
 	if (head_config) {
@@ -1153,7 +1153,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 #define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)	\
 do {								\
 	ADD_CONFIG_TERM(__type, __weak);			\
-	__t->val.__name = __val;				\
+	__t->val.__name = (typeof(__t->val.__name))__val;	\
 } while (0)
 
 #define ADD_CONFIG_TERM_STR(__type, __val, __weak)		\
@@ -2299,12 +2299,12 @@ static void __parse_events_error__print(int err_idx, const char *err_str,
 	const char *str = "invalid or unsupported event: ";
 	char _buf[MAX_WIDTH];
 	char *buf = (char *) event;
-	int idx = 0;
+	size_t idx = 0;
 	if (err_str) {
 		/* -2 for extra '' in the final fprintf */
 		int width       = get_term_width() - 2;
-		int len_event   = strlen(event);
-		int len_str, max_len, cut = 0;
+		size_t len_event   = strlen(event);
+		size_t len_str, max_len, cut = 0;
 
 		/*
 		 * Maximum error index indent, we will cut
@@ -2342,7 +2342,7 @@ static void __parse_events_error__print(int err_idx, const char *err_str,
 
 	fprintf(stderr, "%s'%s'\n", str, buf);
 	if (idx) {
-		fprintf(stderr, "%*s\\___ %s\n", idx + 1, "", err_str);
+		fprintf(stderr, "%*s\\___ %s\n", (int)idx + 1, "", err_str);
 		if (err_help)
 			fprintf(stderr, "\n%s\n", err_help);
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 60fb9997ea0d..2aaedb581d83 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -263,7 +263,7 @@ void perf_session__delete(struct perf_session *session)
 static void swap_sample_id_all(union perf_event *event, void *data)
 {
 	void *end = (void *) event + event->header.size;
-	int size = end - data;
+	size_t size = end - data;
 
 	BUG_ON(size % sizeof(u64));
 	mem_bswap_64(data, size);
@@ -912,13 +912,13 @@ static void branch_stack__printf(struct perf_sample *sample,
 
 static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
 {
-	unsigned rid, i = 0;
+	unsigned int i = 0;
+	size_t rid;
 
 	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs[i++];
 
-		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid, arch), val);
+		printf(".... %-5s 0x%016" PRIx64 "\n", perf_reg_name((int)rid, arch), val);
 	}
 }
 
@@ -1452,7 +1452,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 */
 		if (!perf_data__is_pipe(session->data))
 			lseek(fd, file_offset + event->header.size, SEEK_SET);
-		err = tool->auxtrace(session, event);
+		err = (int)tool->auxtrace(session, event);
 		break;
 	case PERF_RECORD_AUXTRACE_ERROR:
 		perf_session__auxtrace_error_inc(session, event);
@@ -1506,7 +1506,7 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 	events_stats__inc(&evlist->stats, event->header.type);
 
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
-		return perf_session__process_user_event(session, event, 0, NULL);
+		return (int)perf_session__process_user_event(session, event, 0, NULL);
 
 	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
 }
@@ -1935,7 +1935,7 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 		perf_session__warn_about_errors(session);
 	ordered_events__free(&session->ordered_events);
 	auxtrace__free_events(session);
-	return err;
+	return (int)err;
 }
 
 static union perf_event *
@@ -2155,7 +2155,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
 				   session->header.needs_swap);
 	if (IS_ERR(event))
-		return PTR_ERR(event);
+		return (int)PTR_ERR(event);
 
 	if (!event)
 		return READER_NODATA;
@@ -2168,8 +2168,8 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	    (skip = rd->process(session, event, rd->file_pos, rd->path)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
 		       rd->file_offset + rd->head, event->header.size,
-		       event->header.type, strerror(-skip));
-		err = skip;
+			event->header.type, strerror((int)-skip));
+		err = (int)skip;
 		goto out;
 	}
 
@@ -2683,14 +2683,14 @@ int perf_event__process_id_index(struct perf_session *session,
 		if (!sid)
 			return -ENOENT;
 
-		sid->idx = e->idx;
+		sid->idx = (int)e->idx;
 		sid->cpu.cpu = e->cpu;
-		sid->tid = e->tid;
+		sid->tid = (pid_t)e->tid;
 
 		if (!e2)
 			continue;
 
-		sid->machine_pid = e2->machine_pid;
+		sid->machine_pid = (pid_t)e2->machine_pid;
 		sid->vcpu.cpu = e2->vcpu;
 
 		if (!sid->machine_pid)
@@ -2704,7 +2704,8 @@ int perf_event__process_id_index(struct perf_session *session,
 			perf_guest = true;
 		}
 
-		ret = perf_session__set_guest_cpu(session, sid->machine_pid, e->tid, e2->vcpu);
+		ret = perf_session__set_guest_cpu(session, sid->machine_pid,
+						(pid_t)e->tid, (int)e2->vcpu);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c51049087e4e..b7822aa8cc8c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -91,7 +91,7 @@ static int repsep_snprintf(char *bf, size_t size, const char *fmt, ...)
 	va_end(ap);
 
 	if (n >= (int)size)
-		return size - 1;
+		return (int)size - 1;
 	return n;
 }
 
@@ -392,7 +392,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 				       len, ip);
 	}
 
-	return ret;
+	return (int)ret;
 }
 
 int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width)
@@ -1339,7 +1339,7 @@ static int _hist_entry__addr_snprintf(struct map_symbol *ms,
 				       len, ip);
 	}
 
-	return ret;
+	return (int)ret;
 }
 
 static int hist_entry__addr_from_snprintf(struct hist_entry *he, char *bf,
@@ -2667,7 +2667,7 @@ static int __sort__hpp_width(struct perf_hpp_fmt *fmt,
 	if (!len)
 		len = hists__col_len(hists, hse->se->se_width_idx);
 
-	return len;
+	return (int)len;
 }
 
 static int __sort__hpp_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -2681,7 +2681,7 @@ static int __sort__hpp_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	if (!len)
 		len = hists__col_len(he->hists, hse->se->se_width_idx);
 
-	return hse->se->se_snprintf(he, hpp->buf, hpp->size, len);
+	return hse->se->se_snprintf(he, hpp->buf, hpp->size, (unsigned int)len);
 }
 
 static int64_t __sort__hpp_cmp(struct perf_hpp_fmt *fmt,
@@ -2918,7 +2918,7 @@ static int hde_width(struct hpp_dynamic_entry *hde)
 {
 	if (!hde->hpp.len) {
 		int len = hde->dynamic_len;
-		int namelen = strlen(hde->field->name);
+		int namelen = (int)strlen(hde->field->name);
 		int fieldlen = hde->field->size;
 
 		if (namelen > len)
@@ -2968,7 +2968,7 @@ static void update_dynamic_len(struct hpp_dynamic_entry *hde,
 			len = pos - str;
 
 			if (len > hde->dynamic_len)
-				hde->dynamic_len = len;
+				hde->dynamic_len = (unsigned int)len;
 			break;
 		}
 
@@ -3007,7 +3007,7 @@ static int __sort__hde_width(struct perf_hpp_fmt *fmt,
 	if (!len)
 		len = hde_width(hde);
 
-	return len;
+	return (int)len;
 }
 
 bool perf_hpp__defined_dynamic_entry(struct perf_hpp_fmt *fmt, struct hists *hists)
@@ -3256,7 +3256,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 
 	/* case 1 */
 	if (event_name[0] == '%') {
-		int nr = strtol(event_name+1, NULL, 0);
+		int nr = (int)strtol(event_name+1, NULL, 0);
 
 		if (nr > evlist->core.nr_entries)
 			return NULL;
@@ -4212,7 +4212,7 @@ char *sort_help(const char *prefix, enum sort_mode mode)
 {
 	struct strbuf sb;
 	char *s;
-	int len = strlen(prefix) + INDENT;
+	int len = (int)strlen(prefix) + INDENT;
 
 	strbuf_init(&sb, 300);
 	strbuf_addstr(&sb, prefix);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2fc4d0537840..f65bb4b76ccb 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -338,10 +338,10 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 
 	if (io__get_hex(io, &temp) != ':')
 		return false;
-	*maj = temp;
+	*maj = (u32)temp;
 	if (io__get_hex(io, &temp) != ' ')
 		return false;
-	*min = temp;
+	*min = (u32)temp;
 
 	ch = io__get_dec(io, inode);
 	if (ch != ' ') {
@@ -433,7 +433,7 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 	unsigned long long timeout = proc_map_timeout * 1000000ULL;
 	int rc = 0;
 	const char *hugetlbfs_mnt = hugetlbfs__mountpoint();
-	int hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
+	size_t hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
 
 	if (machine__is_default_guest(machine))
 		return 0;
@@ -815,7 +815,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		if (!isdigit(dent->d_name[0]))
 			continue;
 
-		_pid = strtol(dent->d_name, &end, 10);
+		_pid = (pid_t)strtol(dent->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -1043,7 +1043,7 @@ int perf_event__synthesize_threads(const struct perf_tool *tool,
 		return err;
 
 	if (nr_threads_synthesize == UINT_MAX)
-		thread_nr = sysconf(_SC_NPROCESSORS_ONLN);
+		thread_nr = (int)sysconf(_SC_NPROCESSORS_ONLN);
 	else
 		thread_nr = nr_threads_synthesize;
 
@@ -1829,7 +1829,7 @@ int perf_event__synthesize_id_sample(__u64 *array, u64 type, const struct perf_s
 		array++;
 	}
 
-	return (void *)array - (void *)start;
+	return (int)((void *)array - (void *)start);
 }
 
 int __perf_event__synthesize_id_index(const struct perf_tool *tool, perf_event__handler_t process,
@@ -2213,7 +2213,7 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
 	aligned_size = PERF_ALIGN(size, sizeof(u64));
 	padding = aligned_size - size;
 	ev.tracing_data.header.size = sizeof(ev.tracing_data);
-	ev.tracing_data.size = aligned_size;
+	ev.tracing_data.size = (__u32)aligned_size;
 
 	process(tool, &ev, NULL, NULL);
 
@@ -2227,7 +2227,7 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
 	if (write_padded(&ff, NULL, 0, padding))
 		return -1;
 
-	return aligned_size;
+	return (int)aligned_size;
 }
 #endif
 
@@ -2375,8 +2375,8 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 	struct perf_header *header = &session->header;
 	struct perf_record_header_feature *fe;
 	struct feat_fd ff;
-	size_t sz, sz_hdr;
-	int feat, ret;
+	size_t sz, sz_hdr, feat;
+	int ret;
 
 	sz_hdr = sizeof(fe->header);
 	sz = sizeof(union perf_event);
@@ -2394,7 +2394,7 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 
 	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
 		if (!feat_ops[feat].synthesize) {
-			pr_debug("No record header feature for header :%d\n", feat);
+			pr_debug("No record header feature for header :%zu\n", feat);
 			continue;
 		}
 
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 0f383418e3df..6a331743a099 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -112,7 +112,7 @@ enum target_errno target__parse_uid(struct target *target)
 		 * The user name not found. Maybe it's a UID number.
 		 */
 		char *endptr;
-		int uid = strtol(str, &endptr, 10);
+		int uid = (int)strtol(str, &endptr, 10);
 
 		if (*endptr != '\0')
 			return TARGET_ERRNO__INVALID_UID;
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c6a0a27b12c2..09cd14854aa5 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -180,7 +180,7 @@ static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
 	unsigned int new_sz = 1;
 
 	if (thread_stack__per_cpu(thread) && cpu > 0)
-		new_sz = roundup_pow_of_two(cpu + 1);
+		new_sz = (unsigned int)roundup_pow_of_two(cpu + 1);
 
 	if (!ts || new_sz > old_sz) {
 		new_ts = calloc(new_sz, sizeof(*ts));
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 89585f53c1d5..c108f238012e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -309,7 +309,7 @@ static int __thread__comm_len(struct thread *thread, const char *comm)
 {
 	if (!comm)
 		return 0;
-	thread__set_comm_len(thread, strlen(comm));
+	thread__set_comm_len(thread, (int)strlen(comm));
 
 	return thread__var_comm_len(thread);
 }
@@ -544,7 +544,7 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 
 	addr_location__exit(&al);
 
-	return dso__data_read_offset(dso, machine, offset, buf, len);
+	return (int)dso__data_read_offset(dso, machine, offset, buf, len);
 }
 
 void thread__free_stitch_list(struct thread *thread)
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index b5f12390c355..141fbb819a65 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -93,7 +93,7 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	while ((dirent = readdir(proc)) != NULL) {
 		char *end;
 		bool grow = false;
-		pid_t pid = strtol(dirent->d_name, &end, 10);
+		pid_t pid = (pid_t)strtol(dirent->d_name, &end, 10);
 
 		if (*end) /* only interested in proper numerical dirents */
 			continue;
@@ -195,7 +195,7 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 		return NULL;
 
 	strlist__for_each_entry(pos, slist) {
-		pid = strtol(pos->s, &end_ptr, 10);
+		pid = (pid_t)strtol(pos->s, &end_ptr, 10);
 
 		if (pid == INT_MIN || pid == INT_MAX ||
 		    (*end_ptr != '\0' && *end_ptr != ','))
@@ -259,7 +259,7 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		return NULL;
 
 	strlist__for_each_entry(pos, slist) {
-		tid = strtol(pos->s, &end_ptr, 10);
+		tid = (pid_t)strtol(pos->s, &end_ptr, 10);
 
 		if (tid == INT_MIN || tid == INT_MAX ||
 		    (*end_ptr != '\0' && *end_ptr != ','))
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 3b7f390f26eb..f13d5c1e3cd7 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -134,7 +134,7 @@ static int skipn(int fd, off_t n)
 	while (n > 0) {
 		ret = read(fd, buf, min(n, (off_t)sizeof(buf)));
 		if (ret <= 0)
-			return ret;
+			return (int)ret;
 		n -= ret;
 	}
 
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index ec72d29f3d58..e44dbceaa88b 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -197,7 +197,7 @@ static void perf_read_values__display_pretty(FILE *fp,
 	tidwidth = 3;
 	pidwidth = 3;
 	for (j = 0; j < values->num_counters; j++)
-		counterwidth[j] = strlen(evsel__name(values->counters[j]));
+		counterwidth[j] = (int)strlen(evsel__name(values->counters[j]));
 	for (i = 0; i < values->threads; i++) {
 		int width;
 
@@ -251,7 +251,7 @@ static void perf_read_values__display_raw(FILE *fp,
 			tidwidth = width;
 	}
 	for (j = 0; j < values->num_counters; j++) {
-		width = strlen(evsel__name(values->counters[j]));
+		width = (int)strlen(evsel__name(values->counters[j]));
 		if (width > namewidth)
 			namewidth = width;
 		width = snprintf(NULL, 0, "%x", values->counters[j]->core.idx);
-- 
2.49.0.504.g3bcea36a83-goog

