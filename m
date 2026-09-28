Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC14E66AD;
	Mon, 28 Sep 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611958; cv=none; b=eOaVnXoPFiaw7dUGpBf4fYSiSNAngZJdaQV/Ahs+ysWwg3sGz79CuyQkNT9J453kN4XT5P5cyqqHVXDlGOG18IiJZM5vE7D8c7y214MPbL8hbhM523RmzUlT8qs458CUGbBm5NSYaelDkhzQ6/TYmcneg7Md95By9xFeOOz2jUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611958; c=relaxed/simple;
	bh=Mlyq+ukKe2ByVk3Bd8wSohPfKW8jWheZr5H2rogrdFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LupLZpuRikoIqPInc77e6OmsFNYgLnlwfBtkf6gvejCMCuoRQXcI7mOaMhRvVzhdy8b5A2nVcS4ChpQG/eN55gpk9uZXHAOsGCVpY5TDupdcuHT2LgzKhxnjX2QICLoM2bKGcVZgTBs2LFrRrviP3hifk+fo5HSfxDlLgNWQU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LAMug/Tx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LAMug/Tx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 978A81655;
	Mon, 28 Sep 2026 09:12:32 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554B13F86F;
	Mon, 28 Sep 2026 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790611956; bh=Mlyq+ukKe2ByVk3Bd8wSohPfKW8jWheZr5H2rogrdFA=;
	h=From:Date:Subject:To:Cc:From;
	b=LAMug/Txr/5DrmHQ54y+TxWy/Y1gzKcUmPbN23oUJLqrfO2F792K5C9OWFaw9J+o3
	 Q+eakTy3zohL4lwtrBFIsAz9XiS/rSTMxrEGxS2BJBO+vSoF2L5YIjWqpUDtCdSt2k
	 2lUzaRqfcIhYWFHeOs95PXNtLeQ32ldf/r3m1zL8=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 28 Sep 2026 17:12:28 +0100
Subject: [PATCH] perf arm-spe: Add Neoverse V3AE data source decoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-perf_arm_spe_add_neoverse_v3ae-v1-1-738c9ed12d31@arm.com>
X-B4-Tracking: v=1; b=H4sIAOuRumoC/x3NywrDIBBG4VcJs65gLOTSVyllsPrbzqJGRpBAy
 LtXsvw25xxUoYJKj+EgRZMqW+4YbwOFr88fGInd5Kyb7OoWU6CJvf64FrCPkTO2Bq3gdvcw6zg
 nt9i3C3OgHimKJPs1eL7O8w8NnMyTcAAAAA==
X-Change-ID: 20260928-perf_arm_spe_add_neoverse_v3ae-917f280b2c7c
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kieran Hejmadi <kieran.hejmadi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790611954; l=946;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Mlyq+ukKe2ByVk3Bd8wSohPfKW8jWheZr5H2rogrdFA=;
 b=M3Z0WJzWRnTDgi4rNH0BatdMRZgWsF7Ew4WfIzcwLVK0g1pdBjYnvah1fua6agSOtLmkM937m
 +hJGwBYFKvCBl45UoYNiy1Bv9T1I4zH3f+NyZ7H30SWz+5Vwbj2nUp7
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add all Neoverse V3AE revisions to the list so the common decoder can
populate the memory source and snoop information.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7805a1a98a89a2853ad02ee7751472eddb1054ed..8d95df23be6f654caee77e9d155af7ebf5129c91 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -626,6 +626,7 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 	MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 	{},
 };

---
base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
change-id: 20260928-perf_arm_spe_add_neoverse_v3ae-917f280b2c7c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

