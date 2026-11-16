Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808657;
	b=vV+RaBBjDrpsLLjVehpnwWdsITAY21c3DmIGRmZ2zPD3b2AoY12pILCejlXChTdePtdM
	 mHGS/IKusInBsIdldZRg6q7FLSrClx/wo5QuXHsbl5CnC6nOd4RVbZgp7sxDI3mC+fr55
	 LsLduLdpQzWSiVBVWwPcJqi3eRd/zFzFRZx6IR3QvwApRaZPLxlecLNSmvVkJDTmMEUXs
	 TJ4X8qhdIXy8gGRcVuIQmDRiihRxyfin7PUyt7fnjPn2Vl+/+fe8FE4TawTWyMpXDXqMh
	 dUpvDGCNcZRDmXFwO9fJZkLudu0pEFrXcoDont+PpwM6i6/Chf7HDEIj7bu94l8cBfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r+DZc60+5tqUNwki4i/cR/N681kq1FtjzxelTQaXdSM=;
	b=Mrjdpf/BcTKfiogvFQN2cQ3S7xpom7pfush6mOu58SLt0BjRjKjgrZm1qpbnjG6GxeDX
	 V4Rm2oV1tUqCwpeClV5XQor/nbZGyaukAxKNanJxFDPW84KDFrqViGPiFlzyGWvhXmjwO
	 531PFcDVz2q5sl1KR1VF7tQwaLfgPWYNgkX/p0aSD+37pyDLeHXVN0uj17WJJjFfrJpkU
	 22L/yaCiqBPAdqM5VtbAI9/4LoJ/eJhOlPO00vmHnsJFu9DrTMeEj/xNcMvZP7WgwrOeS
	 2qq5D6nkt61TotcAyNkM4eSXWsU5iFacpJ5HlE71qdOl5LqvO7AdomrNx6T7AZsS8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvDqeg3D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B68606A8BC;
	Mon, 16 Nov 2026 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvDqeg3D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9793C1F000CA;
	Mon, 16 Nov 2026 05:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808656;
	bh=r+DZc60+5tqUNwki4i/cR/N681kq1FtjzxelTQaXdSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IvDqeg3D9y8kQ5w6HcdNt0nB9EXI+Gwts0M+xBclIzhduHbpbElWDBpJ6Uj26H+CW
	 kZ2bz9JTFIS+Ki2hz06DS/wiMtPOZgjUqpRKf7Wl6KN8ZJ68ZzrNiMPXi/B2It2kKE
	 LDvZXo2qbUs48nlzRlbo5ank0saGd5iBpwyIzPJkjv3kiCRGC0BqZhzqfGZ+bE0b6z
	 /dA5gAcj6C6mP7Il/t1ngaJixuRIkbwsvx+wewuy52KFBDITlfS7Q2pNGFejTnMLXl
	 v7ozhKOBxtkQZ6kFt1LFVxspIbjLQm7WLkYEtT6VPvoeuj3l5iZrTYU/7R0EV3AcSI
	 6+pomMoNI6O0Q==
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
Subject: [PATCH v2 08/11] perf tools: Export filename__read_build_id_ns()
Date: Sun, 15 Nov 2026 21:57:28 -0800
Message-ID: <20261116055731.707164-9-namhyung@kernel.org>
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

Export filename__read_build_id_ns(), including a chroot fallback guarded
by nsinfo__check_proc(), and use it in the dsos callback and
perf-inject's dso__read_build_id() instead of open-coding
nsinfo__mountns_enter() and dso__filename_with_chroot() fallbacks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 12 +-----------
 tools/perf/util/build-id.c  | 14 +++++++++++---
 tools/perf/util/dsos.c      | 17 +++--------------
 tools/perf/util/symbol.h    |  3 +++
 4 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 05bf1aae61778952..71ebb5b9ab84cbf7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -894,24 +894,14 @@ static int perf_event__repipe_tracing_data(const struct perf_tool *tool,
 
 static int dso__read_build_id(struct dso *dso)
 {
-	struct nscookie nsc;
 	struct build_id bid = { .size = 0, };
 
 	if (dso__has_build_id(dso))
 		return 0;
 
 	mutex_lock(dso__lock(dso));
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+	if (filename__read_build_id_ns(dso__long_name(dso), &bid, dso__nsinfo(dso)) > 0)
 		dso__set_build_id(dso, &bid);
-	else if (dso__nsinfo(dso)) {
-		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
-
-		if (new_name && filename__read_build_id(new_name, &bid) > 0)
-			dso__set_build_id(dso, &bid);
-		free(new_name);
-	}
-	nsinfo__mountns_exit(&nsc);
 	mutex_unlock(dso__lock(dso));
 
 	return dso__has_build_id(dso) ? 0 : -1;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 02233ef0eafff2c2..ff083a594b405208 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -847,15 +847,23 @@ int build_id_cache__remove_s(const char *sbuild_id)
 	return err;
 }
 
-static int filename__read_build_id_ns(const char *filename,
-				      struct build_id *bid,
-				      struct nsinfo *nsi)
+int filename__read_build_id_ns(const char *filename,
+			       struct build_id *bid,
+			       struct nsinfo *nsi)
 {
 	struct nscookie nsc;
 	int ret;
 
 	nsinfo__mountns_enter(nsi, &nsc);
 	ret = filename__read_build_id(filename, bid);
+	if (ret < 0 && errno == ENOENT && nsinfo__check_proc(nsi)) {
+		char *new_name = filename_with_chroot(nsinfo__pid(nsi), filename);
+
+		if (new_name) {
+			ret = filename__read_build_id(new_name, bid);
+			free(new_name);
+		}
+	}
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e927e707abace9c6..a97fed55286aefca 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -4,11 +4,11 @@
 #include "dso.h"
 #include "util.h"
 #include "vdso.h"
-#include "namespaces.h"
 #include <errno.h>
+#include <linux/perf_event.h>
 #include <stdlib.h>
 #include <string.h>
-#include <symbol.h> // filename__read_build_id
+#include <symbol.h> // filename__read_build_id_ns
 #include <unistd.h>
 
 void dsos__init(struct dsos *dsos)
@@ -70,7 +70,6 @@ struct dsos__read_build_ids_cb_args {
 static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 {
 	struct dsos__read_build_ids_cb_args *args = data;
-	struct nscookie nsc;
 	struct build_id bid = { .size = 0, };
 
 	if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
@@ -79,20 +78,10 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 		args->have_build_id = true;
 		return 0;
 	}
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
+	if (filename__read_build_id_ns(dso__long_name(dso), &bid, dso__nsinfo(dso)) > 0) {
 		dso__set_build_id(dso, &bid);
 		args->have_build_id = true;
-	} else if (errno == ENOENT && dso__nsinfo(dso)) {
-		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
-
-		if (new_name && filename__read_build_id(new_name, &bid) > 0) {
-			dso__set_build_id(dso, &bid);
-			args->have_build_id = true;
-		}
-		free(new_name);
 	}
-	nsinfo__mountns_exit(&nsc);
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 6347bd218ad5eac4..7ac362b5d53530b0 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -28,6 +28,7 @@
 struct dso;
 struct map;
 struct maps;
+struct nsinfo;
 struct option;
 struct build_id;
 struct perf_env;
@@ -211,6 +212,8 @@ struct symbol *dso__next_symbol(struct symbol *sym);
 enum dso_type dso__type_fd(int fd);
 
 int filename__read_build_id(const char *filename, struct build_id *id);
+int filename__read_build_id_ns(const char *filename, struct build_id *bid,
+			       struct nsinfo *nsi);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
-- 
2.56.0.611.g1030f0b940-goog

