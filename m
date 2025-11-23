Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37377229B36
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865167; cv=none; b=jux3YYQpDtOXSdIYdjROetT5S6Z733Jn2V1dzkl5f7UapO1HPUoTrTwl0tSzPUH0jtGd3+4RLn1agvv87R4yyyQydoh+ajEn4TMkBzOTRZA1B6pc1w3RYAv2OFDgPPjn4fvR4TofxOmw6bZme+N1seZO49xL4fjIkdJUie/iuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865167; c=relaxed/simple;
	bh=8PCV8gXQ8V6nDsf7afO/nL/dMr2vpBmrTqN18/8lUVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jLei+9zIRlxtfp36m+obRiE9TUSMI1c9OaNTVf6Tj40He3Z8/08S0C0kISANUecOvL7E3A2RyIXibILfA2fgKl+hrAiJraECOe4+L941iQD2aVZc7+wNp+PdEZoUK02nNRC7j5K5Acg22oWp2wugi6jpkg2HEh8WC1P5V4CDqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjJ8cQJa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjJ8cQJa"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc169af24cfso2609331a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865164; x=1764469964; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2kO6YXL2sAgHQwAq8vIr/1t6R+Qh+dvjHWTyxEb3ww=;
        b=RjJ8cQJai0XXftLkLIBOv7MU6Qjx22v/2als+4Roa4j/l5NAHqC3OLugYiZBpI3gXb
         zPAHofdnD6VbRu4QWtffaf1KJy9gGnChIREspdy+ElbONikAf1cJDSlaxtW72VfLbPOm
         Pt89kyY6f0G3XkTSwcAF0YrG0YTwrT89EGhuvL7RaqT6T0e2JzoBJDR4fir+TBt02fJ8
         2o79fXyOO1EAn2sWNIPUC+2SDDbzemwxPzsVRGjOGOV98Aud2Yfdlb1TxC9IiR0FD1D1
         oz/O4qM/nEROblZDQV6I+U9chiOgUQ84clFJgOo0NNTcIq6ankINzT2RdW36P51ljGlI
         /PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865164; x=1764469964;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2kO6YXL2sAgHQwAq8vIr/1t6R+Qh+dvjHWTyxEb3ww=;
        b=QEGF2wUcKfo4JCVWMduQE73t4h/tpOTY2fqHuuwmKp4CkLcr48LVKV8B6IUIWQR6Mq
         e0HwSV9NVWVBcJ9EYvmIXgKNOkabr7aO9TmLTdW67BezUWPVNvmNb/UMTkKGFrVicD+e
         +yo9HrrbNAW4cxbl0H6cJXbnV2XRtu6kFCbUmmgmv1f6G/d5sEzbRK72waoboNxmd6Ol
         bR+5Adeth1EywrZjFxytc5mJOefas9BebG0nzalyYlm0YVgl3/t+9mqiJUHCYb4dSA8u
         5facz7JYTNZvOsBKMV/mDgqGDXIWENOzyPZW73P8pkGEz0uCtIimCCAKbrsJof1dSDSX
         TiOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIWm6Z55rPqnT15LoxnhBLi+sGqb6ktjKhyhxwpODOI8sPv3ZL29gJ0DehEBWyrQreZZSccnY7N4KFS6BF5Nld@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlWtyEDrpoO8TWmKq5xRW4fn5yENifC4fJ3/gCIQM9O1kTXOq
	48W68lRU9QCgC8FfZwmcWzohTACPIBoyEbeYf2YIgpewz4KKF2ITm3Nz/HEGihMF8+DK90XLKfk
	jURon/XhkNA==
X-Google-Smtp-Source: AGHT+IFJk2oPW4r6McQs/nWZKohHl26TK542JQ9qyywVf6xez5/Uz4mzhA1OszwKINIzeSyPsG1Wz/ZjsSLx
X-Received: from dlbvp8.prod.google.com ([2002:a05:7022:ff48:b0:11b:b1cd:e328])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea46:10b0:11b:9386:826d
 with SMTP id a92af1059eb24-11c9d8707d7mr4146724c88.42.1763865164339; Sat, 22
 Nov 2025 18:32:44 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:24 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-9-irogers@google.com>
Subject: [PATCH v1 8/9] perf symbol: Use fallbacks for sysfs__read_build_id
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

Try libelf then symbol-minimal version in symbol.c. Reduce scope of
NOTE_ALIGN macro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf-libelf.c    | 56 ++++++++++++++++++++++++++++++++
 tools/perf/util/perf-libelf.h    | 12 ++++---
 tools/perf/util/symbol-elf.c     | 50 ----------------------------
 tools/perf/util/symbol-minimal.c |  4 +--
 tools/perf/util/symbol-minimal.h |  1 +
 tools/perf/util/symbol.c         | 10 ++++++
 6 files changed, 76 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/perf-libelf.c b/tools/perf/util/perf-libelf.c
index a8a8c39056da..861cb7ae9b45 100644
--- a/tools/perf/util/perf-libelf.c
+++ b/tools/perf/util/perf-libelf.c
@@ -9,6 +9,11 @@
 #include "build-id.h"
 #include "debug.h"
 
+/*
+ * Align offset to 4 bytes as needed for note name and descriptor data.
+ */
+#define NOTE_ALIGN(n) (((n) + 3) & -4U)
+
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx)
 {
@@ -145,6 +150,57 @@ int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid)
 	return err;
 }
 
+int libelf_sysfs__read_build_id(const char *filename, struct build_id *bid)
+{
+	size_t size = sizeof(bid->data);
+	int fd, err = -1;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		goto out;
+
+	while (1) {
+		char bf[BUFSIZ];
+		GElf_Nhdr nhdr;
+		size_t namesz, descsz;
+
+		if (read(fd, &nhdr, sizeof(nhdr)) != sizeof(nhdr))
+			break;
+
+		namesz = NOTE_ALIGN(nhdr.n_namesz);
+		descsz = NOTE_ALIGN(nhdr.n_descsz);
+		if (nhdr.n_type == NT_GNU_BUILD_ID &&
+		    nhdr.n_namesz == sizeof("GNU")) {
+			if (read(fd, bf, namesz) != (ssize_t)namesz)
+				break;
+			if (memcmp(bf, "GNU", sizeof("GNU")) == 0) {
+				size_t sz = min(descsz, size);
+
+				if (read(fd, bid->data, sz) == (ssize_t)sz) {
+					memset(bid->data + sz, 0, size - sz);
+					bid->size = sz;
+					err = 0;
+					break;
+				}
+			} else if (read(fd, bf, descsz) != (ssize_t)descsz)
+				break;
+		} else {
+			int n = namesz + descsz;
+
+			if (n > (int)sizeof(bf)) {
+				n = sizeof(bf);
+				pr_debug("%s: truncating reading of build id in sysfs file %s: n_namesz=%u, n_descsz=%u.\n",
+					 __func__, filename, nhdr.n_namesz, nhdr.n_descsz);
+			}
+			if (read(fd, bf, n) != n)
+				break;
+		}
+	}
+	close(fd);
+out:
+	return err;
+}
+
 int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_t size)
 {
 	int fd, err = -1;
diff --git a/tools/perf/util/perf-libelf.h b/tools/perf/util/perf-libelf.h
index 167679f9fc9b..95fe8805aa41 100644
--- a/tools/perf/util/perf-libelf.h
+++ b/tools/perf/util/perf-libelf.h
@@ -21,17 +21,13 @@ struct build_id;
 # define PERF_ELF_C_READ_MMAP ELF_C_READ
 #endif
 
-/*
- * Align offset to 4 bytes as needed for note name and descriptor data.
- */
-#define NOTE_ALIGN(n) (((n) + 3) & -4U)
-
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep, GElf_Shdr *shp, const char *name,
 			     size_t *idx);
 
 int __libelf__read_build_id(Elf *elf, void *bf, size_t size);
 
 int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid);
+int libelf_sysfs__read_build_id(const char *filename, struct build_id *bid);
 int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
 #else // !defined(HAVE_LIBELF_SUPPORT)
@@ -43,6 +39,12 @@ static inline int libelf__read_build_id(int fd __always_unused,
 	return -1;
 }
 
+static inline int libelf_sysfs__read_build_id(const char *filename __always_unused,
+					      struct build_id *bid __always_unused)
+{
+	return -1;
+}
+
 static inline int libelf_filename__read_debuglink(const char *filename __always_unused,
 						  char *debuglink __always_unused,
 						  size_t size __always_unused)
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index d4a1b01010c1..5ddf8353e01b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -751,56 +751,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	return 0;
 }
 
-int sysfs__read_build_id(const char *filename, struct build_id *bid)
-{
-	size_t size = sizeof(bid->data);
-	int fd, err = -1;
-
-	fd = open(filename, O_RDONLY);
-	if (fd < 0)
-		goto out;
-
-	while (1) {
-		char bf[BUFSIZ];
-		GElf_Nhdr nhdr;
-		size_t namesz, descsz;
-
-		if (read(fd, &nhdr, sizeof(nhdr)) != sizeof(nhdr))
-			break;
-
-		namesz = NOTE_ALIGN(nhdr.n_namesz);
-		descsz = NOTE_ALIGN(nhdr.n_descsz);
-		if (nhdr.n_type == NT_GNU_BUILD_ID &&
-		    nhdr.n_namesz == sizeof("GNU")) {
-			if (read(fd, bf, namesz) != (ssize_t)namesz)
-				break;
-			if (memcmp(bf, "GNU", sizeof("GNU")) == 0) {
-				size_t sz = min(descsz, size);
-				if (read(fd, bid->data, sz) == (ssize_t)sz) {
-					memset(bid->data + sz, 0, size - sz);
-					bid->size = sz;
-					err = 0;
-					break;
-				}
-			} else if (read(fd, bf, descsz) != (ssize_t)descsz)
-				break;
-		} else {
-			int n = namesz + descsz;
-
-			if (n > (int)sizeof(bf)) {
-				n = sizeof(bf);
-				pr_debug("%s: truncating reading of build id in sysfs file %s: n_namesz=%u, n_descsz=%u.\n",
-					 __func__, filename, nhdr.n_namesz, nhdr.n_descsz);
-			}
-			if (read(fd, bf, n) != n)
-				break;
-		}
-	}
-	close(fd);
-out:
-	return err;
-}
-
 bool symsrc__possibly_runtime(struct symsrc *ss)
 {
 	return ss->dynsym || ss->opdsec;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 8700c0628437..cc9055ba2f2a 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -194,8 +194,7 @@ int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid)
 	return ret;
 }
 
-#ifndef HAVE_LIBELF_SUPPORT
-int sysfs__read_build_id(const char *filename, struct build_id *bid)
+int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid)
 {
 	int fd;
 	int ret = -1;
@@ -226,6 +225,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 	return ret;
 }
 
+#ifndef HAVE_LIBELF_SUPPORT
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	         enum dso_binary_type type)
 {
diff --git a/tools/perf/util/symbol-minimal.h b/tools/perf/util/symbol-minimal.h
index 185d98968212..5cce1f1f0f16 100644
--- a/tools/perf/util/symbol-minimal.h
+++ b/tools/perf/util/symbol-minimal.h
@@ -5,5 +5,6 @@
 struct build_id;
 
 int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid);
+int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid);
 
 #endif /* __PERF_SYMBOL_MINIMAL_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1152d11a0366..81f4428f7bed 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2049,6 +2049,16 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 	return err;
 }
 
+int sysfs__read_build_id(const char *filename, struct build_id *bid)
+{
+	int err = libelf_sysfs__read_build_id(filename, bid);
+
+	if (err == 0)
+		return 0;
+
+	return sym_min_sysfs__read_build_id(filename, bid);
+}
+
 int filename__read_debuglink(const char *filename, char *debuglink, size_t size)
 {
 	int err = libbfd_filename__read_debuglink(filename, debuglink, size);
-- 
2.52.0.rc2.455.g230fcf2819-goog

