Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569910;
	b=eNHtnbXbSVWbZrxvjzMH8sSsyiS7fWvjScRBdTpaUYFpXXcItgcm/u4jXZbLRNaxA0cz
	 Usv+Mk21pPHE4IcVMm6MX5D5Wrs1dqSHgP0a2VCQaXbFw2xF6ot/28jBZZ8+WnW929C1I
	 6d1XZaYJ2j1V7GTXj9/rralJusJlSfb6OJTcHIYZhZNSZXUkQV9a2f4fH4qm63IT2OjkT
	 iaodHTLCGEOSFBNUvpnE5lnaDQmrpICmwE1v3MeYwFw7T+/9CERbkYVRQ/rFLbviCeDb0
	 otlHk0/+BntJ/nmh0FyfW189f5+H3raWmqiN/IfwI0b0ll4ynvzUUjBLyExuGKKMkmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MahiC7D0ZIOhMz97xWmjX00QeVr1A1IECgnuiT+EXIk=;
	b=4irh/mlvRZ85D/TiIMtLPwk93MaDRCH7tjzxCg88C23UvYEgztr1wcjl7ZjqPdAob0l2
	 aLiSEPJrSRBc4/1jXJI2g6/MqRfcQnoA5jQYGERZrxHugXY3qgt4B7+PxmChpGH9TZQM3
	 tjtVHaprkNU7PnOFSLB+L8BR370ZGqd6Dmh7aKR2KwLCIPQIwJW9sZPcipBHKewi1DwfA
	 lpcZpVQIjgrMnpGvXIo8TCh2ywWr1gD9Zq2ZSgo63uCFzOFxK9N5R/3FvhJYdWiM7ANAg
	 GXlIw8VMLRussXHNV/CJE9LQQeSnvPKn+HeFx2mzUwJrwk4O94jbMvx+G7iDOOCTGoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgvYsuQ2;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25998606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 01:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25998606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgvYsuQ2
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc53938a8fso3506291137.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795569909; x=1796174709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MahiC7D0ZIOhMz97xWmjX00QeVr1A1IECgnuiT+EXIk=;
        b=kgvYsuQ2Y1nixBlcyPnIyAQh3I9ZSoM6dKjIOvDumigk/uw1wooptga00DkPz89q4L
         VdJy1S/+GSfiMFTafI2KgPha+2nHdQdFutbp3qWZowXir/kAiuMV4cyphjN4Bv+NCvfo
         etJDQGAgwowYscTJX52Qbgv0psIniZFw4yD31wq0aDQRAQ09fIcg/+PmO62LlYOc2yrW
         lli41aEY9Vmk5Js5f7QQnJKNxA96isKb58gxQYxeXeasjOekOduE5ADWWY/GT257GFjQ
         FU7lnJfRZtPux0mXci3Umfo/+MONcMjROdaPyIc72AkHPKbW9lFe8BaeV3DTAf+pqE9f
         ZJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795569909; x=1796174709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MahiC7D0ZIOhMz97xWmjX00QeVr1A1IECgnuiT+EXIk=;
        b=M15rCbu/8TapZIbOV3BVjgCp73SwJ2VQrdRO27xb1jw7JICRyK+iJFWdF3nHBul18f
         bWTi3uDZadPlir2rynGJ4Zc41oYDWE+sYE1h6LuLmmyWydvXTzSxBjxVfKOerB67Htdj
         1K2hbrfAayrwn4wKjEm49aVdceJSR0fSH+2IYnHHmgwFXaxUQoT/czahrGljlDmS1oEl
         YT5tJPInJpHMzpI8kxbojnlDEFepUcq2QSIsl770wc5fd3jUtscTSx52b7OKUYHwjOyl
         L3MyBydrrWe/CwA/MCzK5T8osDlxGyGF/PzA7fcbeuCYvqkCEdJ5xOJicw/WiRNLR1Tt
         K/EQ==
X-Forwarded-Encrypted: i=1; AL+hErFE4hLGb8VqfbLCA1qTr/DHGpPlBy9/DoEro7wyIzHFvfvrX4o/JM05zNJpRWm8O2i6dX+xfIQJg+DORdFwCCe5@vger.kernel.org
X-Gm-Message-State: APuU4Z+ahvHtU+cQjZdGBQRIAX8QcDlFfkn5WE9SYbGfnm5OsKnFtM+1
	sOASJCqqJXFCmli+DzFqshWTCGkIsbUF0rr/UBHubZSzX+u0dXDYSDz5
X-Gm-Gg: AZFdTZeaHBXMBtwUyorEvA2V7fTzaowgU0kKpVR72mFHj8WnbrqRKnxwCWrVnHPxpKx
	cTEjuJvLE+E+8qGWtEPZsU29FhtAvEXpKqu3eZqx+MdjhA2+sD4QCUOnVrIf5KWgM7i42aKl1mv
	4NwQ85BPed0YKWAwYJ6q+AJE1yH2elctAIehbQqY/tYCTPy3wxPWnq3bZktuMyw1hIipnsgGPlm
	0QT+xYl6aLZTBWgGbCB8jKmC8VHyDu/w8lJOgHWr1U+SO7aeyWXLc91ffwyTwDfOXyxB1XzVgUF
	0QdeZ8DGddxVH/LFmvip5ZOTwxYbU/zSTD0dOKjfqIedMu0SbbOrAPvNCd/pMHyL7c6am4NEGSG
	bWQ9TdCzdqDK/t9CitUr0Uj1zq8xCTreIMzEZZQF3FEmbhyud2lzXuj2u58ci6S5dLHR7HcYvUf
	VhW5zVGCdv5kROkKEuaWG/qdg89HHMmunCpPjMpX4jrm03qDeZn2OT36f5Z13MdHyZFsQF5cIx8
	Gno/Oxnk4SbeEg/gh+yZBSuyf1YTqxnereCc+zXP9XkxmB+m90DIAWTBbA89FmPjR2lvJ5yrZAR
	bHQl8N+biuRwrKYIeEmUrNll0aWphnEXS11cOPttHGKYLS3UnuMbbn9t9lPTmcb0mPsOssCbOBP
	MDD/URVeMexBrABOvn8E9soH3AThiejB07ErQe7AFQ+KcsC9A4lL4Q8vZrj6NRkYDZZXotcMUzc
	bE8YAdxwhtU0M=
X-Received: by 2002:a05:6102:4245:b0:7ab:af4a:f2f3 with SMTP id ada2fe7eead31-7d739628997mr9588366137.26.1795569908929;
        Tue, 24 Nov 2026 17:25:08 -0800 (PST)
Received: from omarchy-jonathan.taildd0689.ts.net ([2800:40:33:a58e:d6f4:f4fd:c31f:7b1e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7d784b3sm16838329137.2.2026.11.24.17.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:25:07 -0800 (PST)
From: Jonathan Goyvaerts <jonathan.goyvaerts@gmail.com>
To: Ivan Shapovalov <intelfx@intelfx.name>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf: support zstd-compressed kernel modules
Date: Tue, 24 Nov 2026 22:24:39 -0300
Message-ID: <20261125012441.391214-1-jonathan.goyvaerts@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <auwQRrlxzuTg4dDN@z2>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name> <auwQRrlxzuTg4dDN@z2>
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

On Wed, Nov 04, 2026 at 09:12:38PM -0800, Namhyung Kim wrote:
> Can you please address comments from Sashiko and the bot?

Ivan, in case it saves you time: the diff below goes on top of v1 and
addresses those comments, plus a few more things I ran into. Please
fold it into v2 as you see fit; if you take it as is, a
Co-developed-by: with my Signed-off-by: is fine with me.

For the Sashiko and LKP reports:

- 4/4: step back by 3 (".ko") again, so .ko.gz and .ko.xz are modules
  again. This is also the LKP kmod_path__parse failure.
- 2/4: zstd_decompress_buffer() returns 0, not SIZE_MAX, when the
  stream can't be set up.
- 3/4: zstd_is_compressed() returns false when open() fails, and
  compares the magic as bytes, like gzip_is_compressed() does, so it
  needs no htole32() or <endian.h>.
- 1/4: the comment in perf_session__process_compressed_event() names
  zstd_decompress_buffer().

Not in those reports:

- 3/4: the !HAVE_ZSTD_SUPPORT stubs need __maybe_unused, or the
  make_minimal build (NO_LIBZSTD=1) fails with
  -Werror=unused-parameter.
- 3/4: the ZSTD_DStream{In,Out}Size() buffers are 256 KiB of VLAs on
  the stack. perf top decompresses modules on process_thread, which
  gets the default thread stack: 128 KiB on musl. With the stack
  limited by "ulimit -s 256", "perf buildid-cache -a asahi.ko.zst"
  segfaults with v1. With fixed 16 KiB buffers it works down to
  "ulimit -s 128".
- Tests: .ko.zst cases for kmod_path__parse, and a .ko.zst case in
  the build id cache shell test. The latter fails without the series
  and also feeds it a truncated file.
- Makefile.perf: the NO_LIBZSTD comment mentions modules.

Tested on arm64 (Arch Linux ARM, glibc, libzstd 1.5.7), where every
module is .ko.zst, with tools/perf as at v1's base-commit
0fcb05b72344f plus v1 and this diff:

- "perf buildid-cache -a asahi.ko.zst" adds the module.
- A "perf record -a -g" stores the .ko.zst paths and the module build
  ids, and perf script resolves all 3054 frames in the asahi module,
  also with an empty build id cache. Without the series all of them
  are [unknown].
- perf test: DSO data, kmod_path__parse, Symbols, build id cache
  operations and both Zstd tests pass.
- The default build and the make_minimal flag set from tests/make
  build.

Not done:

- Only arm64: no x86, 32-bit or big-endian build.
- Not tried on current perf-tools-next.
- .ko.gz and .ko.xz only through kmod_path__parse, not at runtime.
- Not the full perf test suite.
- The musl stack overflow is shown with ulimit on glibc, not on musl.
- On a truncated .ko.zst the loop ends with libzstd's "no progress"
  error; only libzstd 1.5.7 was tried.

An LLM coding assistant wrote this diff and drafted this mail. I asked
it to make perf read the .ko.zst modules on my machine. It found v1 on
lore, applied it, worked through the Sashiko and LKP reports, found
the rest with checkpatch.pl, perf's own tests and a live profile, and
wrote the fixes and tests. I have reviewed the diff and the test
results.

Thanks for the series,
Jonathan

Assisted-by: LLM
Signed-off-by: Jonathan Goyvaerts <jonathan.goyvaerts@gmail.com>
---
 tools/perf/Makefile.perf          |  4 ++--
 tools/perf/tests/kmod-path.c      | 21 ++++++++++++++++
 tools/perf/tests/shell/buildid.sh | 40 +++++++++++++++++++++++++++++++
 tools/perf/util/compress.h        |  9 ++++---
 tools/perf/util/dso.c             |  2 +-
 tools/perf/util/tool.c            |  2 +-
 tools/perf/util/zstd.c            | 31 ++++++++++++++----------
 7 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 29cfd44c427f3..0d77f1aa0731e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -106,8 +106,8 @@ include ../scripts/utilities.mak
 # streaming for record mode. Currently Posix AIO trace streaming is
 # supported only when linking with glibc.
 #
-# Define NO_LIBZSTD if you do not want support of Zstandard based runtime
-# trace compression in record mode.
+# Define NO_LIBZSTD if you do not want support of Zstandard based kernel
+# module decompression and runtime trace compression in record mode.
 #
 # Define TCMALLOC to enable tcmalloc heap profiling.
 #
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index dfe1bd5dabaa8..aacb49fbc9e4a 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -96,6 +96,27 @@ static int test__kmod_path__parse(struct test_suite *t __maybe_unused, int subte
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
 #endif
 
+#ifdef HAVE_ZSTD_SUPPORT
+	/* The zst id is its index in compressions[], after gz and xz */
+#if defined(HAVE_ZLIB_SUPPORT) && defined(HAVE_LZMA_SUPPORT)
+#define ZST_COMP 3
+#elif defined(HAVE_ZLIB_SUPPORT) || defined(HAVE_LZMA_SUPPORT)
+#define ZST_COMP 2
+#else
+#define ZST_COMP 1
+#endif
+	/* path                    alloc_name kmod   comp      name */
+	T("/xxxx/xxxx/x-x.ko.zst", true,      true,  ZST_COMP, "[x_x]");
+	T("/xxxx/xxxx/x-x.ko.zst", false,     true,  ZST_COMP, NULL);
+	M("/xxxx/xxxx/x-x.ko.zst", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
+	M("/xxxx/xxxx/x-x.ko.zst", PERF_RECORD_MISC_KERNEL, true);
+	M("/xxxx/xxxx/x-x.ko.zst", PERF_RECORD_MISC_USER, false);
+
+	T("/xxxx/xxxx/x.zst",      true,      false, ZST_COMP, "x.zst");
+	T("/xxxx/xxxx/x.zst",      false,     false, ZST_COMP, NULL);
+	M("/xxxx/xxxx/x.zst",      PERF_RECORD_MISC_KERNEL, false);
+#endif
+
 	/* path            alloc_name  kmod  comp   name           */
 	T("[test_module]", true      , true, false, "[test_module]");
 	T("[test_module]", false     , true, false, NULL           );
diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index 102808cca9db3..2aca6dfc11b6f 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -44,9 +44,11 @@ ex_pe=$(dirname $0)/../pe-file.exe
 data=$(mktemp /tmp/perf_buildid_test.data.XXX)
 log_out=$(mktemp /tmp/perf_buildid_test.log.out.XXX)
 log_err=$(mktemp /tmp/perf_buildid_test.log.err.XXX)
+kmod_dir=$(mktemp -d /tmp/perf_buildid_test.kmod.XXX)
 
 cleanup() {
 	rm -f ${ex_source} ${ex_md5} ${ex_sha1} ${data} ${log_out} ${log_err}
+	rm -rf ${kmod_dir}
 	if [ ${run_pe} -eq 1 ]; then
 		rm -r ${wineprefix}
 	fi
@@ -198,6 +200,43 @@ test_add()
 	rm -rf ${build_id_dir}
 }
 
+# perf has to decompress a .ko.zst module to read its build id
+test_add_zst()
+{
+	if ! perf version --build-options | grep -q 'zstd: .* on '; then
+		echo "WARNING: perf not built with zstd. .ko.zst modules will not be tested."
+		return
+	fi
+	if ! [ -x "$(command -v zstd)" ]; then
+		echo "WARNING: zstd not found. .ko.zst modules will not be tested."
+		return
+	fi
+
+	build_id_dir=$(mktemp -d /tmp/perf_buildid_test.debug.XXX)
+	perf="perf --buildid-dir ${build_id_dir}"
+
+	# any ELF file with a build id will do as the module
+	zstd -q -c ${ex_sha1} > ${kmod_dir}/ex.ko.zst
+	head -c 100 ${kmod_dir}/ex.ko.zst > ${kmod_dir}/truncated.ko.zst
+
+	id=$(get_build_id ${ex_sha1})
+	${perf} buildid-cache -v -a ${kmod_dir}/ex.ko.zst
+	if ! ${perf} buildid-cache -l | grep -q ${id}; then
+		echo "failed: ${id} of ${kmod_dir}/ex.ko.zst not in cache"
+		exit 1
+	fi
+
+	# must fail without hanging; buildid-cache -a only warns on failure
+	${perf} buildid-cache -v -a ${kmod_dir}/truncated.ko.zst
+	if [ "$(${perf} buildid-cache -l | wc -l)" -ne 1 ]; then
+		echo "failed: truncated ${kmod_dir}/truncated.ko.zst was added"
+		exit 1
+	fi
+
+	echo "add .ko.zst: OK"
+	rm -rf ${build_id_dir}
+}
+
 test_remove()
 {
 	build_id_dir=$(mktemp -d /tmp/perf_buildid_test.debug.XXX)
@@ -304,6 +343,7 @@ test_add ${ex_md5}
 if [ ${add_pe} -eq 1 ]; then
 	test_add ${ex_pe}
 fi
+test_add_zst
 
 # add binaries via perf record post processing
 test_record ${ex_sha1}
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index fd6b541358bb6..c455686653907 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -92,17 +92,20 @@ static inline size_t zstd_decompress_buffer(struct zstd_data *data __maybe_unuse
 	return 0;
 }
 
-static inline int zstd_decompress_stream(struct zstd_data *data, int input_fd, int output_fd)
+static inline int zstd_decompress_stream(struct zstd_data *data __maybe_unused,
+					 int input_fd __maybe_unused,
+					 int output_fd __maybe_unused)
 {
 	return -1;
 }
 
-static inline int zstd_decompress_to_fd(const char *input, int output_fd)
+static inline int zstd_decompress_to_fd(const char *input __maybe_unused,
+					int output_fd __maybe_unused)
 {
 	return -1;
 }
 
-static inline bool zstd_is_compressed(const char *input)
+static inline bool zstd_is_compressed(const char *input __maybe_unused)
 {
 	return false;
 }
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 0e8886172e239..fbc58283ef658 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -463,7 +463,7 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 
 	m->comp = is_supported_compression(ext + 1);
 	if (m->comp > COMP_ID__NONE)
-		ext -= strlen(compressions[m->comp].fmt);
+		ext -= 3;
 
 	/* Check .ko extension only if there's enough name left. */
 	if (ext > name)
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index d7956cd75c26d..dd8be27f57209 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -93,7 +93,7 @@ static int perf_session__process_compressed_event(const struct perf_tool *tool _
 		 * data_size is independent of header.size (which
 		 * includes padding); verify it doesn't exceed the
 		 * actual payload to prevent out-of-bounds reads in
-		 * zstd_decompress_stream().
+		 * zstd_decompress_buffer().
 		 */
 		if (src_size > event->header.size - sizeof(struct perf_record_compressed2))
 			goto err_decomp;
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 982655a1f1a51..a063a680518cd 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -2,6 +2,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <stdint.h>
 #include <string.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
@@ -143,13 +144,12 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t src_size,
 			      void *dst, size_t dst_size)
 {
-	ssize_t ret;
+	size_t ret;
 	ZSTD_inBuffer input = { src, src_size, 0 };
 	ZSTD_outBuffer output = { dst, dst_size, 0 };
 
-	ret = zstd_init_dstream(data);
-	if (ret < 0)
-		return ret;
+	if (zstd_init_dstream(data) < 0)
+		return 0;
 
 	while (input.pos < input.size) {
 		size_t prev_in = input.pos;
@@ -177,12 +177,18 @@ size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t src_size
 	return output.pos;
 }
 
+/*
+ * Not ZSTD_DStream{In,Out}Size(): 256 KiB of stack is more than a musl
+ * thread gets, and perf top decompresses modules on a thread.
+ */
+#define CHUNK_SIZE 16384
+
 int zstd_decompress_stream(struct zstd_data *data, int input_fd, int output_fd)
 {
 	ssize_t ret;
 	bool unflushed = false;
-	char buf_in[ZSTD_DStreamInSize()];
-	char buf_out[ZSTD_DStreamOutSize()];
+	char buf_in[CHUNK_SIZE];
+	char buf_out[CHUNK_SIZE];
 	ZSTD_inBuffer in = {};
 	ZSTD_outBuffer out = {};
 
@@ -262,17 +268,16 @@ int zstd_decompress_to_fd(const char *input, int output_fd)
 bool zstd_is_compressed(const char *file)
 {
 	int fd = open(file, O_RDONLY);
-	const uint32_t magic_le = htole32(ZSTD_MAGICNUMBER);
-	char buf[4];
+	/* ZSTD_MAGICNUMBER as stored in the file (little-endian) */
+	const uint8_t magic[4] = { 0x28, 0xb5, 0x2f, 0xfd };
+	char buf[4] = { 0 };
 	ssize_t rc;
 
-	if (fd < 0) {
-		pr_err("zstd: failed to open(%s): %s\n", file, strerror(errno));
-		return -1;
-	}
+	if (fd < 0)
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
 	return rc == sizeof(buf) ?
-	       memcmp(buf, (const char *) &magic_le, sizeof(buf)) == 0 : false;
+	       memcmp(buf, magic, sizeof(buf)) == 0 : false;
 }
