Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74B345EB9;
	Tue, 11 Aug 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470727; cv=none; b=CJCfQcSaFv/6+NXGZGqG2P5NhXQUsw7/JpOULMFCzc3GhtRfnDlveX4JPQwplxFlxq88TMKgZ+W7o5aPtxuojFRqlOmjowKzrRT5EwPRD+sqjxYxJvqElUpWaPuDqKi7J9mOgWusrdFC1jYTuBPWFP3lVoDrUBSR6sPanjYJ18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470727; c=relaxed/simple;
	bh=SjsB4co41jSVoP6bnS8K970FIJHgbDqURpRb0nLHCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaKwihaS9QDGthNzK8X8sR3GvxGn/EmPSTVy8/a/2vj/IspCx7O50qgqYeQ3sUJeca/6gs9xdhYutSDYyL+VUDIo3mCG7+RRcjhny+x0aj4BVXxYV0anvfHT/Gzb7/tUrIdOITGKmtH9ElwzhXQNC7V8UswSCI47kpJjztI0F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT/yQk6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT/yQk6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9221F000E9;
	Tue, 11 Aug 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470725;
	bh=NukpYtAtFanqUbiSgiuvXq4MtL6kmbQJhHG02AimIxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eT/yQk6na60lRZJnHPUk4nhR646E6jDyMcfFwUUEiF8QSlcoSKqeh8mlm7JzRFH9j
	 L4m08Oud9PlYsY/YtGPuKgkCkfwys4CUeFSilp6L7XAIfymyr9/IYWRCkw/HqX703E
	 h7ltnIdcsLLCxWqyO6PF4b7lLFlserdFQumelHjBF2/C/jYGmzksMpXw2yZnwsdVnK
	 lN74MSTx3zVsIjXc+RzUEUWfEGWDd5lF58sdJYn3tyYKeVdeFT+qsdbTJg6v4wvHNR
	 hgUp3vimU7M7ax8Jn847x1/7Ee92oIribuZ7EOS5J4KHCELvnJwBX+HTgjB0/IWI2m
	 z4DX1rLwI9IYA==
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
Date: Tue, 11 Aug 2026 14:51:33 -0300
Message-ID: <20260811175140.7235-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811175140.7235-1-acme@kernel.org>
References: <20260811175140.7235-1-acme@kernel.org>
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
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 32ae5c78cdb906e6..8e16b919e80721f0 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1005,7 +1005,20 @@ static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
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

