Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64061CF28D;
	Tue, 27 Aug 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777096; cv=none; b=Us3MiHqwA7KGMOu8r7LCOef0IBT4q4CoLqAah5ZqtpPyUe8eCdm65wy5GRwK3OSHLF1oYKXE+dLYnXrLDBQeACjIw2IIzAMR2/Lyz6Qn2tHabj2Rf9dchOLXl61GDrapdwCRcu7ZocRaFEtQSJYMwuEv83mHaWqkHxme1WdO8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777096; c=relaxed/simple;
	bh=BwnfzGeKKodPdb0q9w4EIWZMwjDvuh7tqjkZzZlq4SM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzASjBB7v7cuPF76D7772rta6QaZI9PboCq/Lsjaw7i5cbSjhy5fUyLsvGbAMqBDRz8kMB5dQWPatsL+iA2z25ZjNM8nd+xYgBnKZs1uLEfm6t95LKa0K/hlg3vJmG/RmUq0VLHHzKooVc50oaA2Y4ONs444CfizYOh6/AbpC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A622DDA7;
	Tue, 27 Aug 2024 09:45:20 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58BC73F762;
	Tue, 27 Aug 2024 09:44:52 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 9/9] perf arm-spe: Dump metadata with version 2
Date: Tue, 27 Aug 2024 17:44:17 +0100
Message-Id: <20240827164417.3309560-10-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827164417.3309560-1-leo.yan@arm.com>
References: <20240827164417.3309560-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit dumps metadata with version 2. It uses two string arrays
metadata_hdr_fmts and metadata_per_cpu_fmts as string formats for the
header and per CPU data respectively, and the arm_spe_print_info()
function is enhanced to support dumping metadata with the version 2
format.

After:

  0 0 0x4a8 [0x170]: PERF_RECORD_AUXTRACE_INFO type: 4
  PMU Type           :13
  Version            :2
  Num of CPUs        :8
    CPU #            :0
    MIDR             :0x410fd801
    Bound PMU Type   :-1
    Min Interval     :0
    Load Data Source :0
    CPU #            :1
    MIDR             :0x410fd801
    Bound PMU Type   :-1
    Min Interval     :0
    Load Data Source :0
    CPU #            :2
    MIDR             :0x410fd870
    Bound PMU Type   :13
    Min Interval     :1024
    Load Data Source :1
    CPU #            :3
    MIDR             :0x410fd870
    Bound PMU Type   :13
    Min Interval     :1024
    Load Data Source :1
    CPU #            :4
    MIDR             :0x410fd870
    Bound PMU Type   :13
    Min Interval     :1024
    Load Data Source :1
    CPU #            :5
    MIDR             :0x410fd870
    Bound PMU Type   :13
    Min Interval     :1024
    Load Data Source :1
    CPU #            :6
    MIDR             :0x410fd850
    Bound PMU Type   :14
    Min Interval     :1024
    Load Data Source :1
    CPU #            :7
    MIDR             :0x410fd850
    Bound PMU Type   :14
    Min Interval     :1024
    Load Data Source :1

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 43 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 87cf06db765b..be34d4c4306a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1067,16 +1067,49 @@ static bool arm_spe_evsel_is_auxtrace(struct perf_session *session __maybe_unuse
 	return strstarts(evsel->name, ARM_SPE_PMU_NAME);
 }
 
-static const char * const arm_spe_info_fmts[] = {
-	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
+static const char * const metadata_hdr_fmts[] = {
+	[ARM_SPE_PMU_TYPE]		= "  PMU Type           :%"PRId64"\n",
+	[ARM_SPE_HEADER_VERSION]	= "  Version            :%"PRId64"\n",
+	[ARM_SPE_CPU_NUM]		= "  Num of CPUs        :%"PRId64"\n",
 };
 
-static void arm_spe_print_info(__u64 *arr)
+static const char * const metadata_per_cpu_fmts[] = {
+	[ARM_SPE_CPU]			= "    CPU #            :%"PRId64"\n",
+	[ARM_SPE_CPU_MIDR]		= "    MIDR             :0x%"PRIx64"\n",
+	[ARM_SPE_CPU_PMU_TYPE]		= "    Bound PMU Type   :%"PRId64"\n",
+	[ARM_SPE_CAP_MIN_IVAL]		= "    Min Interval     :%"PRId64"\n",
+	[ARM_SPE_CAP_LDS]		= "    Load Data Source :%"PRId64"\n",
+};
+
+static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
 {
+	unsigned int i, cpu, header_size, cpu_num, per_cpu_size;
+
 	if (!dump_trace)
 		return;
 
-	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
+	if (spe->metadata_ver == 1) {
+		cpu_num = 0;
+		header_size = ARM_SPE_AUXTRACE_V1_PRIV_MAX;
+		per_cpu_size = 0;
+	} else if (spe->metadata_ver == 2) {
+		cpu_num = arr[ARM_SPE_CPU_NUM];
+		header_size = ARM_SPE_AUXTRACE_V2_PRIV_MAX;
+		per_cpu_size = ARM_SPE_AUXTRACE_V2_PRIV_PER_CPU_MAX;
+	} else {
+		pr_err("Cannot support metadata ver: %ld\n", spe->metadata_ver);
+		return;
+	}
+
+	for (i = 0; i < header_size; i++)
+		fprintf(stdout, metadata_hdr_fmts[i], arr[i]);
+
+	arr += header_size;
+	for (cpu = 0; cpu < cpu_num; cpu++) {
+		for (i = 0; i < per_cpu_size; i++)
+			fprintf(stdout, metadata_per_cpu_fmts[i], arr[i]);
+		arr += per_cpu_size;
+	}
 }
 
 static void arm_spe_set_event_name(struct evlist *evlist, u64 id,
@@ -1383,7 +1416,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
-	arm_spe_print_info(&auxtrace_info->priv[0]);
+	arm_spe_print_info(spe, &auxtrace_info->priv[0]);
 
 	if (dump_trace)
 		return 0;
-- 
2.34.1

