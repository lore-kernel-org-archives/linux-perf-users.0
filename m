Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739507;
	b=F7ZGQOTJg0OLXy6+DhwBRRnukMDLLn2oNkNjBi9dmIB3XiuRtmIioXYsyhcZt9BHjnIS
	 YCUHjaKQhvBcqPAverWiDCvIUC5XLMUflrzduT05SuXglD14Rrs4FdvWMu7Kg5ubj5Vv5
	 WTZqHOnMpIlYHGZ+tQZ+rtqWPx6K2ups6vub2qx7+CLnKPA1CuKubSuNpzODbLvjNmZgr
	 dQ5v1zUtyco0zREgasabqwEGRGUYawOdZFYSgFh/XHV7xw1QpYV6ZJMpHLw3fep9s8kw8
	 HjiiWA1aiKH80f3xjFGKTtnceBlsSChPW40/UuC56fHlSZIY65DXeQ4WxEYMziXxqgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DIEbvz97VAtUaSPV0gJ+LoxFrsTdceBEpalJykmJzrs=;
	b=RDPS9ZQMnIrvSqI3TxTfEjZvt8IAnuUCcZC5/SCapMQFY98EO9HW+CE7+ltZRLj/+dqD
	 ZLjT+NPpeov6iDs0DDbRXXynaJw/Ip2DpVsAY5jgsjwKaPs/bdbtOuzlY4HMe00vJzvjU
	 jB0iFocQn+aQpUiiQm3UU2UAbOem0t4bFDgbMru0c++Jjnavsox2wIpnPXYA6Uy8EBMWg
	 e9jlzVkBROtV8zM+kdUDL8QLjHf/YrVu+bHmGk0KXrfGVcmovwchO5nK+aHLIzxkQ6RvR
	 tK9gAGDnrvjQhmGXoEV9tdb3BQnG+EkL63lkLRW+xhGk8UOjWpchuCXkJpBUCGXXbKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtlvxPaX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9013606A31E;
	Fri, 23 Oct 2026 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtlvxPaX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB3B1F031E0;
	Fri, 23 Oct 2026 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739506;
	bh=DIEbvz97VAtUaSPV0gJ+LoxFrsTdceBEpalJykmJzrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtlvxPaX6oOhz4MjANWeq4BFv7mv03brFvQ3fdeeRu8kIRnUA65LECH96+sGutqc4
	 LpjFdDkbsYrtOWmMbWlc7FAyN2bt/8oOyuBsZFriM3Qmqedmra3NYFebOJ/+8KiO5R
	 wWmWgdc0B8u6Jz9hDTObDg4RBEDnaHv3p+tnaAtAPUwlokCC2OtPkHMYbY2mpGkg5j
	 nqtp4tpebU0tPxNkzvHeRjEVafNNXHlnBrCNZZ0FnHyMiOuuZ/0i8B3p0gV1BHZYyh
	 El+GKq4D06j1pc2c2WEUOnbGLb3iUAbMt/cb2v1L8zPMf7QQi6BrzjXxm4CuG+aD7H
	 cG5eWo1EwKt3g==
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
Subject: [PATCH v1 08/11] perf tools: Export filename__read_build_id_ns()
Date: Fri, 23 Oct 2026 00:11:38 -0700
Message-ID: <20261023071141.134149-9-namhyung@kernel.org>
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

Export filename__read_build_id_ns() and use it in the dsos callback
and perf-inject's dso__read_build_id() instead of open-coding
nsinfo__mountns_enter() and dso__filename_with_chroot() fallbacks.

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 12 +-----------
 tools/perf/util/build-id.c  |  6 +++---
 tools/perf/util/dsos.c      | 17 +++--------------
 tools/perf/util/symbol.h    |  3 +++
 4 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ddb21d888e00d143..2f044aef0bb32b94 100644
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
index 02233ef0eafff2c2..db5ba9e91fba4d2d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -847,9 +847,9 @@ int build_id_cache__remove_s(const char *sbuild_id)
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
index d0bac824c79c8283..9d86d2eb694298f7 100644
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
@@ -221,6 +222,8 @@ struct symbol *dso__next_symbol(struct symbol *sym);
 enum dso_type dso__type_fd(int fd);
 
 int filename__read_build_id(const char *filename, struct build_id *id);
+int filename__read_build_id_ns(const char *filename, struct build_id *bid,
+			       struct nsinfo *nsi);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
-- 
2.56.0.257.gf7497c7d27-goog

