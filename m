Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E93E9C37
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540573; cv=none; b=D3326IaNsytfVW/dIV1tknrI3qZM9huUR/kvUzDpBj1R9A9j35INcjmL9+x9bfMZFMd8SJRnTSqaC9wYg1qGY1xf99s797RGa2FZNEu2JKaCe8/WYOv65d/HvKxDiDmyPGjqR+MZlMZAhaneV411Tvp6TADJ0u9HNEbU4SRChtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540573; c=relaxed/simple;
	bh=L7YUlqMQi6NDcCcSyIeTFyIS+A6oxs55+MRWqrdhbI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l48GWg2CnwxrSqJgB/+4iy3shdXKJ4Z33ypvPP0V5ovdvHQ31uYHBKKZv2hmd/2pCxw2ETtBmMghASKk4iFRvddnKGsSNJlo/b1jnt8xywzK5ArOI2qs8akCVkoepB26JgeX5ICRUiyq6yl691U6xQ5oD+6aMpgIGzct6CAgSfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZ2/jkh8; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZ2/jkh8"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso1913327a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789540571; x=1790145371; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jciz2Yg7eF5wpADWsphkTr+aDEba70tJiQc7W7iH7Nc=;
        b=IZ2/jkh8gyKfC4ap4KkLIbu5zQ2z16ZereRzqyM7oo2HjG3I2UkVNBKjaI1Jw1kJam
         p7Hr8sXeqIUME0mtDZafdEjxGmqnF40KIoajb2xwyTtkp5tVkPzCDPzNgCuontHnEHp8
         t3Tkm9YWmwkYYa/UsxhGgjHviMSrK3AfsQpGIN7cA1scj94YkawI4eHCLKp+ELIfKGV4
         GaGfEhGPCQiACFG7+YDEm4heDVMMyr9ue9n5LROhcVfL402QHvosCmhGfQ/3onOaBaFI
         NKOWQ/hhBIULTGvH/BHUO2vjPtSuOVyDUSsq1JFkA4nfc1zFyrGrjW6DvuyhljBlPwk7
         eZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540571; x=1790145371;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jciz2Yg7eF5wpADWsphkTr+aDEba70tJiQc7W7iH7Nc=;
        b=jAjg+zpjR3nNjGZK3FuIstOk+fH76ghswucNa4DtOHuUiT1LLZ4S9xKT1pGjLhOJlD
         EsKXiz5wawpl2J6vgxojkTJqNOabLpCisX13V1WbyWEc5rqJm/R1trSkHXqH/EpJq5Wg
         pY5JVHttxzU08i7aDJ4ulV+9QG3UMUEeUp9fQ0FbfvT8SU+gyE8LJymwoTXnt6VY+wib
         EakiYSCOiC7sF9JpYKKRwVGAMmAliHDwXtmGUBYsrNhKWU4IICgp3Tw4g1tgtRZDwyRw
         GBv34L8gsOEqui1VbxabxoL8AGH6jMKT9tMS+fxOa37hMDiYR/Pv1eHxdwOZxJWhzNr/
         mS0Q==
X-Forwarded-Encrypted: i=1; AKwUvBza5IcLiN+CJUcH1ocoFUswvdvsLSPd9hDvYdTr8NS5n0/BRc/Nvajx9T7tdO0KAdGt305222sHE74adZSE9ico@vger.kernel.org
X-Gm-Message-State: AFuF++mZ62QD+8D6oxprdBLQjaC3OzvWgCd1zFfrVaJBWz1lnh2TjAwv
	OrOly7Ltdvhp4c2KE93iKfXoZg2x2rx5Q55YDIEstbXl+1pgo+WnkOdo3WgTnLeNu7Z9cd+mZsg
	mb/WmnOsIBQ==
X-Received: from dlbbu8.prod.google.com ([2002:a05:7022:2208:b0:143:8b4d:2b9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0e:b0:396:7c01:553f
 with SMTP id 98e67ed59e1d1-39dfe1874b4mr10001864a91.21.1789540570510; Tue, 15
 Sep 2026 23:36:10 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:35:44 -0700
In-Reply-To: <20260916063545.3103314-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914170759.1992947-1-irogers@google.com> <20260916063545.3103314-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916063545.3103314-3-irogers@google.com>
Subject: [PATCH v2 2/3] perf dso: Separate libbfd and cmd addr2line caches to
 fix confusion
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/dso.c     | 49 +++++++++++++++++++++++----------------
 tools/perf/util/dso.h     | 21 +++++++++++++++--
 tools/perf/util/libbfd.c  | 10 ++++----
 tools/perf/util/srcline.c |  2 ++
 4 files changed, 55 insertions(+), 27 deletions(-)

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
index efc78d788ce7..7a462c9d11b6 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -239,7 +239,7 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 				       struct inline_node *node,
 				       struct symbol *sym)
 {
-	struct a2l_data *a2l = dso__a2l(dso);
+	struct a2l_data *a2l = dso__a2l_libbfd(dso);
 	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
 	char *srcline = NULL;
 
@@ -258,11 +258,11 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
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
@@ -323,14 +323,14 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
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

