Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA193431A4C;
	Tue, 11 Aug 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468348; cv=none; b=LNYFhkweozzkJIk1gkBuJ8XpzTiqTvv+4xUaoN+jRkxTjJY7sZNKXQwx1LnVjBgGTpsCVq46L16BJbX1M2qn01O6zd9oD59QKLuw9ErAkSHeJc38iQpJwuVP5WgSSYU1fY9GsWzY1veiEDHgUTcVakYyevPKEBzdx77OYHyhHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468348; c=relaxed/simple;
	bh=nRAE/J1F4RjeaIp94T6DfvFbqHH9zBfwF3h8QR0oGfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N43fPPaZHkirh1Ec8tmj6efq+qwKtFpqk6LMb24LKecpoxASuJC5XOLWevkedIlmwiLAOnforGJiylaYQiCLfNwDWDMiF/uQV03qk50YPEyqUq+31ZJRMtvkSYdXCPkdg5NVgv4HOIZbD6SYbbV4NjwEnNb/KwySoOb/vENTut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mluJTESM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mluJTESM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D5D1F000E9;
	Tue, 11 Aug 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468346;
	bh=edC2gXtMicewaQ3Uim/RZ0IU6TrcKLdQqTeAwo9ObVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mluJTESMT0KIFk7TF4VwtVvbrTVXckNkxFdyjG+8PmntKbQM8EYBYXVcmP8tHuEea
	 kRY0pMLSP+dfkinTvCRgdRa9FzyCzE15J+1XXXubCm4MiRihwwAW+D9z9NIRtlpHgV
	 sxm/36MLvW0p2zmPC/AkAaZdukayE9Kzn7ET8Vp5hQspdXT9hVfoPpK9Ei2qIPkOi5
	 hTLs6ZvWtQ2oFmSAGvlVyuKkOyR3ptanjahkXxxzwkui3/jWaJBqWU3svMIo46MpUx
	 PT5MkwhQ0fsD4cjCSc4mu0eC6COQRHFcKCZ6XcEbBi9Hb7DCcWdtN7rD5Vg/KxGb5l
	 wzxGphUWO6hjA==
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
Date: Tue, 11 Aug 2026 14:11:59 -0300
Message-ID: <20260811171200.30096-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811171200.30096-1-acme@kernel.org>
References: <20260811171200.30096-1-acme@kernel.org>
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
index 845a384a4d56779b..2cf9f44a87903d7d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1005,7 +1005,17 @@ static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
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

