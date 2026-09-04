Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73F3EE1EE;
	Fri,  4 Sep 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532882; cv=none; b=qIixS0NP3R1camarJeMaBW18LU+odk/1Gt83nFXErwmLmAchICA4CusLViUw2vcgSVw9ppEbxRVBTdL8zAMqmlTLimA4kPULXvvWArLsDpuvIMbHVwUg6WWDZuj8Y1lXSdKA9GYJ07xyUjQQk9Z9Gkv3N4yq5UPKGo2ZnXM/pB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532882; c=relaxed/simple;
	bh=e38JMJdiGHRdfA64u0w6Tx1jh3SRtvwMfz7aiaqj09M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQoexpN2auCNUyO3Ywh+hRVcytztG12jZ40tt2XGchSb2Z+7h/Dnjk6n/jCd/Kc6hINt9WeXiwxtWcAv8aDJrBEhTgineJ5f9yAohoxWPxa5MyP/i7x1lx1HP3DLZWZKq2uZf5dr6R1/7LiRw7yPdPpjJbS+OpEvsdK2q+pm5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUvd5eNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUvd5eNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF621F00A3E;
	Fri,  4 Sep 2026 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532880;
	bh=zynrnR2EAq/cFIWBv+qsDcjBh1/+RXYsldS58qsToHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUvd5eNYQ54v0QEIlMEw22g8NGNBTCdBjYjqD8ycmaUDP+BY//oWsQgjQmhhZbaIg
	 cYZ7OHAKqg2bPxrplgxy0ikDg5vjeQeu//OvQW+EVapcwMgI0JYLOjLFGrcTCzm7x0
	 zTiyGTGxQGg7Yrlmv4QTpZyK7srKwG+9NsSGXfBDkc/XCZhAJsc1qJyxZ+9WN68TR+
	 qW9pOPL77O602OnSfBSjF94nWk4giyC1qqhtO5vmx5MBMGEvyUBhYPy7AMBTK1Fzpf
	 F2pOoCC2vgzJYTixxIdo3TvT6+qRl9Jz4EWjpAE/K/neFs/RBh1hDk7r+0WW7Dg88g
	 4ngMXUtCVxr9Q==
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
Subject: [PATCH 3/5] perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero
Date: Fri,  4 Sep 2026 11:40:55 -0300
Message-ID: <20260904144058.3341-4-acme@kernel.org>
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

jit_repipe_code_load() only cleared the unwinding state when both
unwinding_data and eh_frame_hdr_size were set.  When a record carries
unwinding data but eh_frame_hdr_size is 0, the cleanup condition fails
and the unwinding state persists in jd, being applied to all subsequent
JIT_CODE_LOAD and JIT_CODE_MOVE records, duplicating unwinding sections
in the generated ELF files and inflating their event->mmap2.len.

The record is validated upstream so eh_frame_hdr_size <= unwinding_size
always holds.  Free the unwinding data based on the data pointer alone.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e0d5cc9a828189a2..efb40d93e33ae664 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -530,7 +530,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 		jd->nr_debug_entries = 0;
 	}
 
-	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
+	if (jd->unwinding_data) {
 		zfree(&jd->unwinding_data);
 		jd->eh_frame_hdr_size = 0;
 		jd->unwinding_mapped_size = 0;
-- 
2.55.0

