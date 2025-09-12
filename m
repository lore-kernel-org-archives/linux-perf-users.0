Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8475315790
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691771; cv=none; b=Ux837MlRqh7EEPvYUazk6V37SZN9XOcw52UTo4DMBI3s6XuBh0XQUQ3dV1/CCeMaPB/zKsPilSg+Hq19/jFSzRf7OecHLDZ44igMFzD6ZImc99widXg4qZwVapA+PdFNnkHGXKDhcmbwoLw+APg7ZWjnX325uTzQ5/45/fRkUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691771; c=relaxed/simple;
	bh=2z6OBKjmkRcaEjC6nJ2ok4C6Eykyuq0I42TvhkxGR/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbcgfNW7xsMZEZ0FOjeAwGf3xeghO9+IpGfguSyRzPa53EPI6OYIMWoW6cfy+bb+9yLE6b9OiaKcotTlSevo5ySIU5/8kdzXwHZBI6IfW1YBCBFOJvUScoIuWoJ5TamOegKoIIOyzKjYBeJwo74FmQLTi/ZcKLL97VXifOv78qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04431A25;
	Fri, 12 Sep 2025 08:42:39 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF223F694;
	Fri, 12 Sep 2025 08:42:45 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Sep 2025 16:42:08 +0100
Subject: [PATCH v5 03/14] perf arm_spe: Correct setting remote access
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-3-0800880da0a7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691759; l=903;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=2z6OBKjmkRcaEjC6nJ2ok4C6Eykyuq0I42TvhkxGR/g=;
 b=bV1qZVsOEeEsJZvFVLs6LSjU2gXaRj1taC6EeKKhi1eQ2LIXLzAiK3YBnjcErnk0iSDsH9hGe
 SnDKDK4gfazBENgz3bPXlfh2oeDDkW0wfSCbsVr55pDwjQtKFfkU9Jf
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Set the mem_remote field for a remote access to appropriately represent
the event.

Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 228ed52e653d7873c1d07404671447db03a10e59..63a32255197ab8b1400badeddfb439d4dc5813c4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -828,7 +828,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
-		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 }
 
 static bool arm_spe__synth_ds(struct arm_spe_queue *speq,

-- 
2.34.1

