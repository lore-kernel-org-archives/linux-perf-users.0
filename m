Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3974ADD82;
	Tue, 15 Sep 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487348; cv=none; b=prF82ZblKFPWo70kwsVTQUc0vjaesi95dcQw8/G+ydL1W0WXjMqEU6vaIRKdBdf1pPFxyEZp3NJflyZFGLP2FCiEvETazHDFSUbMdj3SwT2MROvLV7sLcwg2XR2djCikE0tMVR0H5z40CZty36QAAM01M5SUZMpqRq/wd/3cD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487348; c=relaxed/simple;
	bh=SS1qtrHSbngdvNGeG6RPiWAf922Nowh6gFGV0Y8RWAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahK4h10s6ZBVbtqaOWD14afzQlxIFHzaa9O7/llxnOs7SVrjrUrqRzQJ73WR61S2ocpAs5JVTnWrQF9Zf6EgfS+wNos81gF15CoUDvXkHXUyM1FlvOP44XMhBVEEt0gIN9irinRfSqVNLAw2LCQGwDHtdkxYrSzfrqzNcMkfnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Cg02Lq0g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Cg02Lq0g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A68FC15A1;
	Tue, 15 Sep 2026 08:49:02 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC1673F882;
	Tue, 15 Sep 2026 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487346; bh=SS1qtrHSbngdvNGeG6RPiWAf922Nowh6gFGV0Y8RWAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cg02Lq0gG5n1mRpbGar6YHdQ8r8ovabBEs37FeOp7fn80ms95FFn+uehzIRFgZD+2
	 gJwvFzGP1r4Tnj+agH2QJuyc+dnb0QRIUoufd+RGSKYtLzPyRs82ORN8J4qHmlT8iF
	 8DOz3Hmq2rFd8Vf7jz7DDVVpYaKT0xGCH5K2uaVY=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:47 +0100
Subject: [PATCH 01/25] perf/core: Reject non-positive AUX snapshot sizes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-1-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=1513;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SS1qtrHSbngdvNGeG6RPiWAf922Nowh6gFGV0Y8RWAU=;
 b=SxMQuzcTemr+ai7HEpuK/BgH25DGTLYAII4GoCYRsGRwpD4jnF4vZB/wJ1/ILF7ZHo87xkeGA
 NpJFSBgW4toCfGtbeZNzzIBJzrZ5NWrqzrBvU1MuGsRJjAnlh/KDdM0
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The existing validation rejects negative copy errors but allows a zero
return. In that case no AUX data was copied, but it is incorrectly
passed to the alignment-padding check.

Reject zero together with negative errors before calculating the padding.
This reports the invalid snapshot result and avoids treating a missing
AUX payload as alignment padding.

Fixes: a4faf00d994c ("perf/aux: Allow using AUX data in perf samples")
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe33fe15689d077e7f445c0b17d9c2e638c884a1..17355e4b8b7c6c106117153c9eb8509e6f9a41e3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8058,12 +8058,11 @@ static void perf_aux_sample_output(struct perf_event *event,
 	size = perf_pmu_snapshot_aux(rb, sampler, handle, data->aux_size);
 
 	/*
-	 * An error here means that perf_output_copy() failed (returned a
-	 * non-zero surplus that it didn't copy), which in its current
-	 * enlightened implementation is not possible. If that changes, we'd
-	 * like to know.
+	 * A negative return means that perf_output_copy() failed, while zero
+	 * means that no AUX data was copied despite a non-zero request. Neither
+	 * can be treated as alignment padding below.
 	 */
-	if (WARN_ON_ONCE(size < 0))
+	if (WARN_ON_ONCE(size <= 0))
 		goto out_put;
 
 	/*

-- 
2.34.1

