Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE513AA38;
	Mon, 11 Nov 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338278; cv=none; b=mlxatlax50U/LECelLmQUGCGvMXh5Nt/GN8aObp8Z4hroHHmhCxv+3FrnT/Uwts8tlIXmFzqmGk5QsIIUeIVFi8i9WAZkkODG+qwhXaVVe+ex2QqIfVhZYZWbog7tWKHnUUWT1vcmTwj+eeQcgRqNRGnKl68QxGGu6CCEpX+KLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338278; c=relaxed/simple;
	bh=8XlzRzF1gBkUhM/gWdpfw1FaK3At+clEa03vKUZgw0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1NtPyjEdIicGjqvcUYuiDx4QHyK1gHTeKwKpVsBPE3MNQrfj3iy80wtQjN9zb45X0WkRtg+zBytVgMaJJ54/n5Lekg6RJYXM/1eZwTIKXF/jmBCHuuo7RD+YBFdgfoCObRQ+g5SWYzFQ/ZuKVIAGq9RQ22zsz8SEOIEY2ayHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlYTYeqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlYTYeqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE928C4CECF;
	Mon, 11 Nov 2024 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338277;
	bh=8XlzRzF1gBkUhM/gWdpfw1FaK3At+clEa03vKUZgw0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlYTYeqyM0uFGmV/dXm/dw0DDiMVK2IwFZV9Eox3wEHL7B0QUnK2kFccpmTk1rsKs
	 QU09N4Z+GCs2NchSAki050uqReHnk0K/RxwhVrwH4l9gIOwFPJ9dvldLznqOwJRMFB
	 +5pnrtPJz05/aOK/Mc19P6BWMYpQUoaxs/rbNIoSlcnZ7GE3n6Je0L5IsycRj3Rwoc
	 F5nI7p+PUYQWospP00PIbtPKWcNsV0OTqHfxZvbglOT2+ItKvd/smTtK9M/llcadeW
	 mWfmNlFez9lgBmx5RO/JaWyQbkxx4UdrO6tdBp46YrdYa1ydTwiT7s0O60Yhf5n3Tj
	 LfZtpDRAMn/fQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Subject: [PATCH 1/3] perf disasm: Introduce symbol__disassemble_objdump()
Date: Mon, 11 Nov 2024 12:17:32 -0300
Message-ID: <20241111151734.1018476-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111151734.1018476-1-acme@kernel.org>
References: <20241111151734.1018476-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With the first disassemble method in perf, the parsing of objdump
output, just like we have for llvm and capstone.

This paves the way to allow the user to specify what disassemblers are
preferred and to also to at some point allow building without the
objdump method.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steinar H. Gunderson <sesse@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/disasm.c | 168 ++++++++++++++++++++-------------------
 1 file changed, 88 insertions(+), 80 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a525b80b934fdb5f..36cf61602c17fe69 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -2045,17 +2045,14 @@ static char *expand_tabs(char *line, char **storage, size_t *storage_len)
 	return new_line;
 }
 
-int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
+static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
+				       struct annotate_args *args)
 {
 	struct annotation_options *opts = &annotate_opts;
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	char *command;
 	FILE *file;
-	char symfs_filename[PATH_MAX];
-	struct kcore_extract kce;
-	bool delete_extract = false;
-	bool decomp = false;
 	int lineno = 0;
 	char *fileloc = NULL;
 	int nline;
@@ -2070,77 +2067,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		NULL,
 	};
 	struct child_process objdump_process;
-	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
-
-	if (err)
-		return err;
-
-	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
-		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
-		 map__unmap_ip(map, sym->end));
-
-	pr_debug("annotating [%p] %30s : [%p] %30s\n",
-		 dso, dso__long_name(dso), sym, sym->name);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
-		return symbol__disassemble_bpf(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
-		return symbol__disassemble_bpf_image(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
-		return -1;
-	} else if (dso__is_kcore(dso)) {
-		kce.kcore_filename = symfs_filename;
-		kce.addr = map__rip_2objdump(map, sym->start);
-		kce.offs = sym->start;
-		kce.len = sym->end - sym->start;
-		if (!kcore_extract__create(&kce)) {
-			delete_extract = true;
-			strlcpy(symfs_filename, kce.extract_filename,
-				sizeof(symfs_filename));
-		}
-	} else if (dso__needs_decompress(dso)) {
-		char tmp[KMOD_DECOMP_LEN];
-
-		if (dso__decompress_kmodule_path(dso, symfs_filename,
-						 tmp, sizeof(tmp)) < 0)
-			return -1;
-
-		decomp = true;
-		strcpy(symfs_filename, tmp);
-	}
-
-	/*
-	 * For powerpc data type profiling, use the dso__data_read_offset
-	 * to read raw instruction directly and interpret the binary code
-	 * to understand instructions and register fields. For sort keys as
-	 * type and typeoff, disassemble to mnemonic notation is
-	 * not required in case of powerpc.
-	 */
-	if (arch__is(args->arch, "powerpc")) {
-		extern const char *sort_order;
-
-		if (sort_order && !strstr(sort_order, "sym")) {
-			err = symbol__disassemble_raw(symfs_filename, sym, args);
-			if (err == 0)
-				goto out_remove_tmp;
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-			err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
-			if (err == 0)
-				goto out_remove_tmp;
-#endif
-		}
-	}
-
-#ifdef HAVE_LIBLLVM_SUPPORT
-	err = symbol__disassemble_llvm(symfs_filename, sym, args);
-	if (err == 0)
-		goto out_remove_tmp;
-#endif
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-	err = symbol__disassemble_capstone(symfs_filename, sym, args);
-	if (err == 0)
-		goto out_remove_tmp;
-#endif
+	int err;
 
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
@@ -2163,13 +2090,13 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	if (err < 0) {
 		pr_err("Failure allocating memory for the command to run\n");
-		goto out_remove_tmp;
+		return err;
 	}
 
 	pr_debug("Executing: %s\n", command);
 
 	objdump_argv[2] = command;
-	objdump_argv[4] = symfs_filename;
+	objdump_argv[4] = filename;
 
 	/* Create a pipe to read from for stdout */
 	memset(&objdump_process, 0, sizeof(objdump_process));
@@ -2207,8 +2134,8 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 			break;
 
 		/* Skip lines containing "filename:" */
-		match = strstr(line, symfs_filename);
-		if (match && match[strlen(symfs_filename)] == ':')
+		match = strstr(line, filename);
+		if (match && match[strlen(filename)] == ':')
 			continue;
 
 		expanded_line = strim(line);
@@ -2253,6 +2180,87 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 out_free_command:
 	free(command);
+	return err;
+}
+
+int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
+{
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	char symfs_filename[PATH_MAX];
+	bool delete_extract = false;
+	struct kcore_extract kce;
+	bool decomp = false;
+	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
+
+	if (err)
+		return err;
+
+	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
+		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
+		 map__unmap_ip(map, sym->end));
+
+	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+		return symbol__disassemble_bpf(sym, args);
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		return symbol__disassemble_bpf_image(sym, args);
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
+		return -1;
+	} else if (dso__is_kcore(dso)) {
+		kce.addr = map__rip_2objdump(map, sym->start);
+		kce.kcore_filename = symfs_filename;
+		kce.len = sym->end - sym->start;
+		kce.offs = sym->start;
+
+		if (!kcore_extract__create(&kce)) {
+			delete_extract = true;
+			strlcpy(symfs_filename, kce.extract_filename, sizeof(symfs_filename));
+		}
+	} else if (dso__needs_decompress(dso)) {
+		char tmp[KMOD_DECOMP_LEN];
+
+		if (dso__decompress_kmodule_path(dso, symfs_filename, tmp, sizeof(tmp)) < 0)
+			return -1;
+
+		decomp = true;
+		strcpy(symfs_filename, tmp);
+	}
+
+	/*
+	 * For powerpc data type profiling, use the dso__data_read_offset to
+	 * read raw instruction directly and interpret the binary code to
+	 * understand instructions and register fields. For sort keys as type
+	 * and typeoff, disassemble to mnemonic notation is not required in
+	 * case of powerpc.
+	 */
+	if (arch__is(args->arch, "powerpc")) {
+		extern const char *sort_order;
+
+		if (sort_order && !strstr(sort_order, "sym")) {
+			err = symbol__disassemble_raw(symfs_filename, sym, args);
+			if (err == 0)
+				goto out_remove_tmp;
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+			err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
+			if (err == 0)
+				goto out_remove_tmp;
+#endif
+		}
+	}
+
+#ifdef HAVE_LIBLLVM_SUPPORT
+	err = symbol__disassemble_llvm(symfs_filename, sym, args);
+	if (err == 0)
+		goto out_remove_tmp;
+#endif
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	err = symbol__disassemble_capstone(symfs_filename, sym, args);
+	if (err == 0)
+		goto out_remove_tmp;
+#endif
+	err = symbol__disassemble_objdump(symfs_filename, sym, args);
 
 out_remove_tmp:
 	if (decomp)
-- 
2.47.0

