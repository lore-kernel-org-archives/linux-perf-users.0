Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39260306768;
	Thu, 21 May 2026 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325934; cv=none; b=GIMsjjkFUc5bKf5LAV/TmbD92CQDiFMqRx8Jav6yn1TS7SN8DKuJLQyHFEdg+dL5JOr32g4eLhMDvtZpCQiw8ejakMbbxOPVvnkqN+yVxQiI7GrY6ATM1FNguzpEbs+WdB+dOYFUhqpstPaHEI5B+/5APEHh3vwd5yl//TvL34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325934; c=relaxed/simple;
	bh=/DCnT6jDug1BmvSNjveuZ+WerLEOJejT2NJhiI8D0/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4lud1pXhRDbcYD87FwwtsvdKiKbLPriIvivHOha/G5JzSHOZ3FMKE+gqtqjJlMS/Z7S/kVjnvf39WvsACBZIi7imQO6PWgYytM/tvz91M4X+a6nTkg07slK4kBealbEc8cvV+9bqENzo27rx7kRt8xsoxKLdiURA2esczQNOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFmfVL30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFmfVL30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB871F000E9;
	Thu, 21 May 2026 01:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325933;
	bh=XbcPDwGAi64vr2qIRi1JYjbatAK0bs/CUotXphvheJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HFmfVL30lA2uiSX4wss2NV7Xnq+JJ4VaoVPA8uCezLTM4bcx7Djk9Qx1hUfUAtwgk
	 s1fTIRioij1duA/QBTosFgN9DF2ff1mpoX7UK3Xjp4d8j1norm2X4H74ivBQX9/9M+
	 cUILB+4OW6Q/CI/7vhRrKJgq9yaFOdgkC8ns0kqHFzYBtGSd7xnuayjba7BUobP9gK
	 chlFASSA2Sm85gKi/7vXD+hsb1kWh+jA60KBY1gB+fVWy5fhU0L4uUSAxxXR+pVgqO
	 a89oe8WYXVU0XcSbTRGLxyJENM0mTLhlzuN+FksXJ3l4+GT/gr/vPtF82kQRTWW04c
	 JQXKIzFf/HtEw==
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
Subject: [PATCH 24/27] perf session: Check for decompression buffer size overflow
Date: Wed, 20 May 2026 22:10:09 -0300
Message-ID: <20260521011027.622268-25-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

On 32-bit systems, sizeof(struct decomp) + decomp_len can wrap
size_t when comp_mmap_len is large.  The preceding patch caps
comp_mmap_len at ~2 GB, which bounds individual values, but two
additions can still overflow:

1. decomp_len += decomp_last_rem: on 32-bit, adding a u64 to
   size_t silently truncates, producing a corrupted decomp_len
   that would bypass the subsequent overflow check and result
   in an undersized buffer allocation.

2. sizeof(struct decomp) + decomp_len: even with the cap, the
   final addition could overflow on systems with small size_t.

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

