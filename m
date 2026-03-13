Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121234751C;
	Fri, 13 Mar 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408097; cv=none; b=P9SPHs/HuyxFxbNCz++J6pMN+s1HIg4i/OJfXHJrHe5ag5WP5Q2mrXuv1hrcV005BFUf90sDP8Y8m/ocogho2C+7+jS2KKhsX6q3mQGroc6AsXuhzxqVzcn30T1ymAyA55mM+bC5bjkhSscWAMfHc7ysKdlvehciK7GBV/hKU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408097; c=relaxed/simple;
	bh=bd1TbJp7Yd89q3Q2WVca8kp+kj8hFLLlbenP86LlzL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TekcT9wXkD0ZpOGHbjlaGj0KWxM9XErTA4B0+AgORGns7yGmfv1jXLJ3XSzo/muu6Tpu1hUiAXkXOjRcJvpuIpfZia1X/S/QwhZApCG3dM5tlEJLiE/x55J0s9m7ns8Ef8buiY7QwC+mXartitRFKbWd5am+tT6BzP2Z8K6f+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4A4176A;
	Fri, 13 Mar 2026 06:21:29 -0700 (PDT)
Received: from e142892.manchester.arm.com (e142892.arm.com [10.33.8.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF0A63F73B;
	Fri, 13 Mar 2026 06:21:33 -0700 (PDT)
From: Mike Leach <mike.leach@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	acme@kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@redhat.com,
	namhyung@kernel.org,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 1/2] perf: tools: cs-etm: Fix print issue for Coresight debug in ETE/TRBE trace
Date: Fri, 13 Mar 2026 13:21:28 +0000
Message-ID: <20260313132129.2743468-2-mike.leach@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313132129.2743468-1-mike.leach@arm.com>
References: <20260313132129.2743468-1-mike.leach@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building perf with CORESIGHT=1 and the optional CSTRACE_RAW=1 enables
additional debug printing of raw trace data when using command:-
perf report --dump.

This raw trace prints the CoreSight formatted trace frames, which may be
used to investigate suspected issues with trace quality / corruption /
decode.

These frames are not present in ETE + TRBE trace.
This fix removes the unnecessary call to print these frames.

Due to an addtional fault with the OpenCSD library, this call when ETE/TRBE
are being decoded will cause a segfault in perf. This fix also prevents
that problem for perf using older (<= 1.8.0 version) OpenCSD libraries.

Fixes: 68ffe3902898 ("perf tools: Add decoder mechanic to support dumping trace data")

Reported-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Mike Leach <mike.leach@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3050fe212666..f7e89693cf16 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -739,7 +739,8 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
 		goto err_free_decoder;
 
 	/* init raw frame logging if required */
-	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
+	if (format == OCSD_TRC_SRC_FRAME_FORMATTED)
+		cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
 
 	for (i = 0; i < decoders; i++) {
 		ret = cs_etm_decoder__create_etm_decoder(d_params,
-- 
2.43.0

