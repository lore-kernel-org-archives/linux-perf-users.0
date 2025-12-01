Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5228489A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622552; cv=none; b=eWHjm+ft96YKKrjYGzL9gzedmVcbaSw+Y0a9nWWYWRnFNIRtMyyhc8kRhKlZ4OvZZNLfD02kWvGcxf22F8z1m8Vt6EP3ds6oIpUr4qGIsZbhanawW4RBeztXw8O71bHUjSrHfdDxKC/+jLargNkyegaQT9sU//tVtc7zWJR77d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622552; c=relaxed/simple;
	bh=jrlJM+/Xgy1nehgeiFknXjuulHnnAtIGNxHD7/IQYEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jST4Fh2MHJIAuQLH2JL0alXTPWWVDLkXqWH0KBBW6TL+oV7Ow3cgXYV1/NbZKE5djNNer8O3td/3I4/dkIcpeADPn+9OgnbNDaQ2938EEthVDBt0S3kyYvO/iFfOPibKjgmQKTF8Bowibwpf76aelYzf6y7ObFPLNiTWq6HbmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ev/qTNbN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ev/qTNbN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bdf47c10220so6762473a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622550; x=1765227350; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKo8U+r87/wZow77a+6w5wG9mxBjXhr2B97riOby7IM=;
        b=Ev/qTNbNmqOZiIL74zrSySwFegdLycWrZ5jj7mvEhMa2A7+GGZrbRJ2QIU+MxX08qr
         n4J9AvvhQdnICpsWdZtFNtp8SRc3510lhUISDFKZTa69w+64MOaauXkpceAkHHZtnUJZ
         R1/d2aYOIkSQFaFdkpaAW2rn4v6ap/xIzeemSspJ7jTjEJxagtt8lhZZZvhODXMYhgTU
         6G8ss8dKQvEq3ptJRsvsP4eZk4vE/1UqTLB4jxQaD57IWI4/T2O9cq783/sE4a9wFCB6
         Nr3pyxhUWtSeSIdvHx9BSgurKG3rTrKZOTdg/56tkTD3/j6tFVZeV7iQGj5JQnE3fnO4
         czNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622550; x=1765227350;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKo8U+r87/wZow77a+6w5wG9mxBjXhr2B97riOby7IM=;
        b=qfllRB54fdvqMWvyMo//LbwhKCzjNAMec2EaXsk7UOBUj9k0x7D62kXN7T+3/+Oqxg
         kIgMzOQLd8U0P/Bv1658Dlk3seHSKpC4YHqtn+EuHgdoY1lccy5cQgbkEiFNCqdKdHmP
         XTz/fCZX4BITwb8f2jcXl/41aVMLny3e+kmfX1N03O5MMG00KKiEAVOWd2I98Qmu96UB
         B9onREHMJ18TxnUmQ+AMWEySVPio27915mAaFegr59CJdrBvQoYJcPzm7vEy4D60lw5R
         RZ51V1ARnxRpoKk/U1a9bELLsoSYFqZOa0rRIpmx3fSpfpwjjoSSJzyzSZmBRuJCUdwi
         t9KA==
X-Forwarded-Encrypted: i=1; AJvYcCWVcZ2EuqHeAE+HlW/NrUCkPvuQPziL3KKEtoGsr9bxJ7zerXi3F41I4K2cyfytOKZ6aHDHeWr6DpY2RhMW2/PE@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIp3InlTSMYLuNe63+SQ1Z9XhFeBJlmi/hHyjSvb8taxW/Jx4
	E6MJupxnjHfmh5WLbxqo5cv0J/0TJFq3YJ3C6Tkdh+f9LzYfbKKH1JCQxtd6asNK+DvVu2KTp1H
	FomLysfeQEA==
X-Google-Smtp-Source: AGHT+IFwfbvxrTUV97nEqe//dS4hmDl4mUXXnvNvY1GF2WwfaNj5WQeqU7NF6PKqtn2upo6UO60uM+9Q7iaX
X-Received: from dybuh25.prod.google.com ([2002:a05:7301:7519:b0:2a4:664f:e91d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:550d:b0:2a4:3594:d552
 with SMTP id 5a478bee46e88-2a719f9d8d6mr19884768eec.31.1764622549762; Mon, 01
 Dec 2025 12:55:49 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:08 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-10-irogers@google.com>
Subject: [PATCH v2 09/10] perf dso: Move type helpers out of symbol and use fallbacks
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
index 4198f4dfad9f..eed5c0317f8b 100644
--- a/tools/perf/util/perf-libelf.c
+++ b/tools/perf/util/perf-libelf.c
@@ -200,3 +200,36 @@ int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_
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
index 2118325c04e5..5ca5641b9dc9 100644
--- a/tools/perf/util/perf-libelf.h
+++ b/tools/perf/util/perf-libelf.h
@@ -4,6 +4,8 @@
 
 #include <stddef.h>
 
+#include "dso.h"
+
 struct build_id;
 
 #ifdef HAVE_LIBELF_SUPPORT
@@ -28,6 +30,7 @@ int __libelf__read_build_id(Elf *elf, void *bf, size_t size);
 
 int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid);
 int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
+enum dso_type libelf_dso__type_fd(int fd);
 
 #else // !defined(HAVE_LIBELF_SUPPORT)
 
@@ -45,6 +48,11 @@ static inline int libelf_filename__read_debuglink(const char *filename __always_
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
index cb890de31044..f483aa67f69b 100644
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
index 0e3a27dae9d6..f9724448fb64 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -259,6 +259,44 @@ int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid)
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
@@ -305,44 +343,6 @@ int dso__synthesize_plt_symbols(struct dso *dso __maybe_unused,
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
index e265e1f028be..4cc557981724 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -117,8 +117,6 @@ struct symbol *dso__first_symbol(struct dso *dso);
 struct symbol *dso__last_symbol(struct dso *dso);
 struct symbol *dso__next_symbol(struct symbol *sym);
 
-enum dso_type dso__type_fd(int fd);
-
 int filename__read_build_id(const char *filename, struct build_id *id);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
-- 
2.52.0.158.g65b55ccf14-goog

