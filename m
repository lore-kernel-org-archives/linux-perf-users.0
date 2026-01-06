Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71F330651;
	Tue,  6 Jan 2026 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701310; cv=none; b=AVmNZbRKXiHErn9xNJ6HnP+cjcyLDWY7uKaw/9hVVPNbSsPSlYFt7ESTlUZQpZH5qfe+TzIfFzi3HcnVQm3HRAqL8rOyS3yiYXjjvGELZYjBdUAzDRTB8aMA2erU7vB/tVcBC3rR7mpRnxMA9e8mDDTT3R4EiqVYFl7vt3lqF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701310; c=relaxed/simple;
	bh=gR5em95jkVY3/iuQLYqrGqJMKIzk5efq2xG/AUglxV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eClVrCL4X7rEmhxIgzitwRZ6hKZKA2zEL5fnk7z5S86RZirlmqzjkNaW/XunRtAVrllzQKoA2WJUaNosHb5V7HzQAAQc92+q7TMgoExj32eD885u63v6771Ivz3FKM9WyceKGWb06l3ZUMpE9cZRFsmZlaQ5i4RrmroCyO9PTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C6A497;
	Tue,  6 Jan 2026 04:08:21 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E383F5A1;
	Tue,  6 Jan 2026 04:08:26 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 12:07:57 +0000
Subject: [PATCH RESEND v4 7/8] perf report: Update document for SIMD flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-7-b887bb999f6e@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767701288; l=1398;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=gR5em95jkVY3/iuQLYqrGqJMKIzk5efq2xG/AUglxV4=;
 b=AKpwXefmFsisKFUkzutM3l9KOt+j7n5qcSW/dDe+qDl7mbG4g9l5OVCT/Bsk50+9A/d4TjAAq
 p1isgHarN5VD0YMxZsFDee3DsFnibo/h+yxXDOGu0WIrRf8IuPoZq7J
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Update SIMD architecture and predicate flags.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
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

