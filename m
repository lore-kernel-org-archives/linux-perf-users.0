Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E2EBDC3
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374810; cv=none; b=R7hJypg8E4nWYz3rKfpC3OFJZpUnD6+KlO3Ugyc7rYz0SkX8z550mQYsyGJYXtufaGIPG2+85OgGcczVmAU5GY6aZ8wqUKd0dWeb/u/kHpJ6hdvPh80FhCMMG+ce3uU0yUwpwYwk8r3ZjjX0l0j41XGzSq5Bs+3BINM+T6/SOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374810; c=relaxed/simple;
	bh=jWmhHDZHMj/3vn0T7Yg57/66qyMX0GILKf6742UzDIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eZqgUk+l50IHbDdITLKbgbJyfCzoLpbgV+DGL1gxTFabcrSwKvZL6GblmqaLdO00M6KvAkaO8AFyJFGJu5dWeZszTO3cYxcPdqinDgPheJ47tPt8CEuv+ts2XFAAifnQRI9XTo4cUA6tCbyGwnjq0E2r9aU37r1Y+Z0XcokzixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVilWEzi; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVilWEzi"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-73e7a59e56cso1666182a34.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374807; x=1753979607; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8rjfFzd/+TAfQBkNwQcdwCN90rmJcS2goaVAmuWKh4=;
        b=fVilWEzisKewcIKQ/VuE2GrYq9psuDo2oh9HyLZBQTd5LpWOPtth/D2aVt/+pO5Lil
         4b7d2w4t2sawZ1rnqJSvEd7Fvt3vELwTdEbYz61DH/I6Pz7zIXcuGIeIsUtudHJfHJKr
         6bblw3HAPLifH/rNQWOoAUerLV2L4LpdulUUoy4Cok1tjix7tddGtIvVIuDoWAAaxmmZ
         R6+RRKkFxt5iOqINr+rqK0rs7Mn/DeIUlPui+xS0ZftOiLPSqwP66yDpHotYEOIaHR1T
         JTRAJOm2Bgt5RWVTqncPXSKdjGfoyDFLYZUKJmruLI0pY2B2YM/lR2gc9rOsjS7AMkBk
         d49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374807; x=1753979607;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8rjfFzd/+TAfQBkNwQcdwCN90rmJcS2goaVAmuWKh4=;
        b=Y5p6hQmgQWpYbt0x7yeYRk0TSWJb7RlBE+3r3PYuiI/2uEUoR/u0PdUrRtBfg8Bl7l
         brn9X06jFLBBTjB+B+YeDEf9VHV0hjyJWHDZtcIP75N8nZySvWXskoSkBTP8u/s48abK
         /hb5r+Ur8t+Pw+L7YcPARp1E/PsgWE43J1oJSO/ivuj9yzCt3fdVJ00ue9bVJm7ecmuo
         ybjkgmrVsEX+TW17AQnwoALLTXnZvyEf7n06/lBr9N23kOitxlZCd5LnFyanHHMZgrAK
         Duafu0AR7Roz7eK2wA1NePMX+p8J71BDF5i4HpGySzUWqZJOB0WM8SRbWeMP3g5mh+3o
         /dXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqGADmsu/yXPW0urzaMLFBhOnZp3fQIFGTwYrySLDKwyOOOh70iDGCS8L0gMyckaXneG7jPUybi6lofQ6EDERi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7svOYl2khSFs3QQ0oDVSxW1+i7mIaAVxangtsykiOTlH+N0sa
	64jMYIn27B/A3Lw0Pq+Dlz1MMmeza8DMFXrn+3FWAyzALhFG+8qKww04VMCVYj1Nr5iXR9qpJz4
	xiNJLBivBAw==
X-Google-Smtp-Source: AGHT+IGeB/DLDZyaNVsHJ4AdldqG7OAmJC6adn7cWB80Ve9eLfKQAPhnQItfzN+IISZ5vKzoha8DgZyIV7TB
X-Received: from oabti11.prod.google.com ([2002:a05:6871:890b:b0:2c8:7806:5ad0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:270e:b0:735:b9db:5939
 with SMTP id 46e09a7af769-74088ab9e84mr6005118a34.10.1753374807417; Thu, 24
 Jul 2025 09:33:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:45 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-6-irogers@google.com>
Subject: [PATCH v6 05/22] perf build-id: Ensure struct build_id is empty
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index cb777b878a48..e11c1be5c6d5 100644
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
 		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	}
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index b74f6fe24bb6..5ffd97ee4898 100644
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
 			build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 		}
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index c73fe2e09fe9..7201494c5c20 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -317,7 +317,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 		  struct symsrc *runtime_ss __maybe_unused,
 		  int kmodule __maybe_unused)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	ret = fd__is_64_bit(ss->fd);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 573c65da9fe0..e816e4220d33 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1813,7 +1813,6 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
 	bool perfmap;
-	struct build_id bid;
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
@@ -1874,6 +1873,8 @@ int dso__load(struct dso *dso, struct map *map)
 	 */
 	if (!dso__has_build_id(dso) &&
 	    is_regular_file(dso__long_name(dso))) {
+		struct build_id bid = { .size = 0, };
+
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
 		if (filename__read_build_id(name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
@@ -2122,7 +2123,7 @@ static bool filename__readable(const char *file)
 
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
2.50.0.727.gbf7dc18ff4-goog

