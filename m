Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFD3793AA;
	Sat,  6 Jun 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776378; cv=none; b=MXBpt8CdH02e0MK5c9XabHM4rR7N/UCkyywSPbvU/BLAmXck0xUvNsKOWQ5+43CYwdq4f9kNtbj4ZnCfSe0PjLri36UnAuH+JwONgiJe1NkGlMTGVcXrQS1q96wu4Vz2UkKA7zX4eBcyFOuxKBx+fqIQgzL4RaQaJYu0uHjfN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776378; c=relaxed/simple;
	bh=x/qyZQUq8mGXqgJoXciDpBAOG9Wt3kK2/xGqd69QYvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkZt7JyhM/e9SQ9oe7ItmvYEegOiHV8+8HnpiyQGF+JMhs5Qf+BmBTsV86BenUKNDtAH6/MKdxwV0ZiB5W3WgX81gEKWStqNxh+eqfo1Gu5DE4u0ZrR4ghZRWpW1/wTjNgXCaMGtIgusIF5WELmH/EuJvBi0exhlwFUQ/CRw7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDeOktvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDeOktvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713491F00898;
	Sat,  6 Jun 2026 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776377;
	bh=zFT7NR1V7cGZRAKQdOM3vBh2LFdUb7iUOlXifB7O/UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UDeOktvjdaLAqj2n212uyUN18rs4T1SaWGkT3VRQnxX5Q4KbBOyF5cMkCUsKh7t+C
	 ln8Gzm6A/DbLHfa1WcV8p5Q4ErevKiJ2Ox+QHZM/YPvRnISlx5DVF+GzWqkDJNX4Qh
	 mSKJTrC1d/KVH4HhYnV10eAdCS5VgvbZrIz4Zz/V9lU+NEKh2K0Wa5u1ZQhQfbM/a6
	 3f5lg03kOMK0sOYdSR8sNYMnmtaE1Ra13VLKuCM5MPMhIpsEe0jMY6rDWDbMPyqXRU
	 eaQ0wd7ScNnE6Kq1R7ZcHAmAsWznVbx14lkarw9XMLQW+8mpNFydMppxhMB5P8cpIx
	 r+Y+12xCSy31g==
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
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 1/7] perf mmap: Fix NULL deref in aio cleanup on alloc failure
Date: Sat,  6 Jun 2026 17:05:53 -0300
Message-ID: <20260606200601.1861227-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_mmap__aio_mmap() sets map->aio.nr_cblocks before allocating the
data array.  If calloc() for aiocb or cblocks fails before the data
array is allocated, the return -1 path leads to perf_mmap__aio_munmap()
which loops nr_cblocks times calling perf_mmap__aio_free().  Both
versions of perf_mmap__aio_free() (NUMA and non-NUMA) dereference
map->aio.data[idx] without checking if data is NULL, causing a NULL
pointer dereference.

Add NULL checks for map->aio.data at the top of both
perf_mmap__aio_free() variants so the cleanup path is safe when
allocation fails partway through perf_mmap__aio_mmap().

Fixes: d3d1af6f011a553a ("perf record: Enable asynchronous trace writing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4404a99eee45f9c3..d64aec6c7c843e81 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -89,10 +89,10 @@ static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 
 static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
-	if (map->aio.data[idx]) {
-		munmap(map->aio.data[idx], mmap__mmap_len(map));
-		map->aio.data[idx] = NULL;
-	}
+	if (!map->aio.data || !map->aio.data[idx])
+		return;
+	munmap(map->aio.data[idx], mmap__mmap_len(map));
+	map->aio.data[idx] = NULL;
 }
 
 static int perf_mmap__aio_bind(struct mmap *map, int idx, struct perf_cpu cpu, int affinity)
@@ -141,6 +141,8 @@ static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 
 static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
+	if (!map->aio.data)
+		return;
 	zfree(&(map->aio.data[idx]));
 }
 
-- 
2.54.0

