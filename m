Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C125474F;
	Fri, 12 Jun 2026 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224503; cv=none; b=lQoXc7vFfS8ffkqk3HttMCHvdkTQbIOL99pHaGPxX2x/Pz9KXKjhR5ulK8F36JXB9UTDRKMmzqCW6/afMSK5v5So08PZ+rTH48EpbGW23R75oEWtgncvjR+yBItNUSUiijJZLZbP+B6ad/VSo7JaUylSEg1RSso3XfE8yMuxDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224503; c=relaxed/simple;
	bh=zRghm0ZnIZquq0T/+HsVTaGZYBC4Cl29UnPC/GAiSJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYSZ+ADux3CR64/u2IiLO6Q60VOojvM1PFS+siIidZTjNYcufIwgUpXcywPWnIFLdVfObmJVZ8d/SxD8YXg35A31H2zjF23EMRw2iJ0UYbpy0Fo1R/eITfhDOx6WL2LVci8+s9JnMUMPSuI4to8zabp+dXnA91/5z+ekLRKCg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOuhRsRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOuhRsRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41741F00A3A;
	Fri, 12 Jun 2026 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224502;
	bh=RRGLbVjAcQuHTfUXZdSHWo9FaFPTQP7iXyHvQdrYWBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oOuhRsRDob0A2KG+VoRZS6BoiWkLtN84Q6v5KahHICu2cAMCZ/8YJgul5ESUSidP4
	 gMoPLiBjt51GiSaH3fND9nbeuAqt5cXfaL7LaJKFlUbuGfPDdX/V0tZZMwfdmy+Zrb
	 bs8hi0xJ10B1VZG7NNUKN2yIzE6ehpT5OuoesU5RbQ4x2J9jpL2fZVzjbribnHMNFu
	 S1RKeMBz0mwPu+j0XT09ngNSE4mviWy1BHBx2cPQgkvSyOQzGmrjZwfZVylTEzRoww
	 gdH1jUkwqNIvAcaFT/WW2Vc4HhGggtp/o/PbhH2P0c1DiE6mOlfmQhXa87ff83mi91
	 uI64fFAs8XBhQ==
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
Subject: [PATCH 03/15] perf symbols: Use fixed buffer in sysfs__read_build_id() for no-libelf build
Date: Thu, 11 Jun 2026 21:34:31 -0300
Message-ID: <20260612003444.50723-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

sysfs__read_build_id() in the no-libelf build path uses fstat() to get
the file size and then allocates an exact-sized buffer.  Sysfs pseudo-
files (/sys/kernel/notes) often report st_size=0 or a page-sized value
(4096) regardless of actual content.  When st_size is 0, malloc(0)
returns a zero-sized allocation and read(fd, buf, 0) returns 0, which
matches the expected (ssize_t)buf_size check, then read_build_id() is
called with a zero-length buffer and never finds any notes.

Replace the fstat + malloc approach with a fixed BUFSIZ stack buffer and
a single read(), matching the strategy used by the libelf-based
sysfs__read_build_id() in symbol-elf.c.  This also eliminates the
malloc/free overhead for what is always a small sysfs file.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: b691f64360ecec49 ("perf symbols: Implement poor man's ELF parser")
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-minimal.c | 41 +++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 0a71d146395271a6..ea2de3d50d33cf33 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -220,29 +220,36 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 {
 	int fd;
 	int ret = -1;
-	struct stat stbuf;
-	size_t buf_size;
-	void *buf;
+	/*
+	 * read_build_id() casts this buffer to a u32 note header pointer,
+	 * so it must be aligned for u32 access.
+	 *
+	 * Accessing a char[] through a u32* is technically type-punning
+	 * under C strict aliasing rules, but perf unconditionally builds
+	 * with -fno-strict-aliasing (Makefile.config), so this is safe.
+	 *
+	 * This file is only compiled when libelf is not available — the
+	 * common case uses the libelf-based path in symbol-elf.c instead.
+	 */
+	char buf[BUFSIZ] __aligned(4);
+	ssize_t len;
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		return -1;
 
-	if (fstat(fd, &stbuf) < 0)
-		goto out;
-
-	buf_size = stbuf.st_size;
-	buf = malloc(buf_size);
-	if (buf == NULL)
-		goto out;
-
-	if (read(fd, buf, buf_size) != (ssize_t) buf_size)
-		goto out_free;
+	/*
+	 * Use a fixed buffer and a single read() instead of fstat() + malloc(),
+	 * because sysfs pseudo-files often report st_size=0 or 4096
+	 * regardless of actual content size.
+	 *
+	 * BUFSIZ (8192) is more than sufficient: a sysfs build-id note is
+	 * ~36 bytes (12-byte note header + 4-byte "GNU" name + 20-byte SHA1).
+	 */
+	len = read(fd, buf, sizeof(buf));
+	if (len > 0)
+		ret = read_build_id(buf, len, bid, false);
 
-	ret = read_build_id(buf, buf_size, bid, false);
-out_free:
-	free(buf);
-out:
 	close(fd);
 	return ret;
 }
-- 
2.54.0

