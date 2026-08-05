Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183EF3EB0F2;
	Wed,  5 Aug 2026 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965262; cv=none; b=fGifqTAnMFR9ptP/0GtQlYecRXL/feKe7SukVr4MTMsnLRncfdBh6yGfN3gXmoZS/YMcR5EH6rbx2OFxqtunCc0Scdfj2LZPV9+9HcJvPyx/hrpb/Bhkqg4WlNiq81STYKcMsbpLu0hJ10u0f7RDq2vN7GaIvRiP8iOva/NPbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965262; c=relaxed/simple;
	bh=wdvzTd+I7Dt/MCzYRI+XVTtFkks3lV/ZxfZuqNleLjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur5VrRivDoB+4TKB8bds+z24scDbYz26LQx9wYY6bVqssSBCBsAzeAVxVgVJ/cfNuIipBZiyvb1mU0Q7yw5aJcA/6GvlWAfJe4rigDuGiRosEvnbO/LqSk8pb8hp2bWGqm01dWpaEJzjkdvStD15fKFhyfWpcyHbHGmuoNfwoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UySGE+U7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UySGE+U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CC21F00A3A;
	Wed,  5 Aug 2026 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965260;
	bh=se3Es46riyeapglgM3WNfK0F1LE8E3A5e3Mgto+pz/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UySGE+U7Et/ydmj3PIgegeVKURagCJcvokchIEOal9hJXqxfxYdLJeMH4sIYPsZzB
	 kgfFSry21m1xw5HEDMdJu4XpEyX9z2jIlBP2TRKOPN1BlEmUnxC5Dyz+YY0yj5bTcG
	 g/Q33EHwEgXmp6iV3dFUtUTQLEW+zT2D2aqaETQiJYGpZkiBdpf1aK3KMM9LFSQooz
	 gNF8BWKXCev9121Gr6nUJ5Za+GEOfW84b07CXX5gf0e6ABVJHhZrFkZUP631ckcJLx
	 98sNq/kaQxWgOLWOckxPaWW00ThSFRmkUlc8idVVN9lwxbvnk5Ie2ufO1hCuyoKXNX
	 6MYLBzRv5ER0w==
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
Subject: [PATCH 05/12] perf jitdump: Check snprintf return before computing header size
Date: Wed,  5 Aug 2026 18:26:55 -0300
Message-ID: <20260805212704.267779-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
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
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 078d3304d2b7ebce..d7e3dcfc63b78edb 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 			jd->dir,
 			nspid,
 			count);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= sizeof(event->mmap2.filename))
+		size = sizeof(event->mmap2.filename) - 1;
 
 	size++; /* for \0 */
 
@@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	         jd->dir,
 		 nspid,
 		 jr->move.code_index);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= sizeof(event->mmap2.filename))
+		size = sizeof(event->mmap2.filename) - 1;
 
 	size++; /* for \0 */
 
-- 
2.55.0

