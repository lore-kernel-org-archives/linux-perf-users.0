Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700892;
	b=zwmDEC+x6yLFFl9Xm3IMK++Xj3F0AvYfpTh6P9VffMPDZ1ru4QPBqvebqo6/EWX1jYma
	 y2yDOJius6zCC0MI68Y2RDfatife2GR0DTHSWz9i1+RoJRcf60PXChkIetjh5e4wUSlpv
	 DRRNeAz+UIT436q7LUNMEkjVD4ZCJ4u99tNBfL1IBOqT/dxDIUUQVxym8rCxrfshpqTDG
	 kYPiTw7+Is+2OP4bZAbAsgY+t0L3GqzwrQUTbDYICtULrpcplE9NsLNfI5xjZQUvpS1ab
	 YIPzQ0jHB/9bYTKeGESMuswnO5JzH2SOtvdXYdvygwyPGjU6OIMN1sl+zPjwQFqTmdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700892;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z7MdV1rQd025OqQWqq41NJvk4bDvVBxG6l1swP98zmE=;
	b=N7B+qeHMHtnzs+oDIFXScbP6wVly5KPbUqqIgCbrTn4K3kMU5drgLv5sadYgegdUdJrw
	 aGvCiEFKWRiV3jO4z0zsuGEj7JA2ZU2qIeTJOKr9hTpUbOgIh55aFPiy1159Td4RuAm8+
	 nVH494xDycQvN8D22e0p3l0cT8Iv1/e7xtWDEfA0bkmnCqrnmIM8UXabCIUq+umOdGxhI
	 BWTVh2ZxO6fqQIMWtd5H8rsPWz9dqMG4fMvkHh77+oyBhlc9iPm5YtzB3nWLE/cgKuxhS
	 Jwc+jL23rUWqakj4HdZrAB19ygmiuWENxDE2OCWqplR5hIVF0pxeARvkh6d/0ke8flg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf0EW0IT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823EB60850A0;
	Tue,  3 Nov 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf0EW0IT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700892;
	b=K70/wKzmoriMVw2xJkH6/63a04b005fu3QGoey0mYEjHZ8fvsP3+fMnxjoIknHJ87Eiq
	 hykmthgq3diU2NmlIYGwPxFoNkpi4R+5oyDYl38y4ynFz6Kb5Wkje3HyT12nfIHsgA6jJ
	 UG8fs0YClaRD34EOTA+hjQ7DUJqF0/shzuml710+0/NaheKWaccSFruqKf00ta1ZtU3U5
	 Iy7/kXwg+OZ1z6NvsgUUi7c4hEvUhZ3fjCWjidOFHceJ7LjbHRLaw0HyvnxQ3vezzFaB0
	 LvB0k2W/kCchFLpUdfZXCYNi8qsRsPfxLN3PiXkO3Rp1FWMtk4ERCOFJefPlS9+NGgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700892;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z7MdV1rQd025OqQWqq41NJvk4bDvVBxG6l1swP98zmE=;
	b=MaheqTeAoFhWSH8gEglTI3adhX7LUQ1PrelPs6XXbvKjDsqUBRYJQ7+zuWaI/ywNkA39
	 uae1TrJ/rUP1DglXcFzowduNveGtAFyO9aehMTZ5dFuahDL6S7iv89a2Fjk1AR0nixJc3
	 OP32XBlZSlG6OnQDD+hlOvdxMAaGueeSVWvwqamZpPHqSCZ9KBRg+YrVdQ6C7Qh7dmf9Q
	 SItcyPa/isf+cCNtiIxHrTUESekF8KduaDksozcCT9ZhUlDetviypko7u3rJBBBTgQAOK
	 wZq2zjrAH0Nqr1fx/N/wjxBckQvYAI19dkqPvJ6HjRiCVn/E4o1VSiEdCfgFu0XOXiw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AACC21F00A02;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700892;
	bh=z7MdV1rQd025OqQWqq41NJvk4bDvVBxG6l1swP98zmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cf0EW0IT7ju/Plqx2O3vdDzInTWhWcjNpd+mJUygzaMui3jBYGJ9xLK7YTLiptUCA
	 ctEzIf1jndpS+gaKYPS2LbHZpDjk0kJ68uH9gXr849Kgj+ti0Fv3ZG/JCfL4XnrGgm
	 jfAh55Ek19joajpp5bVoJOCkUQf1dLIZE+ZjMalbP4C9nG0rtDh49dzU6PNIQWU2Vo
	 eFIvn/pDfLBHj8ZONekelXz3DsIZyKWHEDAcJG5joWn0ycd7WOpOVQijCu0q+CkGlM
	 pnZ/PvsGPh4YNLf6iTuO7qcqxG45e/eQeYpZXNEaItvdM0uMGjqg/czfwNfL/JaQY0
	 dZd3nmL++rWJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D75B3468AD;
	Tue,  3 Nov 2026 10:14:47 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:42 +1100
Subject: [PATCH 07/13] drivers/perf: apple_m1: Add Apple M4 Series Support
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-m3-plus-pmu-events-v1-7-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
In-Reply-To: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14614;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=XOoeAlLqX7GMAw/JnyH1BeiYriV8te11JESBEN6vwIk=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uERE87SKnvmX2q9OyglrnNVI6GKcIzGGdyd5j9
 UDr0Pmzvu4dpSwMYlwMsmKKLPqmadqT2RoulS5z3QIzh5UJZAgDF6cATGRnEyPDsU8le61qBe5b
 aeVpPOfjF/my0sGoVe7XkiX2bq+k3FdfYfjD9zkwokdj38QNfKLmV20mxbjZTFrJPEfx5E6vp5M
 10xRZAZlFRPc=
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Add support for the CPU PMU found in the various M4 SoCs. This PMU is
almost exactly the same as the M3 PMU, just with different event
encodings.

One notable difference, is the addition of the various ARM_* events,
which appear to implement the PMUv3 specific events that the arm PMU
specification provides. Hook them up with the various perf events so
that more can easily be counted on M4+ devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 224 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index ac9373126054..bdbd138cf1db 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -201,6 +201,121 @@ enum m3_pmu_events {
 	M3_PMU_CFG_COUNT_GUEST					= BIT(19),
 };
 
+enum m4_pmu_events {
+	M4_PMU_PERFCTR_ARM_L1D_CACHE_REFILL				= 0x03,
+	M4_PMU_PERFCTR_ARM_L1D_CACHE					= 0x04,
+	M4_PMU_PERFCTR_INST_ALL						= 0x08,
+	M4_PMU_PERFCTR_ARM_BR_MIS_PRED					= 0x10,
+	M4_PMU_PERFCTR_CORE_ACTIVE_CYCLE				= 0x11,
+	M4_PMU_PERFCTR_ARM_BR_PRED					= 0x12,
+	M4_PMU_PERFCTR_INST_BRANCH					= 0x21,
+	M4_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC				= 0x22,
+	M4_PMU_PERFCTR_ARM_STALL_FRONTEND				= 0x23,
+	M4_PMU_PERFCTR_ARM_STALL_BACKEND				= 0x24,
+	M4_PMU_PERFCTR_ARM_L1D_CACHE_LMISS_RD				= 0x39,
+	M4_PMU_PERFCTR_RETIRE_UOP					= 0x3a,
+	M4_PMU_PERFCTR_MAP_UOP						= 0x3b,
+	M4_PMU_PERFCTR_ARM_STALL					= 0x3c,
+	M4_PMU_PERFCTR_ARM_STALL_SLOT_BACKEND				= 0x3d,
+	M4_PMU_PERFCTR_ARM_STALL_SLOT_FRONTEND				= 0x3e,
+	M4_PMU_PERFCTR_ARM_STALL_SLOT					= 0x3f,
+	M4_PMU_PERFCTR_ARM_L1D_CACHE_RD					= 0x40,
+	M4_PMU_PERFCTR_MAP_DISPATCH_BUBBLE_IC				= 0x182,
+	M4_PMU_PERFCTR_MAP_DISPATCH_BUBBLE_ITLB				= 0x183,
+	M4_PMU_PERFCTR_DECODE_UOP					= 0x186,
+	M4_PMU_PERFCTR_L1I_TLB_MISS_DEMAND				= 0x1d4,
+	M4_PMU_PERFCTR_MAP_DISPATCH_BUBBLE				= 0x1d6,
+	M4_PMU_PERFCTR_FETCH_RESTART					= 0x1de,
+	M4_PMU_PERFCTR_MAP_DISPATCH_BUBBLE_SLOT				= 0x1e1,
+	M4_PMU_PERFCTR_INTERRUPT_PENDING				= 0x26c,
+	M4_PMU_PERFCTR_MAP_STALL_DISPATCH				= 0x270,
+	M4_PMU_PERFCTR_MAP_REWIND					= 0x275,
+	M4_PMU_PERFCTR_MAP_STALL					= 0x276,
+	M4_PMU_PERFCTR_MAP_INT_UOP					= 0x27c,
+	M4_PMU_PERFCTR_MAP_LDST_UOP					= 0x27d,
+	M4_PMU_PERFCTR_MAP_SIMD_UOP					= 0x27e,
+	M4_PMU_PERFCTR_SCHEDULE_UOP_ANY					= 0x283,
+	M4_PMU_PERFCTR_MAP_INT_SME_UOP					= 0x285,
+	M4_PMU_PERFCTR_SME_ENGINE_SM_ENABLE				= 0x286,
+	M4_PMU_PERFCTR_SME_ENGINE_SM_ZA_ENABLE				= 0x287,
+	M4_PMU_PERFCTR_SME_ENGINE_ZA_ENABLED_SM_DISABLED		= 0x288,
+	M4_PMU_PERFCTR_LDST_UNIT_WAITING_SME_ENGINE_INST_QUEUE_FULL	= 0x28c,
+	M4_PMU_PERFCTR_SCHEDULE_WAITING_SME_ENGINE_REG_DATA		= 0x28e,
+	M4_PMU_PERFCTR_LDST_UNIT_WAITING_SME_ENGINE_MEM_DATA		= 0x28f,
+	M4_PMU_PERFCTR_LDST_UNIT_OLD_L1D_CACHE_MISS			= 0x290,
+	M4_PMU_PERFCTR_LDST_UNIT_WAITING_OLD_L1D_CACHE_MISS		= 0x291,
+	M4_PMU_PERFCTR_LD_UNIT_WAITING_YOUNG_L1D_CACHE_MISS		= 0x294,
+	M4_PMU_PERFCTR_MAP_RECOVERY					= 0x2ad,
+	M4_PMU_PERFCTR_MAP_STALL_NONRECOVERY				= 0x2ae,
+	M4_PMU_PERFCTR_SCHEDULE_EMPTY					= 0x351,
+	M4_PMU_PERFCTR_L1I_TLB_FILL					= 0x404,
+	M4_PMU_PERFCTR_L1D_TLB_FILL					= 0x405,
+	M4_PMU_PERFCTR_MMU_TABLE_WALK_INSTRUCTION			= 0x407,
+	M4_PMU_PERFCTR_MMU_TABLE_WALK_DATA				= 0x408,
+	M4_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION				= 0x40a,
+	M4_PMU_PERFCTR_L2_TLB_MISS_DATA					= 0x40b,
+	M4_PMU_PERFCTR_LDST_SME_XPG_UOP					= 0x508,
+	M4_PMU_PERFCTR_INST_SME_ENGINE_PACKING_FUSED			= 0x529,
+	M4_PMU_PERFCTR_LD_BLOCKED_BY_SME_LDST				= 0x52c,
+	M4_PMU_PERFCTR_ST_BARRIER_BLOCKED_BY_SME_LDST			= 0x52e,
+	M4_PMU_PERFCTR_LD_SME_NT_UOP					= 0x573,
+	M4_PMU_PERFCTR_ST_SME_NT_UOP					= 0x574,
+	M4_PMU_PERFCTR_LD_SME_NORMAL_UOP				= 0x575,
+	M4_PMU_PERFCTR_ST_SME_NORMAL_UOP				= 0x576,
+	M4_PMU_PERFCTR_LDST_SME_PRED_INACTIVE				= 0x577,
+	M4_PMU_PERFCTR_L1D_TLB_ACCESS					= 0x5a0,
+	M4_PMU_PERFCTR_L1D_TLB_MISS					= 0x5a1,
+	M4_PMU_PERFCTR_L1D_CACHE_MISS_ST				= 0x5a2,
+	M4_PMU_PERFCTR_L1D_CACHE_MISS_LD				= 0x5a3,
+	M4_PMU_PERFCTR_LD_UNIT_UOP					= 0x5a6,
+	M4_PMU_PERFCTR_ST_UNIT_UOP					= 0x5a7,
+	M4_PMU_PERFCTR_L1D_CACHE_WRITEBACK				= 0x5a8,
+	M4_PMU_PERFCTR_LDST_X64_UOP					= 0x5b1,
+	M4_PMU_PERFCTR_LDST_XPG_UOP					= 0x5b2,
+	M4_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_SUCC				= 0x5b3,
+	M4_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_FAIL				= 0x5b4,
+	M4_PMU_PERFCTR_ST_NT_UOP					= 0x5e5,
+	M4_PMU_PERFCTR_LD_NT_UOP					= 0x5e6,
+	M4_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC			= 0x884,
+	M4_PMU_PERFCTR_INST_BRANCH_CALL					= 0x88e,
+	M4_PMU_PERFCTR_INST_BRANCH_RET					= 0x88f,
+	M4_PMU_PERFCTR_INST_BRANCH_TAKEN				= 0x890,
+	M4_PMU_PERFCTR_INST_BRANCH_INDIR				= 0x893,
+	M4_PMU_PERFCTR_INST_BRANCH_COND					= 0x894,
+	M4_PMU_PERFCTR_INST_INT_LD					= 0x895,
+	M4_PMU_PERFCTR_INST_INT_ST					= 0x896,
+	M4_PMU_PERFCTR_INST_INT_ALU					= 0x897,
+	M4_PMU_PERFCTR_INST_SIMD_LD					= 0x898,
+	M4_PMU_PERFCTR_INST_SIMD_ST					= 0x899,
+	M4_PMU_PERFCTR_INST_SIMD_ALU					= 0x89a,
+	M4_PMU_PERFCTR_INST_LDST					= 0x89b,
+	M4_PMU_PERFCTR_INST_BARRIER					= 0x89c,
+	M4_PMU_PERFCTR_INST_SIMD_ALU_VEC				= 0x89f,
+	M4_PMU_PERFCTR_INST_SME_ENGINE_SCALARFP				= 0x8a0,
+	M4_PMU_PERFCTR_INST_SME_ENGINE_LD				= 0x8a1,
+	M4_PMU_PERFCTR_INST_SME_ENGINE_ST				= 0x8a2,
+	M4_PMU_PERFCTR_INST_SME_ENGINE_ALU				= 0x8a3,
+	M4_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC			= 0x8bf,
+	M4_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC			= 0x8c0,
+	M4_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC				= 0x8c1,
+	M4_PMU_PERFCTR_ST_MEM_ORDER_VIOL_LD_NONSPEC			= 0x8c4,
+	M4_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC			= 0x8c5,
+	M4_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC			= 0x8c6,
+	M4_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC			= 0x8c8,
+	M4_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC		= 0x8ca,
+	M4_PMU_PERFCTR_L1I_CACHE_MISS_DEMAND				= 0x4006,
+	M4_PMU_PERFCTR_LAST						= M3_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	M4_PMU_CFG_COUNT_USER						= BIT(16),
+	M4_PMU_CFG_COUNT_KERNEL						= BIT(17),
+	M4_PMU_CFG_COUNT_HOST						= BIT(18),
+	M4_PMU_CFG_COUNT_GUEST						= BIT(19),
+};
+
 /*
  * Per-event affinity table. Most events can be installed on counter
  * 2-9, but there are a number of exceptions. Note that this table
@@ -277,6 +392,40 @@ static const struct event_affinity_16 m3_pmu_event_affinity[] = {
 	{ M3_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,		ONLY_5_6_7		},
 };
 
+static const struct event_affinity_16 m4_pmu_event_affinity[] = {
+	{ M4_PMU_PERFCTR_INST_ALL,				ONLY_2_TO_7 | BIT(1)	},
+	{ M4_PMU_PERFCTR_CORE_ACTIVE_CYCLE,			ANY_BUT_0_1 | BIT(0)	},
+	{ M4_PMU_PERFCTR_INST_BRANCH,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_RETIRE_UOP,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_BRANCH_CALL,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_BRANCH_RET,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_BRANCH_TAKEN,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_BRANCH_INDIR,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_BRANCH_COND,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_INT_LD,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_INT_ST,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_INT_ALU,				BIT(7)			},
+	{ M4_PMU_PERFCTR_INST_SIMD_LD,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_SIMD_ST,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_SIMD_ALU,				BIT(7)			},
+	{ M4_PMU_PERFCTR_INST_LDST,				BIT(7)			},
+	{ M4_PMU_PERFCTR_INST_BARRIER,				ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_SIMD_ALU_VEC,			BIT(7)			},
+	{ M4_PMU_PERFCTR_INST_SME_ENGINE_SCALARFP,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_SME_ENGINE_LD,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_SME_ENGINE_ST,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_INST_SME_ENGINE_ALU,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC,			ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_ST_MEM_ORDER_VIOL_LD_NONSPEC,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC,		ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC,	ONLY_2_TO_7		},
+	{ M4_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC,	ONLY_2_TO_7		},
+};
+
 static const unsigned int m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
@@ -293,12 +442,27 @@ static const unsigned int m3_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BRANCH_MISSES]		= M3_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,
 };
 
+static const unsigned int m4_pmu_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= M4_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= M4_PMU_PERFCTR_INST_ALL,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= M4_PMU_PERFCTR_ARM_L1D_CACHE,
+	[PERF_COUNT_HW_CACHE_MISSES]		= M4_PMU_PERFCTR_ARM_L1D_CACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= M4_PMU_PERFCTR_INST_BRANCH,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= M4_PMU_PERFCTR_ARM_BR_MIS_PRED,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= M4_PMU_PERFCTR_ARM_STALL_FRONTEND,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= M4_PMU_PERFCTR_ARM_STALL_BACKEND,
+};
+
 #define M1_PMUV3_EVENT_MAP(pmuv3_event, m1_event)				\
 	[ARMV8_PMUV3_PERFCTR_##pmuv3_event]	= M1_PMU_PERFCTR_##m1_event
 
 #define M3_PMUV3_EVENT_MAP(pmuv3_event, m3_event)				\
 	[ARMV8_PMUV3_PERFCTR_##pmuv3_event]	= M3_PMU_PERFCTR_##m3_event
 
+#define M4_PMUV3_EVENT_MAP(pmuv3_event, m4_event)				\
+	[ARMV8_PMUV3_PERFCTR_##pmuv3_event]	= M4_PMU_PERFCTR_##m4_event
+
 static const u16 m1_pmu_pmceid_map[ARMV8_PMUV3_MAX_COMMON_EVENTS] = {
 	[0 ... ARMV8_PMUV3_MAX_COMMON_EVENTS - 1]	= HW_OP_UNSUPPORTED,
 	M1_PMUV3_EVENT_MAP(INST_RETIRED,	INST_ALL),
@@ -315,6 +479,25 @@ static const u16 m3_pmu_pmceid_map[ARMV8_PMUV3_MAX_COMMON_EVENTS] = {
 	M3_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED,	BRANCH_MISPRED_NONSPEC),
 };
 
+static const u16 m4_pmu_pmceid_map[ARMV8_PMUV3_MAX_COMMON_EVENTS] = {
+	[0 ... ARMV8_PMUV3_MAX_COMMON_EVENTS - 1]	= HW_OP_UNSUPPORTED,
+	M4_PMUV3_EVENT_MAP(L1D_CACHE_REFILL,	ARM_L1D_CACHE_REFILL),
+	M4_PMUV3_EVENT_MAP(L1D_CACHE,		ARM_L1D_CACHE),
+	M4_PMUV3_EVENT_MAP(INST_RETIRED,	INST_ALL),
+	M4_PMUV3_EVENT_MAP(BR_MIS_PRED,		ARM_BR_MIS_PRED),
+	M4_PMUV3_EVENT_MAP(CPU_CYCLES,		CORE_ACTIVE_CYCLE),
+	M4_PMUV3_EVENT_MAP(BR_PRED,		ARM_BR_PRED),
+	M4_PMUV3_EVENT_MAP(BR_RETIRED,		INST_BRANCH),
+	M4_PMUV3_EVENT_MAP(STALL_FRONTEND,	ARM_STALL_FRONTEND),
+	M4_PMUV3_EVENT_MAP(STALL_BACKEND,	ARM_STALL_BACKEND),
+	M4_PMUV3_EVENT_MAP(L1D_CACHE_LMISS_RD,	ARM_L1D_CACHE_LMISS_RD),
+	M4_PMUV3_EVENT_MAP(STALL,		ARM_STALL),
+	M4_PMUV3_EVENT_MAP(STALL_SLOT_BACKEND,	ARM_STALL_SLOT_BACKEND),
+	M4_PMUV3_EVENT_MAP(STALL_SLOT_FRONTEND,	ARM_STALL_SLOT_FRONTEND),
+	M4_PMUV3_EVENT_MAP(STALL_SLOT,		ARM_STALL_SLOT),
+	M4_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED,	BRANCH_MISPRED_NONSPEC),
+};
+
 /* sysfs definitions */
 static ssize_t m1_pmu_events_sysfs_show(struct device *dev,
 					struct device_attribute *attr,
@@ -356,6 +539,12 @@ static struct attribute *m3_pmu_event_attrs[] = {
 	NULL,
 };
 
+static struct attribute *m4_pmu_event_attrs[] = {
+	M3_PMU_EVENT_ATTR(cycles, M4_PMU_PERFCTR_CORE_ACTIVE_CYCLE),
+	M3_PMU_EVENT_ATTR(instructions, M4_PMU_PERFCTR_INST_ALL),
+	NULL,
+};
+
 static const struct attribute_group m1_pmu_events_attr_group = {
 	.name = "events",
 	.attrs = m1_pmu_event_attrs,
@@ -366,6 +555,11 @@ static const struct attribute_group m3_pmu_events_attr_group = {
 	.attrs = m3_pmu_event_attrs,
 };
 
+static const struct attribute_group m4_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = m4_pmu_event_attrs,
+};
+
 PMU_FORMAT_ATTR_SHOW(event_8b, "config:0-7");
 PMU_FORMAT_ATTR_SHOW(event_16b, "config:0-15");
 
@@ -740,6 +934,13 @@ static int m3_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 					  m3_pmu_event_affinity);
 }
 
+static int m4_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx_16(cpuc, event, ARRAY_SIZE(m4_pmu_event_affinity),
+					  m4_pmu_event_affinity);
+}
+
 static void m1_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 				   struct perf_event *event)
 {
@@ -800,6 +1001,12 @@ static int m3_pmu_map_event(struct perf_event *event)
 				   M3_PMU_CFG_EVENT);
 }
 
+static int m4_pmu_map_event(struct perf_event *event)
+{
+	return apple_pmu_map_event(event, &m4_pmu_perf_map, ARMPMU_EVT_63BIT,
+				   M3_PMU_CFG_EVENT);
+}
+
 static int apple_pmu_map_pmuv3_event(unsigned int eventsel, const u16 pmceid_map[])
 {
 	u16 apple_event = HW_OP_UNSUPPORTED;
@@ -820,6 +1027,11 @@ static int m3_pmu_map_pmuv3_event(unsigned int eventsel)
 	return apple_pmu_map_pmuv3_event(eventsel, m3_pmu_pmceid_map);
 }
 
+static int m4_pmu_map_pmuv3_event(unsigned int eventsel)
+{
+	return apple_pmu_map_pmuv3_event(eventsel, m4_pmu_pmceid_map);
+}
+
 static void apple_pmu_init_pmceid(struct arm_pmu *pmu)
 {
 	unsigned int event;
@@ -933,14 +1145,26 @@ static int gen ## _pmu_ ## family ## _init(struct arm_pmu *cpu_pmu)				\
 #define m2_pmu_events_attr_group	m1_pmu_events_attr_group
 #define m2_pmu_format_attr_group	m1_pmu_format_attr_group
 
+#define m4_pmu_enable_event		m3_pmu_enable_event
+#define m4_pmu_set_event_filter		m3_pmu_set_event_filter
+#define m4_pmu_format_attr_group	m3_pmu_format_attr_group
+
 APPLE_PMU_INIT(m1, icestorm)
 APPLE_PMU_INIT(m1, firestorm)
 APPLE_PMU_INIT(m2, avalanche)
 APPLE_PMU_INIT(m2, blizzard)
 APPLE_PMU_INIT(m3, sawtooth)
 APPLE_PMU_INIT(m3, everest)
+APPLE_PMU_INIT(m4, donan_e)
+APPLE_PMU_INIT(m4, donan_p)
+APPLE_PMU_INIT(m4, brava_e)
+APPLE_PMU_INIT(m4, brava_p)
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {
+	{ .compatible = "apple,brava-e-pmu",	.data = m4_pmu_brava_e_init, },
+	{ .compatible = "apple,brava-p-pmu",	.data = m4_pmu_brava_p_init, },
+	{ .compatible = "apple,donan-e-pmu",	.data = m4_pmu_donan_e_init, },
+	{ .compatible = "apple,donan-p-pmu",	.data = m4_pmu_donan_p_init, },
 	{ .compatible = "apple,sawtooth-pmu",	.data = m3_pmu_sawtooth_init, },
 	{ .compatible = "apple,everest-pmu",	.data = m3_pmu_everest_init, },
 	{ .compatible = "apple,avalanche-pmu",	.data = m2_pmu_avalanche_init, },

-- 
2.56.0


