Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6D2135D1
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876066; cv=none; b=hmjdRINzqlzknArrb7pVQTfc9AQGctqRRLyFM1WpNAawqyEY7jwLaxS3SGhyTFZqE+HmHBBYXdV43p1bralDYW10+qirJ0N1FD/ZkC9MMrYyPe85jBr6dODkwRUonao9CdtuuUpEWXxWQNxAXRzcHGhoITMYz7iP9WZSE9jBtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876066; c=relaxed/simple;
	bh=9lFs23nhfZvzu0Mj5gCbGsdPtLWWA75vQnigtb7zG2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=POAXoKyG1ma51YlOpKJqsGRclw3s/lj+Zo/PlVh/lD8zHfbZ++pVtFpRvSI4fnrjn4Vm6Lj5NnBeIMyEeEeUbGvam1PJMqWFS1X97h1lp47K18uPuMBV5taHK33Ux5ePuFkqB9S+cZ3P4BjnCjNFGq+NJ//+9PRmG2mRqFJYH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDfRaPk3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDfRaPk3"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af5156fbe79so6016151a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745876064; x=1746480864; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzxXgRFN2UGn9FhDNQufHxyUI8OddqfRc8hra+lL44Y=;
        b=LDfRaPk3iKTtlh/eEAsUOK8KqGwMISjiGPm6iRnX2dL397SEk0ZPJ74Dhcp7m2R+OV
         1bzVgb3saTofowqdXcl1yBtfgidkomd7JbjrnuwlxrbPXLYTCgX6GAMkKVC3qv63hvx9
         yBWhFuWbqWcJdf3oT4L8SFrk2Ub3AYfkAWA92mWcyvxl+1yx+HxJNojJ6yUTI+3s5teg
         ixyWlglIYYeIi0FPrXm2NgoMkWHGvTZGWNb/mL1KM+csIvR4KPVIP1vi+Vaq0dkRk3XD
         MQEyO2yZZJ9WZbEUceFBMZd/2VP82c65oxeNV2sgPhZUA6/9/+9F89mCUEpbG8TJLf2S
         1qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876064; x=1746480864;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzxXgRFN2UGn9FhDNQufHxyUI8OddqfRc8hra+lL44Y=;
        b=IqUOaQI4DQV72TbLJA3YbL2SCjZ3sFuoDwK7926x42XBozWJG+/53WG6CS6ezE8nU5
         l8K7oGman1mHVSVTL10Eg4002/OcW0QUjzI7D1kecN5W4uhAsjUlOzunO8iZNbbL5dWC
         G4ggsHs+10YEFpFmiTqSr/u0mGpvylMjTG08VyjzSykKeXmqXAT0qQvg3ctAym9ZoWQb
         3d0qXX1AhPl2RuKNfz48y8GVGxYVjlkRU9GBVOh0JGF1UNWrtzurcUcmRjwiSVcLCcZg
         9hRZDzpmcHL97QvD3HHFqFDrxwY5X9whWfMgUJ+QCK2Ag+OsIdkMnvoxn/XVhDShbK4k
         XBXg==
X-Forwarded-Encrypted: i=1; AJvYcCWCLBmU1dXgVtvS+bXOZw8l97qHAiD1MdFlp2FxZQfEFI1ZWcTjY8mqPhcDEJIIIcY+jishFxyYxEJ83dgJvQ3v@vger.kernel.org
X-Gm-Message-State: AOJu0YzixtbWU3+eI7JKV+iWJ5hWF/o64T3D+pAIctcoX/K6C7KQVzUW
	KnhuBXIzTz5EJ3uxgRnkmYDpwPymZG5Dj7KlYue+KP5DXRtic9lYvcBSJHffjGkkyCsT+bdwgj7
	lvcky2g==
X-Google-Smtp-Source: AGHT+IHQ+3fvZJZBirX+hKlkf4n2BDlXYbytD3KHk+S5P5S4UjHXnDX8BeCp6mikTekER78DQoH9ifZMgv81
X-Received: from pgar18.prod.google.com ([2002:a05:6a02:2e92:b0:af9:775:2e8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d27:b0:1f5:60ce:6cc6
 with SMTP id adf61e73a8af0-2046a58d8c8mr13745484637.21.1745876063759; Mon, 28
 Apr 2025 14:34:23 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:34:05 -0700
In-Reply-To: <20250428213409.1417584-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428213409.1417584-7-irogers@google.com>
Subject: [PATCH v3 6/9] perf build-id: Ensure struct build_id is empty before use
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index c6f369b5d893..6e3d79730538 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -343,7 +343,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 		  struct symsrc *runtime_ss __maybe_unused,
 		  int kmodule __maybe_unused)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	ret = fd__is_64_bit(ss->fd);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 30750ed313ca..41420d5f4001 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1804,7 +1804,6 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
 	bool perfmap;
-	struct build_id bid;
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
@@ -1865,6 +1864,8 @@ int dso__load(struct dso *dso, struct map *map)
 	 */
 	if (!dso__has_build_id(dso) &&
 	    is_regular_file(dso__long_name(dso))) {
+		struct build_id bid = { .size = 0, };
+
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
 		if (filename__read_build_id(name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
@@ -2113,7 +2114,7 @@ static bool filename__readable(const char *file)
 
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
2.49.0.901.g37484f566f-goog

