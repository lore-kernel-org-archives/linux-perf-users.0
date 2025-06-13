Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788D19E7E2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830067; cv=none; b=gq1cyH3sT4HlzWkA0CMw+n00AAl4Dr0vfdFaf2U28lHngun/aZB1uRn5xiwqrqrwOd+/uUyDo9sSCFYcm9isfT/ReVbPX7GOXQMy1CnQpYKVXdv1xD9HMV6FhHFk0g41wHA4D8GRLNgJJmczUy4QwlR7a3+zT8ymffbLhphy7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830067; c=relaxed/simple;
	bh=eshcdLLlNIy+/NOBSwdTwt3N0IPW+kbq82UNKpVsUkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHs2w+uJLFlUKFoYRzIexmq5BtsKPoKvDKAHwrf31lBMiNssfU7MWf6Jx2WXUu+SGA+FJ0M7Z/i3Bo2ccMZs/BB09rGlbTEvZi05IvNiKLfh9J9/Kx6UonUngFzyvaT13vYhSSfGhKVnZDog9nhyJUGCHlQzfbPWVOvn1Pi0Jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54D71204C;
	Fri, 13 Jun 2025 08:54:05 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14003F59E;
	Fri, 13 Jun 2025 08:54:23 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Jun 2025 16:53:38 +0100
Subject: [PATCH 05/12] perf arm_spe: Decode event types for new features
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-5-6faecf0a8775@arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830053; l=2646;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=eshcdLLlNIy+/NOBSwdTwt3N0IPW+kbq82UNKpVsUkY=;
 b=24E85IjtczNmy1LsdabPH1xmXzGlquF5YwgJhwVhbuQcPfFAXTfy8Z7bhUgwGNIboky/hvivD
 NLTmgxbtBcLAnkXS8Zu6rI1JLhIitV0V2B4cm2aRoaQL2J0nqvX91BA
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Decode new event types introduced by FEAT_SPEv1p4, FEAT_SPE_SME and
FEAT_SPE_SME.

The printed event names don't strictly follow the naming in the Arm ARM.
For example, the "Cache data modified" event is shown as "HITM", and the
"Data snooped" event is printed as "SNOOPED". Shorter names are easier
to read and review while preserving core meanings.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 14 ++++++++++++++
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 13cadb2f1ceac7a90e359c4d6aa1d5fc5169e142..80561630253dd5c46f7e99b24fc13b99f346459f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -314,6 +314,20 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
 	if (payload & BIT(EV_EMPTY_PREDICATE))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
+	if (payload & BIT(EV_L2D_ACCESS))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-ACCESS");
+	if (payload & BIT(EV_L2D_MISS))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-MISS");
+	if (payload & BIT(EV_CACHE_DATA_MODIFIED))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " HITM");
+	if (payload & BIT(EV_RECENTLY_FETCHED))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LFB");
+	if (payload & BIT(EV_DATA_SNOOPED))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SNOOPED");
+	if (payload & BIT(EV_STREAMING_SVE_MODE))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " STREAMING-SVE");
+	if (payload & BIT(EV_SMCU))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SMCU");
 
 	return err;
 }
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 2cdf9f6da2681244291445d54c5b13fe8a2e9d9a..d00c2481712dcc457eab2f5e9848ffc3150e6236 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -108,6 +108,13 @@ enum arm_spe_events {
 	EV_TRANSACTIONAL	= 16,
 	EV_PARTIAL_PREDICATE	= 17,
 	EV_EMPTY_PREDICATE	= 18,
+	EV_L2D_ACCESS		= 19,
+	EV_L2D_MISS		= 20,
+	EV_CACHE_DATA_MODIFIED	= 21,
+	EV_RECENTLY_FETCHED	= 22,
+	EV_DATA_SNOOPED		= 23,
+	EV_STREAMING_SVE_MODE	= 24,
+	EV_SMCU			= 25,
 };
 
 /* Operation packet header */

-- 
2.34.1

