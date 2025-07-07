Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88961D554
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895598; cv=none; b=Z3E+jfIDp+5SzXLcQOTB4XsEdJES6LBZXnkkb4dFqFqoXDIe4hbC22KyCK+RKQ63Wg0+UAUmU6SJ5IeorCtDTBeTv0hljcEGVay14pVQLA0heOsYBsrzk82OIw9Wek8iW/0lcC9k6CMS90R/E1b4edorAHDoMXBP/NB9vOJKmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895598; c=relaxed/simple;
	bh=Z1YwAQtlPaqPhy06Cikq4OmxWx4nI1SYRBIjUV0ECcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7n2r3yrot14nH0zOU+uvgeliptLhFhCYiYxaPNL2jjEzibMaLghIPR9DqMZHCc+SoTwW7xEgofgkSgBRv9mKzsEVuoA0J/LGlVL3+PXPjTLRlUOUtnaN9LRtaburWV5ty2KyZQNR1BCrLByutmuGm2hfZFt2LmOQRd9yv4p26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28241BCB;
	Mon,  7 Jul 2025 06:39:43 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FA303F6A8;
	Mon,  7 Jul 2025 06:39:54 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 07 Jul 2025 14:39:24 +0100
Subject: [PATCH v3 02/14] perf arm_spe: Correct setting remote access
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-2-33ea82da3280@arm.com>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
In-Reply-To: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751895589; l=852;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Z1YwAQtlPaqPhy06Cikq4OmxWx4nI1SYRBIjUV0ECcA=;
 b=BQWVSXQrpdWwj2oqVM0fB0WoZbpRpnD+ZKi2sENP1jo8zBRkH4EVoPk6+4xm0gUb1RctNqzqb
 k7R2KVPeYp/BsqC7UFVG4WD0Gc01IGGMH1urYcef1c/98ax4Sze9eyy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Set the mem_remote field for a remote access to appropriately represent
the event.

Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d46e0cccac99a36148b4daa37f2bf2342e6b47ef..fdef6f743cf3c76b1dcdd57f5a2c297642fdd21a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -839,7 +839,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
-		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 }
 
 static bool arm_spe__synth_ds(struct arm_spe_queue *speq,

-- 
2.34.1

