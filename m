Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0CC4AF14B;
	Thu,  3 Sep 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441808; cv=none; b=i7KZTLKzHUAqRLEu6iJRHsCzAYfPUapS1dnZm34Q4z9SJunrUlGyOESF+Yg7ltQLteagvjOoMbeIAb+ogomDW0nhLIvmGrTTDz45K/9ybQfa6v8OqJDmTEVcrTJBSYHh/na8LV6MWc+4bmh36WS29z9SekM5SEYMkB9YNc0icdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441808; c=relaxed/simple;
	bh=5hEhJUAi/thyWbcDgFlB22m8l2sq4GBoKIV1ou5jN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W48B695l/rglF7nN3Jhk5A69jFQlUSlHOaJhbRaz3+rb9SaHzOKCLHf1yR+lD7EKRvjHy+/XIgHfTszbqUC02v+npXCo9sC1cNQ1xJzXazXAyCWEfGPwlHyee/D7m9KL3yGI61Vf6x7ZTbG6Eg2oDkF8fG8nFY2hWB9LESGMIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcdFtvPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcdFtvPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D1A1F00ACF;
	Thu,  3 Sep 2026 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441786;
	bh=FFS9RizjkOWavg/h9KaPhTtsqZ2GndXNrlnfx0cHXJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcdFtvPzB5hCqDDBCFV6Z/QffAatGji4Mox2ousLXJ8BEvQ4WWFce0ioL6b0cXf8q
	 PtV+ry2zGMhSzM+UTaqetV8JI19Dv7QMeXKV9V4q8qLGx6BPYKYnbcHgANXJWaA98z
	 60c9ZteFHU3GYlIW70ecZsg5Spi9t27KkpBGE4UPP+8Nb9TlI9cHN1F1BC8aaLpPJS
	 rLeNLNWT+EwH8fP77i1B2Wt9bOYThYlGvUz5ZyVyFo4r0ICCem7H+U7EBlr4FTDVwF
	 RuxRZjWCbdmnl272zwUo3/MXU9/jJF2fYKaKP4E0DcbE7vg+nZqOqDtHqbJEx0Ql71
	 U4wWF5qWDKYLw==
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
Date: Thu,  3 Sep 2026 10:22:49 -0300
Message-ID: <20260903132251.237029-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903132251.237029-1-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
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

