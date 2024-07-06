Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82E13B285;
	Sat,  6 Jul 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279276; cv=none; b=kPYwH1iu6imHbQ0EFjwsHZFneupK+TKNksEwnpJfQTG0Qktc/EA59/Zfwp3w3hjVZqh7YZbtFptHf9LVXp45rtcBhV6suRYLceDsfmu0jrVHNZcEiU+O17hG38wV+f2S+ExEkI2rDssF3QF6G6AykPb+V45Ezkhmo2xl7RocFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279276; c=relaxed/simple;
	bh=yXdPT+WkyCxMh0Bgond9k/k+SWwa6T8kNHAgWgcUYnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onOvLIIHFbtWxhWhJ8bChWgKikNtZdDi2GiXyLbrBfbEE+qrh9o+HBb9FNoNyleykDfsFg/vzYY04JOKIPTnU+AcVS13V8nJUBL65cE81n2m46sOk3m0R6aFt196PQ1B9iVI1RXgUpt+mIKiSawqthEBY6+4WyaiK/I4IPL0WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70B881596;
	Sat,  6 Jul 2024 08:21:33 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BC623F762;
	Sat,  6 Jul 2024 08:21:06 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@arm.com>
Subject: [PATCH v2 2/2] perf mem: Warn if memory events are not supported on all CPUs
Date: Sat,  6 Jul 2024 16:20:35 +0100
Message-Id: <20240706152035.86983-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706152035.86983-1-leo.yan@arm.com>
References: <20240706152035.86983-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible that memory events are not supported on all CPUs.

Prints a warning by dumping the enabled CPU maps in this case.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/mem-events.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 6dda47bb774f..8aff2ca8bbd5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <api/fs/fs.h>
 #include <linux/kernel.h>
+#include "cpumap.h"
 #include "map_symbol.h"
 #include "mem-events.h"
 #include "mem-info.h"
@@ -242,6 +243,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 	int i = *argv_nr;
 	const char *s;
 	char *copy;
+	struct perf_cpu_map *cpu_map = NULL;
 
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
@@ -266,7 +268,19 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = copy;
+
+			cpu_map = perf_cpu_map__merge(cpu_map, pmu->cpus);
+		}
+	}
+
+	if (cpu_map) {
+		if (!perf_cpu_map__equal(cpu_map, cpu_map__online())) {
+			char buf[200];
+
+			cpu_map__snprint(cpu_map, buf, sizeof(buf));
+			pr_warning("Memory events are enabled on a subset of CPUs: %s\n", buf);
 		}
+		perf_cpu_map__put(cpu_map);
 	}
 
 	*argv_nr = i;
-- 
2.34.1

