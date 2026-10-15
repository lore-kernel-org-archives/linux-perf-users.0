Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F92367295;
	Thu, 15 Oct 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079546; cv=none; b=anNeboXuioWoA8eD7SOk2RDDIohspSNJXEHt7AbmA6uNtmgZt9DT37axgko+lk/dPytUO8l1lub+PxeCYlW5HQ1VJJj+uh9jOjMsW6Y3TDZp2tkKrwS24ZuHLwcTD1Udd+6bRVV4Xy/IJcAFcbjL418IvAUCPs7bVXUXNoEIpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079546; c=relaxed/simple;
	bh=UsCucnKFbKHlnk/F6TLrWSk1K2rkrN5p17L2rucxR3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VL9t5aIoW/ZX616FKKF0sDFeaWYm7AmGC8IzIykY5tMVozle1ivH+mEmV501NBX7aju7TDmLFieFKqfTgoM3WmSRm6E5CaeW/JkLOrTiWGMyo1qCgCSiLhtYRu6KHPHb/F2iU1jl+E0KQJ6drSMpak1jPkO1sLJMp3oI8RUiz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WhjEwxub; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WhjEwxub"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D2C1576;
	Thu, 15 Oct 2026 08:52:09 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB783F7B4;
	Thu, 15 Oct 2026 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792079532; bh=UsCucnKFbKHlnk/F6TLrWSk1K2rkrN5p17L2rucxR3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WhjEwxub1G+PVPhg1zi/d1OtUzMMy7qscvqNVR6KMwWueipE8B4+N/UmcaYhPoHIa
	 00tnBxL3UkhC1lQ6gcVZiXbD6bSiV5pHMpTUg2HeSmXEJsXFYl7LyzuFwujos+6wJu
	 fquc4F0tqJzlRm7OP4hEeEd3Am872iuCs0q6gtUg=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 15 Oct 2026 16:51:59 +0100
Subject: [PATCH 2/2] coresight: trbe: Order padding before publishing AUX
 head
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-add_barriers_for_perf_aux_output_skip-v1-2-5847d0578859@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792079527; l=1351;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=UsCucnKFbKHlnk/F6TLrWSk1K2rkrN5p17L2rucxR3s=;
 b=gsloEepkVMtNNVQxOuyaX8g3lCODtKFXXcVigyk6awxiHlk2ZhtSAsvT3+ZV2vqvTxD88hV7d
 UrzDuPHy3rHCNDzJ9dbwX3PuXAN87mSg/TXtPdKHCOhEJqZG+jzmiTL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

TRBE fills gaps in the AUX buffer before advancing aux_head. Neither
perf_aux_output_skip() nor perf_aux_output_end() guarantees ordering of
these CPU stores before publishing the new head.

Add smp_wmb() after memset() in __trbe_pad_buf(). This covers alignment
padding published by perf_aux_output_skip() and the overwrite erratum
padding written by trbe_get_trace_size() before perf_aux_output_end().

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Assisted-by: LLM
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index c7cbca45f2debd4047b93283ea9fe5dd9e1f2ebf..b605121b1dcfed9837c15cd92ff4c42515f39eaf 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -362,6 +362,8 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
 static void __trbe_pad_buf(struct trbe_buf *buf, u64 offset, int len)
 {
 	memset((void *)buf->trbe_base + offset, ETE_IGNORE_PACKET, len);
+	/* Order the padding stores before publishing the new aux_head. */
+	smp_wmb();
 }
 
 static void trbe_pad_buf(struct perf_output_handle *handle, int len)

-- 
2.34.1

