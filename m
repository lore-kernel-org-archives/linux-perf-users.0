Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A423EEAC7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621507; cv=none; b=Oz75PC63PAezwgmwH23aPzMhaHDSJ6ZO54oTI1zBTGSttUPFoJr6vW5KSxBHI3r0AuF2LRWbhfSoHiPcpwi/uWhNWkGtErWxh5w/9wzBApggVQQxg4Sz41eAzsUuiLkk/o/e7yKem34sDYuFVBSVywPc9w4rgZik+yQgaK3yK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621507; c=relaxed/simple;
	bh=PRAqxIH7Nse2dygdgdFcvLxJD+weegKHVUr46ng0BkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bO9nWM55+i14nxyFJ3//y+X0azWMB9gPK4Dly4zfhdjWR9F0McKulfva9cXOrR/0JTJqGbIQzXwxFtMgGsN044Ud84rhdNIfeki4I0QkRmUhpgpjxHkFMq/AiSaTy77j645qoWarpw5vfvcXxTVPSU6KXwVOo35gJGOtgEDORag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmR+/3EM; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmR+/3EM"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so7503215ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621505; x=1790226305; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3s+ycrBVBnz/zQ2IIva9/k57GZY44OyOpoEzLIeoo0c=;
        b=MmR+/3EMMZgq4Iyjz/WIwWL4LE1AxOy0mCEbUphbiIcGkNq1AdyRyGB01pZm3EcZQM
         UdSmlkLEjLzlg2ny+Ol/lhR2+3ghsBcr9nZZ3Lpamg8V6nUtG3Jh3VX4p615ZT6DQyZK
         z3wI3vWdiSWPBtI9dodpqh1kOsy9ihhT/6JyqTroRwGS8xOIZJ8H9DaOgc5iDKV7VAzQ
         qiCqTZCaK7p2ZQc0RWw+/+iq9ChX8X0ulCJBtHpikjleHReb2mJehqnM2RL7/YA82qsG
         j+rIScI3Sr7/lev922ILGYZR1/4scwjKauJfw7vfCaPzIbMiCXP6sj/jSh8F1hcenvbS
         iezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621505; x=1790226305;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3s+ycrBVBnz/zQ2IIva9/k57GZY44OyOpoEzLIeoo0c=;
        b=AcBB53NmNuCBLI2UcrFqKRqIYPz8ahKr+iFbe4CGfjREi6M22UEhru4VHLauw0sSKw
         bZLaRILEYT+QMoB7pLiM70m7mh5SSY/Zi+30FXqLaaswK/VqrAq2QM5jlVDD1N3QRQyn
         wrtZYu68bbIseSVTSifV8rtk6mbq7TPvtmrvbvqt/6QEkFVfgr1b4+yHQegRMRor4AZp
         ADU1ddldtQcoARs4XfhKBX4EAHWJ6EB9SNg/+9D9J6UVwg4zCFY2CHS9dem3Uv4TcIYJ
         odcdfKWyEsNn5LmJuWEX0tmU/dqivCOPuKQLfdH5FThsNWA8oOgYQrwjeYwp8qUPzBXJ
         dc8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzvzsP4IuofpnaPx0WNkaE8c8fU8zpO6pKRj2yGy+RFfbyEyz9MrloerniTmMfKTGcS6CiXSvr/jQkDF8FNjDxI@vger.kernel.org
X-Gm-Message-State: AFuF++lIb/c0UtWPkqYNvw+H9mvJ2y0i1W8AbL+Zt30+y1c9VJopVjdF
	BsRxLT2psJQEYi+65nah/7ajXd1Yu3sNFwRXDg4U+bW+zPAnpeUwFunUvPlYTV0aRd9VcYtGqWN
	QJCXbmwuZfQ==
X-Received: from dlbps14.prod.google.com ([2002:a05:7023:88e:b0:144:bfb6:b5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:20c3:b0:3bf:6d96:ac40
 with SMTP id adf61e73a8af0-3dd5f475f34mr13517098637.12.1789621505081; Wed, 16
 Sep 2026 22:05:05 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:04:49 -0700
In-Reply-To: <20260917050450.703018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234402.437113-1-irogers@google.com> <20260917050450.703018-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050450.703018-3-irogers@google.com>
Subject: [PATCH v4 2/3] perf dso: Separate libbfd and cmd addr2line caches to
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
 tools/perf/util/dso.c     | 48 +++++++++++++++++++++++----------------
 tools/perf/util/dso.h     | 21 +++++++++++++++--
 tools/perf/util/libbfd.c  | 10 ++++----
 tools/perf/util/srcline.c |  2 ++
 4 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index df39e6ca88e6..9e90de92fcfa 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,38 +1,44 @@
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
@@ -1757,6 +1763,7 @@ void dso__delete(struct dso *dso)
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
+	dso__free_a2l_libbfd(dso);
 	dso__free_libdw(dso);
 	dso__free_symsrc_filename(dso);
 	nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
@@ -2081,6 +2088,7 @@ void dso__set_symsrc_filename(struct dso *dso, char *val)
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
index 5ed89f97ff11..a8d16106f619 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -301,6 +301,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
+		dso__free_a2l_libbfd(dso);
 	}
 	mutex_unlock(dso__lock(dso));
 out:
@@ -348,6 +349,7 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
+		dso__free_a2l_libbfd(dso);
 	}
 	mutex_unlock(dso__lock(dso));
 
-- 
2.55.0.1082.g2b9226bbc0-goog

