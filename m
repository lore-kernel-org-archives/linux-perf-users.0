Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B04EBAE6
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602261; cv=none; b=ft+8lclva+cERJhhrABaKP6U9fF3PevN2+YcYo/D6Kd3uBE3pfNRJjzqd6mS0ZO/9TtSKExXFqrOdi/5ARYjp5mSGaZ9bhVOdOnp+/P6mJ6WfOnHfaYb8yO5UaoiksnzndibzHdtLvp+K1Au/shXlzpffh+BcRIbQM0gHc96l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602261; c=relaxed/simple;
	bh=xP10taDMLP0iuYlIVVM2a23fZRTDyL4vs128okCOz4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GFGz9PR00mWQpN7oz9308+07ERr6SkAbOgMiwN006XoHid0LuF8uz8Awdtsj+p4r3IWBgJxorWvEz9wBFwCCnSxhJFDR0xkc1nqa86uvw1QoqM58o480SK9tCtt1YrAIfxSpSq76u2kpoR22eLqtsqLi+sSCW7ianYj1Mqye680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drfOY0Nj; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drfOY0Nj"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso5237175ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602259; x=1790207059; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrTRcdREb/1Pe51W7xJkyBsA0asz0RYuJXXZoVXSudE=;
        b=drfOY0NjbqfW8EmO2PPv1zf+jaUBwvFOAkc4M2NIShFm1wg55KWFKEfQqfJ+dUTRcN
         43CFTdxTf73sO4U7mvirOsVEbX5nW0tgRmkbfFbz+2J/DIn9qGubRTBZsDGB1mDuxFuO
         d75ML1IGH2nlZqE2pplvW1Hot7tFt0A7e5IGqk+HOz0jyLzzY591jD/ESgabUqVCq3n+
         HunFznRZb/mUbLOVEPQW+ko7+JEV+voGUEBEuJog/8ybbSi2DR9BID7xnK9Rsw981GW4
         o7LPumeDXGefa/udqcNmcv6N+Nk6Gx4d1kdXkYJbjj1af4uSyKP4Ji+/UY6+4AAwdLe4
         DzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602259; x=1790207059;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DrTRcdREb/1Pe51W7xJkyBsA0asz0RYuJXXZoVXSudE=;
        b=RbrEwkmXNBkWBE4Zw9dD/+tC/A55OyJ1QM3UbbCKcggOUQPzjACh+luxXJtJsaNU+l
         5wPcgw9OUUPpLi5/ndJSTW+ag5xRWaA6n226yKbLZ0lOE21xLsjmuiwIvaPdrMVE4Z4r
         R8l+Uvuf95qh0gJS00jkeLbq1U4miAOjtWr9/mHbLErBWUEhbK/r0Yuwr/i0kbSno7oq
         2IB0cusmxjXFxp/XfVHQD8+uCEn0T5qxDcWtX9gM8yYDxQrQzTCw0zc5SzaHzzz94K6N
         qs+aU9sBc+DaiBWNG8BMWiFGSfMVTKaEq6xbQq0Wbqym3w1d48JSJs2g6bp17pM/vUeY
         z3FA==
X-Forwarded-Encrypted: i=1; AKwUvBxF8kzgo4cCL2uEnQL+ON5WDxEDTXPCzNrB4L+A4DhpgfMioSo/b2RdeenYRHLP4YRnuQ6pTJH5/bM8eS+BMS7n@vger.kernel.org
X-Gm-Message-State: AFuF++lJMwRDUUT7vx8NIydMzr9GYo+8/YMk0vBEdOzNuOBQPM4KxuZp
	TXVVlbgxWt7Nl0N3dzRaFF3kp9DmRjB/OyfMaNG7bmLyQiFUnmB2s/cBPJW+T89FFEtlJSUbIzw
	m4SH1QStrxw==
X-Received: from dyuw12-n2.prod.google.com ([2002:a05:693c:880c:20b0:313:b34f:8861])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ac6:b0:2db:55d6:349d
 with SMTP id d9443c01a7336-2dd8e75600emr102850515ad.21.1789602258533; Wed, 16
 Sep 2026 16:44:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:44:01 -0700
In-Reply-To: <20260916234402.437113-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916063545.3103314-1-irogers@google.com> <20260916234402.437113-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234402.437113-3-irogers@google.com>
Subject: [PATCH v3 2/3] perf dso: Separate libbfd and cmd addr2line caches to
 fix confusion
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
index 807944cd978c..d87242d88525 100644
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
 
@@ -259,11 +259,11 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 	mutex_lock(dso__lock(dso));
 	dso_name = dso__symsrc_filename(dso) ?: dso_name;
-	a2l = dso__a2l(dso);
+	a2l = dso__a2l_libbfd(dso);
 
 	if (!a2l) {
 		a2l = addr2line_init(dso_name);
-		dso__set_a2l(dso, a2l);
+		dso__set_a2l_libbfd(dso, a2l);
 	}
 
 	if (a2l == NULL) {
@@ -324,14 +324,14 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
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
2.55.0.1082.g2b9226bbc0-goog

