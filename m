Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6D4AE12F;
	Fri,  4 Sep 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532890; cv=none; b=WjvyOGFUA79DKstQqQX3H7A2G6lBdH1FHXDVWVC81uMyaNKu/AvaqM0PCccaGgagI1gYGL7nuouXfna+SlHs9mJJ5PsQ0Rnx/xNAQmhKhEDIaV9Rcgu1cvUL7Fzn2rDfjfOjxRfvxVV4nQCw9HfrtklEq/vr6LLM632qwsogpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532890; c=relaxed/simple;
	bh=0OFX+kU+M74+gQHFuQ54KprjKZmepHcrpnuizWKwuF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7TJSTqQpL8pjLsAgQw3y4eshLFPD5I1AClz5Vo2cHn3xzPF86c2y4FNOvcTX7WTQ5L92EwJMDzBriB6lmO1RsxrpjijynQWzYr1ag4+vg/1tWu250b+w1QMyYJn68+mkUt8GO8xD3xwGr+4JZRSsXVR9AAhzAfMzkDbHSwosXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OovZey8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OovZey8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941431F00ACF;
	Fri,  4 Sep 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532889;
	bh=G5XXIVsnnMnL87uEXb7dOvLIfX/ZYGTR5Ky0opjA36I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OovZey8Rs3ade4fcOYYjtd+cbFN3b4Hsqe8UjRuqcGVhCASQQ6vfWRkuxbHJnSeyQ
	 iiQy1jvXGXJEzm2j4kX1adCDoLyhA4afkmG+G00CB4Q2+zJKToa53hv3zTWsKvqq9q
	 azC3PxhuSWcwg98xYKN9N90aUBBCVLcwTg75Rl8G5vXrqab5m/q5xL/UPAi3YJUW23
	 pdoVMOtHEZRD60t54ahgGZsAZIkTFJUsP5zAMW9DZze8PPUhhQj8ykjjlklI0dIjQ/
	 wAmPGmolvnvEjDh1M1GFvLwLaXSSKCA5TCj3Xr3ZItwewZNqQ7t3kR0jEYn5Z5ZUB+
	 q7Cu3TnnpTExw==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 5/5] perf jitdump: Size code_move event allocation with idr_size
Date: Fri,  4 Sep 2026 11:40:57 -0300
Message-ID: <20260904144058.3341-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904144058.3341-1-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_move() allocated the mmap2 event with a hardcoded
+16, but computes event->mmap2.header.size as sizeof(event->mmap2)
minus unused filename bytes plus idr_size.  When idr_size is larger
than 16, header.size exceeds the allocation, so perf_data__write()
reads past the heap allocation, leaking adjacent heap memory into the
generated perf.data file.

Size the allocation with idr_size like jit_repipe_code_load() does.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index f8b937a95fe84573..45a05316b3ca65b7 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -646,9 +646,10 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	idr_size = jd->machine->id_hdr_size;
 
 	/*
-	 * +16 to account for sample_id_all (hack)
+	 * Sample ID is written past the end of the mmap2 record; size
+	 * the allocation to account for it instead of a hardcoded +16.
 	 */
-	event = calloc(1, sizeof(*event) + 16);
+	event = calloc(1, sizeof(*event) + idr_size);
 	if (!event)
 		return -1;
 
-- 
2.55.0

