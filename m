Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99010256C93
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493623; cv=none; b=LGHhq33aS0Fx7wUdHLeseYXwWpxroC+dZFPM35pR50Wiqp6xuvUV8i1edJj+fM+LC0yOOYrDfksK7obYIki4M90/JG/VCixwBZtlKAUzYXgqoPGbM16+14GtIJ5Dt+pX1jso/UFJp8cZtBeagX2kDQayUqLmbTeJtn98CvkuAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493623; c=relaxed/simple;
	bh=hrgDm6073NKSgZmuRNrlZjmYOWa6YgnSkn2Bjf0yw1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Pl+xjnXfZHveMHEBeF6ErCADovYm2RJerB8VnZkXGSTuR8mMejp/9K5JV4dRvSQDoXZixGtUBiBRYSqjGn1qqxRNqz81aHGdK4oLAIBp/G4vrV/e6IKHm7APKWxtjwFBcwR6xZACDXgBOJgywJvFaCQYhiAdOZrthtg+CcwxezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jntMQ+WY; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jntMQ+WY"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4066fdc6c85so277867b6e.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493618; x=1749098418; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/4nfLMgZpzjPI0//QABIjXhhHcB64OFKqXFaV6Z4bE=;
        b=jntMQ+WY/GCPbVZjfuuuBlRthumNRhAxTVC9dDsEDmR17S/jhslrtCbY4U0xVYqtSg
         3estE5aWVstMBLIABRmBinDJC8agNDPiYA4WbaMRErzAPWjOqGzvn5ko6gZovZLAGaSr
         lB7sxJ+ay4xY+g1kNxadfj8KmIGdKMspIyXCAyzklYTkkDOAX3dWRLEVfdl4v3tNDwjA
         pS8dnxZZZNSCSH15l8yw0b64kXRJ7Csal2QdvXUp2TOCfFGlOFdSrTqfCSZeXBLoltM2
         lIIL/zyFVSBKPyzucawkw6BVeDtl/GEjASGDIQE7WCxHKR2tD+dTXTESguw3oqOKlHzG
         9tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493618; x=1749098418;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/4nfLMgZpzjPI0//QABIjXhhHcB64OFKqXFaV6Z4bE=;
        b=PKwERkBPRghrt/Pkyiie2e27ReUfsabCQkRUkWt2AC2OgVn+IgfTGrnk+eQvciKN6o
         C5RMI7ei/5yzVBeqVwUMtRv0v9mheMgVt5p04JrFueJ/TZb8GecIbE8v331kIgSA8Pk1
         /+2iujSHlc/s10VOIwcOQcVk7Hr2HtR+76fNtf5uz1/DJlZolj80nAjAoaaTLZqvIcGp
         heibhRQAPJyBy55hrAKYT13MaVWLgiSB7P0vvBJ2CTOh/JGvnSd6cGgqL5Vjxw2Ox6la
         aWoi4BbYH9i94SPl5epryBsfcvJuHZVI7g2WMkvIFHhsqzlXhwPwwwXW/+Qs9ZY7aP7P
         a6ew==
X-Forwarded-Encrypted: i=1; AJvYcCUDiNW77aA6XC4ZhwG6sSKnKGRuWTrl+5dT3hK/4YwcRtd0UhclnXs7LcQHKBDxA8wafaIONw6Pj8bGixbGc+1w@vger.kernel.org
X-Gm-Message-State: AOJu0YyradFyAN1w2kk6oJwaX5S12p7HvgI13HuffBatuGKHTEtCuzWF
	YBbly1mH1OFAvp+Sl1OqOtuPbUeMgJ6p2AjzMz/1DvJPThX+GaHb7+NgbTu2ITE+lxQn5HMgjMF
	OYML9xDzNNA==
X-Google-Smtp-Source: AGHT+IENFligdelPdiwHRPX0P9XtMn74tYe9bLeP7jO9zz9croZ9oZmT7qzbt5nQGNBRog7N7al92g6G0Oe1
X-Received: from oabut1.prod.google.com ([2002:a05:6870:ad81:b0:2bc:6267:d082])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:80b2:b0:400:32b9:7926
 with SMTP id 5614622812f47-406468101b9mr10531127b6e.6.1748493618533; Wed, 28
 May 2025 21:40:18 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:42 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-7-irogers@google.com>
Subject: [PATCH v4 06/24] perf build-id: Ensure struct build_id is empty
 before use
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

If a build ID is read then not all code paths may ensure it is empty
before use. Initialize the build_id to be zero-ed unless there is
clear initialization such as a call to build_id__init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/inject-buildid.c  | 2 +-
 tools/perf/builtin-buildid-cache.c | 8 ++++----
 tools/perf/tests/pe-file-parsing.c | 2 +-
 tools/perf/tests/sdt.c             | 2 +-
 tools/perf/util/build-id.c         | 6 +++---
 tools/perf/util/debuginfo.c        | 2 +-
 tools/perf/util/probe-event.c      | 3 ++-
 tools/perf/util/probe-finder.c     | 3 ++-
 tools/perf/util/symbol-minimal.c   | 2 +-
 tools/perf/util/symbol.c           | 5 +++--
 tools/perf/util/synthetic-events.c | 2 +-
 11 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index f55c07e4be94..aad572a78d7f 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -80,7 +80,7 @@ static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
 		   int typeflag, struct FTW *ftwbuf __maybe_unused)
 {
 	struct bench_dso *dso = &dsos[nr_dsos];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 
 	if (typeflag == FTW_D || typeflag == FTW_SL)
 		return 0;
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 3f7739b21148..e936a34b7d37 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -175,7 +175,7 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int err;
 	struct nscookie nsc;
 
@@ -198,7 +198,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	struct nscookie nsc;
 
 	int err;
@@ -275,7 +275,7 @@ static int build_id_cache__purge_all(void)
 static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 {
 	char filename[PATH_MAX];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
@@ -303,7 +303,7 @@ static int build_id_cache__fprintf_missing(struct perf_session *session, FILE *f
 static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	struct nscookie nsc;
 
 	int err;
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index fff58b220c07..30c7da79e109 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -24,7 +24,7 @@ static int run_dir(const char *d)
 {
 	char filename[PATH_MAX];
 	char debugfile[PATH_MAX];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	char debuglink[PATH_MAX];
 	char expect_build_id[] = {
 		0x5a, 0x0f, 0xd8, 0x82, 0xb5, 0x30, 0x84, 0x22,
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 919712899251..de4c7916b40d 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -28,7 +28,7 @@ static int target_function(void)
 static int build_id_cache__add_file(const char *filename)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int err;
 
 	err = filename__read_build_id(filename, &bid);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 3386fa8e1e7e..1abd5a670665 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -95,7 +95,7 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuild_id_size)
 {
 	char notes[PATH_MAX];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	if (!root_dir)
@@ -112,7 +112,7 @@ int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuil
 
 int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sbuild_id_size)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	ret = filename__read_build_id(pathname, &bid);
@@ -849,7 +849,7 @@ static int filename__read_build_id_ns(const char *filename,
 
 static bool dso__build_id_mismatch(struct dso *dso, const char *name)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	bool ret = false;
 
 	mutex_lock(dso__lock(dso));
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index b5deea7cbdf2..a44c70f93156 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -103,7 +103,7 @@ struct debuginfo *debuginfo__new(const char *path)
 	char buf[PATH_MAX], nil = '\0';
 	struct dso *dso;
 	struct debuginfo *dinfo = NULL;
-	struct build_id bid;
+	struct build_id bid = { .size = 0};
 
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..3c87aa6f7d3b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1063,7 +1063,6 @@ static int sprint_line_description(char *sbuf, size_t size, struct line_range *l
 static int __show_line_range(struct line_range *lr, const char *module,
 			     bool user)
 {
-	struct build_id bid;
 	int l = 1;
 	struct int_node *ln;
 	struct debuginfo *dinfo;
@@ -1088,6 +1087,8 @@ static int __show_line_range(struct line_range *lr, const char *module,
 			ret = -ENOENT;
 	}
 	if (dinfo->build_id) {
+		struct build_id bid;
+
 		build_id__init(&bid, dinfo->build_id, BUILD_ID_SIZE);
 		build_id__sprintf(&bid, sbuild_id);
 	}
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 3cc7c40f5097..1bbb91758316 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -848,7 +848,6 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
 /* Find probe points from lazy pattern  */
 static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 {
-	struct build_id bid;
 	char sbuild_id[SBUILD_ID_SIZE] = "";
 	int ret = 0;
 	char *fpath;
@@ -858,6 +857,8 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 
 		comp_dir = cu_get_comp_dir(&pf->cu_die);
 		if (pf->dbg->build_id) {
+			struct build_id bid;
+
 			build_id__init(&bid, pf->dbg->build_id, BUILD_ID_SIZE);
 			build_id__sprintf(&bid, sbuild_id);
 		}
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index d8da3da01fe6..7fcba821bbe5 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -345,7 +345,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 		  struct symsrc *runtime_ss __maybe_unused,
 		  int kmodule __maybe_unused)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	ret = fd__is_64_bit(ss->fd);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index aa46364f1ab8..dddc02ed8b2f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1806,7 +1806,6 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
 	bool perfmap;
-	struct build_id bid;
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
@@ -1867,6 +1866,8 @@ int dso__load(struct dso *dso, struct map *map)
 	 */
 	if (!dso__has_build_id(dso) &&
 	    is_regular_file(dso__long_name(dso))) {
+		struct build_id bid = { .size = 0, };
+
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
 		if (filename__read_build_id(name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
@@ -2115,7 +2116,7 @@ static bool filename__readable(const char *file)
 
 static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	char sbuild_id[SBUILD_ID_SIZE];
 	bool is_host = false;
 	char path[PATH_MAX];
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 68bb7c5fe1b1..b7ebee95536f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -368,7 +368,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 					     struct machine *machine,
 					     bool is_kernel)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	struct nsinfo *nsi;
 	struct nscookie nc;
 	struct dso *dso = NULL;
-- 
2.49.0.1204.g71687c7c1d-goog

