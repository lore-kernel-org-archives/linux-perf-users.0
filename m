Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C4339370;
	Mon, 31 Aug 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181912; cv=none; b=FFju0UtCOBEV69ziwDsebhU247ehp6lB2Xn29QDV5PmM9LRgQMdiDX+AzC5cwO6vfGWChE0a6b7WYTwJWcbjfKG7Vy7LrcTLMZxR55NAjWmGjEFuVMt0JUKCgcahRTEb4lBxQEhGTpNrwWL8db9EaDOl4YJNyCYBiEd+NcSWGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181912; c=relaxed/simple;
	bh=lepJkGAKkM7AIII9AU/p8r/TUwoDgv+2MiJ6+tlPhow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAc+2ciuYUGTcz5p6+e8j9lD9oXNcpGYIUN4sVJCAcfzDGKske46hVsIOJz2YrJJMxJQZ/83/y5X0Q5DdiCtZeAZVPHx/AL+ahG2qKUY2hS/IIQxTmSZRsVOG2+GgnA/Y0Irf0Ps3yniURrMYjdfBrFzhXR/vAFJi3uTz5s3Wfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIerOJn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIerOJn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947B01F000E9;
	Mon, 31 Aug 2026 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181911;
	bh=lgFhw2YoqLSIzK97jx3aEy4Y1T0tZe9CdtP0GzyctiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIerOJn01Cot+ImpKh69NquO8tdgIp3oOyyREdHwD53aSuClFQg5IC6Avqfvbxwi+
	 8bdTgsN15o2Sb/37zZZNAysa60E1nQMoYWXf2dCAZMDy89oyd5yZx7Ffc58mTNcjcL
	 cMCN1m1b1Pkl1rTSkRz41RyRwKHDnrYRl4pG2bFgCvqo4eeT2ChEpBize90IiSu18t
	 CO6bSj7UtLjUhM0bu2urFowRrF0+DgGzrLARHalJlh89pPALtxJVNhGwYaAvP+qR04
	 z9EnCanwFAIJ825AasgEZfDP1UKLgxtM68PYyiOeiPnyseD9C5X/H6Wx/98Hr0xtG6
	 Cu7dYS1uWYbmg==
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
Subject: [PATCH 06/12] perf jitdump: Check snprintf return before computing header size
Date: Mon, 31 Aug 2026 10:11:02 -0300
Message-ID: <20260831131110.4681-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

snprintf() returns the would-have-been length on truncation.  When the
jitted filename exceeds PATH_MAX, the unclamped 'size' value inflates
sizeof(event->mmap2.filename) - size into a massive underflow, causing
the header.size computation to write an oversized header.  The
subsequent write to 'id = event + header.size - idr_size' then corrupts
the heap.

Clamp size to PATH_MAX - 1 after snprintf in both jit_repipe_code_load()
and jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 7efbaa07f1ba73f9..45f0e21b0e780cb6 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -495,6 +495,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 			jd->dir,
 			nspid,
 			count);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= sizeof(event->mmap2.filename))
+		size = sizeof(event->mmap2.filename) - 1;
 
 	size++; /* for \0 */
 
@@ -625,6 +628,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	         jd->dir,
 		 nspid,
 		 jr->move.code_index);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= sizeof(event->mmap2.filename))
+		size = sizeof(event->mmap2.filename) - 1;
 
 	size++; /* for \0 */
 
-- 
2.55.0

