Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828E328B77;
	Thu, 21 May 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325923; cv=none; b=W1atkLFInVtZjgt9+3QQg/MgElkEMZYtPhLvc/WalHGOtGY54GpOrgaqHJ5JTi0MWBe9n+1wAEUBgDeo1TfnDE+Wus2lJNI9duzbr0IpGo9wLOy+6TpDxbXa9k0SLQ19a+dUBh88SqfbOafaLzPBuRcTRzKGWgxZJJOq46Wvirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325923; c=relaxed/simple;
	bh=lE0Lp4NvipUcKkNQLLOOZWucucRFl5RhO95SQFiVuUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnR9Ppsm0IHSv/uEHwW3VtKIzxrolpkbBAgkYy/uy1FGcpu7WYWrSw8kP4A3AloZh8BIYd0TdWUwJaytODQEcxJpKNzQjJp05ScWh0MjSlaZj27wGqsXqacjRlZNR3a4foWaTUpIsrAYysHXiY4Qa6ge3aKhSPfMn5rG6LtAB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSHe778x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSHe778x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F01F00A3B;
	Thu, 21 May 2026 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325921;
	bh=HdLJnlfbFxfwz3n9WaCXsNCSFEvx7+4Ha7Ihp8LuP2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSHe778xl4Q682xLleyeMMfV1OLxvusfzZd8hB4Zk7z4BUcQKwU6yhRGXnMD6TKSW
	 wjE9j3SIJGWXFG3KBaATThqKiPbQftVr0BzBxLDU1hn0YuNhXvdNmrLO9iDpfv6Ir7
	 U46drTx0zHjmK+2K58LjFQ+21nNI0Y1gR/7zbl6oclh6prraMPuPHaT3n1taNjE43B
	 h+VxHTX3+NHCis5iLDBfkR5oTCnajfZnFpjoJX+j8KXyFmltM7f2P/Dyf0UVboNUrE
	 M4S7JeFtEKXJNibTsfqCbKZFT6uxYOR3enVRSzScqJv4p1vr+5Gu9TQq6cTEEU7zJ3
	 AxhJDrdIuGAFg==
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
Subject: [PATCH 21/27] perf header: Validate bitmap size before allocating in do_read_bitmap()
Date: Wed, 20 May 2026 22:10:06 -0300
Message-ID: <20260521011027.622268-22-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
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

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Closes: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425@smtp.kernel.org/
Fixes: a881fc56038a ("perf header: Sanity check HEADER_MEM_TOPOLOGY")
Closes: https://lore.kernel.org/linux-perf-users/20260410223242.DD76FC19421@smtp.kernel.org/
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 05674b76df9b47f6..634a11c7d8b9a9ef 100644
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
 
@@ -3496,7 +3519,7 @@ static int process_mem_topology(struct feat_fd *ff,
 		return -1;
 	}
 
-	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
+	if (ff->size < 3 * sizeof(u64) + nr * 3 * sizeof(u64)) {
 		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu nodes\n",
 		       ff->size, (unsigned long long)nr);
 		return -1;
@@ -3531,7 +3554,7 @@ static int process_mem_topology(struct feat_fd *ff,
 
 out:
 	if (ret)
-		free(nodes);
+		memory_node__delete_nodes(nodes, nr);
 	return ret;
 }
 
-- 
2.54.0

