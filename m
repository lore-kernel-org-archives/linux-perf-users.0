Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826045474F;
	Fri, 12 Jun 2026 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224499; cv=none; b=BrIRtgY9VGXnts99g9sAJEmRXdSzfqQfrnJgj96MwMDoHOKVvwLeESjUQ21P5gp+8RnLjiOZwvo91dYb/JtxLrPs69IG7stk7pbylHssCGwPv9lro5NLDEYyZnvdlRvb+PlIaHKSV2URGbiBdmw+Q6WwgukpBLKAdL8X2egazUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224499; c=relaxed/simple;
	bh=LPfqgijeLC1IhUy/+y6OUmNFlDsUd0sJjAwzsLer54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6q1if1cvB0dP7JTCCvBJ7KibVYNX/ZKjPHYyqkYcqUNcrwlt2+q8dytzjwjxFqnPZ1VdaV2cvRvrEyxiBwye267z13H6/yvIZsXgDbIuWZJfYSfRDGIuSEdbBaQmBjzhq7gdOEFMwD6aTGmNJMqmJsz4j5WWCoBJ4CRwsCmLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEGsS02W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEGsS02W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18351F000E9;
	Fri, 12 Jun 2026 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224498;
	bh=3yySncgWe3MwM9qPjrXV0BV1fEsK543HDSbXQn4f+3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EEGsS02W0LYcJwuwP8zgJE/UQYqRSmtDJImHbmWHRcCkxgxantXOgQPrPtr6VM3WX
	 lDtmtrXRFvK/UXHM0jUtBLdR+EEf3KXGI+b3TMNcc+9RZ3NxcYI+OJvcW2co9tCkQO
	 FNrPP/Q/5hwQTHg/8MC0QmQVjtaJp6FtGYek6raeOVSWLf7ZcSuPQxLkdFGIx8IBk6
	 Iua1g9H/yoAsPq5RbTk2twkptl2ZHzzSHRgjGPW5YEYlD+uaC5svFkXfZDNBcMZ8oQ
	 pC/19LH2RxgiFBEwOaCtOG1BhZRZWpgCfuy064W7rBBd09l4ZNxlSI5heOE8MH+X6j
	 SVx0E3jG2HMkg==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 02/15] perf symbols: Validate p_filesz before use in filename__read_build_id()
Date: Thu, 11 Jun 2026 21:34:30 -0300
Message-ID: <20260612003444.50723-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__read_build_id() stores ELF p_filesz in a ssize_t variable.
A crafted 32-bit ELF with p_filesz = 0xFFFFFFFF produces ssize_t value
-1.  The comparison `p_filesz > buf_size` evaluates false because signed
-1 is less than any non-negative buf_size, so the realloc is skipped and
buf remains NULL.

The subsequent read(fd, NULL, -1) returns -1, which equals p_filesz,
passing the error check.  read_build_id() then dereferences the NULL
buffer.

Add an explicit check for p_filesz <= 0 before using the value,
catching both zero-length and sign-wrapped negative sizes from crafted
ELF files.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: ba0b7081f7a521d7 ("perf symbol-minimal: Fix ehdr reading in filename__read_build_id")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-minimal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index f4b0a711a62cf3de..0a71d146395271a6 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -186,6 +186,9 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			continue;
 
 		p_filesz = elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr64[i].p_filesz;
+		/* ssize_t can go negative with crafted ELF p_filesz values */
+		if (p_filesz <= 0)
+			continue;
 		if (p_filesz > buf_size) {
 			void *tmp;
 
-- 
2.54.0

