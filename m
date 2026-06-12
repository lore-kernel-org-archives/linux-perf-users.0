Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8A311967;
	Fri, 12 Jun 2026 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224546; cv=none; b=aKDuIunEAx5IhhP+dZQYobstsRPnS3tYXiHffJOMBClZtA3x0eemuJ+ZMc02mOrVhINbqIyH+EFTh/LuttnoZg5hRToJmGjtVC7p25/k+5pUx2I30wJDwX14Ta3WWppJ8709y9FF509b5StdBTKBXraEukyiT7/KQu/XZZc52yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224546; c=relaxed/simple;
	bh=Wns1qTj4iJ6y3TikPVR1My11XrwfVjOmF6KY5JxPYno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckoqB/X8JmKUCDq03wqLpn1WP5i0Okz0STndwQYO3hbiQS48Q61hPgK/5a+veV15t/tV3Neg2bgSU4i8myivNTcl5o7QYHwtXlY2BoHWu5OBSIU8y/0XoJwvbpVUtriq1UR7Wf4jXZVV0Bhe3gEoGxzE2BEcAPxEHSKo25v6WcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgA2X6Ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgA2X6Ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAAB1F000E9;
	Fri, 12 Jun 2026 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224544;
	bh=DJlzqQy0AVb9lKHuIP6dUlHkyuar+ckpr83w7l2O+rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cgA2X6JavR4M0eq6+k3LnjHZKJ3AH90koU4i2bCZEpVMrreGifJf3dG/RmXvsNQEH
	 9AwjrC3bSuT8cKVv6BTsI4kDgElG7Xw8d0He7T2e7tuT2M9WCpCHgExIQGuhgYwNdR
	 XjToVHh/riHeIJw4RxuL3Etfx+kNS60NtixqkAc6fCTo2c5CURgZyca8HsZunRvhFG
	 uDgu7Y8BREA7225aP9ARy+dlFqG253Q6sHJpfLGHSgCV6Jmx+bSIxDzQmkEJ/2l19r
	 7OXzkDxdQyubFHjT+DctpmJ9glNB9OgnV3/meZHd87PVq2WIeqv6XDzQD8HskHBbEs
	 eKuuFJT5Qc+GQ==
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
Subject: [PATCH 14/15] perf symbols: Add O_NONBLOCK to DSO open() calls for untrusted paths
Date: Thu, 11 Jun 2026 21:34:42 -0300
Message-ID: <20260612003444.50723-15-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

DSO paths from perf.data MMAP events could reference FIFOs, device
nodes, or other special files.  Opening such paths without O_NONBLOCK
can hang perf report/script indefinitely waiting for a writer or device.

Add O_NONBLOCK to all open() calls in the DSO symbol resolution paths:
filename__read_build_id(), filename__read_debuglink(), symsrc__init(),
do_open(), filename__decompress(), and __dso__read_symbol().

O_NONBLOCK is a no-op on regular files but prevents blocking on special
files, following the systemd "foreign file" convention.  Also add missing
O_CLOEXEC flags in symbol-minimal.c for consistency.

Fixes: a08cae03f430b971 ("perf tools: Allow to close dso fd in case of open failure")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/finding/6
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c            | 6 +++---
 tools/perf/util/symbol-elf.c     | 7 ++++---
 tools/perf/util/symbol-minimal.c | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1a2fc6d18da74d6c..dc0c8b9c63017239 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *pathname,
 	 * descriptor to the uncompressed file.
 	 */
 	if (!compressions[comp].is_compressed(name)) {
-		fd = open(name, O_RDONLY | O_CLOEXEC);
+		fd = open(name, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 		if (fd < 0)
 			*err = errno;
 		if (pathname && len > 0)
@@ -547,7 +547,7 @@ static void close_first_dso(void);
 static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	do {
-		int fd = open(name, O_RDONLY|O_CLOEXEC);
+		int fd = open(name, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
 
 		if (fd >= 0)
 			return fd;
@@ -1927,7 +1927,7 @@ static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	int saved_errno;
 
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(symfs_filename, O_RDONLY | O_CLOEXEC);
+	fd = open(symfs_filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	saved_errno = errno;
 	nsinfo__mountns_exit(&nsc);
 	if (fd < 0) {
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index dc48e2d2763379b9..01c7b09fc82bcddb 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -886,7 +886,8 @@ static int read_build_id(const char *filename, struct build_id *bid)
 	if (size < BUILD_ID_SIZE)
 		goto out;
 
-	fd = open(filename, O_RDONLY | O_CLOEXEC);
+	/* O_NONBLOCK avoids hangs on FIFOs/devices from crafted perf.data paths */
+	fd = open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	if (fd < 0)
 		goto out;
 
@@ -1022,7 +1023,7 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	if (err >= 0)
 		goto out;
 
-	fd = open(filename, O_RDONLY | O_CLOEXEC);
+	fd = open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	if (fd < 0)
 		goto out;
 
@@ -1187,7 +1188,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 
 		type = dso__symtab_type(dso);
 	} else {
-		fd = open(name, O_RDONLY | O_CLOEXEC);
+		fd = open(name, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 		if (fd < 0) {
 			*dso__load_errno(dso) = errno;
 			return -1;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index ea2de3d50d33cf33..dc4a06b2a03ad3cb 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -118,7 +118,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	if (!is_regular_file(filename))
 		return errno == 0 ? -EWOULDBLOCK : -errno;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	if (fd < 0)
 		return -1;
 
@@ -234,7 +234,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 	char buf[BUFSIZ] __aligned(4);
 	ssize_t len;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	if (fd < 0)
 		return -1;
 
@@ -257,7 +257,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	         enum dso_binary_type type)
 {
-	int fd = open(name, O_RDONLY);
+	int fd = open(name, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	if (fd < 0)
 		goto out_errno;
 
-- 
2.54.0

