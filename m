Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24883233ED;
	Fri, 12 Dec 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543461; cv=none; b=jnyW+rEj5BdhqAhkvxqwRkC7hL7Dc/T0SDty91MRqYQKNO2+F7Iq7aypEGFOAKdPX3NqtgD6m/7e9z/Qz3/911JfS74I8gGVzrkSwxXjH4CWA2G/4g6jgEa4p4OTVWV0edOqnKxzdJUgES4QnmrWU/GNuAEN4JrkeOmA+NUjpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543461; c=relaxed/simple;
	bh=xjFry3+Qwb2If5ls7tOuCo2U0koPfIRw3LR2ftk6/dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mngRblxu7CWo9YGqoFRb9Sy6s27mpNI/ij1r04+BSxiSVdD6ouCrnD3qNZFGiVmaFJ5q94scLyB/yWPz9cA6ILYd613EV/Vrfzeh0qwddbludLhXDzgAL5IudWKCtFKxin0A65H9f0dcWQDyOkYI11ZI0aiAT3zwBz/R1esceeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328EFFEC;
	Fri, 12 Dec 2025 04:44:12 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 820E23F762;
	Fri, 12 Dec 2025 04:44:17 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Dec 2025 12:44:04 +0000
Subject: [PATCH 2/2] perf c2c: Update documentation for Arm SPE events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-perf_c2c_update_event-v1-2-29a26c7a949b@arm.com>
References: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
In-Reply-To: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765543453; l=1053;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=xjFry3+Qwb2If5ls7tOuCo2U0koPfIRw3LR2ftk6/dI=;
 b=gLk+Oz9sgXO0vTq5i0+d0vBbN95yxI6Har+R8p/Y7EKtJ/CGsMqtsUaBitmY4dZ5URIHp//k2
 abZPeaUXxm4DEoXtzC7gE0NvzG3txTiO3NqUpTWjMrlp0m5IsnMswNM
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Document the default Arm SPE events used by the perf c2c tool.  Make a
minor adjustment to the PowerPC entry for formatting consistency.

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-c2c.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 40b0f71a2c44eb642ff3bb234631a614b7c4fc9d..b765ae2511d2418a63092fb8a90a61faa335ac91 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -170,11 +170,16 @@ following on AMD:
 
   ibs_op//
 
-and following on PowerPC:
+following on PowerPC:
 
   cpu/mem-loads/
   cpu/mem-stores/
 
+following on Arm:
+
+  arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,min_latency=30/
+  arm_spe_0/ts_enable=1,pa_enable=1,store_filter=1/
+
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):
 

-- 
2.34.1

