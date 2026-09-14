Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AC3D1CC5
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405692; cv=none; b=ov8BbfQAGT1/QZ1uO+QZByNRNK5qNGqhZvU12nglhJyMKjAGv+uE6Iz77apik3DE3qJigu92N0eLYrqyOWaysvWpyNEPnKs5w9oIk4E2b4E3QZfI9vmcSGKIKqEKWhrmBYTp1GcuBeLxVZu8Xn6Vq1x2IvRKoGMd5U9jYkVRWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405692; c=relaxed/simple;
	bh=KWwhOExXkxuHKJSze0zrmUoXuDnB70b9lq7Di09ZMqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JEZoLCfBy/Mb7J9sI6qnZjooxqSJuA8qW4NifaGFNYYuBKl5jUbsMlxK2qVkMM6kOAmyfmpBswZqeHPVbEXFvq2hA44wtLwioTFw1IoVwHvtlDhvSeDAA/62WmnJh8Ts+RzD0SemAdqMDYTCMQihIK+IBUJNWcb0C6LFnz9H0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1Vd2A+7; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1Vd2A+7"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so7903879a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789405690; x=1790010490; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BV+cdLHm/UXgK8ux34UkjPdQXRVZPhMI7hVk5RemaYM=;
        b=o1Vd2A+7v5gTS3GBJONage23tuoDr7TRZLZpkd5PVbsDErNjB2pequ+M/oV9QxUWHO
         88ASQ/etzXUsGXbFr2vxTqT47x4N/h5aeVqWT4DVD98zW2VGIzXH/pw5xBnHBNszqCUa
         bGNtHa+m6k+XVY+bbr7fbTD0z4cV2gywbfTZw/GT+o+TBCpEijMXLaQc2jMtUOAW6OvM
         MXineuTGJiWJ3dM4CLNQADQKUrGgHvdQlYp/hFkDW3swHVepqJS2fR2BNGze06X99bMV
         ewU+L9v2ZVeTchnF0HiA7FVIhXNeVC7jEtVkDuqowxGd7yAQKL2Ep9PWu70E3vHBKc9B
         fVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789405690; x=1790010490;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BV+cdLHm/UXgK8ux34UkjPdQXRVZPhMI7hVk5RemaYM=;
        b=DQ1so06Y3Scho5Drk2kjCDDzoG9eqd44o/cmPDlfWXio3S0U3W+JU3xeiqIJWX0NuO
         SxlDCsVxDk/oH51Il/l1+jnkuAB3Jidwdf77YzpD/dLHf/1yAAZdEiBR4r4rhhasRAg9
         232i4xdNZFFUIiIdmiO3WdwSMd8ekVYuHF9/aWDBmHR6W7A2HkiiHpgYiGXAsXZULvo/
         RC90dy2DG6yHGo1Wn7Nnu2FwVEHdgL6XjKnfNSzay9wWCDZZL+R1JsAvS3pyxLJlzUyO
         6OxrE0DCIvdbDIndtTePbJXQ9zRNWIHsFIslTwUST2g7D1j3Rfg1EesbBg4pa1bLCU/n
         Lwmg==
X-Forwarded-Encrypted: i=1; AKwUvBztraIEbX4ZntQ+If4WHF58yCmhwmmXrCHbqjstrVkLO2hMPNZtiXLvYpIiq46QWaVvNrY9Y0U/0uCOq5Kt3SS2@vger.kernel.org
X-Gm-Message-State: AFuF++lAhJjb6gjO8GHh30IgTSsQSopqFrljAZ3eV+JAcpZPFnyab7eb
	b39VbBRL++M1dt4wbJkrovBdUudkY5uh/XUXGfIhxRQNG0w2cjVvuK3jxmqz+NlveZSDPGQzKCu
	Q3Rm1TKnNpw==
X-Received: from dycnr23-n1.prod.google.com ([2002:a05:7300:e9d7:10b0:328:ea0:399e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c50:b0:38e:49c0:75a7
 with SMTP id 98e67ed59e1d1-39debfa8268mr7175920a91.8.1789405689469; Mon, 14
 Sep 2026 10:08:09 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:07:59 -0700
In-Reply-To: <20260914170759.1992947-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914170759.1992947-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914170759.1992947-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf dso: Separate libbfd and cmd addr2line caches to
 fix confusion
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a dso executes addr2line via libbfd it instantiates an a2l_data
pointer. If the DSO later executes via the command-line fallback due
to an inlined bug, the a2l pointer is unconditionally populated with a
child_process process wrapper. If libbfd is queried again, the offline
reader attempts to cast struct a2l_data into child_process, coercing
random arbitrary instruction addresses and causing silent aborts. This
cleanly splits the caches.

Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementations")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/dso.c     | 49 ++++++++++++++++++++++---------------
 tools/perf/util/dso.h     | 21 ++++++++++++++--
 tools/perf/util/libbfd.c  | 51 +++++++++++++++++++++++++++------------
 tools/perf/util/srcline.c |  2 ++
 4 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index df39e6ca88e6..6510767177be 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,38 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "dso.h"
+
+#include <errno.h>
+#include <stdlib.h>
+
 #include <asm/bug.h>
+#include <fcntl.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
-#include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/libbpf.h>
-#include "bpf-event.h"
-#include "bpf-utils.h"
-#endif
+
+#include "annotate-data.h"
+#include "auxtrace.h"
 #include "compress.h"
+#include "debug.h"
+#include "dso.h"
+#include "dsos.h"
 #include "env.h"
+#include "libbfd.h"
+#include "libdw.h"
+#include "machine.h"
+#include "map.h"
 #include "namespaces.h"
 #include "path.h"
-#include "map.h"
-#include "symbol.h"
 #include "srcline.h"
-#include "dso.h"
-#include "dsos.h"
-#include "machine.h"
-#include "auxtrace.h"
-#include "util.h" /* O_CLOEXEC for older systems */
-#include "debug.h"
 #include "string2.h"
+#include "symbol.h"
+#include "util.h" /* O_CLOEXEC for older systems */
 #include "vdso.h"
-#include "annotate-data.h"
-#include "libdw.h"
+
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/libbpf.h>
+
+#include "bpf-event.h"
+#include "bpf-utils.h"
+#endif
 
 static const char * const debuglink_paths[] = {
 	"%.0s%s",
@@ -1757,6 +1764,7 @@ void dso__delete(struct dso *dso)
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
+	dso__free_a2l_libbfd(dso);
 	dso__free_libdw(dso);
 	dso__free_symsrc_filename(dso);
 	nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
@@ -2081,6 +2089,7 @@ void dso__set_symsrc_filename(struct dso *dso, char *val)
 	RC_CHK_ACCESS(dso)->symsrc_filename = val;
 	dso__free_libdw(dso);
 	dso__free_a2l(dso);
+	dso__free_a2l_libbfd(dso);
 	dso__set_has_srcline(dso, true);
 	dso__set_a2l_fails(dso, 0);
 }
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 7966c7048c85..e7d5f4bbf894 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -304,7 +304,12 @@ DECLARE_RC_STRUCT(dso) {
 	const char	 *short_name;
 	const char	 *long_name;
 	void		 *a2l;
+#ifdef HAVE_LIBBFD_SUPPORT
+	void		 *a2l_libbfd;
+#endif
+#ifdef HAVE_LIBDW_SUPPORT
 	void		 *libdw;
+#endif
 	char		 *symsrc_filename;
 	struct nsinfo	*nsinfo;
 	struct auxtrace_cache *auxtrace_cache;
@@ -368,6 +373,20 @@ static inline void dso__set_a2l(struct dso *dso, void *val)
 	RC_CHK_ACCESS(dso)->a2l = val;
 }
 
+#ifdef HAVE_LIBBFD_SUPPORT
+static inline void *dso__a2l_libbfd(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->a2l_libbfd;
+}
+
+static inline void dso__set_a2l_libbfd(struct dso *dso, void *val)
+{
+	RC_CHK_ACCESS(dso)->a2l_libbfd = val;
+}
+#endif
+
+struct Dwfl;
+#ifdef HAVE_LIBDW_SUPPORT
 static inline void *dso__libdw(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->libdw;
@@ -378,8 +397,6 @@ static inline void dso__set_libdw(struct dso *dso, void *val)
 	RC_CHK_ACCESS(dso)->libdw = val;
 }
 
-struct Dwfl;
-#ifdef HAVE_LIBDW_SUPPORT
 struct Dwfl *dso__libdw_dwfl(struct dso *dso);
 #else
 static inline struct Dwfl *dso__libdw_dwfl(struct dso *dso __maybe_unused)
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index d0a27b14ee0d..f7400e30ee76 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -1,5 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "libbfd.h"
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <fcntl.h>
+#include <pthread.h>
+
+#include <tools/dis-asm-compat.h>
+
 #include "annotate.h"
 #include "bpf-event.h"
 #include "bpf-utils.h"
@@ -11,15 +23,13 @@
 #include "symbol.h"
 #include "symbol_conf.h"
 #include "util.h"
-#include <tools/dis-asm-compat.h>
+
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #endif
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
+
 #define PACKAGE "perf"
 #include <bfd.h>
 
@@ -39,13 +49,13 @@ struct a2l_data {
 	asymbol **syms;
 };
 
-static bool perf_bfd_lock(void *bfd_mutex)
+static bool perf_bfd_lock(void *bfd_mutex) NO_THREAD_SAFETY_ANALYSIS
 {
 	mutex_lock(bfd_mutex);
 	return true;
 }
 
-static bool perf_bfd_unlock(void *bfd_mutex)
+static bool perf_bfd_unlock(void *bfd_mutex) NO_THREAD_SAFETY_ANALYSIS
 {
 	mutex_unlock(bfd_mutex);
 	return true;
@@ -165,11 +175,17 @@ static struct a2l_data *addr2line_init(const char *path)
 {
 	bfd *abfd;
 	struct a2l_data *a2l = NULL;
+	char *alloc_path = strdup(path);
+
+	if (!alloc_path)
+		return NULL;
 
 	ensure_bfd_init();
-	abfd = bfd_openr(path, NULL);
-	if (abfd == NULL)
+	abfd = bfd_openr(alloc_path, NULL);
+	if (abfd == NULL) {
+		free(alloc_path);
 		return NULL;
+	}
 
 	if (!bfd_check_format(abfd, bfd_object))
 		goto out;
@@ -179,7 +195,7 @@ static struct a2l_data *addr2line_init(const char *path)
 		goto out;
 
 	a2l->abfd = abfd;
-	a2l->input = strdup(path);
+	a2l->input = alloc_path;
 	if (a2l->input == NULL)
 		goto out;
 
@@ -189,11 +205,14 @@ static struct a2l_data *addr2line_init(const char *path)
 	return a2l;
 
 out:
+	if (abfd)
+		bfd_close(abfd);
 	if (a2l) {
 		zfree((char **)&a2l->input);
 		free(a2l);
+	} else {
+		free(alloc_path);
 	}
-	bfd_close(abfd);
 	return NULL;
 }
 
@@ -210,7 +229,7 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 				       struct inline_node *node,
 				       struct symbol *sym)
 {
-	struct a2l_data *a2l = dso__a2l(dso);
+	struct a2l_data *a2l = dso__a2l_libbfd(dso);
 	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
 	char *srcline = NULL;
 
@@ -229,11 +248,11 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 	struct a2l_data *a2l;
 
 	mutex_lock(dso__lock(dso));
-	a2l = dso__a2l(dso);
+	a2l = dso__a2l_libbfd(dso);
 
 	if (!a2l) {
 		a2l = addr2line_init(dso_name);
-		dso__set_a2l(dso, a2l);
+		dso__set_a2l_libbfd(dso, a2l);
 	}
 
 	if (a2l == NULL) {
@@ -282,6 +301,8 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 	if (file) {
 		*file = a2l->filename ? strdup(a2l->filename) : NULL;
 		ret = *file ? 1 : 0;
+	} else {
+		ret = 1; /* inline frame successfully appended by bfd_find_inliner_info */
 	}
 
 	if (line)
@@ -294,14 +315,14 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 void dso__free_a2l_libbfd(struct dso *dso)
 {
-	struct a2l_data *a2l = dso__a2l(dso);
+	struct a2l_data *a2l = dso__a2l_libbfd(dso);
 
 	if (!a2l)
 		return;
 
 	addr2line_cleanup(a2l);
 
-	dso__set_a2l(dso, NULL);
+	dso__set_a2l_libbfd(dso, NULL);
 }
 
 static int bfd_symbols__cmpvalue(const void *a, const void *b)
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index e60dea472507..68798a4de887 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -300,6 +300,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
+		dso__free_a2l_libbfd(dso);
 	}
 	mutex_unlock(dso__lock(dso));
 out:
@@ -347,6 +348,7 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
+		dso__free_a2l_libbfd(dso);
 	}
 	mutex_unlock(dso__lock(dso));
 
-- 
2.55.0.1032.g73a4cd73de-goog

