Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642139;
	b=BIlEpLFqyUNkldZfyn9aMQ2oh+2s11o7ZTyLyG/cnV4wHPjfoCFPlsDrrDHQAeYAeuVc
	 nHapl4qHOoNaavA2+0teL/pupRFQ2FKvCAM+RCAnY9+DP1pw+23VHtKUjxoKm/xeicD4Y
	 QYgM1EnY5rfBAS6YgmXlB2EyaC5qeaQYVl3cPl3odhtlAKU13smcHvtm3gozqh5M4RHNC
	 HZJTdhtqOAOTQOUNR17Ap50/FvGM8OauBhVSVDrXEGsU1vpfUsiklBIymkYJ0RHGs4tPi
	 hsQlnFJOLjmPVv004ixCXx35qa1gD6ltVjPh83Jj+i6yhxi3tepFZPgg3alnMhXu0Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3npt5MeJdSF1ykF66UEZxvSrY3CnqI6gcPOmbzhGxJo=;
	b=p5t55edn4qMG3NkKG90zgxc69d3VlCjiaLIZtTTqv8/S1zhhcsR5uKdvuCmZyaemjsKx
	 BfLSTWYbFwBz7ZOFa+QZmYztaYyqi1Vd4w/ylIfwceQGT08NYgOEMvtM4Fd760rS8SMnW
	 mscjoUPii0JZ6clbn+6uLBd5uYDUltvyiZD1HosWCyC8l1fIpMYdXm14uO9ZPXjN5g9Iy
	 cSjadmQDlyHpBODg9YB1Ar1/zX2UqA5+fDzvMjw/cA0XeY4AM7wbF6LbkDww6YzwFyC54
	 oyRBo7nYWxoXC8gRcXtwbeP5Dl7DmGIszEXegLhsqZXN/CLzWASAoRLBZqEbjzm18sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4EL9Dbt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CD60A2630;
	Wed, 25 Nov 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4EL9Dbt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C6D1F01565;
	Wed, 25 Nov 2026 21:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642138;
	bh=3npt5MeJdSF1ykF66UEZxvSrY3CnqI6gcPOmbzhGxJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4EL9Dbtk8NAuiRophRxk486yMvYMEny671Aa1wEyqAtQ9y4jcqcomSOVE5hbZRH8
	 k5fbiBvtMbG0WO4unfp/1j1PF8573dZrlxYfgF5cHuQmKN6HLp9H9ZWhr/4aL2+OcK
	 0aPX7r5TKpS7sYUVkJxM/6eWfvsLIftqeoLV0E23Jnu01yEdkiYnZ0/IJFXAF6L6oH
	 XvYPLNsBnAD56OidEWy0tJzpqynHjOMN40yJaDp7zoEhBWNKDS7veJG9cegLF0xSUS
	 6zQq+/71+oBplXa2Bvksx/cPfRPixkT9w9LwEm3rMBxU3aRxkpy4XavJqLrpMrzlZR
	 BTzFYB/vIVCHA==
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
Subject: [PATCH v4 08/11] perf tools: Export filename__read_build_id_ns()
Date: Wed, 25 Nov 2026 13:28:48 -0800
Message-ID: <20261125212851.1792988-9-namhyung@kernel.org>
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
index 64fdf402d21913a3..a6bc187fae28029a 100644
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
@@ -257,6 +258,8 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_
 enum dso_type dso__type_fd(int fd);
 
 int filename__read_build_id(const char *filename, struct build_id *id);
+int filename__read_build_id_ns(const char *filename, struct build_id *bid,
+			       struct nsinfo *nsi);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
-- 
2.56.1.831.g720f3f5937-goog

