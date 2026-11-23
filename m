Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476033;
	b=rvOxpAFkYSVbofi4VQDnr41CskbJYTrTuBcv37kq4GGgDjCxhKqCM02Faq1eev8aRfPl
	 K0kwcdDCX7/+5xcxBV/esQlHTLJrj0nX+6mE4r0RZAHj1nPMwl0JMh8y5bTjNfjEpRofK
	 pXvHjO9rtvuwFBIn0vZZvad+m1jjlFrdDrnorue0TxkkpHAjDxljGQ0MYupZ64j55zDj+
	 CwId4j9k1H7VTRsmfZV5g5ILDKa84pDqrd++yBe2R+ZnuBP006YK2VYmR0MLSnrilgiiV
	 hh1epFXxwueZmmWie86qEt1q1EehuxGSzQb6PoqLcbgwr0GKHklHlqiMm1KVCbJx8zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1tse0JnChZbfhglDWUIbnh/F560LAFOsOr+QahzFXEo=;
	b=qQq5He3uhYQmKXZQFzFnRE++7EFzb3wit0NOfKMyj8JDl/Y9xFHQ9/jhajHgs9sQimh5
	 nvRnIIT3NVeOLzUAY21qeOypLopoKwZaeQVuhorkaAYNMAYFYaSoMKvGCV/PPAkkmS7CN
	 IgFBGZqQlxPBV73rKWG3UX4uW69q8NB8Cpm32WOn/FuDZB+LnfogCdx0kFzTDrhXnena6
	 l9IMYLCuvgfOvo8oVxypLgGDsQmwzilKtF/myaw9lvjtCvET42MmRM4zQZJYzAcTYtiBA
	 by8bCMu8L7vwkbTn3V04o7fIicTLr/YDY2yBSGwGky4i5r3EUphcOSDCGr3wFel76zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGAHHXBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A5606A334;
	Mon, 23 Nov 2026 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGAHHXBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF81F000C0;
	Mon, 23 Nov 2026 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476033;
	bh=1tse0JnChZbfhglDWUIbnh/F560LAFOsOr+QahzFXEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGAHHXBLnRBilZ54DLdZKWlF4DM5hM3BsCklfVmGh0+s+9kr0YGVVZ+vK+2bWAH/Y
	 blE/kXhaB4g1+Wj351xH8ERj+cHrozM0/QxgtpK4nGE1lM30rJfJZ9psWfG0z3er/x
	 he2M/tSRilHuIJwZaTWlD00SJC4/VOI+C95pzEVB8ZMnY45mHFXG9xaon2MKQgKP8o
	 EkiOs8oJ9UZR4aVybWLdB2ux8cYcms8KiKsB6D0zgr5CrylJGj5hzv5rJwlqgOOPR7
	 jHRaXmAn0JCZCQ8PvmHxBcGunGtBq8GdwswI8ettihkCYaufmLOizhp62PYVlbYZQw
	 M8v9bn0cRdhTQ==
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
Subject: [PATCH v3 08/11] perf tools: Export filename__read_build_id_ns()
Date: Mon, 23 Nov 2026 15:20:22 -0800
Message-ID: <20261123232025.1406560-9-namhyung@kernel.org>
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

Export filename__read_build_id_ns(), including a chroot fallback guarded
by !nsinfo__need_setns() && nsinfo__check_proc(), and use it in the dsos
callback and perf-inject's dso__read_build_id() instead of open-coding
nsinfo__mountns_enter() and dso__filename_with_chroot() fallbacks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 12 +-----------
 tools/perf/util/build-id.c  | 15 ++++++++++++---
 tools/perf/util/dsos.c      | 17 +++--------------
 tools/perf/util/symbol.h    |  3 +++
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index de3a74d2bab9220f..31e23169e25a5af1 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -906,24 +906,14 @@ static int perf_event__repipe_tracing_data(const struct perf_tool *tool,
 
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
index c792448cc3442db9..395fc5b7bf2818e3 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -850,15 +850,24 @@ int build_id_cache__remove_s(const char *sbuild_id)
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
+	if (ret < 0 && errno == ENOENT && !nsinfo__need_setns(nsi) &&
+	    nsinfo__check_proc(nsi)) {
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
index 7a56577f4ec86a18..9ae27ee934135c48 100644
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
@@ -72,7 +72,6 @@ struct dsos__read_build_ids_cb_args {
 static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 {
 	struct dsos__read_build_ids_cb_args *args = data;
-	struct nscookie nsc;
 	struct build_id bid = { .size = 0, };
 
 	if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
@@ -81,20 +80,10 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
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
index 8b8ab7e1e1481999..455b45ca68e705d8 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -29,6 +29,7 @@
 struct dso;
 struct map;
 struct maps;
+struct nsinfo;
 struct option;
 struct build_id;
 struct perf_env;
@@ -238,6 +239,8 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_
 enum dso_type dso__type_fd(int fd);
 
 int filename__read_build_id(const char *filename, struct build_id *id);
+int filename__read_build_id_ns(const char *filename, struct build_id *bid,
+			       struct nsinfo *nsi);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
-- 
2.56.1.809.ga0b61035b5-goog

