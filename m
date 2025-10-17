Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FEE30FC3B
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695550; cv=none; b=Ft4WbLMGAx8CnUL/0CSAdbl/YDpNoImqHVcHVnlAJx2e2hBBQV+kn18ZLzUD8tQU/s+58+HeHvStxoBZrDWsxHNclE25gnesu/A55bLIMQtZ20KID1E/CmvD3DH4TcmTdL9xg1K5OE4+611CCum4vXXd/NG/iPr9LalsmIC7+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695550; c=relaxed/simple;
	bh=K+lf5GgTPw3SkqzOp32MWVxQu+Fbe4D7TBbZIbWs9ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElBEr8CNelbD/i+BZttH0uaiJrrcLe/eYQF5NGFx/fXxvl7meWgWF2Mx9eYKn9qjHeMC1rtRGFCFAWLvFd/v/xSwrv1MGbj5uTg4q9BVcPSXKDuqbv8NNMg6lnQmFKN3WiCccuFIjR5apfjIs7VhXd1ayz/jjHHb3BqG1Dpawl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2341C25;
	Fri, 17 Oct 2025 03:05:40 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 289903F59E;
	Fri, 17 Oct 2025 03:05:47 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:13 +0100
Subject: [PATCH v2 24/25] perf report: Update document for SIMD flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-24-2d41e4746e1b@arm.com>
References: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
In-Reply-To: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=1301;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K+lf5GgTPw3SkqzOp32MWVxQu+Fbe4D7TBbZIbWs9ig=;
 b=8KspN+Twk/hJKAn4lxPldBCPyM1QBdRuH+SAfTGc3DyhwPHVceq9aEI6KY/VbYPvFd7oWJDMd
 iGcnrU/nzNGDmkfAb0O5F8a55JTUlVaCTPlu8u+tcg1w13bGwEOclDc
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Update SIMD architecture and predicate flags.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-report.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index acef3ff4178eff66e8f876ae16cdac7b1387f07b..f361081a65dbe9cead539c7cb81d6ed86eb0acc6 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -136,7 +136,10 @@ OPTIONS
 	- addr: (Full) virtual address of the sampled instruction
 	- retire_lat: On X86, this reports pipeline stall of this instruction compared
 	  to the previous instruction in cycles. And currently supported only on X86
-	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
+	- simd: Flags describing a SIMD operation. The architecture type can be Arm's
+	  ASE (Advanced SIMD extension), SVE, SME. It provides an extra tag for
+	  predicate: "e" for empty predicate, "p" for partial predicate, "d" for
+	  predicate disabled, and "f" for full predicate.
 	- type: Data type of sample memory access.
 	- typeoff: Offset in the data type of sample memory access.
 	- symoff: Offset in the symbol.

-- 
2.34.1

