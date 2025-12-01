Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3027C842
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622537; cv=none; b=dxTAhnCRmzVplmHfOC27MGpxN6rVoVWVk5fzw5LJRyAGzeek3iAxPBaRJTwxYMgh0O4Tz2itKGwnz1Kcy8+JMw5dkIxE9RFozbBd8tfgD4DyEAaGWncEMYdt9nNsIWYmRWwsqpjZzebp1PuF41rRqGLPMOVMKCxe1UYzyGcq2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622537; c=relaxed/simple;
	bh=zUVBgiiZ0gXg2kVcXRXUmDd2ZV1Y5zckGB+gp6QQQ3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mMec+GZuYshdhaypYviePBIQJ3Sfo0gT23w19wLpiwReUo2Gu8So1tdm3Y20jP1krXbzcJygzTY/GUPmswEBSG3yKFvKVFtmQmw4Gdy2k63n03/qpkHI5ds2DaRSazlILsw9du2wBn4CTOnH/YuyxowRwq906U7SUgxiJsNg0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SBZyhNT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SBZyhNT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99f6516262so11623875a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622535; x=1765227335; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XN0PksgfGile0bb+ntHwdR8Wgi7cddiEbQBXMGD33y4=;
        b=0SBZyhNT1JI1uVh/pxDe7hy13GbP1VqWP884TLe/9r0A+uL1LUYfcGHje10fq/B4c4
         bJJPrvz7/0oPVPy1h82p8goahoV6ycRRVIxz7Y/27p6VzJskGWBa5iimrw4le2tr7qO7
         AkwVFycjCZjRszXofyfFiDXefT2p1b1DnGwf/GkCS9S+hlFgdOOl20jY5dx2W9BuldVd
         SHGxpIjpbo7JM5AKvyOmOoZJJFx7IQKTAAJRSY34Rn98BzK3nOdCC9tYAxH/45uykOoW
         H+26kJRG7UQV8afh+iFGSD70+BzGGZjbgrl2SiFDmPItIm9lQyf5G9lPn7J2G7EYC/Zz
         Z3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622535; x=1765227335;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN0PksgfGile0bb+ntHwdR8Wgi7cddiEbQBXMGD33y4=;
        b=rOPGaZ1H7gktioFbxhX9oar3C0OrEY0j2rJ5oc/Cq8TKAeRpn2lHF4eUQ/rpdT0f+v
         DJYFJo6uASWLrjF3xYZmmRuTy/npGfiMvv4nF8lTro2kXUVCH4S0Ka/j01V+zuGBFlki
         7Ux7A9sKDbJXpUNPeVQ72dHJaKqt6cuTL282vpHtSPFA0pNb1G79enxgoAn8UUiakS6G
         W7yjGwOTArRzh8tIujsbS4wpLCx9GZW16tsVMvUT74yRmHE+jGISHgSvUBfq5Fl6lUEG
         EoEU7DuIG/uZ7Tgn3U4arFioam7sNQYZp8b9sI9hJ1OhgogEjSj96nhXz34k9PfPJRaZ
         HfSw==
X-Forwarded-Encrypted: i=1; AJvYcCVx1MGRiNHiP3UaSAXleS8ob2TXrk+jvO7EESFxiEDGDne5r2T7vZ/xQPHkvtAWojrWJR8FdbEZTknoK4DZDX1/@vger.kernel.org
X-Gm-Message-State: AOJu0YzfM2dvRIjbPVKdVtYXQTtjuizcnIsg5+LUUjm2QvWdu5AYZW9F
	A/YCMl7b9XLAws/Nve00Yx1PEkN7ak7enMP6LVlMCciYn91csqdk4dvT+ZF1Bd5bKaL+3brIbZ4
	5Mu109qszYg==
X-Google-Smtp-Source: AGHT+IFHeAOg9/N3Q5WZyX9xvhKVcksBco4IpwEXc2kFEVfynL65kSy79cDzSSZueJGis+MGC5RUjkOviWyf
X-Received: from dybph18.prod.google.com ([2002:a05:7301:4192:b0:2a4:7453:cd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2a18:b0:2a4:4bce:309c
 with SMTP id 5a478bee46e88-2a94186f8f4mr15215437eec.22.1764622534894; Mon, 01
 Dec 2025 12:55:34 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:02 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-4-irogers@google.com>
Subject: [PATCH v2 03/10] perf symbol: Move libelf code to its own file/header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
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
index 99b1e060acf5..72632bf9cc30 100644
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
index f12bb3d0e08b..393a528326d5 100644
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
2.52.0.158.g65b55ccf14-goog

