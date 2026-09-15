Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7044ACC9A;
	Tue, 15 Sep 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487354; cv=none; b=BHF5OoVFLB9ZM1xF8fhiNscwBovbp8oO1x5kxkkeibsbb+nOouaTaxvqKhK10Truab/8luxbTrzQZPyWApBvgMb8bHdlLyHTqJ0OahhMitBLpRRojKgpsgCVmNo0PCVKJAFqwAarz/GapQq7iaxru0UxgwDed8NDhmFzNN29WfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487354; c=relaxed/simple;
	bh=uKAFRhyIt1gjtBPb9l3BgDILFBey3jhPAZxBylli1AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpeO3hgAWcF9OYL18qtVGFlI2wA8lL5Yoa0v7kWrpkvJcrHdsPCDD8OAv4ffgkpKcVpHDJFUIcyVVj+R93ZyngG1Gb0vLc/on9Ye2/0/BuEMO49q3DYEl8R7wH44RO8GOCqONBaWwE9hmJvFrPYaxvc8U/y7v+khQTLux3Sgj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hIhsgwZt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hIhsgwZt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A121570;
	Tue, 15 Sep 2026 08:49:08 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 343C43F882;
	Tue, 15 Sep 2026 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487351; bh=uKAFRhyIt1gjtBPb9l3BgDILFBey3jhPAZxBylli1AA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hIhsgwZtsfBg4lWL2UBv9c04SkNq7BCDILiHgCNpigGvMpYsS0/cOpbvpb2/CpdJw
	 5FPWNBpQVsV/fD7bdfDP3YL3vJWY6CEXk7BVlP+EIvW53kY8y7DpAHqRPO7M4uY9Jp
	 4MyMcvT8AfsUcHCrCPzLUKwtz3WsI6oCZXjK2s7c=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:49 +0100
Subject: [PATCH 03/25] perf/core: Export output copy helpers for CoreSight
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-3-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=1214;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=uKAFRhyIt1gjtBPb9l3BgDILFBey3jhPAZxBylli1AA=;
 b=nIQGJIWpljvvO37hFp25/Y01Ze6az87G38R0IwB3bG0xzjOIw6zkAlRH6Nr8s2RA0pY8VTFQh
 O8+3/fLPJSkBbThxx66yZ+dakd5DQG4o+8YWP1jB846bHezSmX2V0KT
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

CoreSight AUX sampling needs perf_output_copy_aux() to copy trace data
into samples and perf_output_copy() to prepend zero bytes when the
available trace is shorter than the requested snapshot.

Export both helpers so the CoreSight snapshot_aux() callback can use
them when CONFIG_CORESIGHT=m.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1b1ffe0533e58a9d976d0eb0fc23e09d5936da2b..e69ea5b077a5e94b5b6bb1f4c6f0ca5b8a94a6cc 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -298,6 +298,7 @@ unsigned int perf_output_copy(struct perf_output_handle *handle,
 {
 	return __output_copy(handle, buf, len);
 }
+EXPORT_SYMBOL_GPL(perf_output_copy);
 
 unsigned int perf_output_skip(struct perf_output_handle *handle,
 			      unsigned int len)
@@ -617,6 +618,7 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
 
 	return len;
 }
+EXPORT_SYMBOL_GPL(perf_output_copy_aux);
 
 #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
 

-- 
2.34.1

