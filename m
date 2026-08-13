Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D9485CDC;
	Thu, 13 Aug 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633930; cv=none; b=Z23uedFx04RAsCbjjgU9vI/g8A/h0VyYQG4IPc139TX1EXpVy9RLvWNojRb1TQ2AkMlOP6Yrnbv17AsvOpBowl7FaO0kv1HSc14mTQWuqhqHqUIMe1HFTmJYObAn8+7VyPJVNXbBgfzw1FzMVNe6lrBz9FIrUd31kVHiDniitrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633930; c=relaxed/simple;
	bh=w/ov9dTFWUJ5efYR6riEWce9i1ZpojtqDWXcbEGZqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC0CeV8hBlWq8cAkPx6ueZO1hlcB1KYlaHpgGgLqKsYCC8a63sU11YbtN9lMiaPWgJutRtazZV0cb0YGcbpGVncTWlHlQPiEDSsUEI6rQ8bS3K88cMBcRPxz/7b/3fGnjWjt1Y/6mqFmtgQGB6wpEKghnwlre8vyYim3YHvQSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX7bAYfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX7bAYfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B99E1F00A3A;
	Thu, 13 Aug 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633928;
	bh=5RWhhoRAyfdFS4j/kY6A9DoZiJijxrHc7BxW9IrX+yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NX7bAYfBgiFp6ScuK4KuFRVEblVxaDgcq+S/cIgG6yTakkl1AwBjNiTq8NwSm9gwj
	 lyXhbKZvAv+Bt1G3Ecgp+xLWstHbllLzJDONsGRhJZgv8Eo9PJc1MVk8MlG2CkCa27
	 avp4Y0PbR2RheLmIaQ5eNJF5Rthn0UWqp+24v8u2+MSlFDJPJfQsHWGWyjP/Nje34N
	 sYa7Zmtl9W+1RN0Dtgg/T4pbr3FijTBC24plNfxURo6T8q/s1OZTNFNDrXmmmQ9/UE
	 6bhmFmm9lgKrsE/peFdCNrW4x72SojX1ShADLEyfV/w8ozwk/RNib5GAVG824iGaXs
	 0uxGT3l/l8Llw==
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
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 4/5] perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()
Date: Thu, 13 Aug 2026 12:11:45 -0300
Message-ID: <20260813151148.23169-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813151148.23169-1-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dso_cache__memcpy() computes cache_offset = offset - cache->offset,
then cache_size = min(cache->size - cache_offset, size).  The RB tree
lookup in __dso_cache__find() matches using the full
DSO__DATA_CACHE_SIZE window, but cache->size reflects the actual pread
return value from dso_cache__populate().

A short pread (e.g. near end-of-file) makes cache->size smaller than
DSO__DATA_CACHE_SIZE.  If a subsequent access targets an offset past
cache->offset + cache->size but within the DSO__DATA_CACHE_SIZE
window, the cache entry is found but cache_offset exceeds cache->size.
Since both are u64, the subtraction cache->size - cache_offset wraps
to a large value, min() selects the caller's size, and memcpy reads
out of bounds.

Return 0 for an offset past the valid cached data.  For a regular
file a short pread only happens at end-of-file, so 0 is what a direct
pread() at that offset would return: cached_io() stops its read loop
as on EOF.  Re-reading from the backing file would not help — a
second pread at the same offset returns the same short count.

Fixes: 366df72657e0 ("perf dso: Refactor dso_cache__read()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 60aa77f7978514ec..4dd64069c4348c06 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1014,7 +1014,20 @@ static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
 				 u64 size, bool out)
 {
 	u64 cache_offset = offset - cache->offset;
-	u64 cache_size   = min(cache->size - cache_offset, size);
+	u64 cache_size;
+
+	/*
+	 * The RB tree matches using DSO__DATA_CACHE_SIZE, but a short
+	 * pread may leave cache->size smaller.  For a regular file a
+	 * short pread only happens at end-of-file, so an offset past
+	 * the valid data is EOF: return 0, matching what a direct
+	 * pread() at that offset would return, and cached_io() then
+	 * stops its read loop.
+	 */
+	if (cache_offset >= cache->size)
+		return 0;
+
+	cache_size = min(cache->size - cache_offset, size);
 
 	if (out)
 		memcpy(data, cache->data + cache_offset, cache_size);
-- 
2.55.0

