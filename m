Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A812C11FA;
	Mon, 25 May 2026 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671256; cv=none; b=ZCWY2ZDFJ9rm01oS1CRbhTBqhmJ6YGkp9OmnA+7s25xb3cm+OfjclpNOZRGwKgQv264lg/QgG04O7wun6eLpXfdE429tg5R1O/gvKxwilPp5F4FpI0DRiUM8xWgU32j4RzU8Pc0iMGbJYypdmxDBaRrvko0iXT33j8oKoa2c9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671256; c=relaxed/simple;
	bh=/DCnT6jDug1BmvSNjveuZ+WerLEOJejT2NJhiI8D0/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbbtnCWuY5DFUw9Lf0GR/MbPMTiblEmUib0NbuxfeWEKBhSt/v/SZoPq0xCrqZxDtLRdeijiVRB4+KJAGlefACT4q0IF+FlqIPmoVP1EPz6TS1VOjgGy2mHDFn60WEwEXsnaBuZ15N2L3xSCzQJo2k0SWt6G/cirWoGeFIYMEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxcgUZ7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxcgUZ7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2111F000E9;
	Mon, 25 May 2026 01:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671255;
	bh=XbcPDwGAi64vr2qIRi1JYjbatAK0bs/CUotXphvheJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxcgUZ7ZJGcL0gN/bzY783fD6l4tfyYpbg3w+qIKdnBD7v/+kD8ljfBANYW5JTQg5
	 by7Qq0tPqGhVVob3EIq9kxlrV2v+8OD+rz6uSz6a3duVQPv9chuXWeMosq4Bfdwvhj
	 Sdqz6kyjIQOIozeF3YGuYipmEQN0RfaB6jruLHb1td3BbVtBQSJTryho4Gq2Fh6cBA
	 vy7nwCfyZUjbvOIJglUnKuxdGUFmXSB4cw57ho7cHYvpelMJbvOEhnlDrbV1O6UteF
	 ckWWpCQuynYVXRpAuEjJAkOad+3QLQ3ckACaJSktJqdD7MZcqSARtkhmHX+BTUJG21
	 Tuvb+QeTgXxVw==
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
Date: Sun, 24 May 2026 22:05:45 -0300
Message-ID: <20260525010550.1100375-26-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525010550.1100375-1-acme@kernel.org>
References: <20260525010550.1100375-1-acme@kernel.org>
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

