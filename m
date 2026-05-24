Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DF2848BA;
	Sun, 24 May 2026 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593276; cv=none; b=LzkkvrsNiHKuXTonzZQeX7DDZIpAFjxmcfco4uncwcfKoL/DJmjzsNtDxdYpaLzE9r3GoGCZJQLR076pYxMosRynRhNiIOCe5VRS3W6bb9z+OSVdGvP9TyL9HwoC66p7C0m9NySHEDTyTgztG60rF+G7XH0f4o6UDo5xy9k+aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593276; c=relaxed/simple;
	bh=t4MWiZOVnbvgN1FLY3y20WYpEcIeoyhE5ptaJr2ZZp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxU+YclZ6weO5353gXu30WC9zIbEJoCkQQ4xinfvqdZv/1PdTzCxznyRZUwnBKRzKzxK+T40+v2CVrSfk7ceBctRWoCRYk4BMcqlaAy4t5et2z2mMjA58MUNsIs0UN2sujJtbD58LXF5nCyuBVS9haYdaPq0n2x5+m6QnTNdgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMXppHDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMXppHDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AFA1F00A3A;
	Sun, 24 May 2026 03:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593274;
	bh=J8t0BS/K7fNTh75SuO9HWTTq8JhLusrqBgf02oogCjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMXppHDXZyG9STJ27RosQNkTOIsv22DOl/0ddIFPyF6dxgWk2IsiF1s6t0Bi3nGbf
	 xWpKdvtiVeKH6l1TfuDyLXDdIwdSsCTFm5BMgmlBNuV9sh4X/7HiC7G3XXBD8bK22j
	 Q/HHeGHzQsFWfVNuFkiuFl1Ps20s8zwDBYHF9e64KujEDLh71LD6yTgNBnWPIoWeXo
	 M2oiSwHYfKbehUP6f3E3si8r7F62CeEpwZZnv8SuB/06OjK5R9YGsgvvTA1xolqK79
	 lRJ3ohNby9m3DWTGdkoihns14OCMGAF/tfAfPGpKAIP4eEP4YmsrDzAS+HhjLUTgY5
	 jUrFgHD2bGD3Q==
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
Date: Sun, 24 May 2026 00:26:39 -0300
Message-ID: <20260524032709.1080771-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
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

