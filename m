Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DD2C21F2;
	Sun, 24 May 2026 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593375; cv=none; b=JobPA/pG/5yb9RJ9SGV3rfa7D+btNykUg1relT1go2tJ0fYN1Dd1V7dMm9PP9YewdNwPS2ikMgD0GNl2b7UMhnWmHmzJUPWGANOVFB9wO5CUeQcw2fbBxSUWOm4j8rw+I/Wt11dJ4NB5s1VPmihFjCBLZ9p0n/cJYOmsozwXmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593375; c=relaxed/simple;
	bh=4Gx/YOP+aPiLksa1FfKwabV409iw61JsiNi5SjAUU40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcdnovcHo+1eKde99DqAmJqUzm9pFamGtiofL97cErj5lOjq2N6HEPcO1pKuV3sheduzRTtFcQu00XN22qHi8Lz/k7X/iSc5OAnsUY9tLLx/ymEibNQ3iTTaMZtgijxmtUs3jQUCK8Lc4C6qzrBWAGSXqJ7JE2QObw+vSsfv3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egCHQ26+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egCHQ26+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE351F000E9;
	Sun, 24 May 2026 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593374;
	bh=ZzhQFO3HW842N3AoWGSveQM3PGbkZDx5yKZbw3Ul+Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=egCHQ26+7AJfiNycQ7LqEkQIu0lCaqHVhAMvW0h0wAsp3CrWAE+7aXgKrTr8tYzCt
	 C9Czc9+QkLevotSSY0CQOQlZ0tSJKditaImH+Qjih7SjFou98phb+yoFmJw5fH5PIW
	 mygYexBh6iNOnAetq4/hZH3X+G/I13I9n9hLO2SemHs4zhHCzBkflBymg+ZxjiXL3p
	 CZ5ogUKPfs/EfVfGz49JgtqtRe37gCnDDly28R1G17rrNl0RqA/vOEtT/bLq2tDx19
	 HfHScJygYE6c0EjAOC5UUBq++369vHIXWRYWGKUpZ6I35WyAzx4NPWqWUpDsOZJWKF
	 Mh06uM7hs6oMg==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 22/29] perf header: Validate bitmap size before allocating in do_read_bitmap()
Date: Sun, 24 May 2026 00:26:56 -0300
Message-ID: <20260524032709.1080771-23-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

do_read_bitmap() reads a u64 bit count from the file and passes it
to bitmap_zalloc() without checking it against the remaining section
size. A crafted perf.data could trigger a large allocation that would
only fail later when the per-element reads exceed section bounds.

Additionally, bitmap_zalloc() takes an int parameter, so a crafted
size with bits set above bit 31 (e.g. 0x100000040) would pass the
section bounds check but truncate when passed to bitmap_zalloc(),
allocating a much smaller buffer than the subsequent read loop
expects.

Reject size values that exceed INT_MAX, and check that the data
needed (BITS_TO_U64(size) u64 values) fits in the remaining section
before allocating.  Switch from bitmap_zalloc() to calloc() of u64
units so the allocation size matches the u64 read/write granularity
and avoids unsigned long vs u64 mismatch on 32-bit architectures.

Fix do_write_bitmap() to use memcpy to read u64-sized chunks from
the unsigned long bitmap, preventing out-of-bounds reads on 32-bit
systems where sizeof(unsigned long) is 4 but the bitmap is stored
in u64 units.

Fix process_mem_topology() minimum section size: the check used
nr * 2 * sizeof(u64) per node, but do_read_bitmap() reads an
additional u64 for the bitmap size, so the minimum is 3 * sizeof(u64).

Fix memory leak in process_mem_topology() error paths: replace
free(nodes) with memory_node__delete_nodes() to free per-node
bitmaps allocated by do_read_bitmap().

Currently used by process_mem_topology() for HEADER_MEM_TOPOLOGY.

Fixes: a881fc56038a ("perf header: Sanity check HEADER_MEM_TOPOLOGY")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Closes: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425@smtp.kernel.org/
Closes: https://lore.kernel.org/linux-perf-users/20260410223242.DD76FC19421@smtp.kernel.org/
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 37d7c9849e0e9199..66929c5557b21494 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -178,15 +178,25 @@ int do_write(struct feat_fd *ff, const void *buf, size_t size)
 /* Return: 0 if succeeded, -ERR if failed. */
 static int do_write_bitmap(struct feat_fd *ff, unsigned long *set, u64 size)
 {
-	u64 *p = (u64 *) set;
+	size_t byte_size = BITS_TO_LONGS(size) * sizeof(unsigned long);
 	int i, ret;
 
 	ret = do_write(ff, &size, sizeof(size));
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * The on-disk format uses u64 elements, but the in-memory bitmap
+	 * uses unsigned long, which is only 4 bytes on 32-bit architectures.
+	 * Copy with bounded size so the last element doesn't read past the
+	 * bitmap allocation when BITS_TO_LONGS(size) is odd.
+	 */
 	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
-		ret = do_write(ff, p + i, sizeof(*p));
+		u64 val = 0;
+		size_t off = i * sizeof(val);
+
+		memcpy(&val, (char *)set + off, min(sizeof(val), byte_size - off));
+		ret = do_write(ff, &val, sizeof(val));
 		if (ret < 0)
 			return ret;
 	}
@@ -335,7 +345,20 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
-	set = bitmap_zalloc(size);
+	/* Bitmap APIs use int for nbits; reject u64 values that truncate. */
+	if (size > INT_MAX ||
+	    BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64)) {
+		pr_debug("do_read_bitmap: size %" PRIu64 " exceeds section bounds\n", size);
+		return -1;
+	}
+
+	/*
+	 * bitmap_zalloc() allocates in unsigned long units, which are only
+	 * 4 bytes on 32-bit architectures. The read loop below casts the
+	 * buffer to u64 * and writes 8-byte elements, so allocate in u64
+	 * units to ensure the buffer is large enough.
+	 */
+	set = calloc(BITS_TO_U64(size), sizeof(u64));
 	if (!set)
 		return -ENOMEM;
 
@@ -3497,7 +3520,8 @@ static int process_mem_topology(struct feat_fd *ff,
 		return -1;
 	}
 
-	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
+	/* Per node: version(u64) + bitmap_size(u64) + bitmap data (>= 1 u64) */
+	if (ff->size < 3 * sizeof(u64) + nr * 3 * sizeof(u64)) {
 		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu nodes\n",
 		       ff->size, (unsigned long long)nr);
 		return -1;
@@ -3532,7 +3556,7 @@ static int process_mem_topology(struct feat_fd *ff,
 
 out:
 	if (ret)
-		free(nodes);
+		memory_node__delete_nodes(nodes, nr);
 	return ret;
 }
 
-- 
2.54.0

