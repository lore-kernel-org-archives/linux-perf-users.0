Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB63E95AE;
	Mon,  8 Jun 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949908; cv=none; b=mlysVF6I09ycQIbzL4lsrFAQYvvQFg1h8EiKKlqTzzMfar5aZA3xqwealpusz2wEIu+eMiA0O/225RwzAZXasQHoGJJn6pbAvzUp/2OWHCiFifDAz0a7i8I6egaG9FF2K2yrvXzwVafap1eKU8AJf3q/ROyT/1QQyobPpr5Sq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949908; c=relaxed/simple;
	bh=GmlkmpwNEIyUNU99GBS/vYd9JNh9cxHwCEU0fxnK4Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6Dc9ll8PLot4yCIya/auDuwf88LGuLmublZq9yrIOJmlClYNIFTJA0sYmf6xNwqXnM4R9t2VIH9JYBjJ/fCkDBUhSEiFqmf7tK6UGPkTs28+dY8x/iGelJYPPRjAfIjdDAohlnlrPJ6c7OBo4lNFVNFxG96X+gxMX27TtxlxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwD5GIP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwD5GIP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01451F00898;
	Mon,  8 Jun 2026 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949907;
	bh=xsbh6otPSU9/W94kKgL0+/butihCxeIySCs04NABBLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwD5GIP+sDgLiRThGe94tE6xig6zzDXXRpqLKLPvTjaIex69wAFtHm5LLz7ZLWSjJ
	 huJsB1Wfv30D2GUMdPh7MpGTWdK3wXqmVs+etmzwSMKG7+JC0MXphOSg+10cAQvAWK
	 gH3Mnbn+d5ZmUOzfieQBRQ1Ap/1XKVCEYrmIJn0RXEnQXFcqUVQzswznyu9DI+ksJ2
	 w9GAtQ7F6BUptoNPI64GopJgvTig5xXhbwZUkfIGREnrCIXABpTTM36GED+xSt7v7y
	 x8IbTRgAfHQVVIimeHueUdVYEz30VO830ofhoIJVTsflifT4tjEGlsU8gzg0p8ri+O
	 r8ZLSMXDzv3pQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 07/11] perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code
Date: Mon,  8 Jun 2026 17:17:47 -0300
Message-ID: <20260608201753.1979464-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

open() calls in dso.c and symbol-elf.c omit O_CLOEXEC, which leaks
file descriptors to child processes spawned during symbol resolution
(e.g., addr2line, objdump).  This can exhaust the fd limit during
long profiling sessions or when processing many DSOs.

Add O_CLOEXEC to all open() calls in both files (12 call sites).

Fixes: cdd059d731eeb466 ("perf tools: Move dso_* related functions into dso object")
Fixes: e5a1845fc0aeca85 ("perf symbols: Split out util/symbol-elf.c")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c        |  4 ++--
 tools/perf/util/symbol-elf.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 7dced896c64eafd7..fb2e78fe2aa8eb94 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *pathname,
 	 * descriptor to the uncompressed file.
 	 */
 	if (!compressions[comp].is_compressed(name))
-		return open(name, O_RDONLY);
+		return open(name, O_RDONLY | O_CLOEXEC);
 
 	fd = mkstemp(tmpbuf);
 	if (fd < 0) {
@@ -1911,7 +1911,7 @@ static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	int saved_errno;
 
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(symfs_filename, O_RDONLY);
+	fd = open(symfs_filename, O_RDONLY | O_CLOEXEC);
 	saved_errno = errno;
 	nsinfo__mountns_exit(&nsc);
 	if (fd < 0) {
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 186e6d92ac3d7742..c2bdfd0003df2abe 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -217,7 +217,7 @@ bool filename__has_section(const char *filename, const char *sec)
 	GElf_Shdr shdr;
 	bool found = false;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		return false;
 
@@ -872,7 +872,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 	if (size < BUILD_ID_SIZE)
 		goto out;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		goto out;
 
@@ -935,7 +935,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 	size_t size = sizeof(bid->data);
 	int fd, err = -1;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		goto out;
 
@@ -995,7 +995,7 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	if (err >= 0)
 		goto out;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		goto out;
 
@@ -1153,7 +1153,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 
 		type = dso__symtab_type(dso);
 	} else {
-		fd = open(name, O_RDONLY);
+		fd = open(name, O_RDONLY | O_CLOEXEC);
 		if (fd < 0) {
 			*dso__load_errno(dso) = errno;
 			return -1;
@@ -1952,7 +1952,7 @@ static int kcore__open(struct kcore *kcore, const char *filename)
 {
 	GElf_Ehdr *ehdr;
 
-	kcore->fd = open(filename, O_RDONLY);
+	kcore->fd = open(filename, O_RDONLY | O_CLOEXEC);
 	if (kcore->fd == -1)
 		return -1;
 
@@ -1985,7 +1985,7 @@ static int kcore__init(struct kcore *kcore, char *filename, int elfclass,
 	if (temp)
 		kcore->fd = mkstemp(filename);
 	else
-		kcore->fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400);
+		kcore->fd = open(filename, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0400);
 	if (kcore->fd == -1)
 		return -1;
 
@@ -2461,11 +2461,11 @@ static int kcore_copy__compare_files(const char *from_filename,
 {
 	int from, to, err = -1;
 
-	from = open(from_filename, O_RDONLY);
+	from = open(from_filename, O_RDONLY | O_CLOEXEC);
 	if (from < 0)
 		return -1;
 
-	to = open(to_filename, O_RDONLY);
+	to = open(to_filename, O_RDONLY | O_CLOEXEC);
 	if (to < 0)
 		goto out_close_from;
 
@@ -2883,7 +2883,7 @@ int get_sdt_note_list(struct list_head *head, const char *target)
 	Elf *elf;
 	int fd, ret;
 
-	fd = open(target, O_RDONLY);
+	fd = open(target, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		return -EBADF;
 
-- 
2.54.0

