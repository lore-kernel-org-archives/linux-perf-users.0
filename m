Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137E21C9F9
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865157; cv=none; b=N/GUcvGT/l+oAbWNFJHX+SdU8sPXhIjSJbESLDQF1XLSnFCpmHvexmGcWxAa5TFdNnQwvdGQdMyCcs5YuYGK2obvGsmjMQ4/tex8+eGbYhJBPB3UUdUGhjgSGQrTGrfaEwpBoLjCbA+rbTQ29uGwHDY2H5Ix7TT0/CIjRQRYX6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865157; c=relaxed/simple;
	bh=aurn4Dh28lozFTymzAvSbXMKa1lOTrutbzsMcEL3k5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iEdgDD7RykvXixhQ+6BNw+xrTKRrd0IP4rwqfgxyuDbYMRTv0g5Skq2tVRIVesPb8BZl/59c1h2VmXh+yd0xbxrP5OipMXyXKnWkOZXay8VCBhYvP3PLtwxm29CYrCi/T//ETDPkKb87Kw5wRKLec1gbNelSa1UxPsEyQkuB/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAAjaGIf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAAjaGIf"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99763210e5so7239866a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865155; x=1764469955; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hyIb3WLSFrI4ZPWpu7Qui5QIECa8CMI86AYGc9NSmg=;
        b=dAAjaGIf+T5nS4Jt+ARE7KXIXM49ZEoyATmTF4kX9XhQeeKGBRPW0j6weHIbEejJYb
         Gz+1hs1Y/+FSABNsaGBWdGxToeO6e0yd4xDv9KeFLmaiZ/SfVqOhZS0oN+d/WoA2FPzc
         gQgYPTZrw9xYXkQMmphN/Xbp8c2Kh47r6+y/RHVMM6KK9S6ggMByBQD1af6tjhQvGy/O
         IyFCyOtlfM+Ble8IE3ZVGCPT6xEmYH/mVaNdxC4rUR5XW2KVAWrnjlRm6WnOIwPaHuzc
         dbusNPDt104KNGXgtRppt18mGn7hiUdH+ukAPm3tLmclDwfxUE3sCJPZUkhPvhKl8Ft6
         UwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865155; x=1764469955;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hyIb3WLSFrI4ZPWpu7Qui5QIECa8CMI86AYGc9NSmg=;
        b=aMtshD4C7EiAVvy1mlNzcV21ma6pa9Etp/Nk5h4sENxFbxgJBTSVbpciKvp1vaHFF5
         Y/KNi9ILSmjw6xl5/yOvTwaKR6yNjNWDHafJ8v1V1CjCcZLS3FOjUealyqrCiJaltQyy
         7ZTV6fGn4pc57Kdv2MYbqwAxu8oMprfEQQOnbPeuozbgExDw1iMPqk+iJeox6rTZ5Kh8
         1Uwgy1EN14Ux49udrYm/dWb+rdKmdcrBhX7L4FK4+xBDPqYK4+30Eyy/9a5xOtMHGqdo
         uRjiQYjm3W+aFjYFlVyT+VFSzTYR9/Eqy2jBWahQx4ObdiM6nYbwDsyBvyRaju+RvMzJ
         v6dg==
X-Forwarded-Encrypted: i=1; AJvYcCXCJ4jTTaRACR0C6KNAv6e0GhynW7oPVuqB9qV4X4oLjb9Pt9SwOGAPBoB3HRnMStYKUhd0+0ExlgKBcbiszgeS@vger.kernel.org
X-Gm-Message-State: AOJu0YwonV5TIChEKNK0jCHh7Mlucrra+aXndJkmTAyTHul9K0RGuZQr
	8JdbLi9LnXE1r/IQKCL/FEbTWFvjiPpcJ9c4N9NLSunRTphM6BovZYek/iYJU0P1cvFUmidI9qd
	Mi2g5JWpIsw==
X-Google-Smtp-Source: AGHT+IF4v0ISLVNVWR+f517YFzCUNed78JCR/m2OEg5f9W15rzeFtSWlCjrOJ+aDJ2Vi7/mPFC0Rjrw5O4Lz
X-Received: from dyz20.prod.google.com ([2002:a05:693c:4094:b0:2a2:9bd7:1a64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:de01:b0:2a4:41c6:24f
 with SMTP id 5a478bee46e88-2a7190b3e87mr3276686eec.7.1763865154630; Sat, 22
 Nov 2025 18:32:34 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:19 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-4-irogers@google.com>
Subject: [PATCH v1 3/9] perf symbol: Move libelf code to its own file/header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move perf declarations depending on libelf out of symbol.h into
perf-libelf.h. Move the corresponding C code into perf-libelf.c. This
is motivated by trying to make it clearer the symbol.[ch] is generic
code without library dependencies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          |  1 +
 tools/perf/util/perf-libelf.c  | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/perf-libelf.h  | 25 +++++++++++++++++++++++++
 tools/perf/util/probe-event.c  |  1 +
 tools/perf/util/probe-finder.c |  1 +
 tools/perf/util/symbol-elf.c   | 27 +--------------------------
 tools/perf/util/symbol.h       | 19 -------------------
 7 files changed, 61 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/util/perf-libelf.c
 create mode 100644 tools/perf/util/perf-libelf.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1c2a43e1dc68..dcac6f1e1d99 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -193,6 +193,7 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork_top.o
 endif
 
+perf-util-$(CONFIG_LIBELF) += perf-libelf.o
 perf-util-$(CONFIG_LIBELF) += symbol-elf.o
 perf-util-$(CONFIG_LIBELF) += probe-file.o
 perf-util-$(CONFIG_LIBELF) += probe-event.o
diff --git a/tools/perf/util/perf-libelf.c b/tools/perf/util/perf-libelf.c
new file mode 100644
index 000000000000..abd55bd7f14b
--- /dev/null
+++ b/tools/perf/util/perf-libelf.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "perf-libelf.h"
+
+#include <stddef.h>
+#include <string.h>
+
+Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
+			     GElf_Shdr *shp, const char *name, size_t *idx)
+{
+	Elf_Scn *sec = NULL;
+	size_t cnt = 1;
+
+	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
+	if (!elf_rawdata(elf_getscn(elf, ep->e_shstrndx), NULL))
+		return NULL;
+
+	while ((sec = elf_nextscn(elf, sec)) != NULL) {
+		char *str;
+
+		gelf_getshdr(sec, shp);
+		str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
+		if (str && !strcmp(name, str)) {
+			if (idx)
+				*idx = cnt;
+			return sec;
+		}
+		++cnt;
+	}
+
+	return NULL;
+}
+
diff --git a/tools/perf/util/perf-libelf.h b/tools/perf/util/perf-libelf.h
new file mode 100644
index 000000000000..5d7d18daf5ff
--- /dev/null
+++ b/tools/perf/util/perf-libelf.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LIBELF_H
+#define __PERF_LIBELF_H
+
+#ifdef HAVE_LIBELF_SUPPORT
+
+#include <libelf.h>
+#include <gelf.h>
+
+/*
+ * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
+ * for newer versions we can use mmap to reduce memory usage:
+ */
+#ifdef ELF_C_READ_MMAP
+# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
+#else
+# define PERF_ELF_C_READ_MMAP ELF_C_READ
+#endif
+
+Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep, GElf_Shdr *shp, const char *name,
+			     size_t *idx);
+
+#endif // defined(HAVE_LIBELF_SUPPORT)
+
+#endif /* __PERF_LIBELF_H */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6ab2eb551b6c..c27ad9121230 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -23,6 +23,7 @@
 #include "build-id.h"
 #include "event.h"
 #include "namespaces.h"
+#include "perf-libelf.h"
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 5ffd97ee4898..f94f742a3458 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -25,6 +25,7 @@
 #include "debug.h"
 #include "debuginfo.h"
 #include "intlist.h"
+#include "perf-libelf.h"
 #include "strbuf.h"
 #include "strlist.h"
 #include "symbol.h"
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 629b272e0a13..750a30b216d6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -12,6 +12,7 @@
 #include "libbfd.h"
 #include "map.h"
 #include "maps.h"
+#include "perf-libelf.h"
 #include "symbol.h"
 #include "symsrc.h"
 #include "machine.h"
@@ -183,32 +184,6 @@ static size_t elf_addr_to_index(Elf *elf, GElf_Addr addr)
 	return -1;
 }
 
-Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
-			     GElf_Shdr *shp, const char *name, size_t *idx)
-{
-	Elf_Scn *sec = NULL;
-	size_t cnt = 1;
-
-	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
-	if (!elf_rawdata(elf_getscn(elf, ep->e_shstrndx), NULL))
-		return NULL;
-
-	while ((sec = elf_nextscn(elf, sec)) != NULL) {
-		char *str;
-
-		gelf_getshdr(sec, shp);
-		str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
-		if (str && !strcmp(name, str)) {
-			if (idx)
-				*idx = cnt;
-			return sec;
-		}
-		++cnt;
-	}
-
-	return NULL;
-}
-
 bool filename__has_section(const char *filename, const char *sec)
 {
 	int fd;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 78fb2ba69f65..0aa8680cbd3e 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -14,10 +14,6 @@
 #include "symbol_conf.h"
 #include "spark.h"
 
-#ifdef HAVE_LIBELF_SUPPORT
-#include <libelf.h>
-#include <gelf.h>
-#endif
 #include <elf.h>
 
 struct dso;
@@ -26,21 +22,6 @@ struct maps;
 struct option;
 struct build_id;
 
-/*
- * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
- * for newer versions we can use mmap to reduce memory usage:
- */
-#ifdef ELF_C_READ_MMAP
-# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
-#else
-# define PERF_ELF_C_READ_MMAP ELF_C_READ
-#endif
-
-#ifdef HAVE_LIBELF_SUPPORT
-Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
-			     GElf_Shdr *shp, const char *name, size_t *idx);
-#endif
-
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
  * symbol__annotation) and/or a browser_index (see symbol__browser_index).
-- 
2.52.0.rc2.455.g230fcf2819-goog

