Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE593CC7EA;
	Tue, 29 Sep 2026 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644313; cv=none; b=ca+7Eh1EaiC8pBcU+anmFmDLbyVQctMye6aevyl1AKalWEWWdH+S6FvmwzY6RwUR+KdRfdUXrcYazz5og6SFrxF9HCi6TBPvk8GzOxSLh4XD9HqNTp16jjSz5uKJw+2utOMq4wpfcnNAoJMTHMTGlQWJR19f9I9zvjOZ0fxp5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644313; c=relaxed/simple;
	bh=rTI+2BuScq7ak5eTIRWwY6jPw6CZh6yOjnU9ThJEjuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjBoc8zloSwq4hXQEEDnJ9yukm7qtTShjPhUqFSbrvhJuIF7b9fzRfrHwTL41kU/lx0uFXG+ISh+o+z+83uEkAz/iarVU5r3NpP7SUyP4pQWI5klMjhF03nSFs5co5gYEj8BdlrWR88WplSsGWdLGzTYyuNMT+P1fNlJOJvkyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNFR+aTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNFR+aTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CC41F0089D;
	Tue, 29 Sep 2026 01:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644311;
	bh=1/48DZIxr3zvd28xH+pHA0Hjnda1Iq6UKXxPbEYouKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNFR+aTKhdZgPEI27bkmMwrjlkeo5KD6KqWRWvgxMPwN91FCIbzzakiNNmvSSqXXz
	 gRfgw0SzARW4MHugP90MQR7fLSsBbTi0jwyRScYW8C9ptkHuJV+kyz/qZk5k/pydKF
	 uE4NfCPjj3JtA5uf6jR5pWTYemW0RoselEgOFXZtFwtfKa8Qa++Uzr9/tQdAe3sfED
	 S+73lok1RhUY+2hHq48AljTpBDuYbnMEI5ynZfPiL1J0f+HG/N5HEh4BpycvmNMkrc
	 4ddBTA/WvhwLlPtGn+P9N1snENZnblVnX2+cBx3LPkEmsIg+LoXLd16Id87pNmPOYM
	 ujPPynmNZ/q2w==
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 5/8] perf tools: Add dso__put_filename()
Date: Mon, 28 Sep 2026 18:11:36 -0700
Message-ID: <20260929011139.53242-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929011139.53242-1-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
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

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c |  5 +----
 tools/perf/util/dso.c       | 27 +++++++++++++--------------
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 16 insertions(+), 18 deletions(-)

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
index 7fd6b64583d8b61a..c765c9b80e957871 100644
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
 
@@ -2135,10 +2137,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 		found = filename__has_section(path, ".debug_info") ||
 			filename__has_section(path, ".zdebug_info");
 
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

