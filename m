Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808658;
	b=HdoWtG8QBPxq8B779CYOmpCTcUySyaK3KHRARW+LY40VwCSrrAjJmDDhR2dRDjVqKZbE
	 sQtY93Ba+Yt8zuiJ/bxSvY5amlTnoH/WJBfNKL8V0YPF2ebABuNUjv1ZqTTeXTyw9oAhy
	 Xy9v1lXlewpXkEII2iWTlOS1uxgLGlx4MgrKKxkWHLd5N8GW9JCkZOpBBklbNyYLExl9k
	 +LHGQQ/kYCWPOjBDx80sNIBw75dF8iVmmBbE7FKefuSCTUuBILTWeSgYxg0hFFBb+k8l+
	 xUcCPzcxsXNuuBt1xM42jJgSo2MUU5H+4diQZLI2khaJgvKu1rXQPi3vn6g9VFTvllA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FXLTw2ZmcyEOptfBtYE9G82SHiId9pdWmZNnu7krob4=;
	b=1Oz25At1CW8hEGDPlNyGxkbasQ+mYpKwFOIX+y1wKKeYqNOaKoZHo/MNr9/+I8diTkAK
	 /L8QAa4rHjLjVHRmEBrFvJM92W2i/zo6WafFY/SJpksA/XcaNDsH+71Vxei8LGEqblvOq
	 GlHbZpktrD+fg+TteicbEE3N9YnqW+8sL3up6Wf3H09gQk/hixtrO3wmusV6zK0GjEQHJ
	 bSJdfSe14IyYtP0AqO84D+yZiKxlShpxgK6+CUlQiJQUcswQEZ+tMIy/44dwi6YJBSgtq
	 D7SN81PFoWLLL3QD9iCYWvQP0KSC5hF9DHuBBtMZevM/qulYgGMGAEZuVOcK7HxowvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS0xdejO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FC606A88E;
	Mon, 16 Nov 2026 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS0xdejO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FBE1F00930;
	Mon, 16 Nov 2026 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808657;
	bh=FXLTw2ZmcyEOptfBtYE9G82SHiId9pdWmZNnu7krob4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GS0xdejO6v+GXtncZrbGx11c09o6YmzxHxLAzNoycQzAzwHQ9DCPxuJfIsBg8wmsH
	 VMletcyZiPqnsjRRapM3hezfvIXlZxhOQksjpujDd5IYN6IJph6Ruy76p4sjb3+6aS
	 3AKZtJQitvkomVaNXi4BQxRMS1Rav0qv1ENNYPqr9UWldBzMa/6+uWWNfF4CC6aGyY
	 5RGUgBB2wuFsRBZrJ158aV/LPE5wyinXLv77+nRx4Z+1VC5bLqW5V4KsOuyAYj8Vp2
	 oZB/IGjI3r7TYGaxYfhpz0Cw3dNU0vbxAR4ZKSqRBrFKsluyXtPmA3RHd8HChtgeoG
	 lZ0USYziBxTDw==
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
Subject: [PATCH v2 10/11] perf tools: Scope mount namespace entry in dso__load()
Date: Sun, 15 Nov 2026 21:57:30 -0800
Message-ID: <20261116055731.707164-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <20261116055731.707164-1-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
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

Enter the target mount namespace only for the specific binary types
that need it in dso__load(), and use filename__read_build_id_ns() for
BUILDID_DEBUGINFO lookup and in symbol-minimal's dso__load_sym() so it
does not read the wrong build-id from the host filesystem.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-minimal.c |  4 ++-
 tools/perf/util/symbol.c         | 45 +++++++++++++++-----------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 0a71d146395271a6..5beb73fd508ad079 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -342,7 +342,9 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 	if (ret >= 0)
 		RC_CHK_ACCESS(dso)->is_64_bit = ret;
 
-	if (filename__read_build_id(ss->name, &bid) > 0)
+	if (filename__read_build_id_ns(ss->name, &bid,
+				       dso_binary_type__needs_ns(ss->type) ?
+				       dso__nsinfo(dso) : NULL) > 0)
 		dso__set_build_id(dso, &bid);
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dc70bbe8514f4d37..4c0ff9f0c32f8293 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1811,17 +1811,6 @@ int dso__load(struct dso *dso, struct map *map)
 	const char *map_path = dso__long_name(dso);
 
 	mutex_lock(dso__lock(dso));
-	perfmap = is_perf_pid_map_name(map_path);
-
-	if (perfmap) {
-		if (dso__nsinfo(dso) &&
-		    (dso__find_perf_map(newmapname, sizeof(newmapname),
-					dso__nsinfo_ptr(dso)) == 0)) {
-			map_path = newmapname;
-		}
-	}
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
@@ -1845,8 +1834,16 @@ int dso__load(struct dso *dso, struct map *map)
 
 	dso__set_adjust_symbols(dso, false);
 
+	perfmap = is_perf_pid_map_name(map_path);
 	if (perfmap) {
+		if (dso__nsinfo(dso) &&
+		    (dso__find_perf_map(newmapname, sizeof(newmapname),
+					dso__nsinfo_ptr(dso)) == 0)) {
+			map_path = newmapname;
+		}
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		ret = dso__load_perf_map(map_path, dso);
+		nsinfo__mountns_exit(&nsc);
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);
 		dso__set_symtab_type(dso, ret > 0
 				? DSO_BINARY_TYPE__JAVA_JIT
@@ -1869,7 +1866,7 @@ int dso__load(struct dso *dso, struct map *map)
 		struct build_id bid = { .size = 0, };
 
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
-		if (filename__read_build_id(name, &bid) > 0)
+		if (filename__read_build_id_ns(name, &bid, dso__nsinfo(dso)) > 0)
 			dso__set_build_id(dso, &bid);
 	}
 
@@ -1882,27 +1879,28 @@ int dso__load(struct dso *dso, struct map *map)
 		struct symsrc *ss = &ss_[ss_pos];
 		bool next_slot = false;
 		bool is_reg;
-		bool nsexit;
+		bool nsenter;
 		int bfdrc = -1;
 		int sirc = -1;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
 
-		nsexit = (symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
-		    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO);
-
 		if (!dso__is_compatible_symtab_type(dso, kmod, symtab_type))
 			continue;
 
+		nsenter = dso_binary_type__needs_ns(symtab_type);
+		if (nsenter)
+			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+
 		if (dso__read_binary_type_filename(dso, symtab_type,
-						   root_dir, name, PATH_MAX))
+						   root_dir, name, PATH_MAX)) {
+			if (nsenter)
+				nsinfo__mountns_exit(&nsc);
 			continue;
-
-		if (nsexit)
-			nsinfo__mountns_exit(&nsc);
+		}
 
 		is_reg = is_regular_file(name);
-		if (!is_reg && errno == ENOENT && dso__nsinfo(dso)) {
+		if (!is_reg && errno == ENOENT && nsenter && dso__nsinfo(dso)) {
 			char *new_name = dso__filename_with_chroot(dso, name);
 			if (new_name) {
 				is_reg = is_regular_file(new_name);
@@ -1918,8 +1916,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (is_reg && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
-		if (nsexit)
-			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 
 		if (bfdrc > 0) {
 			dso__set_symtab_type(dso, symtab_type);
@@ -1986,7 +1984,6 @@ int dso__load(struct dso *dso, struct map *map)
 out:
 	dso__set_loaded(dso);
 	mutex_unlock(dso__lock(dso));
-	nsinfo__mountns_exit(&nsc);
 
 	return ret;
 }
-- 
2.56.0.611.g1030f0b940-goog

