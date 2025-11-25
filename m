Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE71230BD5;
	Tue, 25 Nov 2025 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058069; cv=none; b=n/WVZbxQBs21QvO+YMGg1Pk6iRIq4J9cPhea4DZ99xWb7BSJV4/QuJCyq0kw/Gc7x5zVIz34n8lZZV9YetKnqcuxFW8/1k41d66bH67cK5EKAncKbrJ9BN3XdbDfSmR25jUU2xgmCMD+bLHESOseYktXPlXQmba3+N8yZNXPnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058069; c=relaxed/simple;
	bh=gnK25BO6MmTaG9o7ZGaqsLRWbVERrF9peN8MVb8f3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fB+s0xsHxF/08Ju61+W3knDDw4BnLkhC/IiMxtCEElbTJuNVftwxXhWphLDlvzStprvzv8qNo60XkGc0eg4lv36yYMrlyAtqdFbxZkaXtoTzoAKeoSZnWmw+b+wT9DOvxDvSqdFpMphmB+6CwpI+Mv6BI9mveVyto9jmQ1GUySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZXiKVPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZXiKVPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3836C4CEF1;
	Tue, 25 Nov 2025 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764058069;
	bh=gnK25BO6MmTaG9o7ZGaqsLRWbVERrF9peN8MVb8f3Es=;
	h=From:To:Cc:Subject:Date:From;
	b=QZXiKVPx+L+X++73fYp5a/t5efivq5GHETVXIm3aEH0bdliSyFfdBlrbQbalczPIl
	 4uGRdEG33BTqldPPuYzLd1abEOKz+XhJUgSHJKuXP+m42XwHm4MiAQO1/7WdlqEadl
	 jdWjki3uWuGTZzpZADfFISbl8Cuaa40BhI292Dna6ZNR5Hvgczi3SbdvOLSkYiAWTu
	 g6A+i+iNQsRCStGTpazDVjEXBt59AHfCukkYUMJIhiKHg+QMjPzGICjFH11rGOwrE1
	 5i+vTITQuW5REO/aWXoAmu3VgYXkG4xqlp6wqhW8OhURE552lDQrruFZYPB2DRSfj3
	 1YX6SSToiU3yw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Pablo Galindo <pablogsal@gmail.com>,
	Fangrui Song <maskray@sourceware.org>
Subject: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID generation
Date: Tue, 25 Nov 2025 00:07:46 -0800
Message-ID: <20251125080748.461014-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that python backtrace with JIT dump was broken after the
change to built-in SHA-1 implementation.  It seems python generates the
same JIT code for each function.  They will become separate DSOs but the
contents are the same.  Only difference is in the symbol name.

But this caused a problem that every JIT'ed DSOs will have the same
build-ID which makes perf confused.  And it resulted in no python
symbols (from JIT) in the output.

Looking back at the original code before the conversion, it used the
load_addr as well as the code section to distinguish each DSO.  But it'd
be better to use contents of symtab and strtab instead as it aligns with
some linker behaviors.

This patch adds a buffer to save all the contents in a single place for
SHA-1 calculation.  Probably we need to add sha1_update() or similar to
update the existing hash value with different contents and use it here.
But it's out of scope for this change and I'd like something that can be
backported to the stable trees easily.

Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Pablo Galindo <pablogsal@gmail.com>
Cc: Fangrui Song <maskray@sourceware.org>
Link: https://github.com/python/cpython/issues/139544
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) use symtab/strtab instead of load_addr

 tools/perf/util/genelf.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 591548b10e34ef6a..a1cd5196f4ec8f88 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -173,6 +173,8 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	Elf_Shdr *shdr;
 	uint64_t eh_frame_base_offset;
 	char *strsym = NULL;
+	void *build_id_data = NULL, *tmp;
+	int build_id_data_len;
 	int symlen;
 	int retval = -1;
 
@@ -251,6 +253,14 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
 	shdr->sh_entsize = 0;
 
+	build_id_data = malloc(csize);
+	if (build_id_data == NULL) {
+		warnx("cannot allocate build-id data");
+		goto error;
+	}
+	memcpy(build_id_data, code, csize);
+	build_id_data_len = csize;
+
 	/*
 	 * Setup .eh_frame_hdr and .eh_frame
 	 */
@@ -334,6 +344,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	shdr->sh_entsize = sizeof(Elf_Sym);
 	shdr->sh_link = unwinding ? 6 : 4; /* index of .strtab section */
 
+	tmp = realloc(build_id_data, build_id_data_len + sizeof(symtab));
+	if (tmp == NULL) {
+		warnx("cannot allocate build-id data");
+		goto error;
+	}
+	memcpy(tmp + build_id_data_len, symtab, sizeof(symtab));
+	build_id_data = tmp;
+	build_id_data_len += sizeof(symtab);
+
 	/*
 	 * setup symbols string table
 	 * 2 = 1 for 0 in 1st entry, 1 for the 0 at end of symbol for 2nd entry
@@ -376,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	shdr->sh_flags = 0;
 	shdr->sh_entsize = 0;
 
+	tmp = realloc(build_id_data, build_id_data_len + symlen);
+	if (tmp == NULL) {
+		warnx("cannot allocate build-id data");
+		goto error;
+	}
+	memcpy(tmp + build_id_data_len, strsym, symlen);
+	build_id_data = tmp;
+	build_id_data_len += symlen;
+
 	/*
 	 * setup build-id section
 	 */
@@ -394,7 +422,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	/*
 	 * build-id generation
 	 */
-	sha1(code, csize, bnote.build_id);
+	sha1(build_id_data, build_id_data_len, bnote.build_id);
 	bnote.desc.namesz = sizeof(bnote.name); /* must include 0 termination */
 	bnote.desc.descsz = sizeof(bnote.build_id);
 	bnote.desc.type   = NT_GNU_BUILD_ID;
@@ -439,7 +467,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	(void)elf_end(e);
 
 	free(strsym);
-
+	free(build_id_data);
 
 	return retval;
 }
-- 
2.52.0.460.gd25c4c69ec-goog

