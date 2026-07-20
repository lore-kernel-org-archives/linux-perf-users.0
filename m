Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38A305665
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541698; cv=none; b=ipig2NXvpb/ZjO+LcXzXNjkCA7tvHqfuTevLOIo/KI+mAOR/8wocS8UabDDYZUvprvKy4EL0Mfmo7UaPM4mU5MLRegpGNTe1Es3qBNWSN1Wxr1d19yv/5BfZYWuCPgJUA2PwTAgfXwMKfgrvvqZpQDq4yxtuF7ZNG5pLog3MeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541698; c=relaxed/simple;
	bh=HvH60az2pgbHIpr+00e5DtDk22sQ4vHKOnqPd/nOpz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BUuM5pp8Dp5TIj9PstgdnLOK8UbueuTSTFrnRy7YI33op5PeDxlb4wK99l7QBBfV9Nk4YdBdH0yM/QOhjFGmw+2AmZZcwwgLsGgCLpGkM0Nx0wcNGx563RDWMlJV/CfBecLRotJag29CH3CmISIWR4uPyBwkil5FI9KnT25o028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=USzRiFif; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="USzRiFif"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC302B;
	Mon, 20 Jul 2026 03:01:31 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 665193F86F;
	Mon, 20 Jul 2026 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784541695; bh=HvH60az2pgbHIpr+00e5DtDk22sQ4vHKOnqPd/nOpz0=;
	h=From:Date:Subject:To:Cc:From;
	b=USzRiFifRaM1egoAR25PE6nkkvG/vL0F4AoCyTalJzWFsyjlhkjfYuMogevZ+GW4k
	 VL7r3jjtXSFzMG/GMCuYDpIR1nODL3AV7mYe5I6LHgx4snMReu6XYdIIU+e4EBbKvi
	 njLcrRjiplmJrv48wa/td74yukWe6CNsVCydGywE=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 20 Jul 2026 11:01:21 +0100
Subject: [PATCH] perf cs-etm: Avoid truncating AUX buffer sizes to int
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
X-B4-Tracking: v=1; b=H4sIAPDxXWoC/x2MwQqDMBAFf0X23EAMNCn+SpHFxhe7B61ki4iSf
 zd4HIaZkxRZoNQ1J2VsovJbKrSPhuJ3WCYYGSuTs87b4KxZkRNHZfxnTrLzRyZWOWAQn96+UvB
 hTFTzNaP6e/3uS7kAbyJ1zGoAAAA=
X-Change-ID: 20260720-perf_cs_etm_fix_big_size-ec5608f767df
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Suyash Mahar <smahar@meta.com>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784541694; l=3060;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=HvH60az2pgbHIpr+00e5DtDk22sQ4vHKOnqPd/nOpz0=;
 b=EnprNlHgaiV8R5vwtyiaanocyQCXT4KPvm+chm9kn032dyPaIvytisSsqcb3dx6lzIeYbZNw+
 wkUGCFRpZusC1HQ2RQ2csrA2ZjJr7WSFPq1zcG9LPH4NpBY9Pv2RtAG
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__get_trace() returns an int, but it used to return etmq->buf_len
on success. That value comes from auxtrace_buffer::size, which is a
size_t. For a large AUX trace block, returning the byte count through an
int can overflow and make a valid buffer look like a negative error.

The callers do not need the actual byte count from cs_etm__get_trace().
The buffer length is already stored in the etmq->buf_len. The callers
only need to distinguish three states:

  < 0: error
  = 0: no more AUX buffers
  > 0: data is available

Make cs_etm__get_trace() return 0 for all non-error cases and use
etmq->buf_len to indicate whether a new buffer was found. Then make
cs_etm__get_data_block() return 1 whenever data is available, instead of
returning the buffer length.

Also refactor cs_etm__get_data_block() to make its return value
semantics clearer.

Reported-by: Suyash Mahar <smahar@meta.com>
Fixes: 8224531cf5a1 ("perf cs-etm: Modularize auxtrace_buffer fetch function")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 95e3ec1171acc8442d8539a72a26a1a5a53a2f37..114b3cd2da495e54e78df8fbd707898312f95079 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1467,8 +1467,7 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 	etmq->buf_used = 0;
 	etmq->buf_len = aux_buffer->size;
 	etmq->buf = aux_buffer->data;
-
-	return etmq->buf_len;
+	return 0;
 }
 
 /*
@@ -2151,26 +2150,33 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
 	int ret;
 
-	if (!etmq->buf_len) {
-		ret = cs_etm__get_trace(etmq);
-		if (ret <= 0)
-			return ret;
-		/*
-		 * We cannot assume consecutive blocks in the data file
-		 * are contiguous, reset the decoder to force re-sync.
-		 */
-		ret = cs_etm_decoder__reset(etmq->decoder);
-		if (ret)
-			return ret;
+	/* The current block is not finished */
+	if (etmq->buf_len)
+		return 1;
 
-		/*
-		 * Since the decoder is reset, this causes a global trace
-		 * discontinuity. Flush all thread stacks.
-		 */
-		cs_etm__flush_all_stack(etmq);
-	}
+	ret = cs_etm__get_trace(etmq);
+	if (ret < 0)
+		return ret;
+
+	/* No more buffer to read */
+	if (!etmq->buf_len)
+		return 0;
+
+	/*
+	 * We cannot assume consecutive blocks in the data file
+	 * are contiguous, reset the decoder to force re-sync.
+	 */
+	ret = cs_etm_decoder__reset(etmq->decoder);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the decoder is reset, this causes a global trace
+	 * discontinuity. Flush all thread stacks.
+	 */
+	cs_etm__flush_all_stack(etmq);
 
-	return etmq->buf_len;
+	return 1;
 }
 
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,

---
base-commit: e01c7bd5b1eece254bcbf282db066b12c4815d21
change-id: 20260720-perf_cs_etm_fix_big_size-ec5608f767df

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

