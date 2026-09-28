Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778833E40FD;
	Mon, 28 Sep 2026 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574673; cv=none; b=jCMqlPbSFt8rPqsplaz7IJ0FWd+KM6sXd27OR5G/Tx5nJT41lkUJJrSNsQ4LjbhTlgyLRIMMkpg1OZb6+jdXlco+PkYU8iCucX31+PB2WtOYCi600kKpzGVwZnsQatLnEPLXGBG1CEwo+uOh2E9RwQDnuFW+/7BZh9A7SSrnBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574673; c=relaxed/simple;
	bh=zjeL/KRkKZVgemOpCg4SL6bmj/UnsXeLf66oxJltyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChbhgiHkT9nGsPz2l0z/QS+I/edpR2UK0LYj2GCSg0x39fvwhKy/MBdIyuVkBX9Gul9hIAX8AYC9hhDp2Ma7oW3A8RMXWuL9o0q05obcoFHbK8+J3WWqcFkI1cOMkgdODUoxLeYj0ZBYdT1/2Mcb44UkcpbVjGbpptc8D6oDLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMkIomYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMkIomYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3421F0089B;
	Mon, 28 Sep 2026 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574667;
	bh=1VBbcjzKmHeGO8HMOQnNDIghmBXHiruF5omxahI7Y6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMkIomYl9vi6y27UdbJJJfoueGQrSndn+yvUJ8JKZacyZ1VgT73GMFarK22gHKx4k
	 QFj6D+MqHhXn85bE6IhS4HZ8PXEUqDrqCmIGQi07sluMB1ZkzxxhMnzzEl+k+hUsrv
	 NJGOr/hyKdmKilYQVPvOhtUSEUsrGKN2ve9g5xixAqefRoymaoYb930MDmAAqYC3ek
	 oz+9cJ16bLw/m871pp+B1attpsUHchHt1JcUin2lYaqOJE9U2Zr+tjbvpte4Pjfccx
	 eDgPjxmfAQbAzzxv6xsQAdpCknGvH8N6EjcYiV5wc1g6MHuNgss+M6FLrllYhildCv
	 foukpwE4jEVag==
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
Subject: [PATCH v1 8/8] perf tools: Update debuginfo__new() to take DSO
Date: Sun, 27 Sep 2026 22:50:55 -0700
Message-ID: <20260928055055.95144-9-namhyung@kernel.org>
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

It should be the common case to get debuginfo from existing DSOs.
Now dso__debuginfo() calls it with its debuginfo type to avoid the
unnecessary loop to find the location of debug file.

Update existing function to debuginfo__from_path() for clarity.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c   | 28 ++++++++++++++++++----------
 tools/perf/util/debuginfo.h   | 13 +++++++++++--
 tools/perf/util/dso.c         | 11 ++---------
 tools/perf/util/probe-event.c |  4 ++--
 4 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index fc2640dcd29d3aaa..db188c397d63880c 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -91,13 +91,27 @@ static struct debuginfo *__debuginfo__new(const char *path)
 	return dbg;
 }
 
-struct debuginfo *debuginfo__new(const char *path)
+struct debuginfo *debuginfo__new(struct dso *dso)
+{
+	struct debuginfo *dinfo;
+	char *path;
+	bool decomp = false;
+
+	dso__find_dbginfo_type(dso);
+	path = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
+	if (path == NULL)
+		return NULL;
+
+	dinfo = __debuginfo__new(path);
+	dso__put_filename(dso, path, decomp);
+	return dinfo;
+}
+
+struct debuginfo *debuginfo__from_path(const char *path)
 {
 	struct dso *dso;
 	struct debuginfo *dinfo;
 	struct build_id bid = { .size = 0 };
-	char *filename;
-	bool decomp = false;
 
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
@@ -112,13 +126,7 @@ struct debuginfo *debuginfo__new(const char *path)
 	if (filename__read_build_id(path, &bid) > 0)
 		dso__set_build_id(dso, &bid);
 
-	dso__find_dbginfo_type(dso);
-	filename = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
-	if (filename == NULL)
-		return NULL;
-
-	dinfo = __debuginfo__new(filename);
-	dso__put_filename(dso, filename, decomp);
+	dinfo = debuginfo__new(dso);
 	dso__put(dso);
 
 	return dinfo;
diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
index a52d69932815cd72..ade40d54ea125988 100644
--- a/tools/perf/util/debuginfo.h
+++ b/tools/perf/util/debuginfo.h
@@ -18,8 +18,12 @@ struct debuginfo {
 	const unsigned char	*build_id;
 };
 
+struct dso;
+
 /* This also tries to open distro debuginfo */
-struct debuginfo *debuginfo__new(const char *path);
+struct debuginfo *debuginfo__from_path(const char *path);
+/* Create a debuginfo using information in DSO */
+struct debuginfo *debuginfo__new(struct dso *dso);
 void debuginfo__delete(struct debuginfo *dbg);
 
 int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
@@ -31,7 +35,12 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 struct debuginfo {
 };
 
-static inline struct debuginfo *debuginfo__new(const char *path __maybe_unused)
+static inline struct debuginfo *debuginfo__from_path(const char *path __maybe_unused)
+{
+	return NULL;
+}
+
+static inline struct debuginfo *debuginfo__new(struct dso *dso __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9c8b963906a7e88c..f8b5528427765b02 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2086,17 +2086,10 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 
 struct debuginfo *dso__debuginfo(struct dso *dso)
 {
-	char *name;
-	bool decomp = false;
-	struct debuginfo *dinfo = NULL;
+	struct debuginfo *dinfo;
 
 	mutex_lock(dso__lock(dso));
-
-	name = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
-	if (name) {
-		dinfo = debuginfo__new(name);
-		dso__put_filename(dso, name, decomp);
-	}
+	dinfo = debuginfo__new(dso);
 	mutex_unlock(dso__lock(dso));
 	return dinfo;
 }
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 11ae4a09412c9bd9..1534280c0c1d59cb 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -519,7 +519,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
 		pr_debug("Load debuginfo from debuginfod (%s)\n", path);
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = debuginfo__new((const char *)path);
+	ret = debuginfo__from_path((const char *)path);
 	nsinfo__mountns_exit(&nsc);
 	return ret;
 }
@@ -567,7 +567,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 		path = dso__long_name(dso);
 	}
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = debuginfo__new(path);
+	ret = debuginfo__from_path(path);
 	if (!ret && !silent) {
 		pr_warning("The %s file has no debug information.\n", path);
 		if (!module || !strtailcmp(path, ".ko"))
-- 
2.55.0

