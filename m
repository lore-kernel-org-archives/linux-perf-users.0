Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A676279DC9;
	Sun,  2 Aug 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680444; cv=none; b=XhN77mdq0mv4Juwlwm0F185nJtPvbgT+FT5y4C7TG+wOe1an1lmKNJYsCavRXd6gAFdEvAojGPwNVTkrUDcn/gSDAXx9f/YUKrivkKTLQ4qTjD9kc/PzTX7QYHJyIJPMw2Ux5yaCGzvs5txqCcTYQZ5axhTuQOCGco+FMf8pK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680444; c=relaxed/simple;
	bh=T0au0knACm02e7WFBuaok0htElCfFeiNuNr3FVuD0TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDu+DQ+lOwznuzKcx4d8IERnAS5L/i6BfuuJxbCfdVQmlYMf1uxokw42b50Mrji0kCJbfJHjVHV9jWvUOavgn57YgtZGmCe997iIGga12vj0fCvgW1P1aJig96hJBHzwmbuG5G0XkMo9E1/hDDadaRdpPtkIs54ncLPYNmW+sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvWaNoiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvWaNoiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6E71F000E9;
	Sun,  2 Aug 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680443;
	bh=ypSDwZYY52iXi+nT9gOxURQmfbVF+SQVe22zSOqD8og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvWaNoiVXtKbclGPlZt3uG7ElMrOqTPwKiwByg4h7mjKv8nOPHmXATgSDkf8OXmS2
	 E9oeh4dZbKwNzTYf+PXJ75dWF/znyME5WGZZPhFP2/Ca0kTuRMEdYUg7EWS614Jx/i
	 2BM09q8eRN9AsM2B+Xmq/7LJqmv0rlpXkbNs+brDBE2FM0dYfg4w09WAMAgPXt/r3o
	 MM5sxSfT3Eic5BEFgWS1C7WsgbTPLWS/GIDs5JhVqNc//8wSjlWx3RF4oF6qZBjzzo
	 k9iA9CDkSP1NulMu50/MibezZ8WX7rzF3yf9kK86FAyLW5yM7ZhjYTviW9aPWPbbVR
	 3K5Jv08aVMJcQ==
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
Date: Sun,  2 Aug 2026 11:20:21 -0300
Message-ID: <20260802142022.154219-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142022.154219-1-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Return 0 (cache miss) when cache_offset falls outside the valid cached
range, so the caller re-reads from the backing file.

Fixes: 366df72657e0 ("perf dso: Refactor dso_cache__read()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 207f8744aac97e8c..a0de56c93592a5dd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1002,7 +1002,17 @@ static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
 				 u64 size, bool out)
 {
 	u64 cache_offset = offset - cache->offset;
-	u64 cache_size   = min(cache->size - cache_offset, size);
+	u64 cache_size;
+
+	/*
+	 * The RB tree matches using DSO__DATA_CACHE_SIZE, but a short
+	 * pread may leave cache->size smaller.  Treat an offset past
+	 * the valid data as a cache miss so the caller re-reads.
+	 */
+	if (cache_offset >= cache->size)
+		return 0;
+
+	cache_size = min(cache->size - cache_offset, size);
 
 	if (out)
 		memcpy(data, cache->data + cache_offset, cache_size);
-- 
2.55.0

