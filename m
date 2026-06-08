Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BF3EA97B;
	Mon,  8 Jun 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949897; cv=none; b=ojmnvqbfjrxiVj7ABrcasNg8KFCjMLZTmr2iuwKU4L9X1HfLvHPjaF2FYgQ3VqzUYM/PzE09zIt9PwD7s96/mtaruRLIUotolWcn3wT5PoTY6GOQK/BZcUJLgoUHBbeqNgQf8jRTD/+Q+69iye5dLZq2NNBcrVXUKMcEuq484AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949897; c=relaxed/simple;
	bh=D+Btd+P6P6EBYT1bld6K9EDJrGmjb0z1SMMuJwJq++g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQEsGzThkXDEqmI2cx+QD9NrZDyMTZslIBhclnXILyJVtuXt2+WI4G6cnyUjJHd4DJAkhD7ns72wp/tEckNNCwKMG3x2/3wYNyP98H5ox7nyziskr75k5WrCwhDK6Ht00cCi3XqiCelPCVd4K7bc0kOuATIw7Zk8xbXoOrWqGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ussl6iws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ussl6iws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194DB1F00899;
	Mon,  8 Jun 2026 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949895;
	bh=f3AaD08Djt7PRBkkv9nm5JBCOTC6JVj0r+NCWl5MIkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ussl6iws/ODqNeG6LXxvtbdcWn53U+c0P0Cwj8ppKzakf+KpuJ5kOFbtTUTkjkW2t
	 92Cskk2h5gFdsYWGunuxgVzoaBQuFc6vpOyA5PLRgBkgyVpeFLFNrGK0O4sB2I921C
	 YDqxkM128+RaRq/m5B9cZqnPvwJviMow8OmqNWApb58gaA1FgPoAR1mxtaoT1nIc8T
	 GPm6B6eduR1qERh+F2Z0jKiehsBGx0B+ZhpPRIuNxDuMp4qOWFVOGz5pyo27/VrHrr
	 qoWjpzfXjGm3wj4S0qUj09zmnUjkM3c0yVG6vzAQ1M6jJigj2lvsO+41on16zuUdid
	 fJTMntKEXABdw==
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
Date: Mon,  8 Jun 2026 17:17:44 -0300
Message-ID: <20260608201753.1979464-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
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
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 1 +
 tools/perf/util/mmap.c      | 1 +
 2 files changed, 2 insertions(+)

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
index d64aec6c7c843e81..c6bd4c37d50ee57e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -238,6 +238,7 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
+	map->affinity_mask.bits = NULL;
 
 	zstd_fini(&map->zstd_data);
 
-- 
2.54.0

