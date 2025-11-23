Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA215239E7E
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865168; cv=none; b=l0ubnFXnbW5+SBYgC7IgINONVpXjJ17jddh6NBfk1TpL2a5VOP0tmcbnPJeWSSvJ9OO8mzQtlh0jAQymYYExNyiYJCzwgbmNi2xl+S1oVR6Oeg1+XAIvIQaV13w0JRM3xgbgnoJgDk+olix8nnCGXOgwyGiC1wqt9TreB2nIMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865168; c=relaxed/simple;
	bh=gmLo+tgn4IZIr717BNDUYeGmMI7UzWO3Pd0YWYVvZ0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WI6G6JVq1AXJ6+cq7pQK5qn/bYPZjWB9ArU8X5R4DWlQJGtT2zKwACEvaagdy8phpNzhrP4eeaN7XHlM6PuRcoeruP3x42xk9FAGWxZtxbbEYsuq7OH1sWeWS2KLqvdx2CENm2F3eAONYZ6VKYImm2PImENGgokjMsPqhSHsTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOXcy/dl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOXcy/dl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so6036110a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865166; x=1764469966; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJWi9LJoNL3FYJ5G98IXAS+1MZDxRsbBpxNCWiuvz3Y=;
        b=rOXcy/dliwqxm0O0CMdF/7SSgwPjy8bmhvMwPfHBndZZ1J3ry0i+PCMmRwmU8prfTA
         BGywM3lMP5ruW3VckQ2VO37w9DdfuhxdZQ4iW8PH8aghz2FcKRN6jBaCMGv39mQE6Osq
         n9zfqi7vjnPVoZFP+bUPnyELIGkNTiBXcjj8SEriUh4aXBcE0xSmeEhGDVSUfgqHsaPi
         LnZ8KsKU5xMWxnBroiOzEFZOK5TYQEbMWRbaXYYrXmqowP0jdFpsdekYJdM7VLzyNAAa
         5SXp9TIk7RMJFUjgBbQQxGE2DpALxMvOrEi6ZVEdiywWHFa8FoXHP0mYd6QSoTe94QEu
         04OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865166; x=1764469966;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJWi9LJoNL3FYJ5G98IXAS+1MZDxRsbBpxNCWiuvz3Y=;
        b=i46drNTwGoltFpT/YmhVLC6w4AhRciv7FR9+Z4CCTOU5t1yz0f9k9EHcAAhLBUjcQl
         JhfdEBDNLrQs4kLMsqPLF6w+5516k98uTT3xldpe86Y28Zre7wL+VeFggNXI8aExgk7M
         zBHcBJZKBhPqFVP4BT2H8gBQ6IvUbVCpr94QKzOe4YQZAY9HuVt9ZbtD9AgC3w5yShd1
         cER2Xx7SBjZgwiM8ZzXjl9Huw5SpCDUIPnlihTPGS18p4ama6t6gNbNGserSWyCwcNhW
         eGdSS3WK1FzdijoNYFjUAU5AUqPWwHRUXltGm0McNacb2HaBj+CQtsMyZiDmzTyx7Nsv
         gbXA==
X-Forwarded-Encrypted: i=1; AJvYcCXyTGy9aTb//bazJwr9SWTytgqklJQk/yRGlI88Ep5t+tgfO6TS4uSTYh50hMnRvRazDS7ymfO8nayro0yJgV15@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUw85dBYS4nHyS0KUU3O2sF88wB/b9cOWKwws4nR6NXg3RTfL
	AZhxRCjVOW/Cld73Kz3xSC3sDn5lIq+2yzr8XaLhMvysc2cQWabrmOxMw9+oF7pALBVboCw7tHB
	TSQPKfzPkIg==
X-Google-Smtp-Source: AGHT+IGlLjcaAxzInDuxNrjd4MICP4gAlip8m1PZOAGVSGoEQnG3ECgO4g4ensv3j1w62Z5aRC/CWmyas1X5
X-Received: from dlbrh6.prod.google.com ([2002:a05:7022:f306:b0:11a:26c7:567d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f909:b0:11b:9386:a380
 with SMTP id a92af1059eb24-11c9d8720c3mr2820469c88.47.1763865165987; Sat, 22
 Nov 2025 18:32:45 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:25 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-10-irogers@google.com>
Subject: [PATCH v1 9/9] perf dso: Move type helpers out of symbol and use fallbacks
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

Fallback between libelf and symbol-minimal versions. Remove the
symbol.c code and just directly inline into the only caller in dso.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c            | 57 ++++++++++++++----------
 tools/perf/util/perf-libelf.c    | 33 ++++++++++++++
 tools/perf/util/perf-libelf.h    |  8 ++++
 tools/perf/util/symbol-elf.c     | 33 --------------
 tools/perf/util/symbol-minimal.c | 76 ++++++++++++++++----------------
 tools/perf/util/symbol-minimal.h |  3 ++
 tools/perf/util/symbol.h         |  2 -
 7 files changed, 115 insertions(+), 97 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 344e689567ee..421fa4d27d2a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,37 +1,42 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <asm/bug.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/libbpf.h>
-#include "bpf-event.h"
-#include "bpf-utils.h"
-#endif
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "annotate-data.h"
+#include "auxtrace.h"
 #include "compress.h"
+#include "debug.h"
+#include "dso.h"
+#include "dsos.h"
 #include "env.h"
+#include "machine.h"
+#include "map.h"
 #include "namespaces.h"
 #include "path.h"
-#include "map.h"
-#include "symbol.h"
+#include "perf-libelf.h"
 #include "srcline.h"
-#include "dso.h"
-#include "dsos.h"
-#include "machine.h"
-#include "auxtrace.h"
-#include "util.h" /* O_CLOEXEC for older systems */
-#include "debug.h"
 #include "string2.h"
+#include "symbol-minimal.h"
+#include "symbol.h"
+#include "util.h" /* O_CLOEXEC for older systems */
 #include "vdso.h"
-#include "annotate-data.h"
+
+#include <asm/bug.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/libbpf.h>
+#include "bpf-event.h"
+#include "bpf-utils.h"
+#endif
 
 static const char * const debuglink_paths[] = {
 	"%.0s%s",
@@ -1747,7 +1752,11 @@ enum dso_type dso__type(struct dso *dso, struct machine *machine)
 	enum dso_type type = DSO__TYPE_UNKNOWN;
 
 	if (dso__data_get_fd(dso, machine, &fd)) {
-		type = dso__type_fd(fd);
+		type = libelf_dso__type_fd(fd);
+
+		if (type == DSO__TYPE_UNKNOWN)
+			type = sym_min_dso__type_fd(fd);
+
 		dso__data_put_fd(dso);
 	}
 
diff --git a/tools/perf/util/perf-libelf.c b/tools/perf/util/perf-libelf.c
index 861cb7ae9b45..d36b69ccccda 100644
--- a/tools/perf/util/perf-libelf.c
+++ b/tools/perf/util/perf-libelf.c
@@ -251,3 +251,36 @@ int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_
 out:
 	return err;
 }
+
+enum dso_type libelf_dso__type_fd(int fd)
+{
+	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
+	GElf_Ehdr ehdr;
+	Elf_Kind ek;
+	Elf *elf;
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL)
+		goto out;
+
+	ek = elf_kind(elf);
+	if (ek != ELF_K_ELF)
+		goto out_end;
+
+	if (gelf_getclass(elf) == ELFCLASS64) {
+		dso_type = DSO__TYPE_64BIT;
+		goto out_end;
+	}
+
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		goto out_end;
+
+	if (ehdr.e_machine == EM_X86_64)
+		dso_type = DSO__TYPE_X32BIT;
+	else
+		dso_type = DSO__TYPE_32BIT;
+out_end:
+	elf_end(elf);
+out:
+	return dso_type;
+}
diff --git a/tools/perf/util/perf-libelf.h b/tools/perf/util/perf-libelf.h
index 95fe8805aa41..976fe3fb5cd8 100644
--- a/tools/perf/util/perf-libelf.h
+++ b/tools/perf/util/perf-libelf.h
@@ -4,6 +4,8 @@
 
 #include <stddef.h>
 
+#include "dso.h"
+
 struct build_id;
 
 #ifdef HAVE_LIBELF_SUPPORT
@@ -29,6 +31,7 @@ int __libelf__read_build_id(Elf *elf, void *bf, size_t size);
 int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid);
 int libelf_sysfs__read_build_id(const char *filename, struct build_id *bid);
 int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
+enum dso_type libelf_dso__type_fd(int fd);
 
 #else // !defined(HAVE_LIBELF_SUPPORT)
 
@@ -52,6 +55,11 @@ static inline int libelf_filename__read_debuglink(const char *filename __always_
 	return -1;
 }
 
+enum dso_type libelf_dso__type_fd(int fd __always_unused)
+{
+	return DSO__TYPE_UNKNOWN;
+}
+
 #endif // defined(HAVE_LIBELF_SUPPORT)
 
 #endif /* __PERF_LIBELF_H */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5ddf8353e01b..3d385d749c53 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1572,39 +1572,6 @@ int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
 	return err;
 }
 
-enum dso_type dso__type_fd(int fd)
-{
-	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	GElf_Ehdr ehdr;
-	Elf_Kind ek;
-	Elf *elf;
-
-	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
-	if (elf == NULL)
-		goto out;
-
-	ek = elf_kind(elf);
-	if (ek != ELF_K_ELF)
-		goto out_end;
-
-	if (gelf_getclass(elf) == ELFCLASS64) {
-		dso_type = DSO__TYPE_64BIT;
-		goto out_end;
-	}
-
-	if (gelf_getehdr(elf, &ehdr) == NULL)
-		goto out_end;
-
-	if (ehdr.e_machine == EM_X86_64)
-		dso_type = DSO__TYPE_X32BIT;
-	else
-		dso_type = DSO__TYPE_32BIT;
-out_end:
-	elf_end(elf);
-out:
-	return dso_type;
-}
-
 static int copy_bytes(int from, off_t from_offs, int to, off_t to_offs, u64 len)
 {
 	ssize_t r;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index cc9055ba2f2a..336886c2b1ff 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -225,6 +225,44 @@ int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid)
 	return ret;
 }
 
+static int fd__is_64_bit(int fd)
+{
+	u8 e_ident[EI_NIDENT];
+
+	if (lseek(fd, 0, SEEK_SET))
+		return -1;
+
+	if (readn(fd, e_ident, sizeof(e_ident)) != sizeof(e_ident))
+		return -1;
+
+	if (memcmp(e_ident, ELFMAG, SELFMAG) ||
+	    e_ident[EI_VERSION] != EV_CURRENT)
+		return -1;
+
+	return e_ident[EI_CLASS] == ELFCLASS64;
+}
+
+enum dso_type sym_min_dso__type_fd(int fd)
+{
+	Elf64_Ehdr ehdr;
+	int ret;
+
+	ret = fd__is_64_bit(fd);
+	if (ret < 0)
+		return DSO__TYPE_UNKNOWN;
+
+	if (ret)
+		return DSO__TYPE_64BIT;
+
+	if (readn(fd, &ehdr, sizeof(ehdr)) != sizeof(ehdr))
+		return DSO__TYPE_UNKNOWN;
+
+	if (ehdr.e_machine == EM_X86_64)
+		return DSO__TYPE_X32BIT;
+
+	return DSO__TYPE_32BIT;
+}
+
 #ifndef HAVE_LIBELF_SUPPORT
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	         enum dso_binary_type type)
@@ -271,44 +309,6 @@ int dso__synthesize_plt_symbols(struct dso *dso __maybe_unused,
 	return 0;
 }
 
-static int fd__is_64_bit(int fd)
-{
-	u8 e_ident[EI_NIDENT];
-
-	if (lseek(fd, 0, SEEK_SET))
-		return -1;
-
-	if (readn(fd, e_ident, sizeof(e_ident)) != sizeof(e_ident))
-		return -1;
-
-	if (memcmp(e_ident, ELFMAG, SELFMAG) ||
-	    e_ident[EI_VERSION] != EV_CURRENT)
-		return -1;
-
-	return e_ident[EI_CLASS] == ELFCLASS64;
-}
-
-enum dso_type dso__type_fd(int fd)
-{
-	Elf64_Ehdr ehdr;
-	int ret;
-
-	ret = fd__is_64_bit(fd);
-	if (ret < 0)
-		return DSO__TYPE_UNKNOWN;
-
-	if (ret)
-		return DSO__TYPE_64BIT;
-
-	if (readn(fd, &ehdr, sizeof(ehdr)) != sizeof(ehdr))
-		return DSO__TYPE_UNKNOWN;
-
-	if (ehdr.e_machine == EM_X86_64)
-		return DSO__TYPE_X32BIT;
-
-	return DSO__TYPE_32BIT;
-}
-
 int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 		  struct symsrc *ss,
 		  struct symsrc *runtime_ss __maybe_unused,
diff --git a/tools/perf/util/symbol-minimal.h b/tools/perf/util/symbol-minimal.h
index 5cce1f1f0f16..282466aca7d9 100644
--- a/tools/perf/util/symbol-minimal.h
+++ b/tools/perf/util/symbol-minimal.h
@@ -2,9 +2,12 @@
 #ifndef __PERF_SYMBOL_MINIMAL_H
 #define __PERF_SYMBOL_MINIMAL_H
 
+#include "dso.h"
+
 struct build_id;
 
 int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid);
 int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid);
+enum dso_type sym_min_dso__type_fd(int fd);
 
 #endif /* __PERF_SYMBOL_MINIMAL_H */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d37d5a97bc6f..25484b2e7fa4 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -117,8 +117,6 @@ struct symbol *dso__first_symbol(struct dso *dso);
 struct symbol *dso__last_symbol(struct dso *dso);
 struct symbol *dso__next_symbol(struct symbol *sym);
 
-enum dso_type dso__type_fd(int fd);
-
 int filename__read_build_id(const char *filename, struct build_id *id, bool block);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
-- 
2.52.0.rc2.455.g230fcf2819-goog

