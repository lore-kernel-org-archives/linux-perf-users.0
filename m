Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3132E6AB;
	Tue,  6 Jan 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701298; cv=none; b=ZSDxw/dLIUvlOW4kDcyMIm8exA8H+8pddLLER3Mrw7tIYs3XNFVV773J9nrflRfCJc8qfyNnP66ISonq9indNF09Veajd07duD8jEaqYqhuOQ7jsEt5cCiNDlQysA+W0kNLI3o+mSrmAURr8ylnh61Z+Ehm/rVc7qLbgjxhMBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701298; c=relaxed/simple;
	bh=wqpObe0Nxv5h+lsHQTKeKqAHWgvWXKjfqylNAhef7+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKJ6z1w2WAm3b9IOctJ+f2QyYt3HXDXZKJ4AfqnLo1W3T8GzS67Gk8c/LRe5mspv5LJJMmoONv1xbdaBtkR5e18Yf3v8XDe95X2ZVU4xMxazMGx7wxxtuzly33kQRVUlQ+CMDU6eR1WkjjNSLWvFMeV546DVuT6Eb9bqDXjumLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D7F497;
	Tue,  6 Jan 2026 04:08:09 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA69D3F5A1;
	Tue,  6 Jan 2026 04:08:13 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 12:07:52 +0000
Subject: [PATCH RESEND v4 2/8] tools/include: Sync uapi/linux/perf.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-2-b887bb999f6e@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767701288; l=2631;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=wqpObe0Nxv5h+lsHQTKeKqAHWgvWXKjfqylNAhef7+o=;
 b=dJdN9RAa95S6tnH8yz58u0q+rqXk1WxUL5mnK96T+L+i+mnlAzl0CwfJFE0D8TaWXsuKPLWiM
 Tn2n864WEqaBCSQzPFg/xCSwFheyrW7hxP2+/9FzoOt2Gav7gUPqU/G
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Sync for extended memory operation bit fields.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index c44a8fb3e4181c91a1e6e3a40e23fcf1de421af3..3d2c5ee9282efc4a2310f554443082f1d0027889 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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

