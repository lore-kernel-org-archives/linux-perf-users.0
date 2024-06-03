Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0B137C2E;
	Mon,  3 Jun 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439594; cv=none; b=T7zw0DSB8WkCLFdJD67dl+YfhbSBwieNLcl0s0Y1G5zsOcdGGzfvREQ/GKaIL7FBanGR4lYwLIclKVcvlj81JCYD5thax3v6IRM4zmu4GA9gjiS7pWmgeXWQSpFRIrwkxwjtFEHkKTk+O02fkEkdk49YWD51u38dP2MPIN1HC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439594; c=relaxed/simple;
	bh=jj98CjPyME4Voy2QNWkrK/fLGNfW8hYiYos9sHUioDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VaHQk0yCgziYBx/QTX0FkXVINr0xAe2TOvAibv/a0HnUIr8GS0TaFoN1S+19YdiarKQyE/YxYTgOCSfOXndat1NLW3BOas8sOdYTkYVULQvsw+NC7r1qP0iJehucwC5TB6gKelhkNJDmQMIbl8irbpC80cb5mU6BxrUFyJLso+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNr2KKPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNr2KKPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA85C2BD10;
	Mon,  3 Jun 2024 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717439594;
	bh=jj98CjPyME4Voy2QNWkrK/fLGNfW8hYiYos9sHUioDc=;
	h=Date:From:To:Cc:Subject:From;
	b=pNr2KKPEQNBb/rj38zjXqkpqE3syPrUUNJlgXH3iN7pcww+ss2jTI4OwsRpTIxMwO
	 mcsqEjXQezj6xsSIFTVAENtYDLC8D8rP9sCMDvLR2SgALjbvD+ROSKsiU+37AI1TQd
	 /W7K9W+75HMBuUUL0qdJ1/GvFYb7p1ksoahjV1RQEpMiB6cap2uw6t1KFth1oC6yUZ
	 N0XbyxXrDM83mI0OJyCv7mB0cBaXeX9SqxqC/plAvxi72Iy8K/UEOwB13i13yVyQB2
	 Pxi8jT+XaqiHxSYtUNblXZeMw9dhEhZy1svXt/OxPsy34KFbmNr96Ts9fMDZjjfPEg
	 rEODhx7z9Q7hA==
Date: Mon, 3 Jun 2024 15:33:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Will Deacon <will@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <Zl4MYzhP0NB-Z1DW@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To get the changes in:

  0ce85db6c2141b7f ("arm64: cputype: Add Neoverse-V3 definitions")
  02a0a04676fa7796 ("arm64: cputype: Add Cortex-X4 definitions")
  f4d9d9dcc70b96b5 ("arm64: Add Neoverse-V2 part")

That makes this perf source code to be rebuilt:

  CC      /tmp/build/perf-tools/util/arm-spe.o

The changes in the above patch add MIDR_NEOVERSE_V[23] and
MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
for later when this is all tested on those machines?

  static const struct midr_range neoverse_spe[] = {
          MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
          MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
          MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
          {},
  };

That addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 52f076afeb96006c..7b32b99023a21d3a 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -86,6 +86,9 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
+#define ARM_CPU_PART_CORTEX_X4		0xD82
+#define ARM_CPU_PART_NEOVERSE_V3	0xD84
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -159,6 +162,9 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
+#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
+#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.44.0

