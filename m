Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE1E766F;
	Mon, 25 May 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671183; cv=none; b=L9lYOqsxQXa04A7OcgoD+tNhqEycqaPTy34wa8CquTUa3tUcm8bXgJ+3we5EUVAqWgELt8ffqRUbha/fOBNd2oIIdsz5dCkGiZj32UbMwlCf2tGt4/aH1fG8eFWOVpkM7nzLAtSq3o+mSl/eKfOQeT/5xnl7kKM201rAtbeIOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671183; c=relaxed/simple;
	bh=t4MWiZOVnbvgN1FLY3y20WYpEcIeoyhE5ptaJr2ZZp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kddh/GVWOFSffSTerjT6aHbR/2kirHRQ8O/ODPx7PozbQiogRtnAy4S1C9ruT0khs2c+hD1KuLItoP/lpYKu2bXQHLC3Puptau9aaFHr5+zZHuNv0pSeFTG707XxiP0FV2nRmd7TCuCWinbOCMsz5cSTvxswLBxjVivQIZHG0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRPafgxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRPafgxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3291F00A3A;
	Mon, 25 May 2026 01:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671181;
	bh=J8t0BS/K7fNTh75SuO9HWTTq8JhLusrqBgf02oogCjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QRPafgxs66gHB5pxqfUSLE8LGfqAzAn4t5ruDHpHHYFCt6UCDZ1UCxNzx6Hg1wUy6
	 IdjnP9zk+dNqUfOr5InQNG+hwUR79AxX+kQ75+Dgt/xHKz4neEiJmaR1Nz1ud8b80P
	 FquiQcXOaNgclQoTc3faCcN4hFCSrK4WWZwJtQYP8we/0NTg97Tux8bAVcs58r8Itk
	 OOOfBaMj2OjpY8buR5CXUJLh5LAQ/vUASE/Aseji9CcxEqBWOrt6vnkLwO1d4YBZzp
	 9eMqdJOKBez3U1RJiIewtIcrf8ebhDsRI0MCzAVnmcQ5A0oawSFsXqhNSCi4rk3CJT
	 wI4uMynR4qRAQ==
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
Subject: [PATCH 05/29] perf zstd: Fix multi-iteration decompression and error handling
Date: Sun, 24 May 2026 22:05:25 -0300
Message-ID: <20260525010550.1100375-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525010550.1100375-1-acme@kernel.org>
References: <20260525010550.1100375-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

zstd_decompress_stream() has two bugs in its multi-iteration loop:

1. After each ZSTD_decompressStream() call, the code advances
   output.dst by output.pos but doesn't reset output.pos to 0.
   ZSTD interprets output.pos relative to output.dst, so the
   next iteration writes at (dst + pos) + pos = dst + 2*pos,
   skipping a gap and potentially writing out of bounds.

2. On ZSTD_decompressStream() error, the loop executes break
   and returns output.pos (which is > 0 if some bytes were
   decompressed before the error).  The caller checks
   !decomp_size and skips the error, silently accepting
   truncated or corrupted data.

Fix both by removing the output buffer adjustment — ZSTD
correctly accumulates output.pos across calls without it.
Return 0 on decompression error so the caller detects it.
Add a no-progress guard to prevent infinite loops if the
output buffer fills before all input is consumed.

Note: the compressed event data_size is validated against
header.size by a subsequent patch in this series
("perf tools: Harden compressed event processing").

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/zstd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index ecda9deb53b738fa..21a0eb58597c21f9 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -123,14 +123,26 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 		}
 	}
 	while (input.pos < input.size) {
+		size_t prev_in = input.pos;
+		size_t prev_out = output.pos;
+
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
 			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
-			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
-			break;
+			       src_size, output.pos, dst_size, ZSTD_getErrorName(ret));
+			return 0;
 		}
-		output.dst  = dst + output.pos;
-		output.size = dst_size - output.pos;
+		/*
+		 * Neither stream advanced — decompression is stuck.
+		 * Return 0 (error) rather than partial output: perf
+		 * uses ZSTD_flushStream (not ZSTD_endStream), so the
+		 * stream is continuous across compressed events.
+		 * Discarding unconsumed input would desynchronize the
+		 * decompressor, causing the next call to produce
+		 * garbage that could be misinterpreted as valid events.
+		 */
+		if (input.pos == prev_in && output.pos == prev_out)
+			return 0;
 	}
 
 	return output.pos;
-- 
2.54.0

