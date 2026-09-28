Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BB3E0230;
	Mon, 28 Sep 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574670; cv=none; b=t8Q6Uy4lvj1HqIpHRPqFG47mdD4EE5ldyotA8czHUp4T3qbh6jn/rBYe+3NtMWF3FZTymr/mB8y8PpMKjgv/YXCcfORSkDzsE6m+Isnq5PA7I3DTih9iSVmc/C/+2P2M9h5FWsS65HdXojxKIGeO0uoTekLnGzlMU0XGZBAqyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574670; c=relaxed/simple;
	bh=cW0lP5hKAZ5iSIaz1jnN39xf0FYa50ttVZNTEVNLwuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7H1m8IA3RhUCd1musSYMTlgjLs+B9X8/VlRoZVeEiBzYHLgCP0kMuErsY4OorQz0BR9MjrN2PRV2lKcPpeo8RYBUUNyiHyZJs1O3W85bBWscbx3G5wHMp7KDf7wjjw6XMp3sgm0l/XU75pYQABky77lA7xG10dUUW2eftab1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ4vqHvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ4vqHvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8EC1F000FF;
	Mon, 28 Sep 2026 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574665;
	bh=QrakXfSrbOxjE22wjTfc0COXVou6nAqniPYoJx2hAwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQ4vqHvLM1BaG0tDEhunYJX8wT9bOUG1kOsAXjajKCr+lzvXeLb6ZIU1BV5Ft1ee1
	 T5j+ydQz3alE2bbYcx7Oy8uq713OVkV4X7VUtx/W5nQO+mCsOV0O+P3PA+WaG1JP4L
	 tvx1YfFtITVYeogmhBOMQ0z3h0+1XTIy9v0iVxWYOMCmsWRlVbfyJGN9poYSl2+w0u
	 uJeNRRTUr5yfT+e5SiQ0CdSQI5EiGZAzyDESDnh/4Usl9/u3O0MKGpvjXOpfACK7wT
	 4jgPMWR952edU60wAda9Qr1eqzxaIg3B2D9T4w103CqW/Ez+RxMifNxbO8wE0Nl4wp
	 0bxrc8Amais+w==
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
Subject: [PATCH v1 5/8] perf tools: Add dso__put_filename()
Date: Sun, 27 Sep 2026 22:50:52 -0700
Message-ID: <20260928055055.95144-6-namhyung@kernel.org>
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

It's a counterpart of the dso__get_filename() as the returned string
should be free.  Optionally it needs to remove a temporary file if it's
decompressed on the fly.

Currently the dso argument is not used, but it's better to pair with the
matching dso.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c |  5 +----
 tools/perf/util/dso.c       | 28 +++++++++++++---------------
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 38e9299765182bd7..fc2640dcd29d3aaa 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -118,10 +118,7 @@ struct debuginfo *debuginfo__new(const char *path)
 		return NULL;
 
 	dinfo = __debuginfo__new(filename);
-
-	if (decomp)
-		unlink(filename);
-	free(filename);
+	dso__put_filename(dso, filename, decomp);
 	dso__put(dso);
 
 	return dinfo;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 52f3e78c37220780..0c76441fba82c413 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -661,6 +661,14 @@ char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
 	return NULL;
 }
 
+void dso__put_filename(struct dso *dso __maybe_unused, char *filename, bool decomp)
+{
+	if (decomp)
+		unlink(filename);
+
+	free(filename);
+}
+
 static int __open_dso(struct dso *dso, struct machine *machine)
 	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
@@ -680,11 +688,8 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		fd = -errno;
 	}
 
-	if (decomp)
-		unlink(name);
-
+	dso__put_filename(dso, name, decomp);
 	mutex_unlock(dso__lock(dso));
-	free(name);
 	return fd;
 }
 
@@ -2088,14 +2093,11 @@ struct debuginfo *dso__debuginfo(struct dso *dso)
 	mutex_lock(dso__lock(dso));
 
 	name = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
-	if (name)
+	if (name) {
 		dinfo = debuginfo__new(name);
-
-	if (decomp)
-		unlink(name);
-
+		dso__put_filename(dso, name, decomp);
+	}
 	mutex_unlock(dso__lock(dso));
-	free(name);
 	return dinfo;
 }
 
@@ -2133,11 +2135,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 			continue;
 
 		found = filename__has_section(path, ".debug_info");
-
-		if (decomp)
-			unlink(path);
-		free(path);
-
+		dso__put_filename(dso, path, decomp);
 		if (found)
 			break;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 94cc7ea89ceb5bd9..45c4954d5eaf9ffa 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -841,8 +841,10 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
 char dso__symtab_origin(const struct dso *dso);
 int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
 				   const char *root_dir, char *filename, size_t size);
+/* returned filename should be freed by dso__put_filename() */
 char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
 			enum dso_binary_type type);
+void dso__put_filename(struct dso *dso, char *filename, bool decomp);
 bool is_kernel_module(const char *pathname, int cpumode);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
-- 
2.55.0

