Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AE350A2F;
	Tue, 13 Jan 2026 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347479; cv=none; b=YSmbl+AYysm0UpBrrQj2fjHh+g7EX2OBebDk1Pg6uBB0LMgQBMhahJYRna7NAtF2HZHi+V2V3+kjxMX8qiLE4cfWI1+K4SHM+aDAy8F6pNVQ3Q7NjEnuximV2zxuWYcGqi7/38egh+H8oCniyvsYP6ugeN9s3sP1P0CT4BAA5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347479; c=relaxed/simple;
	bh=JGTqhV59QkKFc7X6jgO/PsLiLpy3ZTMw89lLplbbB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKZUJ2ZmJf+s00BnE5Ad7+q0RNhlQfqIo1u5+wbbqOadgfraz7E74y0mJsjvDG5deiWTjdHBFnyCVchhU3oDxrAwfpLmZd1b1GRGenT/LkwIPXdGy8E0ZD9mA+fBrOccyWXtBhOT8sPt3eKRfyStOppDtN4SncUNAErlxcTruPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxQkJ//2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxQkJ//2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A458EC116C6;
	Tue, 13 Jan 2026 23:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768347479;
	bh=JGTqhV59QkKFc7X6jgO/PsLiLpy3ZTMw89lLplbbB2o=;
	h=From:To:Cc:Subject:Date:From;
	b=LxQkJ//2HlJIpw/akcaeI2PwnVlC5RBhb7iHqbLHB+TdNUAzD3zEkiZ5zjZw+O1Wn
	 79laLoHfZ98UlsoS9AHsJPy+GtygHgbLpNK1cnh9tNx9Vwj+djH2fwLMWOCaEoKlWc
	 YCB7iIuq7M68dGE1Krts//kxfFL6YsAQh2SBrs7O10oyMt0h1n3I+RQrlzjlJHxzZL
	 A/5AwTb0w4ApQvFPFgF2Refvhy3ZI+6SdhfildE6B3XeD109DmTNlbcPDhSfXFgTJi
	 GTKbixAsShQcuvmn8FbjqN1Ha6jk24931YZwJqY1oYRolyVhAusIauNRyOLn8I5ny3
	 hhC7DSA+VRrAg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Get debug info of DSO properly
Date: Tue, 13 Jan 2026 15:37:57 -0800
Message-ID: <20260113233757.62347-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dso__debuginfo() just used the path name to open the file but it may
be outdated.  It should check build-ID and use the file in the build-ID
cache if available rather than just using the path name.

Let's factor out dso__get_filename() to avoid code duplicate.

Fixes: 53a61a6ca279165d ("perf annotate: Add dso__debuginfo() helper")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 63 ++++++++++++++++++++++++++++++++-----------
 tools/perf/util/dso.h | 11 ++------
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 06980844c014ec9b..922fcc2f798baa57 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -112,7 +112,7 @@ bool dso__is_object_file(const struct dso *dso)
 
 int dso__read_binary_type_filename(const struct dso *dso,
 				   enum dso_binary_type type,
-				   char *root_dir, char *filename, size_t size)
+				   const char *root_dir, char *filename, size_t size)
 {
 	char build_id_hex[SBUILD_ID_SIZE];
 	int ret = 0;
@@ -564,20 +564,15 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
 }
 
-static int __open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static char *dso__get_filename(struct dso *dso, const char *root_dir,
+			       bool *decomp)
 {
-	int fd = -EINVAL;
-	char *root_dir = (char *)"";
 	char *name = malloc(PATH_MAX);
-	bool decomp = false;
 
-	if (!name)
-		return -ENOMEM;
+	*decomp = false;
 
-	mutex_lock(dso__lock(dso));
-	if (machine)
-		root_dir = machine->root_dir;
+	if (name == NULL)
+		return NULL;
 
 	if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
 					    root_dir, name, PATH_MAX))
@@ -602,20 +597,38 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		size_t len = sizeof(newpath);
 
 		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
-			fd = -(*dso__load_errno(dso));
+			errno = *dso__load_errno(dso);
 			goto out;
 		}
 
-		decomp = true;
+		*decomp = true;
 		strcpy(name, newpath);
 	}
+	return name;
+
+out:
+	free(name);
+	return NULL;
+}
 
-	fd = do_open(name);
+static int __open_dso(struct dso *dso, struct machine *machine)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+{
+	int fd = -EINVAL;
+	char *name;
+	bool decomp = false;
+
+	mutex_lock(dso__lock(dso));
+
+	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
+	if (name)
+		fd = do_open(name);
+	else
+		fd = -errno;
 
 	if (decomp)
 		unlink(name);
 
-out:
 	mutex_unlock(dso__lock(dso));
 	free(name);
 	return fd;
@@ -1912,3 +1925,23 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	return __dso__read_symbol(dso, symfs_filename, start, len,
 				  out_buf, out_buf_len, is_64bit);
 }
+
+struct debuginfo *dso__debuginfo(struct dso *dso)
+{
+	char *name;
+	bool decomp = false;
+	struct debuginfo *dinfo = NULL;
+
+	mutex_lock(dso__lock(dso));
+
+	name = dso__get_filename(dso, "", &decomp);
+	if (name)
+		dinfo = debuginfo__new(name);
+
+	if (decomp)
+		unlink(name);
+
+	mutex_unlock(dso__lock(dso));
+	free(name);
+	return dinfo;
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 4aee23775054cf83..3dd7d0fc00797f37 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -777,7 +777,7 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
 
 char dso__symtab_origin(const struct dso *dso);
 int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
-				   char *root_dir, char *filename, size_t size);
+				   const char *root_dir, char *filename, size_t size);
 bool is_kernel_module(const char *pathname, int cpumode);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
@@ -926,14 +926,7 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 bool perf_pid_map_tid(const char *dso_name, int *tid);
 bool is_perf_pid_map_name(const char *dso_name);
 
-/*
- * In the future, we may get debuginfo using build-ID (w/o path).
- * Add this helper is for the smooth conversion.
- */
-static inline struct debuginfo *dso__debuginfo(struct dso *dso)
-{
-	return debuginfo__new(dso__long_name(dso));
-}
+struct debuginfo *dso__debuginfo(struct dso *dso);
 
 const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			   const struct map *map, const struct symbol *sym,
-- 
2.52.0.457.g6b5491de43-goog

