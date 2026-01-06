Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E372A32E15F;
	Tue,  6 Jan 2026 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700656; cv=none; b=SoPGQEgpXHisNwlO0A2p+m+Siu9A4LCwVQnpvqV0odQlS2RwAXkSW8xO8SvVh6mIjg8mq9i4+m3jWB8iantq9SXBY84C+h+tOUqgn3P1toBd/TCOpHyA3+ycJkKzDz6n6b6L7bhhie3HIgl0POwjsNIKzOdw9UM69FiwWxuuOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700656; c=relaxed/simple;
	bh=K+lf5GgTPw3SkqzOp32MWVxQu+Fbe4D7TBbZIbWs9ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIBzB14nlfRAOw1JT76kWHh1ffi/iLlsi2z00WKNN1nBnAl2fKJV2bE+2HzN/jNZs6Dhr0tiSk0N8JMn7jpJhEgKVqlL2L+ikYKdSzPJFPTfXkjCNsz5abNEm9i90OKMsV1tLm7EdkQC4B3U+uzFM0K3ihltUPjiV6GHUURbpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746C51595;
	Tue,  6 Jan 2026 03:57:27 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23BA23F5A1;
	Tue,  6 Jan 2026 03:57:31 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 11:56:52 +0000
Subject: [PATCH v4 7/8] perf report: Update document for SIMD flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-7-bb2d143b3860@arm.com>
References: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
In-Reply-To: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767700634; l=1301;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K+lf5GgTPw3SkqzOp32MWVxQu+Fbe4D7TBbZIbWs9ig=;
 b=k/xTXe3YqGqG9L/Nyv5kn4l5oxuuy7HIXzuHEGa6Vbg+veCO5lFeKkWYRjuEAATLbcwCwkKLX
 oYAK8EJSYivCNoahO4g+IUG+oV9rj+c5namDOlVJ8vvnmW4RertRPRd
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

