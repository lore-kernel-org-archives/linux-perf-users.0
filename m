Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79830CD84
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163907; cv=none; b=itf9wyyQwIAmLwRm49tXummH1/HiPwcaH6+Kf2tgDLGthumcyvhHjRNP8Wo2TAD4WBfHXg0wv0O/u8lU1LqE9CPBqT7rZPgt690zzRCXctOgJTpnKwpQc9TcyuDZjXvpv5wFpfjsPmRtrDRj+RTIFRGo1D9VkLGEnSuUWaAPwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163907; c=relaxed/simple;
	bh=MrUJws3XOxSEfzYPriUT8JOz/TWITk3TYSqTpdF5/j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E46rEqdFcJOnymAKlYtF1ihv8ogiasoQSFJTQX8pxmVtbzJoQSJYgJgX4lG3hsLvXPclQiJgs2hfbqZ+K98MRLy5FIg6Mx5/PQ10PfuhLsXBo0Q4TJywPFoEWIvfoIjf7dyYzAIcnnSwJZqZD2zv1Glqs02t4UhSt/DvTCnIn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22A4F1758;
	Mon, 29 Sep 2025 09:38:17 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10003F66E;
	Mon, 29 Sep 2025 09:38:23 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:55 +0100
Subject: [PATCH 19/25] perf/uapi: Extend data source fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-19-1150b3c83857@arm.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=3062;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=MrUJws3XOxSEfzYPriUT8JOz/TWITk3TYSqTpdF5/j0=;
 b=Nr8EAIpiZWrSgkY5XYqq1BoG4Ov0skvjgCTno8ELCn0dHObMktjjjQuKGXzy6HJd/jrnLVxR1
 SUj3TsWpWhCBsJCb449GVhjkifYYFL01z1WCSC3Vp54L2+g3O7HnV8Y
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Arm CPUs introduce several new types of memory operations, like MTE tag
accessing, system register access for nested virtualization, memcpy &
memset, and Guarded Control Stack (GCS).

For memory operation details, Arm SPE provides information like data
(parallel) processing, floating-point, predicated, atomic, exclusive,
acquire/release, gather/scatter, and conditional.

This commit introduces a field 'mem_op_ext' for extended operation type.
The extended operation type can be combined with the existed operation
type to express a memory type, for examples, a PERF_MEM_OP_GCS type can
be set along with PERF_MEM_OP_LOAD to present a load operation for
GCS register access.

Also use a field 'mem_aff' to store affiliate information.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/uapi/linux/perf_event.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b8002776e5ce83a0d7816601638c61ecc6..51ab37d44ac31fcdc4bc919c14d5f97e560d9339 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1309,14 +1309,18 @@ union perf_mem_data_src {
 			mem_snoopx  :  2, /* Snoop mode, ext */
 			mem_blk     :  3, /* Access blocked */
 			mem_hops    :  3, /* Hop level */
-			mem_rsvd    : 18;
+			mem_op_ext  :  6, /* Extended type of opcode */
+			mem_aff     :  8, /* Affiliate info */
+			mem_rsvd    :  4;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd    : 18,
+		__u64	mem_rsvd    :  4,
+			mem_aff     :  8, /* Affiliate info */
+			mem_op_ext  :  6, /* Extended type of opcode */
 			mem_hops    :  3, /* Hop level */
 			mem_blk     :  3, /* Access blocked */
 			mem_snoopx  :  2, /* Snoop mode, ext */
@@ -1426,6 +1430,26 @@ union perf_mem_data_src {
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT			43
 
+/* Extended type of memory opcode: */
+#define PERF_MEM_EXT_OP_MTE_TAG			0x0001 /* MTE tag */
+#define PERF_MEM_EXT_OP_NESTED_VIRT		0x0002 /* Nested virtualization */
+#define PERF_MEM_EXT_OP_MEMCPY			0x0004 /* Memory copy */
+#define PERF_MEM_EXT_OP_MEMSET			0x0008 /* Memory set */
+#define PERF_MEM_EXT_OP_SIMD			0x0010 /* SIMD */
+#define PERF_MEM_EXT_OP_GCS			0x0020 /* Guarded Control Stack */
+#define PERF_MEM_EXT_OP_SHIFT			46
+
+/* Affiliate info */
+#define PERF_MEM_AFF_DP				0x0001 /* Data processing */
+#define PERF_MEM_AFF_FP				0x0002 /* Floating-point */
+#define PERF_MEM_AFF_PRED			0x0004 /* Predicated */
+#define PERF_MEM_AFF_ATOMIC			0x0008 /* Atomic */
+#define PERF_MEM_AFF_EXCLUSIVE			0x0010 /* Exclusive */
+#define PERF_MEM_AFF_AR				0x0020 /* Acquire/release */
+#define PERF_MEM_AFF_SG				0x0040 /* Gather/Scatter */
+#define PERF_MEM_AFF_CONDITIONAL		0x0080 /* Conditional */
+#define PERF_MEM_AFF_SHIFT			52
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 

-- 
2.34.1

