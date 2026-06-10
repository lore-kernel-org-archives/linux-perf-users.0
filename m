Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5433C52F;
	Wed, 10 Jun 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110359; cv=none; b=ZH4LDuEj44WeY3W71kQ+F6+Bz3F6aqzEnsoLUvZe14dCZZwwZVFAb+LkTMXNVPnzgQb42OI/3+kWV/P5cRSeG0mww2tXShp/9D6e/v9x6gD+N9lLLDjT09l5kmV3OKW7/ojYcqWWRBXojhvXFNQX0DuMtK5ObEU7ZcfnUZKSQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110359; c=relaxed/simple;
	bh=14znaSbE/vYKbUSLkAhlt08WXUSmo+UZRC/Wa4oE7j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siwUh6bNF80yetC9ItzRk/s+HLrTrysgvltYZ+qvYc6nXftV3gX+0AejXkWziSJkrY06LiPwnw0ZQd98xeNqZJNTU46TDE1mYJbTGadLPBWE8u57SuHJu9WSYz+yYxPxLuP7G4xje9/xBwJ2ZnHwgR4dPzmz/Y/i+uA3q5En6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFbsYPxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFbsYPxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D001F00893;
	Wed, 10 Jun 2026 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110357;
	bh=lnwFl+vrAFuz0a1nuMWuGNi60TEb78fCwlXKArHgfiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFbsYPxNZJiQqSlD+v2acin7WYO39m4tOIs0MGXcRIutF8vbg4Lp/lUPIrFw4stfG
	 VkwTNYMHjsIvGj6svn8E4rdjXcv8OOL7dq/3VIFe47FsGeb9YmT4sRJO5Mv940KCc5
	 RDO60b+J/BCJaK2ZsdSn7R2Fdwbn8N7kU3+ogpziFt3FqkEafey/LpVqgzEEPyu6T3
	 0+SASanXMOqZa2zTjWZj5T19qYP+rJBWUa7HkyKzO3SuNcM2jT/s0da+HM84r0f8RT
	 cN6gFA4JpyD0BsVkJh0dzoTQgymmfjt5SDtsr6Upf+oXxclEkVyjeyuFm3Ou6RVE09
	 RUIgIWNTS2Jgg==
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
	Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 04/11] perf tools: NULL bitmap pointers after bitmap_free()
Date: Wed, 10 Jun 2026 13:51:58 -0300
Message-ID: <20260610165207.2077258-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Two call sites free bitmaps without NULLing the pointer, risking
double-free if the structure is reused or cleanup is called twice:

 - mmap__munmap():                 map->affinity_mask.bits
 - record__mmap_cpu_mask_free():   mask->bits

Set each pointer to NULL after bitmap_free().

Fixes: 8384a2600c7ddfc8 ("perf record: Adapt affinity to machines with #CPUs > 1K")
Fixes: f466e5ed6c356d1d ("perf record: Extend --threads command line option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 1 +
 tools/perf/util/mmap.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a33c78f030d91012..e915390556752b9e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3084,6 +3084,7 @@ static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
 static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
 {
 	bitmap_free(mask->bits);
+	mask->bits = NULL;
 	mask->nbits = 0;
 }
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index d64aec6c7c843e81..358e70c4f3edd077 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -238,6 +238,8 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
+	map->affinity_mask.bits = NULL;
+	map->affinity_mask.nbits = 0;
 
 	zstd_fini(&map->zstd_data);
 
-- 
2.54.0

