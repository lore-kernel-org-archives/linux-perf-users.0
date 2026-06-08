Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC702265CA8;
	Mon,  8 Jun 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882301; cv=none; b=LRKUooXKUfGLGhPkqGHktqzyAiiTmq+nUj4CRqdZp66DkOvE33P6E4sbzPPyluJ44qOT4G8OP+8M7p2DwdcfJxjAP86FJW5M7J2LfN+a19wk48+nWiPDe5k/w5lrISPl9BsupUueElmfT2XkxeCfmXGITzGT5b2kPZ80aYZfJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882301; c=relaxed/simple;
	bh=NS10eLvR1wIFhOrcyHm5S3Szt5dZ5EAeLNZsWzPIJB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trL8JZZ7BYEj5J3NOLnkQnVQ5g/9umjomZ4gINzKyejPGDbi9GaD6Kn/ffDeVzIx+GWFTGrFmpPVmBFL7QtcegeQQlgnW6yzXMI/FYWZ6K+OEsAe+GrtTejHr+VnLFXrr6vEFWsv073kflk+mxybm2xRBQVeZWrBpEggKyy4s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvvrbbSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvvrbbSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595BC1F00898;
	Mon,  8 Jun 2026 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882300;
	bh=OoWkGv7kFgVWTn6c6kHUxAclF8Ie+haXIj31Xrb+qPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvvrbbSjym3Ew5Ja4JAx+4BqlD2AMfafL1UFdV9W/skhefuOe+9o8TRHj1QeEom3M
	 9doDHWG3ldS17Q0UHF+mtEsCbeqy6E8din7nKebx1HdIVRAPXPg9bA9iY3Cdd0vOjq
	 ufMRtzpyyXzrspDSmhjgyvvBtGOb6JbMJU5MikZ0GLclFBTCZrXbSlGioKcvifPxWp
	 mkrRPMMVHdO/i7Rtx2xrUU8zWfBb+u4ygZ7GLhV1DooJnot3VKK5XJQjHlBvvwfOn3
	 JybRK3gKBxku/e5YcPRdLIV5WYs+aotNc9VbfdNE3Qa/yplVq04w/Dh0lZD3hcmD7R
	 QWBXAOZTwovOw==
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
Subject: [PATCH 05/11] perf tools: NULL bitmap pointers after bitmap_free()
Date: Sun,  7 Jun 2026 22:30:49 -0300
Message-ID: <20260608013057.1942953-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Three call sites free bitmaps without NULLing the pointer, risking
double-free if the structure is reused or cleanup is called twice:

 - mmap__munmap():                 map->affinity_mask.bits
 - record__mmap_cpu_mask_free():   mask->bits
 - memory_node__delete_nodes():    nodesp[i].set

Set each pointer to NULL after bitmap_free().

Fixes: 8384a2600c7ddfc8 ("perf record: Adapt affinity to machines with #CPUs > 1K")
Fixes: f466e5ed6c356d1d ("perf record: Extend --threads command line option")
Fixes: 36d8658618c2505f ("perf header: Validate bitmap size before allocating in do_read_bitmap()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 1 +
 tools/perf/util/header.c    | 4 +++-
 tools/perf/util/mmap.c      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

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
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d7f41db7322cbcb4..8d2ab440a1c8ee4a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1481,8 +1481,10 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 static void memory_node__delete_nodes(struct memory_node *nodesp, u64 cnt)
 {
-	for (u64 i = 0; i < cnt; i++)
+	for (u64 i = 0; i < cnt; i++) {
 		bitmap_free(nodesp[i].set);
+		nodesp[i].set = NULL;
+	}
 
 	free(nodesp);
 }
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8012301d3cf2ac9a..ee3ebdf53e15291e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -239,6 +239,7 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
+	map->affinity_mask.bits = NULL;
 
 	zstd_fini(&map->zstd_data);
 
-- 
2.54.0

