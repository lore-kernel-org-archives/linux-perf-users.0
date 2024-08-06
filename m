Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B417A591;
	Tue,  6 Aug 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984621; cv=none; b=JRJf2Zfj7BYkgqKObjpfzJqGfW/nyTOhpaiCEg0saW7IzChRzRcnJcS71XwoB9QqASphCqwuls7tRU9EpPCOe6jsLhTXa7LqgAvQbjArhJyI/WEdM6QKDGsim76pKqG3vmDgJ7DpsJCCkbHW/igvJfeaWroADdiIOtRuTIQ33Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984621; c=relaxed/simple;
	bh=gK1obJXd1qkzdCSSqvX5FK5ZTMAeRQdCpQHNrfbJ+40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+F1th2S/PE+g+A8iPsVXPHAkSCqZV4/F19u9kypzrtTjkB0u7/j2eI9vbKgqNzLmyEtrnEDFmhamPz2TPq9hBLqFCcyT7eGdLyBcmL7z8oTMPx/qvgEbGCGM3OgHmG5syaOrBb10DQiisfEtKakzlpfr6SH6eP8vKb/+ux0pjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNn/qlvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNn/qlvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6A5C4AF12;
	Tue,  6 Aug 2024 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984621;
	bh=gK1obJXd1qkzdCSSqvX5FK5ZTMAeRQdCpQHNrfbJ+40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNn/qlviS23xtpwnn36sM+c4rE9Q86HBZ3XiXHNJO3s0LKnH8QF6Imu2asSSer52+
	 llzsVXU5M4Dm7QAbB6KdaluuMNoGnW3nxIHlgq3TDV1ABoge+Fep39pGb81ue53qUO
	 M5n0VkXTOwmG4cwJJ3el0H0PdmwY0ky4ZezIEuECJ7L9hSM0ZEg7RtVW1S868DGIDa
	 kwGVLOmWKAm367+MRO/AbqSk4prdnrfu2QVg3pKciJVnaQiBnpE6Ou11bQsRLzqXzP
	 a0E6vFTyd1Jb9tvdGBJswVvBnmr3SMZrVrB6d4ERjvrtyjpxZuTIi5jceImQRnPDbK
	 ioPFDrVYPKoVA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/10] tools/include: Sync arm64 headers with the kernel sources
Date: Tue,  6 Aug 2024 15:50:13 -0700
Message-ID: <20240806225013.126130-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  9ef54a384526 arm64: cputype: Add Cortex-A725 definitions
  58d245e03c32 arm64: cputype: Add Cortex-X1C definitions
  fd2ff5f0b320 arm64: cputype: Add Cortex-X925 definitions
  add332c40328 arm64: cputype: Add Cortex-A720 definitions
  be5a6f238700 arm64: cputype: Add Cortex-X3 definitions

This should be used to beautify x86 syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/arm64/include/asm/cputype.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 7b32b99023a2..5fd7caea4419 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -86,9 +86,14 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
+#define ARM_CPU_PART_CORTEX_X3		0xD4E
 #define ARM_CPU_PART_NEOVERSE_V2	0xD4F
+#define ARM_CPU_PART_CORTEX_A720	0xD81
 #define ARM_CPU_PART_CORTEX_X4		0xD82
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
+#define ARM_CPU_PART_CORTEX_X925	0xD85
+#define ARM_CPU_PART_CORTEX_A725	0xD87
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -162,9 +167,14 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_CORTEX_X1C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
+#define MIDR_CORTEX_X3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X3)
 #define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
+#define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
 #define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
+#define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
+#define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.46.0.rc2.264.g509ed76dc8-goog

