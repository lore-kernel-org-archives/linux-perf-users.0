Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808657;
	b=GJ5AtKSBOUKKmscmDBq64h3srvZ+1YM9ZkftuICisj2hUzxsGbpCMp56xCdmW7ajXCKA
	 IZSPVwlxy+XTnFicFPVEtX5jVlhrAEePS/rdBuAdZPKemkN8JF4xvhH5Pto6ofxW/HtFu
	 7SmnEj8nwTC1ObqFw/hYwC4CW+8jYxhaxhX0mmVmBUNj7hUriBwYOh9PTlRT/vCeQ7FNn
	 S1mHT+YFmC5p5Tmgm+qSBIxKJak0xxzO5lvcRvBserLwCNuBqmjZ283VPpxYnrEIy1Ll7
	 g0Uli1sGgISWN3nSR4iTD9F3JGwwZ5wvs7HWDld6Hn3oJSWpXcNcPBNn77Q9GDemUVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o/LXBhWx2xUmMAjvH6fIvNai9JuBAdEjimbz2tf7/C4=;
	b=gko9HtOBZ3IhArTjYgGRklIQUXKWdgpdETJiJvcRqH1FCsWE76AhEjD12McDt8/emDkA
	 MjGvUHsp+TTNfDe4lOywJLl2oI9ohmAPbREVFW5d0bjsyx5updTyPiZfEk/PMqvFpQ//I
	 rmoFUYGMOzjJKo1ApC1FIgi2TZpBF3zLHF8PO1BIzZ12uDbbigL5qah0tA4fSTsy1WG7L
	 qXGcIbVIN8yeC1i9VLEWZmUCF6lY7aVuy6om10KqYoIXWBIwEu8PhfapG1Ydx2tFn8piy
	 Uktynm6KzTcnaArbonBmLoaAq4UBcGj/Q7bScPGu0t9lezO8n1U5hAB/YgyN817wQUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcIrOT9K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0660A260B;
	Mon, 16 Nov 2026 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcIrOT9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3AD1F00926;
	Mon, 16 Nov 2026 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808657;
	bh=o/LXBhWx2xUmMAjvH6fIvNai9JuBAdEjimbz2tf7/C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CcIrOT9KL/gLUOpPXG+8pWU86jCJ9xqbm9TKMATjAuwTRKfdxJOtI861ywFd4HMbI
	 FMW6Ey95Ym7EZ5DwESO7Hqh8Yp9SK1K/0KEv6ncSU7LnEk2OzKJwrcC3bUdSEHb38t
	 0h7wDs3l4A8Nuplk+tKbkKQ/Ht/RsxvStoqhkcBaKQIISWQa+2vP+YvPZnQbyb5rMF
	 zrs2JgtKB4NqyExplku8kYJucXpYVtQ+H1pHKZWNCiAJNsZish7TNER6Ax0HzNkY5M
	 /YPw9JzVt5uCwqoGWYFT4Q6SbNSNgaETpr+wJ9xAPTwy8XPPlO7/dvADmwGpAc+3rz
	 UJJPjQCUq9Y/A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 09/11] perf tools: Only enter mount namespace if necessary
Date: Sun, 15 Nov 2026 21:57:29 -0800
Message-ID: <20261116055731.707164-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <20261116055731.707164-1-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dso_binary_type__needs_ns() to distinguish DSO binary and debuginfo
types that reside inside the target process's mount namespace from
host-side paths.

Gate mount namespace entry in open_dso(), dso__find_binary_type_locked(),
dso__find_dbginfo_type(), __dso__read_symbol(), debuginfo__new(),
symbol__disassemble(), and symbol__disassemble_capstone_powerpc() using
dso_binary_type__needs_ns().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/capstone.c  |  8 ++++--
 tools/perf/util/debuginfo.c | 19 +++++++++-----
 tools/perf/util/disasm.c    |  8 +++++-
 tools/perf/util/dso.c       | 52 ++++++++++++++++++++++++++++++-------
 tools/perf/util/dso.h       | 34 ++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 95881f15324aa614..e1de77879c5e5f97 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -649,13 +649,17 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	bool disassembler_style = false;
 	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
+	bool nsenter;
 
 	if (args->options->objdump_path)
 		return -1;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	nsenter = dso_binary_type__needs_ns(dso__binary_type(dso));
+	if (nsenter)
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
+	if (nsenter)
+		nsinfo__mountns_exit(&nsc);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index db188c397d63880c..d339906c28b41425 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -17,6 +17,7 @@
 #include "dso.h"
 #include "debug.h"
 #include "debuginfo.h"
+#include "namespaces.h"
 #include "symbol.h"
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
@@ -93,17 +94,23 @@ static struct debuginfo *__debuginfo__new(const char *path)
 
 struct debuginfo *debuginfo__new(struct dso *dso)
 {
-	struct debuginfo *dinfo;
+	struct debuginfo *dinfo = NULL;
+	struct nscookie nsc;
 	char *path;
 	bool decomp = false;
+	bool nsenter;
 
 	dso__find_dbginfo_type(dso);
+	nsenter = dso_binary_type__needs_ns(dso__dbginfo_type(dso));
+	if (nsenter)
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	path = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
-	if (path == NULL)
-		return NULL;
-
-	dinfo = __debuginfo__new(path);
-	dso__put_filename(dso, path, decomp);
+	if (path != NULL) {
+		dinfo = __debuginfo__new(path);
+		dso__put_filename(dso, path, decomp);
+	}
+	if (nsenter)
+		nsinfo__mountns_exit(&nsc);
 	return dinfo;
 }
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ca478191813cf46f..5b9bc94be55ef088 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1499,7 +1499,8 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	bool delete_extract = false;
 	struct kcore_extract kce;
 	enum dso_binary_type dbt;
-	bool decomp = false;
+	struct nscookie nsc;
+	bool decomp = false, nsenter;
 	int err;
 
 	dbt = dso__find_binary_type(dso);
@@ -1507,8 +1508,13 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	if (dbt == DSO_BINARY_TYPE__KALLSYMS)
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
 
+	nsenter = dso_binary_type__needs_ns(dbt);
 	mutex_lock(dso__lock(dso));
+	if (nsenter)
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	symfs_filename = dso__get_filename(dso, "", &decomp, dbt);
+	if (nsenter)
+		nsinfo__mountns_exit(&nsc);
 	mutex_unlock(dso__lock(dso));
 
 	if (symfs_filename == NULL) {
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 36e6c45dd0383073..d4fc702b4c338d96 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -712,14 +712,15 @@ static int open_dso(struct dso *dso, struct machine *machine)
 {
 	int fd;
 	struct nscookie nsc;
+	bool nsenter = dso_binary_type__needs_ns(dso__binary_type(dso));
 
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+	if (nsenter) {
 		mutex_lock(dso__lock(dso));
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		mutex_unlock(dso__lock(dso));
 	}
 	fd = __open_dso(dso, machine);
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (nsenter)
 		nsinfo__mountns_exit(&nsc);
 
 	if (fd >= 0) {
@@ -897,12 +898,22 @@ static int dso__find_binary_type_locked(struct dso *dso)
 	}
 
 	do {
-		dso__set_binary_type(dso, binary_type_data[i++]);
+		struct nscookie nsc;
+		enum dso_binary_type type = binary_type_data[i++];
+		bool nsenter = dso_binary_type__needs_ns(type);
+
+		dso__set_binary_type(dso, type);
+
+		if (nsenter)
+			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		errno = 0;
-		path = dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
+		path = dso__get_filename(dso, "", &decomp, type);
 		if (path == NULL) {
-			if (errno == EMFILE)
+			saved_errno = errno;
+			if (nsenter)
+				nsinfo__mountns_exit(&nsc);
+			if (saved_errno == EMFILE)
 				goto open_err;
 			continue;
 		}
@@ -912,9 +923,11 @@ static int dso__find_binary_type_locked(struct dso *dso)
 		if (!found)
 			saved_errno = errno;
 		dso__put_filename(dso, path, decomp);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 
 		if (found)
-			return dso__binary_type(dso);
+			return type;
 		else if (saved_errno == EMFILE)
 			goto open_err;
 
@@ -2119,11 +2132,14 @@ static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	};
 	u8 *code_buf = NULL;
 	int saved_errno;
+	bool nsenter = dso_binary_type__needs_ns(dso__binary_type(dso));
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (nsenter)
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(symfs_filename, O_RDONLY | O_CLOEXEC);
 	saved_errno = errno;
-	nsinfo__mountns_exit(&nsc);
+	if (nsenter)
+		nsinfo__mountns_exit(&nsc);
 	if (fd < 0) {
 		errno = saved_errno;
 		return NULL;
@@ -2244,8 +2260,9 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
+	struct nscookie nsc;
 	char *path;
-	bool found, decomp = false;
+	bool found, decomp = false, nsenter;
 
 	if (dso__dbginfo_type(dso) != DSO_BINARY_TYPE__NOT_FOUND)
 		return;
@@ -2255,28 +2272,43 @@ void dso__find_dbginfo_type(struct dso *dso)
 	dso__set_debuginfo_searched(dso);
 
 	/* Maybe debug info is in the same file with the symbol table */
+	nsenter = dso_binary_type__needs_ns(dso__symtab_type(dso));
+	if (nsenter)
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	path = dso__get_filename(dso, "", &decomp, dso__symtab_type(dso));
 	if (path) {
 		found = filename__has_section(path, ".debug_info") ||
 			filename__has_section(path, ".zdebug_info");
 
 		dso__put_filename(dso, path, decomp);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 		if (found) {
 			dso__set_dbginfo_type(dso, dso__symtab_type(dso));
 			return;
 		}
+	} else if (nsenter) {
+		nsinfo__mountns_exit(&nsc);
 	}
 
 	/* Otherwise check distro debug locations */
 	for (type = dbginfo_types; *type != DSO_BINARY_TYPE__NOT_FOUND; type++) {
+		nsenter = dso_binary_type__needs_ns(*type);
+		if (nsenter)
+			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		path = dso__get_filename(dso, "", &decomp, *type);
-		if (path == NULL)
+		if (path == NULL) {
+			if (nsenter)
+				nsinfo__mountns_exit(&nsc);
 			continue;
+		}
 
 		found = filename__has_section(path, ".debug_info") ||
 			filename__has_section(path, ".zdebug_info");
 
 		dso__put_filename(dso, path, decomp);
+		if (nsenter)
+			nsinfo__mountns_exit(&nsc);
 		if (found)
 			break;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d5f7382d4e13a371..7cac0960e1a6dd32 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -141,6 +141,40 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
+static inline bool dso_binary_type__needs_ns(enum dso_binary_type type)
+{
+	switch (type) {
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+		return true;
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return false;
+	}
+}
+
 enum dso_space_type {
 	DSO_SPACE__USER = 0,
 	DSO_SPACE__KERNEL,
-- 
2.56.0.611.g1030f0b940-goog

