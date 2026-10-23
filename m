Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739508;
	b=szjUnEc/+rBlFCkyK5C6OUWhvf6kroPRLyyV0qyKmYbadX+SVjbBRb+R9IfT7R7bHQu3
	 dO5fL+Rf7D8lz3xtoMQm9BX59kkZtiGmW75OIiZcIiNWkSfsQ7zK0m02ssOSerPNYviKN
	 iX+qqui4L1O+/4KkBRvgFTXnNdAxRduZoNBeLTh6MWDqKjTWcq3ea4O2OXGdbDeoK49xY
	 kji8iQkhfIoWqSz3Enz4Nl7AKzVK9H6uMyG/+MWsRxtIMBlivXLhwMn7XOZBZv4C5Wnno
	 8U7+g8R8Maqo8UzEQYo38bPbhegDAw+jEy/t5ve/atq9eto4IPdE1UXejyKtaF/Z+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rukPIb1vV+y9r8NjTzbAfolzc4+3CZtBg94H8UeyaOw=;
	b=yjD1vwwoeQdLB2zSdOf4dZAJKDWM6Ot9gto3tcCsIe9FuNmz9EU+KwAfJ0ArQOb26key
	 6x+2C5hqGGOWZtwJXMeE4sYkN+GSVvAfe6/Odo/xaT8UOdOrkipRj5BMkjhCnIT/xnXlQ
	 Ga1ZgiMVJ0yjDlI0FBswZnWQELX4btEClvcbfOgiQa/+bl1g/D/G8TAWctwqBf0pLLd7c
	 Y7MkTVabu2caCrg0RZDTApj282uJ+SBsfFB6UEanf9/KBKD8jwGocBfIrq8VGfWi2dwHK
	 Xdor9YFW+ufjuv/qUiF4aw0EtHa9FNRig4goHHhbzsrbfMZtecppuDwNRjyIrDx4rsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqSOP80X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B960A2608;
	Fri, 23 Oct 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqSOP80X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E951F01829;
	Fri, 23 Oct 2026 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739508;
	bh=rukPIb1vV+y9r8NjTzbAfolzc4+3CZtBg94H8UeyaOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqSOP80XW0yJDz3XXfHdr4JpYl+entJ8flLDcJ5/YGs8XTC1fvH7SFvpKMvtNY+qT
	 qM43B5V8xhtpROULYAG/51NGKqp/XaYzRWfTa55cKiobmgRx0Bzi0ffOsiKLyMOPiV
	 9vm9C503eYn+IGqPuiXqQO7J9K//w53dUUbV4r1clWFDOxpzY9SfKf4lE8wNX/nDhK
	 8wysHqTEAmHB8XX/Jp7RgXKjdedfQ18s11Mbtopf3dsLA+TAeAumvsGl0IVfLNtnUj
	 p1E/pYBr8C+Sefa9GZy71rVnCE4KpKILjlnPxdX0dA6FYNilePyKG11bbZSOWyX9AI
	 u1EqeNfMW6RNA==
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
Subject: [PATCH v1 11/11] perf tools: Scope mount namespace entry in dso__load()
Date: Fri, 23 Oct 2026 00:11:41 -0700
Message-ID: <20261023071141.134149-12-namhyung@kernel.org>
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

Enter the target mount namespace only for the specific binary types
that need it.

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 43 +++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 807e433c770812a4..063e9da0878e93bc 100644
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
 
@@ -1882,24 +1879,25 @@ int dso__load(struct dso *dso, struct map *map)
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
 
@@ -1910,8 +1908,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (is_reg && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
-		if (nsexit)
-			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 
 		if (bfdrc > 0) {
 			dso__set_symtab_type(dso, symtab_type);
@@ -1978,7 +1976,6 @@ int dso__load(struct dso *dso, struct map *map)
 out:
 	dso__set_loaded(dso);
 	mutex_unlock(dso__lock(dso));
-	nsinfo__mountns_exit(&nsc);
 
 	return ret;
 }
-- 
2.56.0.257.gf7497c7d27-goog

