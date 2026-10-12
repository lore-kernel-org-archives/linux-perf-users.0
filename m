Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016D3F660D;
	Mon, 12 Oct 2026 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848823; cv=none; b=tNp08XWZltIB8VZlzmQCyBGzos89DPhhcwjYBnDBrOXjd+LC6VXKk3CZavhkjV7I9jvC5uOg+H33B5nI0nEVH7jwdrTjh6v8FVm7vVQbCdS28mBVNAR/gSnIWLDl8eZFl3351OOZSnis3dEo204ahVL3yUgvTwbQUNBQitkYk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848823; c=relaxed/simple;
	bh=pRgKuzltqTP5qq1iYZ9yMeN36SmF92IJPhyTgPfkC/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cerFk+eYeSNztZJ/5uiRqJ4L8A5RT3PITW9iQeENKNG3XUrQtcr7kfZsNyO5zwx4TJV98mgNTFcjUtDp1rSbTURkwRdy15YLaRLm+wIK3fcu0uqDRQ/7kVZ4FXbLkC/sZH3Z5ecpeRAjlGSCyFZ7xRvKuXmxBgdD/BCzosGYLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7jBQmvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7jBQmvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BFD1F008A5;
	Mon, 12 Oct 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848821;
	bh=3O2IenCH6/sxzWAWX9Q8FmEqaJVAZBedcZz7xsAkbgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7jBQmvkOBC5MNVeWHybyLBGg6AJxHhxsgt+iFUoC4v5YQcK+hX2advI1LOsgCtXT
	 d+OzZG5HSS9s8P5bc4AZON71xtCeiP8OWnmcWXILkVcp2TQnTXLSci5tUGId2e3SDA
	 ISzKtLsZRkx6w2+3T1+mqQXEyZPI2PeNhxoFBLPbtcOPWOf2t0qeRo/3F7miZQCBED
	 7+pqkXkBAD6LdN+5LqVaxuFN4AfBMVzU6L/MGG1F9n5RX61Grh2zOiE5YsWrWiv+EG
	 Lzl5vQLxGcx7PeO4Aep3qMf2Cf2J3U5o28Y3FTkEB4Qr/WOu9y4H7ChFCdvO3gu+w4
	 +jI50qeKP4rBA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 09/10] perf annotate: Simplify symbol__disassemble() with dso binary_type
Date: Mon, 12 Oct 2026 16:46:53 -0700
Message-ID: <20261012234654.60666-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012234654.60666-1-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now it should set the binary type of a DSO properly.  No need to figure
out a filename suitable for disassembly.

Just call dso__find_binary_type() and dso__get_filename() for that type.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 124 ++++++++-------------------------------
 1 file changed, 24 insertions(+), 100 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 5478c134e7e3b8df..7c289b67b5bde899 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1176,84 +1176,6 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 	return 0;
 }
 
-static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size)
-{
-	char linkname[PATH_MAX];
-	char *build_id_filename;
-	char *build_id_path = NULL;
-	char *pos;
-	int len;
-
-	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
-	    !dso__is_kcore(dso))
-		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
-
-	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
-	if (build_id_filename) {
-		/*
-		 * This is a path in perf's own build id cache, not a path on
-		 * the profiled system, so the symfs layout does not apply.
-		 */
-		path__join(filename, filename_size, symbol_conf.symfs,
-			   build_id_filename);
-		free(build_id_filename);
-	} else {
-		if (dso__has_build_id(dso))
-			return ENOMEM;
-		goto fallback;
-	}
-
-	build_id_path = strdup(filename);
-	if (!build_id_path)
-		return ENOMEM;
-
-	/*
-	 * old style build-id cache has name of XX/XXXXXXX.. while
-	 * new style has XX/XXXXXXX../{elf,kallsyms,vdso}.
-	 * extract the build-id part of dirname in the new style only.
-	 */
-	pos = strrchr(build_id_path, '/');
-	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
-		dirname(build_id_path);
-
-	if (dso__is_kcore(dso))
-		goto fallback;
-
-	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
-	if (len < 0)
-		goto fallback;
-
-	linkname[len] = '\0';
-	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
-		access(filename, R_OK)) {
-fallback:
-		/*
-		 * If we don't have build-ids or the build-id file isn't in the
-		 * cache, or is just a kallsyms file, well, lets hope that this
-		 * DSO is the same as when 'perf record' ran.
-		 */
-		if (dso__kernel(dso) && dso__long_name(dso)[0] == '/')
-			snprintf(filename, filename_size, "%s", dso__long_name(dso));
-		else
-			__symbol__join_symfs(filename, filename_size, dso__long_name(dso));
-
-		mutex_lock(dso__lock(dso));
-		if (access(filename, R_OK) && errno == ENOENT && dso__nsinfo(dso)) {
-			char *new_name = dso__filename_with_chroot(dso, filename);
-			if (new_name) {
-				strlcpy(filename, new_name, filename_size);
-				free(new_name);
-			}
-		}
-		mutex_unlock(dso__lock(dso));
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
-		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
-	}
-
-	free(build_id_path);
-	return 0;
-}
-
 static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
@@ -1566,14 +1488,29 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	struct annotation_options *options = args->options;
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
-	char symfs_filename[PATH_MAX];
+	char *symfs_filename;
 	bool delete_extract = false;
 	struct kcore_extract kce;
+	enum dso_binary_type dbt;
 	bool decomp = false;
-	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
+	int err;
 
-	if (err)
-		return err;
+	dbt = dso__find_binary_type(dso);
+
+	if (dbt == DSO_BINARY_TYPE__KALLSYMS)
+		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
+
+	mutex_lock(dso__lock(dso));
+	symfs_filename = dso__get_filename(dso, "", &decomp, dbt);
+	mutex_unlock(dso__lock(dso));
+
+	if (symfs_filename == NULL) {
+		if (dbt == DSO_BINARY_TYPE__BPF_PROG_INFO ||
+		    dbt == DSO_BINARY_TYPE__BPF_IMAGE)
+			symfs_filename = (char *)dso__long_name(dso);
+		else
+			return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
+	}
 
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
 		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
@@ -1581,9 +1518,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
-		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
-	} else if (dso__is_kcore(dso)) {
+	if (dso__is_kcore(dso)) {
 		kce.addr = map__rip_2objdump(map, sym->start);
 		kce.kcore_filename = symfs_filename;
 		kce.len = sym->end - sym->start;
@@ -1591,18 +1526,8 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 		if (!kcore_extract__create(&kce)) {
 			delete_extract = true;
-			strlcpy(symfs_filename, kce.extract_filename, sizeof(symfs_filename));
-		}
-	} else if (dso__needs_decompress(dso)) {
-		char tmp[KMOD_DECOMP_LEN];
-
-		if (dso__decompress_kmodule_path(dso, symfs_filename, tmp, sizeof(tmp)) < 0)
-			return -1;
-
-		/* empty pathname means file wasn't actually compressed */
-		if (tmp[0] != '\0') {
-			decomp = true;
-			strcpy(symfs_filename, tmp);
+			dso__put_filename(dso, symfs_filename, decomp);
+			symfs_filename = kce.extract_filename;
 		}
 	}
 
@@ -1660,11 +1585,10 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 			pr_debug("Disassembled with %s\n", perf_disassembler__strs[dis]);
 	}
 out_remove_tmp:
-	if (decomp)
-		unlink(symfs_filename);
-
 	if (delete_extract)
 		kcore_extract__delete(&kce);
+	else if (dbt != DSO_BINARY_TYPE__BPF_PROG_INFO && dbt != DSO_BINARY_TYPE__BPF_IMAGE)
+		dso__put_filename(dso, symfs_filename, decomp);
 
 	return err;
 }
-- 
2.56.0.385.gd3acb90ef8-goog

