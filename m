Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9030CD84
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163915; cv=none; b=utbkFWRHspXbEvY1AfDvOaLRp6qyojzHJUXHNBfTsjM6rx2pW8qYFtd8Px5zHVOMnslC65e1ME/keRo6W2i+gy4Z/jjqTxtrGdIAufFTADEfpRDpxxEmZPnwG9SYWuCvmwkW5StuEnfBLkuyjYltvPiwyjoZYsjZKf/6NUuKERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163915; c=relaxed/simple;
	bh=K+lf5GgTPw3SkqzOp32MWVxQu+Fbe4D7TBbZIbWs9ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMm2wpsQDP0ZwGXNcHIslQ+0TH/todHVbTdSV4jl63An8awrmR3LVfRUrl5xFFOQASE1ExrB3ZiMBhz86TzdlAf9sfKPT3njrs16Q2rNbo7PseDI8lVBv70hK4Xdz0ijd0aEoQMJlsweYSsQugwU6amjSvHxc+GW4Z0vazYn65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A018150C;
	Mon, 29 Sep 2025 09:38:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047EC3F66E;
	Mon, 29 Sep 2025 09:38:31 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:38:00 +0100
Subject: [PATCH 24/25] perf report: Update document for SIMD flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-24-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1301;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K+lf5GgTPw3SkqzOp32MWVxQu+Fbe4D7TBbZIbWs9ig=;
 b=2y9rbFtRgPk/fl/IR99AAJdtzFHP8byuTNT6rWvMBLtcukf7b5p7CN7kH1Sm7GfcA7kAjZC7F
 kASMLG48HUeCBLpXDD3ctNov8WowRm1/Fyj7urHk9o0TyjUojPzTPt1
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

