Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A23290AA;
	Thu, 15 Oct 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079552; cv=none; b=cKGl/Q7hsuwPgdZHRq5QJ1AS7+MubaD7Y07g7eFbPeFPZXwigasi7ncj8iWh1O9wrJRer4oVeQrsN5pKAf758TLPFpqQlTyzocUBuz8tFg95/31jP2YY3fM2CIPhRUHxagOW28Dq1pa0x5ByzGHl4mD1h3/2CSuCSzghuuv6Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079552; c=relaxed/simple;
	bh=CHzi+P9m5petahE5T3ggExjx5Ji6RcvGl9WKuhEkeQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLIzV4VzuGKq0bD5qaoEOsTbo3sXhORkazkW8df+y9Esdh6LwbiwCd6azXkzNbMNGGnLHFe7OAeBTo8kXUQm4XFBHtexSk9CUOoBG0HKa3+m7x7vxJHcYIe2Mpi+CnOR6EbuCAwa7y3x074QWvSmlZzwtFJxtFwBstZBzvaAf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zt6XUBe/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zt6XUBe/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7400D1516;
	Thu, 15 Oct 2026 08:52:07 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33BFD3F7B4;
	Thu, 15 Oct 2026 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792079530; bh=CHzi+P9m5petahE5T3ggExjx5Ji6RcvGl9WKuhEkeQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zt6XUBe/ci7svn8AnMsCYgze34uLuwspaJxCWAaahd+8F8pQ40o0imSWtreKsk4/z
	 uT06yYE30jceNQ3//fFVGQIdIGz5pTWlg5dfIeMe6/yBHaiUUEwqHxihKoWazeMVm8
	 sWesWbxEDr1NDjPkt+srP3cT33eM9IKm3afn21rw=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 15 Oct 2026 16:51:58 +0100
Subject: [PATCH 1/2] perf: arm_spe: Order padding before publishing AUX
 head
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-add_barriers_for_perf_aux_output_skip-v1-1-5847d0578859@arm.com>
References: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
In-Reply-To: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792079527; l=1283;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=CHzi+P9m5petahE5T3ggExjx5Ji6RcvGl9WKuhEkeQI=;
 b=zjQfriJA5axeJt3hkdUHMD+NbBgSFhhvyzlc1ouUkDmp0XbsuJi5uivH3qQil2SWGU2ywrKzt
 /q7Scx5oclzBit9UHnzjuYylGs7J9REnu73XWohJINkUXuCCmBwcUA9
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The driver fills alignment gaps and calls perf_aux_output_skip(), which
publishes the new aux_head without a memory barrier. A userspace
consumer on another CPU can therefore observe the new head before the
padding stores become visible.

Add smp_wmb() between the padding stores and perf_aux_output_skip().

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Assisted-by: LLM
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b70f3fedf0282baba1395ce1116272ec5f961ea8..e105462ec5f38eab4776b0a654ba7c8a84f70f71 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -487,8 +487,11 @@ static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
 	u64 head = PERF_IDX2OFF(handle->head, buf);
 
 	memset(buf->base + head, ARM_SPE_BUF_PAD_BYTE, len);
-	if (!buf->snapshot)
+	if (!buf->snapshot) {
+		/* Order the padding stores before publishing the new aux_head. */
+		smp_wmb();
 		perf_aux_output_skip(handle, len);
+	}
 }
 
 static u64 arm_spe_pmu_next_snapshot_off(struct perf_output_handle *handle)

-- 
2.34.1

