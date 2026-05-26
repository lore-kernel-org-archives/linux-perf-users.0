Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C23C344B;
	Tue, 26 May 2026 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830382; cv=none; b=dmM1/oNLi5ygOP9sWSH2kSg9TVzKozPAnfp/ooquePlh5HBWG3AqQHy1wuH0I8tS8JImHR94j7+h/f8CsmdnHrO9vXbSHQvAIkCxPok4OYhlwMfQDydcgQDwlLhif1DbYZGLXKA5qhmAFNinSS4h5zW0LVba4se6p16s3D4a2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830382; c=relaxed/simple;
	bh=w/pT8AP7RhSfJf8c4H672m1DgmrBA2oeSXO3E3FZegU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G06x6g4FTAbn+SrDeY7lYL638bziAmY5Q/M3mSQeGl6Vcx8SBlkP6KXV5UlE7tkEnXql4xLUNBkdJCHWPBMmWKFB9tA0JsGo2eS2i1SjZ20MlG9t/paWrke2GUOkP2JoucX6KMXwQyODm14TlYUk4SOMMB0KJg49GT1eFOXJ+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzULREIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzULREIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E335F1F00A3A;
	Tue, 26 May 2026 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830380;
	bh=lkbSJHOm8dsNCLi2f3ly1BjsY0Qy63cC+DmLvcV8EYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzULREIYAmWnjHcxAx8ykbgH7VvAwIYwM2MnSzoMaZuYpPshItgu6qIFiFAeZOUi9
	 tADniuIL4geA/g0GuVHXhiCJkF7YhR/fLppHFKN6jw/iEbsTD9R0B/AUrGGu0Mi+LK
	 xW3u+NE9DR7UpJvtzIO8TwRX2XX3EyU0W6Sz+refmh5u72vy45uBg/rccE7XeeXgGe
	 rM85aEC0f3j2/4YeCClQ7ZJIZpRx+xjOd+8ulEvkB8YndFVZ5vPAl4govyuuZzcpfk
	 y9KSZAbCpctWNnR5EiHVti1PIBf54jMRnqM+DaWLXfZI+MJjrccmPC9DRdkGxM2UoO
	 IMykCpB02bw+A==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 25/29] perf session: Check for decompression buffer size overflow
Date: Tue, 26 May 2026 18:18:01 -0300
Message-ID: <20260526211806.1193848-26-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>
References: <20260526211806.1193848-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

On 32-bit systems, sizeof(struct decomp) + decomp_len can wrap
size_t when comp_mmap_len is large.  The preceding patch validates
comp_mmap_len alignment but does not cap the upper bound, so two
additions can still overflow:

1. decomp_len += decomp_last_rem: on 32-bit, adding a u64 to
   size_t silently truncates, producing a corrupted decomp_len
   that would bypass the subsequent overflow check and result
   in an undersized buffer allocation.

2. sizeof(struct decomp) + decomp_len: the final addition could
   overflow on systems with small size_t.

Add explicit overflow checks before each addition as
defense-in-depth.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/tool.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 18641919473a859f..25c9b378aa163664 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -34,9 +34,22 @@ static int perf_session__process_compressed_event(const struct perf_tool *tool _
 		if (decomp_last->head > decomp_last->size)
 			return -1;
 		decomp_last_rem = decomp_last->size - decomp_last->head;
+		/*
+		 * Check before adding: on 32-bit, size_t += u64
+		 * silently truncates, bypassing the overflow check
+		 * below and producing an undersized buffer.
+		 */
+		if (decomp_last_rem > SIZE_MAX - decomp_len - sizeof(struct decomp)) {
+			pr_err("Decompression buffer size overflow\n");
+			return -1;
+		}
 		decomp_len += decomp_last_rem;
 	}
 
+	if (decomp_len > SIZE_MAX - sizeof(struct decomp)) {
+		pr_err("Decompression buffer size overflow\n");
+		return -1;
+	}
 	mmap_len = sizeof(struct decomp) + decomp_len;
 	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
 		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-- 
2.54.0

