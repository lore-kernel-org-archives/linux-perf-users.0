Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13125327204;
	Tue,  6 Jan 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701295; cv=none; b=DaYTv0qzzqVBBLADv/HzAVhn/hwWZOG7TqPG/kfnMlTF7nTuoPs6jFavZUZlM8cdZYEkWmksGll6uW4CrvDqaa9J5rXZVfjhit9YWSdvO1wCZTJGKWeM63mnJP3tyb69fpHzOWmNMaykCdhKhCuvNdINWkwytoEFHNoztANsvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701295; c=relaxed/simple;
	bh=2G+BYjlyH9qKU86t+h0jsCAN3vIQLlv3pde/45iJtBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqLyqxM8VTHbZOEpy9qaPHNk6+ieCfb04Mt54Izxykf38blJmV52DbSzAq1ngMnezL5LusmUVEQvGpm6Cg2ywzgzEzjgJW4a2qmo71WUDSY8iq5paHATwrCEJgaZZKEFX0CeNOoTPKdYxGUIgFT8o6lZtylBJg0VnsUV/jVJL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901801595;
	Tue,  6 Jan 2026 04:08:06 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5253F5A1;
	Tue,  6 Jan 2026 04:08:11 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 12:07:51 +0000
Subject: [PATCH RESEND v4 1/8] perf/uapi: Extend data source fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-1-b887bb999f6e@arm.com>
References: <20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com>
In-Reply-To: <20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767701288; l=3317;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=2G+BYjlyH9qKU86t+h0jsCAN3vIQLlv3pde/45iJtBw=;
 b=hDaTV4oT1KCsYLy2dwgxUBGOkJJgdVLbu6KouoflubzcU5AeAhyjku3dyJMUMXLhQxRM9nlEA
 /Qa6YzkEA2fA2bER0j6T84Ll/6lf7Ur2BFcM8ZCnfJZXaJBP23eauEN
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

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c44a8fb3e4181c91a1e6e3a40e23fcf1de421af3..3d2c5ee9282efc4a2310f554443082f1d0027889 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1330,14 +1330,32 @@ union perf_mem_data_src {
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
@@ -1447,6 +1465,16 @@ union perf_mem_data_src {
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

