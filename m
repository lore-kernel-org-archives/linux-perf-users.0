Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370E3E0241;
	Mon, 28 Sep 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574671; cv=none; b=WpMVQlVDXxU6QZKpUSCdRQEnCvMSgcJG2beVOC3BJU5qq/44R9DSAH7aoHM+tW16Kx4/x5CmwoQyboE5Z0KFAGg2cDCZTbNZH4klSkNe25wosB6raWZjm+Nt/h9DrMNqdx+N1usYDKN/rRMrhjS8sOxIIoQ6nO2GJQs/DPfiYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574671; c=relaxed/simple;
	bh=KHjA4f/G/mEAql7DDLskaouv1kgTzqJWo2T8YnERQkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJpdQxxqme8sSHfdYpwj7gEIHyfaRw5MG5dG0dx+w6tg3r7ffMHRHmLjEPfPNsVuoQnOvlpsV1+HIxwrXt/yXevFMeUo4vKSXj00Agcj5D2m5RjZnroe0xu0gMKLF56qJUF2M5tEAemlC+KYoEQMme5H2EsLZnCRPFXThPkWSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blRavgt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blRavgt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC4E1F00893;
	Mon, 28 Sep 2026 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574665;
	bh=RXMAqe1/mHO85FxwruaKfNmAB1xa63jb59I57+0Yjm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=blRavgt3DY73rNov0mMZ+/FLHiXwkZRTUCtLPvLeWdtxSons0SAGjkcb4zPK3MDA9
	 XvBG9aHasXoR0OyvLnbmpxETHFyb64S1fkrrK4LpkOS5nB/uw2/1NNK3AGvEgGV+28
	 6qvi8D3nzG7gcaEFsuxGrkqADrZ8LvYknBZEm20Y/CGcy90ApgLhjLSFCFI7GkQ5+T
	 tsJbQkoeMllGBPyrJlIwoa31WKkSCYVa+bcPWR1sux95Dc5AwnxgX9Nargbqr1sZFy
	 UUSieFBH/NtnYBrB/5qho1HC3gVZLtOkB0h1BOhb9faFzUgemj4G24V0t3GVOWhn+q
	 fmBK/i4Z7E6OA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 4/8] perf tools: Export dso__get_filename() with type argument
Date: Sun, 27 Sep 2026 22:50:51 -0700
Message-ID: <20260928055055.95144-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928055055.95144-1-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dso__get_filename() returns a new string of filepath for the given
binary type.  It handles chroot and decompressed kernel modules so that
callers can read the file contents.  Thus it'd be better to use it to
check available binary types.

Add a type argument to handle a different path for symbol or debug info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c | 17 +++++++++++------
 tools/perf/util/dso.c       | 27 +++++++++++++++++----------
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 2669d5f5ee6121d4..38e9299765182bd7 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -93,10 +93,11 @@ static struct debuginfo *__debuginfo__new(const char *path)
 
 struct debuginfo *debuginfo__new(const char *path)
 {
-	char buf[PATH_MAX], nil = '\0';
 	struct dso *dso;
-	struct debuginfo *dinfo = NULL;
-	struct build_id bid = { .size = 0};
+	struct debuginfo *dinfo;
+	struct build_id bid = { .size = 0 };
+	char *filename;
+	bool decomp = false;
 
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
@@ -112,11 +113,15 @@ struct debuginfo *debuginfo__new(const char *path)
 		dso__set_build_id(dso, &bid);
 
 	dso__find_dbginfo_type(dso);
-	if (dso__read_binary_type_filename(dso, dso__dbginfo_type(dso), &nil,
-					   buf, PATH_MAX) < 0)
+	filename = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
+	if (filename == NULL)
 		return NULL;
 
-	dinfo = __debuginfo__new(buf);
+	dinfo = __debuginfo__new(filename);
+
+	if (decomp)
+		unlink(filename);
+	free(filename);
 	dso__put(dso);
 
 	return dinfo;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 512f2bb61e8f2a2f..52f3e78c37220780 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -590,8 +590,8 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
 }
 
-static char *dso__get_filename(struct dso *dso, const char *root_dir,
-			       bool *decomp)
+char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
+			enum dso_binary_type type)
 {
 	char *name = malloc(PATH_MAX);
 
@@ -600,8 +600,7 @@ static char *dso__get_filename(struct dso *dso, const char *root_dir,
 	if (name == NULL)
 		return NULL;
 
-	if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
-					    root_dir, name, PATH_MAX))
+	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
 		goto out;
 
 	if (!is_regular_file(name)) {
@@ -671,7 +670,8 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 
 	mutex_lock(dso__lock(dso));
 
-	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
+	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp,
+				 dso__binary_type(dso));
 	if (name) {
 		fd = do_open(name);
 	} else {
@@ -2087,7 +2087,7 @@ struct debuginfo *dso__debuginfo(struct dso *dso)
 
 	mutex_lock(dso__lock(dso));
 
-	name = dso__get_filename(dso, "", &decomp);
+	name = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
 	if (name)
 		dinfo = debuginfo__new(name);
 
@@ -2121,17 +2121,24 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
-	char buf[PATH_MAX];
+	char *path;
+	bool found, decomp = false;
 
 	if (dso__dbginfo_type(dso) != DSO_BINARY_TYPE__NOT_FOUND)
 		return;
 
 	for (type = dbginfo_types; *type != DSO_BINARY_TYPE__NOT_FOUND; type++) {
-		if (dso__read_binary_type_filename(dso, *type, "",
-						   buf, PATH_MAX) < 0)
+		path = dso__get_filename(dso, "", &decomp, *type);
+		if (path == NULL)
 			continue;
 
-		if (filename__has_section(buf, ".debug_info"))
+		found = filename__has_section(path, ".debug_info");
+
+		if (decomp)
+			unlink(path);
+		free(path);
+
+		if (found)
 			break;
 	}
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index a152957322f6b31c..94cc7ea89ceb5bd9 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -841,6 +841,8 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
 char dso__symtab_origin(const struct dso *dso);
 int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
 				   const char *root_dir, char *filename, size_t size);
+char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
+			enum dso_binary_type type);
 bool is_kernel_module(const char *pathname, int cpumode);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
-- 
2.55.0

