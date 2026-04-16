Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0F4086A;
	Thu, 16 Apr 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298498; cv=none; b=S85PjsXNCIwA8/aAx/3r3AMS0qODCHpbTT09hsPBNvRn7oCSzbBGKHooKJm3ldxiPn7nPuTGtt3fGHxrsop9KQ3e5OPyR9OhbJyZK9yK85SriKvwTXw3sz4sLM9SVPeVaCswcO+JfUEulXtaB+EbfX3Q6WfAZAe3OwB7MwP3424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298498; c=relaxed/simple;
	bh=TwNuMHx951fkAA9em4BtdZisD/tSjQAtRnun21WJoGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEXS0lg7dMP9UjpndtKnP9aydLpCZTwiBhqCbKVHlfH9V8m1uN2uF408N3fgXG2Kw+TtGgsHy1QldAAJD59lNIscyDNpCDtklJz31pmC53gDz1ZnqYk9diteYiWL+NHGEj5Au7d5/D/hDv/l2e9o53Q9yYKlOK4RU0aqqDAlFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwWJ+TPk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwWJ+TPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BB1C19424;
	Thu, 16 Apr 2026 00:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298498;
	bh=TwNuMHx951fkAA9em4BtdZisD/tSjQAtRnun21WJoGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwWJ+TPkf49dGGcThusuYESWfDuvahkodW9UjGvN4d1do3is0cGNwdh6IZCq5oD8o
	 Dv4PJve/b/+qLo+5TDhmSG7Mi0iDTfjacONhXhYudQYoUmPPBfUNJ1tHdyJeSji1Ew
	 ZAlA/Z9yynXVCSM6ybJ4Bau2o8a9S9CH99KTL3/+GZkloeKdUF1AI+HiS9H7HSirN0
	 7XbO9Rfi4kgyfeAsYvYzEettCQCZzK6EJBxgLCL/wuy+0qkIT/BPQyPbHB8aVqsP0r
	 KYHFl81x1TfoDBKb4X/JWSlcQrCa5RfGD5Hzb6Y3dJCPLiol3+BoKRa85PQPQl9RUU
	 P4QLRF6hmKb5A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org
Subject: [PATCH 5/5] perf header: Fix 32-bit incompatibility in bitmap serialization
Date: Wed, 15 Apr 2026 21:14:24 -0300
Message-ID: <20260416001424.362797-6-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416001424.362797-1-acme@kernel.org>
References: <20260416001424.362797-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

do_write_bitmap() and do_read_bitmap() serialize bitmaps to/from
perf.data using u64 elements, but the in-memory representation uses
unsigned long, which is 4 bytes on 32-bit architectures and 8 bytes
on 64-bit.

Both functions cast the unsigned long * bitmap to u64 * and iterate
in 8-byte steps. When BITS_TO_LONGS(size) is odd on a 32-bit system
the bitmap occupies an odd number of 4-byte longs, but the loop
accesses it in 8-byte chunks, making the last chunk extend 4 bytes
past the allocation:

  Write side: reads 4 bytes of heap data beyond the bitmap and
  writes it into the perf.data file (heap info leak).

  Read side: writes 8 bytes into a 4-byte tail, corrupting the
  4 bytes following the allocation on the heap.

Fix the write side by using memcpy with the actual remaining byte
count instead of blindly casting to u64 *.  Fix the read side by
allocating in u64 units (calloc(BITS_TO_U64(size), sizeof(u64)))
instead of bitmap_zalloc(), which allocates in unsigned long units,
so the buffer is always large enough for the u64 read loop.

On 64-bit architectures sizeof(unsigned long) == sizeof(u64), so
the behavior is unchanged.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425@smtp.kernel.org/
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e1fed6f1c5e2fa4b..a12f3f4ef0b38e8f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -158,15 +158,25 @@ int do_write(struct feat_fd *ff, const void *buf, size_t size)
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
@@ -300,12 +310,18 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
-	/* bitmap_zalloc() takes an int; reject u64 values that truncate. */
+	/* Bitmap APIs use int for nbits; reject u64 values that truncate. */
 	if (size > INT_MAX ||
 	    BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64))
 		return -1;
 
-	set = bitmap_zalloc(size);
+	/*
+	 * bitmap_zalloc() allocates in unsigned long units, which are only
+	 * 4 bytes on 32-bit architectures. The read loop below casts the
+	 * buffer to u64 * and writes 8-byte elements, so allocate in u64
+	 * units to ensure the buffer is large enough.
+	 */
+	set = calloc(BITS_TO_U64(size), sizeof(u64));
 	if (!set)
 		return -ENOMEM;
 
-- 
2.53.0

