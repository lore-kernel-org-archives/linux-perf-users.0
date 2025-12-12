Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A33260578;
	Fri, 12 Dec 2025 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560315; cv=none; b=YbDMEMXtyk5ESU8iIGPCrM6JvBvwe4cluBQgeyZWUuPvVfkhD4DO659Z4RJCZDGCOf5hjhT9y0FAUL7sCpbLx3ZadoixR+vQFXCe2JmP1sT7GCRrYgZBF7MxFWUsphgwUvQhtQmoxOxqAXF7t8cY0t5L/FUTZkMQ25lTKRRnquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560315; c=relaxed/simple;
	bh=4sENnGgYOHx/gUayinw+QoHCGnkzWEnPWvka3BMCrtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqQHfwg+o+JscZb7k6EosQ8vUh4Cy/8guoJJeyArizYQAaV+AYSDaDvQ63jWGzPeIQR7JmCXUpYWUxqSwx1Lv/Z3XDU/jIc6kUN2r6JZvYR/qBjkGvnALpcUwAyBcdIQ4L/n4ObHx9DnxiQ+bqtHVBXtPwoP0C7h3Y+x9aykbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E55C165C;
	Fri, 12 Dec 2025 09:25:04 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FDB13F762;
	Fri, 12 Dec 2025 09:25:09 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Dec 2025 17:25:00 +0000
Subject: [PATCH v2 2/2] perf c2c: Update documentation for adding memory
 event table
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-perf_c2c_update_event-v2-2-27df9a6cb1d4@arm.com>
References: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>
In-Reply-To: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765560305; l=5821;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=4sENnGgYOHx/gUayinw+QoHCGnkzWEnPWvka3BMCrtU=;
 b=jxujxi9t2BzTy6A7hBC9TsDumro1k4Km+1WDkJS5SoA0uaZ+GSte//QNRQepJDkvlZC8wrXM6
 AMaIIiB27eJDFScd1aPp7JVMoPmfMwIWs5Yq91SihUsH36dCaNdxuA1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Users may occasionally need to see which options are applied to memory
events.  This helps to understand the behavior of "perf c2c" and
"perf mem", and provides guidance for configuring memory event options
directly.

Add a table to track memory events and their corresponding options, and
include the Arm SPE events in it.

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-c2c.txt | 51 +++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 40b0f71a2c44eb642ff3bb234631a614b7c4fc9d..e57a122b8719f1b2e20dd509959fc1563a6c20fd 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -160,20 +160,43 @@ Following perf record options are configured by default:
 
   -W,-d,--phys-data,--sample-cpu
 
-Unless specified otherwise with '-e' option, following events are monitored by
-default on Intel:
-
-  cpu/mem-loads,ldlat=30/P
-  cpu/mem-stores/P
-
-following on AMD:
-
-  ibs_op//
-
-and following on PowerPC:
-
-  cpu/mem-loads/
-  cpu/mem-stores/
+The following table lists the events monitored on different architectures.
+Unless specified otherwise with the -e option, the tool will select the
+default events.
+
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
+  | Arch   | Configuration | Options         | Events                                                                         |
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
+  | Intel  | Default       | -e ldlat-loads  | cpu/mem-loads,ldlat=30/P                                                       |
+  |        |               | -e ldlat-stores | cpu/mem-stores/P                                                               |
+  |        |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Load only     | -e ldlat-loads  | cpu/mem-loads,ldlat=30/P                                                       |
+  |        |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Store only    | -e ldlat-stores | cpu/mem-stores/P                                                               |
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
+  | Intel  | Default       | -e ldlat-loads  | {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P                                 |
+  | with   |               | -e ldlat-stores | cpu/mem-stores/P                                                               |
+  | AUX    |--------------+------------------+--------------------------------------------------------------------------------+
+  |        | Load only     | -e ldlat-loads  | {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P                                 |
+  |        |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Store only    | -e ldlat-stores | cpu/mem-stores/P                                                               |
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
+  | AMD    | Default       | -e mem-ldst     | ibs_op// (without latency support)                                             |
+  |        |               |                 | ibs_op/ldlat=30/ (with latency support)                                        |
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
+  | PowerPC| Default       | -e ldlat-loads  | cpu/mem-loads/                                                                 |
+  |        |               | -e ldlat-stores | cpu/mem-stores/                                                                |
+  |        |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Load only     | -e ldlat-loads  | cpu/mem-loads/                                                                 |
+  |        |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Store only    | -e ldlat-stores | cpu/mem-stores/                                                                |
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
+  | Arm    | Default       | -e spe-ldst     | arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/ |
+  | SPE    |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Load only     | -e spe-load     | arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,min_latency=30/                |
+  |        |---------------+-----------------+--------------------------------------------------------------------------------+
+  |        | Store only    | -e spe-store    | arm_spe_0/ts_enable=1,pa_enable=1,store_filter=1/                              |
+  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
 
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):

-- 
2.34.1

