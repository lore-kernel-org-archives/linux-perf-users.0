Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476035;
	b=Erlx6y44y88h067ZlhTqEn1puu0Ll1g1uXr7rZignlrx7T9D5mklZexo8AZmIeBJ4fOf
	 NQzylVwxXyPwsLVjdOFyDjpKm/jy4cE3lDNHQtVVBHJJDPPzjijKRLTQdtjSPgQIq2CWJ
	 C4GKHtpAg8tS9Jn2PWW8iIkIwi5K/31EppVY0CVSTYhmtOY9nSzFp7Nkdv1ZiGdGAHVRa
	 RKHelzXDshlDruPiTGGV3xC+Qs6F/9AQA58JxdU43T0u03QGX7qODuvupj0LalWUhVW1A
	 SK9s8i0XSfu4ajg1xKBAOHBqRKNLdTCO0uUcyKlvCDT8qzNmFsCRaXaHV3ecIwDoAwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oKRio6WnVhzHgSerN5LZDwo+EvuGmEthpFDqqZ4+Lvo=;
	b=XDVcXnPLXQoH7qLcpGSREkiVOmeRzYS+ThcjZ2IlR6MFEYvMWqwN16jxdqdKRbPYeuCs
	 s2K2c4nZsmlLUffe3jiVgjr9GhSzBJlAr600/J+lvoSqtv/LIWLzoQZ+gSaHKcDfpmYtJ
	 NeblDi6cIK8t3C5n3GCHKCf1YqN2jQoSFT2aweFiCQlXkWOP5PkRgP+1POESGu6tkjR8x
	 CZMzK+8zSoZGQMfQPL7dP36wn+ISZQDqqAkmrS0rB1sZKjWtTuW/YBP2s45y0cae2yHLQ
	 3gTZCfSqw2/a33bIfOqBww6KtkPQhH472QXOIowuEPlKbfpXDSoOFcnQ3BQIE0rUZJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQOPuwKq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBA606A6AD;
	Mon, 23 Nov 2026 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQOPuwKq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9581F000EB;
	Mon, 23 Nov 2026 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476035;
	bh=oKRio6WnVhzHgSerN5LZDwo+EvuGmEthpFDqqZ4+Lvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQOPuwKqWyNk8wTwqSWJAHD82lAVrPQ675sLeK9EMbz1FypWEOCfdqO5EslQV2edW
	 kyawry7OhxGTTvbHxPq04qd8pTGImK/QYFhCu8QUGjBMs08TkYIwwlr3w/TRaGNeES
	 bKUzMuKCfW756jifBfgq2yKPlwu6gPlxIf3yOZrc7bJf7NN/YsqcYNaRp0HjatyCO5
	 5v5VimZLCHLYVjNboRrbddxQISYcucDVv8Qf3aM8U/KsOCC+w9DswSIdrAUA5Oikt6
	 6Hth5R1zsmvd6BtihkSc/YgqSFcKsjD2Or1ktd79YlZn7eAj/Enz4aAIhIj5B7ckDq
	 mY2EhIlNFP5gQ==
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
Subject: [PATCH v3 10/11] perf tools: Scope mount namespace entry in dso__load()
Date: Mon, 23 Nov 2026 15:20:24 -0800
Message-ID: <20261123232025.1406560-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123232025.1406560-1-namhyung@kernel.org>
References: <20261123232025.1406560-1-namhyung@kernel.org>
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
index 35b08c05a2fd00e1..8e03d335ffb25c21 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2209,17 +2209,6 @@ int dso__load(struct dso *dso, struct map *map)
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
@@ -2243,8 +2232,16 @@ int dso__load(struct dso *dso, struct map *map)
 
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
@@ -2267,7 +2264,7 @@ int dso__load(struct dso *dso, struct map *map)
 		struct build_id bid = { .size = 0, };
 
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
-		if (filename__read_build_id(name, &bid) > 0)
+		if (filename__read_build_id_ns(name, &bid, dso__nsinfo(dso)) > 0)
 			dso__set_build_id(dso, &bid);
 	}
 
@@ -2280,27 +2277,28 @@ int dso__load(struct dso *dso, struct map *map)
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
@@ -2316,8 +2314,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (is_reg && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
-		if (nsexit)
-			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 
 		if (bfdrc > 0) {
 			dso__set_symtab_type(dso, symtab_type);
@@ -2384,7 +2382,6 @@ int dso__load(struct dso *dso, struct map *map)
 out:
 	dso__set_loaded(dso);
 	mutex_unlock(dso__lock(dso));
-	nsinfo__mountns_exit(&nsc);
 
 	return ret;
 }
-- 
2.56.1.809.ga0b61035b5-goog

