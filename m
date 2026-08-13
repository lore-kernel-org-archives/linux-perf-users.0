Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA92459EA;
	Thu, 13 Aug 2026 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582195; cv=none; b=Ct+Tw2mwJ70Xn6EOcf81n/eLQKGQ2siFAaxn+50qYugYaqL7HlW1i4ivItqTdrbvWI2qk088X+gZToqM2mAaxunhd/3US6K9LGtTTlXYtUw21nkAg3H1xepdAFsR/T9bN/pE6PtQdzkVv3vi0kC6BIENnLG4qD48XmHLxyDoCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582195; c=relaxed/simple;
	bh=CbpAgGSwC3uY68iyUA3csZcsDcj3e3fYt+cvIyNBt2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCZP6Q3rzJmzQib4j3EeijGDEbuorgEit9nU4qekjoBZmNnoHe2kWgpRt2iLkk9/l2nTZwRG6yLGhpf2JyaldOxb7vehoPprEq+vuZG3vvOhwN3CE4P3ysDnkQMIhi5Dt4W7OL2oWEXNKHaax8bS9mAbNC1jbxPEyLa9Z6RzwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsly/dvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsly/dvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630431F000E9;
	Thu, 13 Aug 2026 00:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582194;
	bh=sTWu+SZuU5ioPBnTOBgpMFPMQ4IcsowNmnLhZJbGVZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vsly/dvkByzC9vCBNYaXNL9s6O84a4hpv0sh3IzjDQobY/1wIflrDwLzjAixtqMgU
	 Ax+RVzZY5pCFUAtxXPdo/JQbTmNxPk3VxfucmKhNfzCJURZOyyrJbZJc9rBKeN4QzA
	 M+uq5rxHMxg7OYQsZhkixiTVVPJehrFHmByMLtYXS0eTjRdHwLu6qXGxTM/+9igJfk
	 5J0mpDXA0M2u689GhdG9bR2mnwK9kTRk+NQ4wgpVeArl3rJ4d9GhRYVUHf1xCD84Hc
	 EjLnJfQs+Y1vpYvbYzb0sEJ5pDgUulq39iiPmxpPlIq11xo9uR30Ez3Bd33LTTU1kU
	 x+2zIeO8HMedw==
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
Date: Wed, 12 Aug 2026 21:49:23 -0300
Message-ID: <20260813004927.16738-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813004927.16738-1-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c7fb9e1d07f14f17..03e7f89d5465c91f 100644
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

