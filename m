Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFF4315D5A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691772; cv=none; b=khKzoCpfzwds3kNZeOwjv77EDYqf4U3VI0iyLLfFi1h48W9KDPrINChhf4I2zFTmBV30KG+aU7/d3f67NIP/cutSh6oW/2vF8iJGNuZY7JgsuTCDxIS4pbRp9iM3SRTr0jNkryPnG+llpwDd/Qz9JNkfyVGSawDup7HHS6GpP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691772; c=relaxed/simple;
	bh=poQSrE8+agtROzK3SJkDGdSS+DLmvWqii95ZKrQmWUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aODdd+HqKbsbZBu+dZMXMlnJKICPkB+YltBluUsykZNUkk5rL12g9x0ps8+Ww+C2i/YX3n6+M87Kg/4Inzv69aVDnQen1hLwKzv1OiSmHBzEFAF0unq8SZhd/PrvbWalUpylBqyu8Ybc5Sq93E8v6jsO9XMo5NO8t8Vemq/m2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21A9528AC;
	Fri, 12 Sep 2025 08:42:42 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6069F3F694;
	Fri, 12 Sep 2025 08:42:48 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Sep 2025 16:42:09 +0100
Subject: [PATCH v5 04/14] perf arm_spe: Correct memory level for remote
 access
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-4-0800880da0a7@arm.com>
References: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
In-Reply-To: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691759; l=1140;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=poQSrE8+agtROzK3SJkDGdSS+DLmvWqii95ZKrQmWUc=;
 b=JK7dtKHfHS8CR5ivNrGqq7P1B6llM+d2JiEzDl8Ns/yVKFH4W6evy57eZJuX0zDCn25Zoqeyf
 FTLtmf7QCRFCQMrC5+/QJeQvQ7XV5tmKDdZIKz0gmEkaOn0u4LYrteT
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

For remote accesses, the data source packet does not contain information
about the memory level. To avoid misinformation, set the memory level to
NA (Not Available).

Fixes: 4e6430cbb1a9 ("perf arm-spe: Use SPE data source for neoverse cores")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 63a32255197ab8b1400badeddfb439d4dc5813c4..6fb012d89488c1e5d4866ec62a2df2bc895cb6ca 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -659,8 +659,8 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
 	 * socket
 	 */
 	case ARM_SPE_COMMON_DS_REMOTE:
-		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
 		break;

-- 
2.34.1

