Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864C337B9F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031473; cv=none; b=dyQNVQAVD5P6ywTTAP5G3+8S+Pep3Kchh8FTQYG/7q87aSbn5mfvgs0wtcJmCF+IJsto4FKS4zck21otEHGsQtzynrcWUoQWE0MCoZIe2xqljk0MbCEO3xlPzImLhyxBg8zSHip6XfFQBCUw2S8+30wn7uOXgegff+V/GuV3at4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031473; c=relaxed/simple;
	bh=JEDHEeHplqXn7/z58T8cqTyw0I4jR/py96X9534o7VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iqCY5UZuHvYVli66rqvMUZzABjIdgDYTD/MxzKQor0g9MLFT8Q6EWF05/Q93acNAbTjtal1JSPKBRl7M2Ii0O1S2G7/ZWD3tFV/a9B/G2I0I7OyN51kz1ZTvuKLsBG95wahk4bIaqKBirppCoM5S/uuBofi568qZJmZx6MIQ1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CBE112FC;
	Thu, 13 Nov 2025 02:57:43 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34293F66E;
	Thu, 13 Nov 2025 02:57:49 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 13 Nov 2025 10:57:39 +0000
Subject: [PATCH v2] perf arm_spe: Add CPU variants supporting common data
 source packet
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-perf_arm_spe_update_midr_list-v2-1-d547768f5520@arm.com>
X-B4-Tracking: v=1; b=H4sIAKK5FWkC/42NQQ6CMBBFr0JmbU1bqURX3MOQpraDTCK0mSLRE
 O5u5QQu38/L+ytkZMIM12oFxoUyxamAPlTgBzc9UFAoDFpqo6RqRELurePR5oT2lYKb0Y4U2D4
 pz+J+NrX32nkZApRGYuzpvfdvXeGhSJE/+92ifuu/5UUJJS4Ba9kYI0+mbot69HGEbtu2L5oAb
 pXIAAAA
X-Change-ID: 20251017-perf_arm_spe_update_midr_list-b654cc2ac0dd
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
 Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763031469; l=2390;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=JEDHEeHplqXn7/z58T8cqTyw0I4jR/py96X9534o7VQ=;
 b=lMdTaX4c6NaFZSKte1Bs7+Lplifa78Kf/rBbmE3GUtVPqWzTzDxV3om6G1IHMWsMvUWe2MIIv
 kfBfJBqLs9uA3rQmeor7cXssSEjLfqvcEYAwyiKAZeU5WojCyXHTj9s
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add the following CPU variants to the list for data source decoding:

  - Cortex-A715 [1]
  - Cortex-A78C [2]
  - Cortex-X1 [3]
  - Cortex-X4 [4]
  - Neoverse V3 [5]

[1] https://developer.arm.com/documentation/101590/0103/Statistical-Profiling-Extension-Support/Statistical-Profiling-Extension-data-source-packet
[2] https://developer.arm.com/documentation/102226/0002/Debug-descriptions/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
[3] https://developer.arm.com/documentation/101433/0102/Debug-descriptions/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
[4] https://developer.arm.com/documentation/102484/0003/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet
[5] https://developer.arm.com/documentation/107734/0002/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Rebased on latest perf-tools-next branch.
- Link to v1: https://lore.kernel.org/r/20251017-perf_arm_spe_update_midr_list-v1-1-9de407550354@arm.com
---
 tools/perf/util/arm-spe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 614ce032f87e46d1f3754258f51bb1693ec128b7..f5bcc84eaa271f4dcc70bb585e517657e523de11 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -570,16 +570,21 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 }
 
 static const struct midr_range common_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720AE),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 	{},
 };
 

---
base-commit: da8fcfba0854dbe0b0eca465d35620c9cf4c89c1
change-id: 20251017-perf_arm_spe_update_midr_list-b654cc2ac0dd

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

