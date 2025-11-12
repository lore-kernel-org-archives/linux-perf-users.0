Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC441353896;
	Wed, 12 Nov 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971934; cv=none; b=CkuxNMHQsK8yDNMj1L2ueUA7P2dcVqjOhWeRtLx8MUl3u8hoo0dOFfHZ5iDxy4YFGs/e2eCUxbMZI+mSbRu6RmrX20X8rl1fs+ot7Q46Qx53GMmJ/zX+X9KfcJQcCfG3TAYqL+3wcFD/XMvNJG0iF8Mjz1CU8/Q0qdwwgEa2gx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971934; c=relaxed/simple;
	bh=3iw/P+AX4UJGoOiKlHAm4WlW+3qWo8a2n9HzWZAvfJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbiVBO9IaBrjskKhYCh7B6fByQ4+YblSydEuJgh2Pgp029l1d0yN62iIWgRS/D6grnUBVaeYQjNvMNTxfucMkt13mnCqQIaVeW0UdRk+lOZskEaH7yn2AHW/BWQLAVYLzdy20PNtkfUSFbQ8gmxE8z2l15O8c+o9VNnaOPE9c1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741F31515;
	Wed, 12 Nov 2025 10:25:24 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435303F63F;
	Wed, 12 Nov 2025 10:25:30 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:44 +0000
Subject: [PATCH v3 18/25] perf/uapi: Extend data source fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-18-e63c9829f9d9@arm.com>
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
In-Reply-To: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=3220;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=3iw/P+AX4UJGoOiKlHAm4WlW+3qWo8a2n9HzWZAvfJM=;
 b=r8RbXPX9xnSN01zcQo1wMZJhTYHVOjQzaenXT7xdLesvu2UErAIu1EuTrd1aCBzaqCQ/a64GB
 Qna8bcQQwtnCg9+UjlMDhmHJpAHR1BHN5GY4x3usfEXzrLnzOPMkHYf
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

Bit fields are also added to represent detailed operation attributes.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b8002776e5ce83a0d7816601638c61ecc6..9b9fa59fd828756b5e8e93520da5a269f0dfff52 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1309,14 +1309,32 @@ union perf_mem_data_src {
 			mem_snoopx  :  2, /* Snoop mode, ext */
 			mem_blk     :  3, /* Access blocked */
 			mem_hops    :  3, /* Hop level */
-			mem_rsvd    : 18;
+			mem_op_ext  :  4, /* Extended type of opcode */
+			mem_dp      :  1, /* Data processing */
+			mem_fp      :  1, /* Floating-point */
+			mem_pred    :  1, /* Predicated */
+			mem_atomic  :  1, /* Atomic operation */
+			mem_excl    :  1, /* Exclusive */
+			mem_ar      :  1, /* Acquire/release */
+			mem_sg      :  1, /* Scatter/Gather */
+			mem_cond    :  1, /* Conditional */
+			mem_rsvd    :  6;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd    : 18,
+		__u64	mem_rsvd    :  6,
+			mem_cond    :  1, /* Conditional */
+			mem_sg      :  1, /* Scatter/Gather */
+			mem_ar      :  1, /* Acquire/release */
+			mem_excl    :  1, /* Exclusive */
+			mem_atomic  :  1, /* Atomic operation */
+			mem_pred    :  1, /* Predicated */
+			mem_fp      :  1, /* Floating-point */
+			mem_dp      :  1, /* Data processing */
+			mem_op_ext  :  4, /* Extended type of opcode */
 			mem_hops    :  3, /* Hop level */
 			mem_blk     :  3, /* Access blocked */
 			mem_snoopx  :  2, /* Snoop mode, ext */
@@ -1426,6 +1444,16 @@ union perf_mem_data_src {
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT			43
 
+/* Extended type of memory opcode: */
+#define PERF_MEM_EXT_OP_NA			0x0    /* Not available */
+#define PERF_MEM_EXT_OP_MTE_TAG			0x1    /* MTE tag */
+#define PERF_MEM_EXT_OP_NESTED_VIRT		0x2    /* Nested virtualization */
+#define PERF_MEM_EXT_OP_MEMCPY			0x3    /* Memory copy */
+#define PERF_MEM_EXT_OP_MEMSET			0x4    /* Memory set */
+#define PERF_MEM_EXT_OP_SIMD			0x5    /* SIMD */
+#define PERF_MEM_EXT_OP_GCS			0x6    /* Guarded Control Stack */
+#define PERF_MEM_EXT_OP_SHIFT			46
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 

-- 
2.34.1

