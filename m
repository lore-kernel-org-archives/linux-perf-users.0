Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E02F8EB8;
	Tue,  9 Jun 2026 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967149; cv=none; b=BS34ellj1hAR3t/Mj6CdB5y933iKrmptpxlbABQr8/1QoVYocZTuGLe3mv51IcjAb2GbNtdXAmrBVJWzYNmIIab7mIWR3sHZdMWdsSvyOUeZrU5SV1rkRtluipMWUJKcJJ8kVOSyVbfyQ7sPK0ZLjnuHZsHTiSGAjMOlYdbqpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967149; c=relaxed/simple;
	bh=9TieOOprA3pr2lqyOGdp8nr4IhsnNzh39oJ7l0byf9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuYWUXYOv9UIP5mRpXNd+lypfBLcsWNpss71UIWmC7+AuVW0Kr/Kfdlxko15+245mbs1YawQ6XlyZ1e4xQV+6T+UdN/yB+nVdC0DVvYJQKt8rbZj0RYxktaZ7keMRl/7fK2MPJMb6y6y93r3/SeSYkhUwcb1MD6GTm3dAayOqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FApIkCrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FApIkCrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D271F00899;
	Tue,  9 Jun 2026 01:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967148;
	bh=Uw4uWVRMf5QS3Z8FoMtWU6duDIpuVg5a57WXOsSf96o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FApIkCrqopCX28ZkhLFuIKTD9Xh/oyTlSqcuquJK5c6gE50wRmQfFZeEB1gxhRQdS
	 NKy6bh51BCdD8qXyVxjIrgl6fKOsZsuuNKL8m0chM15GKQDJVD5UlK+fLxocJKzxnV
	 nVNyR4jU2IfIiw+azWZ13JdpjCWnD1sDyxCDmDUof/N0/EFeK+1SOh+UObGUDRYdEW
	 Tv1KCBKkJutjt6EmLzNSbFCElf4jGxAyZ8Of41NAzzFdlCPFdzfvNwBvh6wIX5318E
	 gTV+nVkYl6Q+lWTFZ2MSCRQtr3yza/Edcoh43WC3NczQyn5axbxrP12k+a3nrUh0nZ
	 enM1q99PQ1xFw==
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
Date: Mon,  8 Jun 2026 22:05:18 -0300
Message-ID: <20260609010526.1998472-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

