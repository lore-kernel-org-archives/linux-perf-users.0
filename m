Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA1285CB4;
	Sun, 10 May 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384209; cv=none; b=rbgV/Wl+rrlh7YPnHTtfVSd/ENHmDGSQSYwstav8l7SRwdTrl8elBSt4S1y/FoYREYKIh5kyIDaspgXEsA9kXkFAp0a96NNldS5kNWHxHD1IFN7+4WAqqH2X93oNshdwop5P/H2Zy7uRLsAGGwowmzrmH+WFT6ZXQvNfxhpW34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384209; c=relaxed/simple;
	bh=BmgSgr1QoQ1SSGA4sPYjM5DUkysC6eOki83batJ4ME4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYllW7TTRPyz+F5IoJrOxdnflrSDlsPg1gKh3FYD2OtDr83lrQwDSgaHbzOhWJVpSuOoqKgcdUS2D3rXg7I3K1L6jNVLrGtPonmTUXVvZTnOCzLE/ph2otbKjKbYVTjhLdkw78JUKQ0A6PAYx+P+qnJrwgfixejAyDxBu0RgDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4uFi53a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4uFi53a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D68BC2BCF6;
	Sun, 10 May 2026 03:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384209;
	bh=BmgSgr1QoQ1SSGA4sPYjM5DUkysC6eOki83batJ4ME4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4uFi53aRs03Kf/xtylfUfK4MT3TTrgpgjcspSSQxewWJSlhm2jMqKn9LSD+YgH8v
	 ds7FQZjXjW3Rg/TMasp6uq8/sbty8NhkwTL84iCQMy0oJ6wWYZxFjDRNaDt+rhi1z5
	 /lC5Ynp+c1SD09/hEJZ7h2mv/P+KvWrGpEBogV9iY0MjAyXQ516Sjv+8AfycL3NWog
	 t2K68QPW+mP3mVpa6EiZw60STbpOon/IcpOIIwtLr+D5eZAadwd2EZTyqi7+vsaM7b
	 A+g0DRfhBT3Ss/EFST74TFsRxp35lRqzpUlUigPtgVn5tUxqsDlmyq8UV8Q1hoUHYR
	 H2jdHc61tMnNA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 24/28] perf session: Check for decompression buffer size overflow
Date: Sun, 10 May 2026 00:34:15 -0300
Message-ID: <20260510033424.255812-25-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
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
comp_mmap_len at ~2 GB, which prevents decomp_len from exceeding
SIZE_MAX after adding decomp_last_rem, but the subsequent addition
of sizeof(struct decomp) could still theoretically overflow on
systems with very small size_t, resulting in a tiny mmap allocation
while zstd receives the original large decomp_len as the
destination size.

Add an explicit overflow check before computing mmap_len as
defense-in-depth.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/tool.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 96fa6d6c55cdca1e..bb13d526ce4c3382 100644
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

