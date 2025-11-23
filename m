Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2CB22541B
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865163; cv=none; b=XdWSGjTHZKTF8eQoaZ0A1sgy/TMR4vqjaAObXATvApXI7MdiMjOlV42oKj7fElwzOxNLE/ixCXm0C7eDYE5AYqeMqk9sGNPaoBhUSWdFS1EKDJT6sD5A0TSwdUSVd8547UcmgvHev/KQXuXYdxFKSV2rP1pqQo8agoqzOMTCo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865163; c=relaxed/simple;
	bh=lR4XJex+YhLGvlJNmOkyF66H8cbin8etsWj49bkyRGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xvuzru8MVsFiH7uY5XL9w49hn4PGWWpX7TvlTNRUppgkAYirRUwmHQQOL1K6Y6ELwQHhZgSSTRmAgohHXk06L7fzlj9sRSu2esIYECvC/Dmw6eII/y2ZioSe/973EznO4C9SFTN331rwtnNWUuzkW5/m5mTXoxuHAAiEwPYhy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj4/xV7/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj4/xV7/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9208e1976so7269881b3a.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865160; x=1764469960; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyZ/CCFSnZu+HsL8ZbXhwTe/1CPGu9zLNC6RL/LGjsc=;
        b=Kj4/xV7/+jSs89V3D3mnbGWIyXGnxV5GZJFB1LgsrnlscpldNUMbW8YKKPe5/tbrKU
         CHb0f5Fiw1saCZql+KxB+Bdaii6TbRZUMtKyGMGVEhokDQgntcfEn+piEao720uU2K+8
         sZTKmLBt4Iy5l7rB+HLGqeuJEOQ1o+GhyJQnPwoESzmWscf3Hn3OtGXDFXfXyG4T+JF6
         9s9fHbtrkUbxgm54C+DCF51dDs1FuD3PrE463ZQy97tj6zJYwSM6eZ29z9tYCCv16JXt
         ADI4EpnihNnBhB3ADNrMjMps7RosxIiAGbdpSh3Ds60EvNuIK7vpGHJf3p5c8xLlH6c8
         +dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865160; x=1764469960;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyZ/CCFSnZu+HsL8ZbXhwTe/1CPGu9zLNC6RL/LGjsc=;
        b=OZptfTQpeS+FvGNCouw3AhOnekmuu6k1ObJ9hrTtYnHFU1MD+mVPuUtC+YjRR8Jhyk
         qjCvvYA/VBVReluehU8tGw5/Dj0wCkFFzWp7/KWp6dR9JyTHE7mYjFVsWkBpsBfAHS5u
         Mhp15YtYgHBcjmlL3ZpR0KIT5AYH+bUiI5dH5ANTDK1PwW7958hwNMC1cOZIj4pSpmjw
         a7OsO/+ICQbrABYvsV/DZQHGANRp718ZDZF4zoFVk/0DG4+Hk7ENrcOSO46jNHaIJYz0
         7RI/NLZouFrV8pPuyE3UwYspPeWPCH43wy7f646wCuQQEqtf+fCiC5HK5KA3LMQ//Vj5
         5itg==
X-Forwarded-Encrypted: i=1; AJvYcCXdE2jJjQcQd+aJRNAnsRF+C9WGq0/LvmL7snolscqS4AhtAIeMbho9CDbZNJSPGR0QxHI9s0lBuhLNPaHU/jiW@vger.kernel.org
X-Gm-Message-State: AOJu0YxPICMZkDZPMC5huJJ2rEUT9DXjQwOuYz1nLKsmdr5xxrEZP6xr
	/Fo1nHG7D9yH6e0n5ZY7HiHvvDVDeDC/mxCz3EfeClvX2SLCpiWOP2LsQlMyWoJsBLM/OmLQiDb
	bnRbdna1CGSE8vgN0/L995TTnZYT265kkDQN08gEtie84gADreEJ0S1ssdG/P6eSBt5Y3gqp7Aw
	LGTZ7v
X-Google-Smtp-Source: AGHT+IFC3vf6O88V6VSVadTfGoCXlyrt97nwA9qA3Uv2+6kOqVnoS/yKs4LzVYCyizDC30uVoYAmsUNS+hjF
X-Received: from dlbps2.prod.google.com ([2002:a05:7023:882:b0:11b:9777:3bd6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4288:b0:11b:8161:5cfc
 with SMTP id a92af1059eb24-11c9d863815mr5019072c88.36.1763865160232; Sat, 22
 Nov 2025 18:32:40 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:22 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-7-irogers@google.com>
Subject: [PATCH v1 6/9] perf symbol: Use fallbacks with filename__read_build_id
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
X-ccpol: medium

Try libbfd, libelf and then symbol-minimal when trying to read a build
ID. Always compile in symbol-minimal so that it is the fallback of
last resort. Rename libelf reading code. Move the decompression code
into symbol.c and allow its use with the symbol-minimal version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build            |   5 +-
 tools/perf/util/libbfd.c         |   4 +-
 tools/perf/util/libbfd.h         |   8 +-
 tools/perf/util/perf-libelf.c    | 113 +++++++++++++++++++++++
 tools/perf/util/perf-libelf.h    |  20 ++++
 tools/perf/util/symbol-elf.c     | 154 +------------------------------
 tools/perf/util/symbol-minimal.c |  12 ++-
 tools/perf/util/symbol-minimal.h |   9 ++
 tools/perf/util/symbol.c         |  50 ++++++++++
 9 files changed, 210 insertions(+), 165 deletions(-)
 create mode 100644 tools/perf/util/symbol-minimal.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index dcac6f1e1d99..c40053db2212 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -54,6 +54,7 @@ perf-util-y += usage.o
 perf-util-y += dso.o
 perf-util-y += dsos.o
 perf-util-y += symbol.o
+perf-util-y += symbol-minimal.o
 perf-util-y += symbol_fprintf.o
 perf-util-y += map_symbol.o
 perf-util-y += color.o
@@ -209,10 +210,6 @@ ifdef hashmap
 perf-util-y += hashmap.o
 endif
 
-ifndef CONFIG_LIBELF
-perf-util-y += symbol-minimal.o
-endif
-
 ifndef CONFIG_SETNS
 perf-util-y += setns.o
 endif
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 6434c2dccd4a..c438fbd03b24 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -418,13 +418,13 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	return err;
 }
 
-int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block)
+int libbfd__read_build_id(int _fd, const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
 	int err = -1, fd;
 	bfd *abfd;
 
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	fd = dup(_fd);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index 5b5149516f1a..72f1ad9a7578 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -26,7 +26,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
 int symbol__disassemble_libbfd(const char *filename, struct symbol *sym,
 			     struct annotate_args *args);
 
-int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block);
+int libbfd__read_build_id(int fd, const char *filename, struct build_id *bid);
 
 int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
@@ -65,9 +65,9 @@ static inline int symbol__disassemble_libbfd(const char *filename __always_unuse
 	return -1;
 }
 
-static inline int libbfd__read_build_id(const char *filename __always_unused,
-					struct build_id *bid __always_unused,
-					bool block __always_unused)
+static inline int libbfd__read_build_id(int fd __always_unused,
+					const char *filename __always_unused,
+					struct build_id *bid __always_unused)
 {
 	return -1;
 }
diff --git a/tools/perf/util/perf-libelf.c b/tools/perf/util/perf-libelf.c
index abd55bd7f14b..c7fa08a177d0 100644
--- a/tools/perf/util/perf-libelf.c
+++ b/tools/perf/util/perf-libelf.c
@@ -3,6 +3,10 @@
 
 #include <stddef.h>
 #include <string.h>
+#include <unistd.h>
+
+#include "build-id.h"
+#include "debug.h"
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx)
@@ -30,3 +34,112 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	return NULL;
 }
 
+int __libelf__read_build_id(Elf *elf, void *bf, size_t size)
+{
+	int err = -1;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	Elf_Data *data;
+	Elf_Scn *sec;
+	Elf_Kind ek;
+	void *ptr;
+
+	if (size < BUILD_ID_SIZE)
+		goto out;
+
+	ek = elf_kind(elf);
+	if (ek != ELF_K_ELF)
+		goto out;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL) {
+		pr_err("%s: cannot get elf header.\n", __func__);
+		goto out;
+	}
+
+	/*
+	 * Check following sections for notes:
+	 *   '.note.gnu.build-id'
+	 *   '.notes'
+	 *   '.note' (VDSO specific)
+	 */
+	do {
+		sec = elf_section_by_name(elf, &ehdr, &shdr,
+					  ".note.gnu.build-id", NULL);
+		if (sec)
+			break;
+
+		sec = elf_section_by_name(elf, &ehdr, &shdr,
+					  ".notes", NULL);
+		if (sec)
+			break;
+
+		sec = elf_section_by_name(elf, &ehdr, &shdr,
+					  ".note", NULL);
+		if (sec)
+			break;
+
+		return err;
+
+	} while (0);
+
+	data = elf_getdata(sec, NULL);
+	if (data == NULL)
+		goto out;
+
+	ptr = data->d_buf;
+	while (ptr < (data->d_buf + data->d_size)) {
+		GElf_Nhdr *nhdr = ptr;
+		size_t namesz = NOTE_ALIGN(nhdr->n_namesz),
+		       descsz = NOTE_ALIGN(nhdr->n_descsz);
+		const char *name;
+
+		ptr += sizeof(*nhdr);
+		name = ptr;
+		ptr += namesz;
+		if (nhdr->n_type == NT_GNU_BUILD_ID &&
+		    nhdr->n_namesz == sizeof("GNU")) {
+			if (memcmp(name, "GNU", sizeof("GNU")) == 0) {
+				size_t sz = min(size, descsz);
+
+				memcpy(bf, ptr, sz);
+				memset(bf + sz, 0, size - sz);
+				err = sz;
+				break;
+			}
+		}
+		ptr += descsz;
+	}
+
+out:
+	return err;
+}
+
+int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid)
+{
+	size_t size = sizeof(bid->data);
+	int fd, err = -1;
+	Elf *elf;
+
+	if (size < BUILD_ID_SIZE)
+		goto out;
+
+	fd = dup(_fd);
+	if (fd < 0)
+		goto out;
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL) {
+		pr_debug2("%s: cannot read %s ELF file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	err = __libelf__read_build_id(elf, bid->data, size);
+	if (err > 0)
+		bid->size = err;
+
+	elf_end(elf);
+out_close:
+	close(fd);
+out:
+	return err;
+}
diff --git a/tools/perf/util/perf-libelf.h b/tools/perf/util/perf-libelf.h
index 5d7d18daf5ff..931597493b1f 100644
--- a/tools/perf/util/perf-libelf.h
+++ b/tools/perf/util/perf-libelf.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_LIBELF_H
 #define __PERF_LIBELF_H
 
+struct build_id;
+
 #ifdef HAVE_LIBELF_SUPPORT
 
 #include <libelf.h>
@@ -17,9 +19,27 @@
 # define PERF_ELF_C_READ_MMAP ELF_C_READ
 #endif
 
+/*
+ * Align offset to 4 bytes as needed for note name and descriptor data.
+ */
+#define NOTE_ALIGN(n) (((n) + 3) & -4U)
+
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep, GElf_Shdr *shp, const char *name,
 			     size_t *idx);
 
+int __libelf__read_build_id(Elf *elf, void *bf, size_t size);
+
+int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid);
+
+#else // !defined(HAVE_LIBELF_SUPPORT)
+
+static inline int libelf__read_build_id(int fd __always_unused,
+					const char *filename __always_unused,
+					struct build_id *bid __always_unused)
+{
+	return -1;
+}
+
 #endif // defined(HAVE_LIBELF_SUPPORT)
 
 #endif /* __PERF_LIBELF_H */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 750a30b216d6..b301f1263ecc 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -751,158 +751,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	return 0;
 }
 
-/*
- * Align offset to 4 bytes as needed for note name and descriptor data.
- */
-#define NOTE_ALIGN(n) (((n) + 3) & -4U)
-
-static int elf_read_build_id(Elf *elf, void *bf, size_t size)
-{
-	int err = -1;
-	GElf_Ehdr ehdr;
-	GElf_Shdr shdr;
-	Elf_Data *data;
-	Elf_Scn *sec;
-	Elf_Kind ek;
-	void *ptr;
-
-	if (size < BUILD_ID_SIZE)
-		goto out;
-
-	ek = elf_kind(elf);
-	if (ek != ELF_K_ELF)
-		goto out;
-
-	if (gelf_getehdr(elf, &ehdr) == NULL) {
-		pr_err("%s: cannot get elf header.\n", __func__);
-		goto out;
-	}
-
-	/*
-	 * Check following sections for notes:
-	 *   '.note.gnu.build-id'
-	 *   '.notes'
-	 *   '.note' (VDSO specific)
-	 */
-	do {
-		sec = elf_section_by_name(elf, &ehdr, &shdr,
-					  ".note.gnu.build-id", NULL);
-		if (sec)
-			break;
-
-		sec = elf_section_by_name(elf, &ehdr, &shdr,
-					  ".notes", NULL);
-		if (sec)
-			break;
-
-		sec = elf_section_by_name(elf, &ehdr, &shdr,
-					  ".note", NULL);
-		if (sec)
-			break;
-
-		return err;
-
-	} while (0);
-
-	data = elf_getdata(sec, NULL);
-	if (data == NULL)
-		goto out;
-
-	ptr = data->d_buf;
-	while (ptr < (data->d_buf + data->d_size)) {
-		GElf_Nhdr *nhdr = ptr;
-		size_t namesz = NOTE_ALIGN(nhdr->n_namesz),
-		       descsz = NOTE_ALIGN(nhdr->n_descsz);
-		const char *name;
-
-		ptr += sizeof(*nhdr);
-		name = ptr;
-		ptr += namesz;
-		if (nhdr->n_type == NT_GNU_BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU")) {
-			if (memcmp(name, "GNU", sizeof("GNU")) == 0) {
-				size_t sz = min(size, descsz);
-				memcpy(bf, ptr, sz);
-				memset(bf + sz, 0, size - sz);
-				err = sz;
-				break;
-			}
-		}
-		ptr += descsz;
-	}
-
-out:
-	return err;
-}
-
-static int read_build_id(const char *filename, struct build_id *bid, bool block)
-{
-	size_t size = sizeof(bid->data);
-	int fd, err;
-	Elf *elf;
-
-	err = libbfd__read_build_id(filename, bid, block);
-	if (err >= 0)
-		goto out;
-
-	if (size < BUILD_ID_SIZE)
-		goto out;
-
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
-	if (fd < 0)
-		goto out;
-
-	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
-	if (elf == NULL) {
-		pr_debug2("%s: cannot read %s ELF file.\n", __func__, filename);
-		goto out_close;
-	}
-
-	err = elf_read_build_id(elf, bid->data, size);
-	if (err > 0)
-		bid->size = err;
-
-	elf_end(elf);
-out_close:
-	close(fd);
-out:
-	return err;
-}
-
-int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
-{
-	struct kmod_path m = { .name = NULL, };
-	char path[PATH_MAX];
-	int err;
-
-	if (!filename)
-		return -EFAULT;
-
-	err = kmod_path__parse(&m, filename);
-	if (err)
-		return -1;
-
-	if (m.comp) {
-		int error = 0, fd;
-
-		fd = filename__decompress(filename, path, sizeof(path), m.comp, &error);
-		if (fd < 0) {
-			pr_debug("Failed to decompress (error %d) %s\n",
-				 error, filename);
-			return -1;
-		}
-		close(fd);
-		filename = path;
-		block = true;
-	}
-
-	err = read_build_id(filename, bid, block);
-
-	if (m.comp)
-		unlink(filename);
-	return err;
-}
-
 int sysfs__read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
@@ -1170,7 +1018,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		struct build_id bid;
 		int size;
 
-		size = elf_read_build_id(elf, build_id, BUILD_ID_SIZE);
+		size = __libelf__read_build_id(elf, build_id, BUILD_ID_SIZE);
 		if (size <= 0) {
 			*dso__load_errno(dso) = DSO_LOAD_ERRNO__CANNOT_READ_BUILDID;
 			goto out_elf_end;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index aeb253248895..f9adeb09ef00 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -1,5 +1,7 @@
+#include "debug.h"
 #include "dso.h"
 #include "symbol.h"
+#include "symbol-minimal.h"
 #include "symsrc.h"
 
 #include <errno.h>
@@ -75,17 +77,19 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 	return -1;
 }
 
+#ifndef HAVE_LIBELF_SUPPORT
 int filename__read_debuglink(const char *filename __maybe_unused,
 			     char *debuglink __maybe_unused,
 			     size_t size __maybe_unused)
 {
 	return -1;
 }
+#endif
 
 /*
  * Just try PT_NOTE header otherwise fails
  */
-int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
+int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid)
 {
 	int fd, ret = -1;
 	bool need_swap = false, elf32;
@@ -102,7 +106,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 	void *phdr, *buf = NULL;
 	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	fd = dup(_fd);
 	if (fd < 0)
 		return -1;
 
@@ -194,9 +198,12 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 	free(phdr);
 out:
 	close(fd);
+	if (ret)
+		pr_debug("Error reading build-id from %s\n", filename);
 	return ret;
 }
 
+#ifndef HAVE_LIBELF_SUPPORT
 int sysfs__read_build_id(const char *filename, struct build_id *bid)
 {
 	int fd;
@@ -358,3 +365,4 @@ bool filename__has_section(const char *filename __maybe_unused, const char *sec
 {
 	return false;
 }
+#endif // HAVE_LIBELF_SUPPORT
diff --git a/tools/perf/util/symbol-minimal.h b/tools/perf/util/symbol-minimal.h
new file mode 100644
index 000000000000..185d98968212
--- /dev/null
+++ b/tools/perf/util/symbol-minimal.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SYMBOL_MINIMAL_H
+#define __PERF_SYMBOL_MINIMAL_H
+
+struct build_id;
+
+int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid);
+
+#endif /* __PERF_SYMBOL_MINIMAL_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 638015651547..c8795e1da2df 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -35,6 +35,7 @@
 #include "path.h"
 #include "perf-libelf.h"
 #include "strlist.h"
+#include "symbol-minimal.h"
 #include "symbol.h"
 #include "symsrc.h"
 #include "util.h" // lsdir()
@@ -1999,6 +2000,55 @@ static bool filename__readable(const char *file)
 	return true;
 }
 
+int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
+{
+	struct kmod_path m = { .name = NULL, };
+	char path[PATH_MAX];
+	int err, fd;
+
+	if (!filename)
+		return -EFAULT;
+
+	err = kmod_path__parse(&m, filename);
+	if (err)
+		return -1;
+
+	if (m.comp) {
+		int error = 0;
+
+		fd = filename__decompress(filename, path, sizeof(path), m.comp, &error);
+		if (fd < 0) {
+			pr_debug("Failed to decompress (error %d) %s\n",
+				 error, filename);
+			return -1;
+		}
+		lseek(fd, 0, SEEK_SET);
+		filename = path;
+		block = true;
+	} else {
+		fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+		if (fd < 0) {
+			pr_debug("Failed to open %s\n", filename);
+			return -1;
+		}
+	}
+
+	err = libbfd__read_build_id(fd, filename, bid);
+	if (err == 0)
+		goto out;
+
+	err = libelf__read_build_id(fd, filename, bid);
+	if (err == 0)
+		goto out;
+
+	err = sym_min__read_build_id(fd, filename, bid);
+out:
+	close(fd);
+	if (m.comp)
+		unlink(filename);
+	return err;
+}
+
 static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 {
 	struct build_id bid = { .size = 0, };
-- 
2.52.0.rc2.455.g230fcf2819-goog

