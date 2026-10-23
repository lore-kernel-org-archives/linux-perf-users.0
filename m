Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739507;
	b=kt7O3wfJ/lDv6ulW6rpMMDhO5RQGansICTb7g4X98Oli+dvh40r0XqsOjpZ+Xcua1D/S
	 n9sC2CfV2kBFkefPitxKN5M4FMM/ohPfEDOQzHfPPst39QTXBjKMWJHkJNOOOA0PD4M3h
	 /mFqOXTDhrViUYUKZA1+ASjYLvyfX77M/uutT1/mQsqMVYqtKZMTW4Ej4z1o+jeienxsg
	 cOyOPH7O95NwNxeiRrO5hnYF212BbPnTOdpM3ZVRFWKpz7HlC+7C6KSU86x90JTQk24Og
	 S68UZTV5p6TPQ+Gv3cL2pFUVWsv2hemsbmyTtigqdOj34aGFyYAwsfNqEHSsN6nyjlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DN9zsEUYSRkpbLEQ0Z8mTeGmjkFAnCeWoPoJg7B3w0s=;
	b=aPvqKDt8oE1bDXCmyJGcDG//aG2psS49fS7x5hbhbOAF15vpaMyshHLB6AvnpJabI9r+
	 U+pKcDnHzOQY7QFSdHeWN2gqm01yiLPs4m7BSVeOIJbz5xWrQd+Zc+e+Aug+d0sJRZjV0
	 L0w7T5fJ7OhfBjVMpIsyupsslInX/atb/FH23nlxNkmalVv/nM3KwubNNJeeDifkHekPC
	 o3EqWD6WPPWseIqYpNocIZWL084/NRYYX5SlbcA420ujHOd0Wc6Dd7pJgTBdrg6Y9qiXw
	 qN7sOuMhugruBGf70wz8lo3Aa0tfqmY96w1pD28hSvEwL0cHt9h75Pxa+QnCOWfqCMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiW2LznU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47860A2603;
	Fri, 23 Oct 2026 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiW2LznU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D551F01829;
	Fri, 23 Oct 2026 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739507;
	bh=DN9zsEUYSRkpbLEQ0Z8mTeGmjkFAnCeWoPoJg7B3w0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UiW2LznUXAV5LRK4mfmFEd3vysR93hd3NwCoCIh1aIDhmBXwgy/TLwLAepkpefcrN
	 s+Qj9PMQpw68vtBKAYgl9zy7yKE+t3UWFlx5Jx2IQYDcl+sy1PupON/66OCZypRv84
	 /9zNwoAK//44543opcXEC3RANUwVQG5dfYl1j6+q09vzVdrBxEdPytHnoeKZRJc8Am
	 h1HTIbSmT5D78fBe6D595TW5ZoAnzQ1Ba6TP3vJXOgXBjfTwNCIk28vWixmxre2Pe6
	 c5twK/aMQ66S09HJXMFFPLPq65JLfs+ZK9MnD+db5AQlvfvA//IjglZ9AvRVSJTJmP
	 P7JEy/T5KcrVg==
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
Subject: [PATCH v1 09/11] perf tools: Remove redundant chroot handling
Date: Fri, 23 Oct 2026 00:11:39 -0700
Message-ID: <20261023071141.134149-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261023071141.134149-1-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that nsinfo__mountns_enter() enters the target process's chroot
alongside its mount namespace, callers inside a mountns context no
longer need to manually prepend the target's root directory path via
dso__filename_with_chroot() or filename_with_chroot().

Remove dso__filename_with_chroot() and filename_with_chroot() and use
the DSO path directly within the mountns scope.

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c    | 29 ++---------------------------
 tools/perf/util/dso.h    |  2 --
 tools/perf/util/symbol.c |  8 --------
 tools/perf/util/util.c   | 31 -------------------------------
 tools/perf/util/util.h   |  2 --
 5 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ce98613868e7d371..4331b48505b2b10e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -585,11 +585,6 @@ static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 	return -1;
 }
 
-char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
-{
-	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
-}
-
 char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
 			enum dso_binary_type type)
 {
@@ -603,28 +598,8 @@ char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
 	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
 		goto out;
 
-	if (!is_regular_file(name)) {
-		struct stat st;
-		char *new_name;
-
-		/*
-		 * errno only reflects the failure reason when stat() itself
-		 * failed: a successful stat() on a non-regular file (e.g. a
-		 * directory) leaves a stale errno, which a previous failed
-		 * iteration of the try_to_open_dso() fallback loop may have
-		 * set to ENOENT.
-		 */
-		if (stat(name, &st) == 0 || errno != ENOENT ||
-		    dso__nsinfo(dso) == NULL)
-			goto out;
-
-		new_name = dso__filename_with_chroot(dso, name);
-		if (!new_name)
-			goto out;
-
-		free(name);
-		name = new_name;
-	}
+	if (!is_regular_file(name))
+		goto out;
 
 	if (dso__needs_decompress(dso)) {
 		char newpath[KMOD_DECOMP_LEN];
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3329f417810c25a4..e53c83c23c578918 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -826,8 +826,6 @@ static inline bool dso__has_symbols(const struct dso *dso)
 	return !RB_EMPTY_ROOT(&RC_CHK_ACCESS(dso)->symbols.rb_root);
 }
 
-char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
-
 bool dso__sorted_by_name(const struct dso *dso);
 void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b61a574ce9a30721..807e433c770812a4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1902,14 +1902,6 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_exit(&nsc);
 
 		is_reg = is_regular_file(name);
-		if (!is_reg && errno == ENOENT && dso__nsinfo(dso)) {
-			char *new_name = dso__filename_with_chroot(dso, name);
-			if (new_name) {
-				is_reg = is_regular_file(new_name);
-				strlcpy(name, new_name, PATH_MAX);
-				free(new_name);
-			}
-		}
 
 #ifdef HAVE_LIBBFD_SUPPORT
 		if (is_reg)
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 8f7cd32f524dc10e..443b1d2b4748bfe4 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -451,37 +451,6 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
 #endif
 }
 
-/*
- * Return a new filename prepended with task's root directory if it's in
- * a chroot.  Callers should free the returned string.
- */
-char *filename_with_chroot(int pid, const char *filename)
-{
-	char buf[PATH_MAX];
-	char proc_root[32];
-	char *new_name = NULL;
-	int ret;
-
-	scnprintf(proc_root, sizeof(proc_root), "/proc/%d/root", pid);
-	ret = readlink(proc_root, buf, sizeof(buf) - 1);
-	if (ret <= 0)
-		return NULL;
-
-	/* readlink(2) does not append a null byte to buf */
-	buf[ret] = '\0';
-
-	if (!strcmp(buf, "/"))
-		return NULL;
-
-	if (strstr(buf, "(deleted)"))
-		return NULL;
-
-	if (asprintf(&new_name, "%s/%s", buf, filename) < 0)
-		return NULL;
-
-	return new_name;
-}
-
 /*
  * Reallocate an array *arr of size *arr_sz so that it is big enough to contain
  * x elements of size msz, initializing new entries to *init_val or zero if
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f8f1ff603c728086..b9adb58df976f29e 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -84,8 +84,6 @@ void perf_debuginfod_setup(struct perf_debuginfod *di);
 
 const char *perf_basename(const char *path);
 
-char *filename_with_chroot(int pid, const char *filename);
-
 int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
 			       size_t msz, const void *init_val);
 
-- 
2.56.0.257.gf7497c7d27-goog

