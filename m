Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642141;
	b=G9YviD19OYOHLWymRGSwIn74dIaqQgOJnhjRqgK/LcuE3F+QkC7iLc0kXu9JvGdPJmkq
	 sx40CSQF3e+Z2wiOGKPzuVLhBC0CZhJe3quv0QYfaaGbj4n0AEjILrr42zdUOWs33a4YC
	 CWKPfQVmKbWLvgkTrNqN5B29uzb9hNyiDC6o6hypfqjLJliZJZLUXWVB77KX8XpBVNd3z
	 gcMG4EgaMFT+OvX6c5ZQ7VfExb/l2exAZznUchEN4h10HGXc5FQKuecZdCgKsNPEMwDZo
	 3H/B+jZuMZVeTo3dsqlFpa2bWcXguYUe2yAQcFqNnAgTGRg/yRNnVb6j2OCFUGf+u+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AQJEmYEk0I4Oui3XCPylMPXLbDTkL37xHqT09lPUs+I=;
	b=TF08ag9ZmL8FikH7DmjsKTeLK1DOiOkdHtgSFuuk9/UhUslF6pY55i1/7jMGF2U4Visk
	 39SDK198Rwuio70MIYIDy1EIjsWzP+ER5L1rPfN6suzWL79yJBmIUlIvI/lX2SZSneFsY
	 M/WoWk/B3PkohDd5LrRm84uDw7TgUp+vZLo6zf7pPvHdFsLNrgueqmF0alUv/bITR5Xde
	 /WPyhr3+/y8BbrBTgmA/hKAXjIHEDMcHI/o2JW/iyMiuSp+wcwi7PHv3SWStNOCiuoGJy
	 DznsnLB4YHqGiM/36Y3UKsul7c1sVeOQAVHz1lF82322FzxZstRavPmkaNQFQP5c65g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oSlb/6lD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48160A381C;
	Wed, 25 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSlb/6lD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B881F00A36;
	Wed, 25 Nov 2026 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642141;
	bh=AQJEmYEk0I4Oui3XCPylMPXLbDTkL37xHqT09lPUs+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSlb/6lDQb01k0piB7PaE7Dof4FiMAKLAWo+aQqI4ML8e232gtkURd0HvxzKFyLBf
	 KKeFATDx5S78WkVXd2ysUBt+ByfgDEofXa8R8T9n5ostV6NwiyzIoo7YJzMBJJYOVI
	 5r1ulyVMEHGcSAvSSMyElFGP8Fs8C5lQb6zQBWPOwEMnKYw2eGzzgMykICifLdl0db
	 ij9ubCZrai/8/7r8vk3vruhwDEEBScYG6Genr80K+vLHNuP6PNg4i0F4U8DTHGNTD1
	 km79sKQ0+gUuAaIRsUIyqhpOLfzd7VsRbYFBOcAHj9SOmU+EFGaPapY+6VpRk4yxuM
	 pT7Q7EV9u1FIw==
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
Subject: [PATCH v4 10/11] perf tools: Scope mount namespace entry in dso__load()
Date: Wed, 25 Nov 2026 13:28:50 -0800
Message-ID: <20261125212851.1792988-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261125212851.1792988-1-namhyung@kernel.org>
References: <20261125212851.1792988-1-namhyung@kernel.org>
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
index fa87c2d9de2a13ae..16f7b96502cecfc4 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -348,7 +348,9 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
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
index d6a841dadcad0f9c..fb86edc00c60bbc9 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2322,17 +2322,6 @@ int dso__load(struct dso *dso, struct map *map)
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
@@ -2356,8 +2345,16 @@ int dso__load(struct dso *dso, struct map *map)
 
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
@@ -2380,7 +2377,7 @@ int dso__load(struct dso *dso, struct map *map)
 		struct build_id bid = { .size = 0, };
 
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
-		if (filename__read_build_id(name, &bid) > 0)
+		if (filename__read_build_id_ns(name, &bid, dso__nsinfo(dso)) > 0)
 			dso__set_build_id(dso, &bid);
 	}
 
@@ -2393,28 +2390,29 @@ int dso__load(struct dso *dso, struct map *map)
 		struct symsrc *ss = &ss_[ss_pos];
 		bool next_slot = false;
 		bool is_reg;
-		bool nsexit;
+		bool nsenter;
 		bool chroot = false;
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
@@ -2431,8 +2429,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (is_reg && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
-		if (nsexit)
-			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 
 		if (bfdrc > 0) {
 			dso__set_symtab_type(dso, symtab_type);
@@ -2500,7 +2498,6 @@ int dso__load(struct dso *dso, struct map *map)
 out:
 	dso__set_loaded(dso);
 	mutex_unlock(dso__lock(dso));
-	nsinfo__mountns_exit(&nsc);
 
 	return ret;
 }
-- 
2.56.1.831.g720f3f5937-goog

