Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C3148304;
	Sat, 14 Sep 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350928; cv=none; b=JQ+2h4sUtuZoW0TJv1cuwoSSANaWtoA0mi9JLYmgUCdV6LuvGWmFYspRhcQXD0qeHPwznbPezKomO2ePEOQHLfp1Y843x0VllyDModC0Av03/zQeUmaGMfmEbvXD0UnfSCLxccZTGBzYnq4AJhUBSsUsdlF+5snE7Inh9MMqiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350928; c=relaxed/simple;
	bh=zHq/VdqpyzLDJ8wHmcGMNwoat4GyL4J6cLWHqWwsFmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0J9y8WT9+l1aOrTigcmkgr17074wk1f6vXv2+Yp2AYOOR8qxWZIUmqFo9vxof9OS4Nf+eDT/YzB/HX37p3upZcUSovkqQR7qODtjrhgyyfuZ3PR7Jbkvw/mrqu0wOd4MpMmohyAy18Dmvp5nc4sWIE1T+n6LA07nYRT6LPbPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42A711FB;
	Sat, 14 Sep 2024 14:55:55 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E2EA3F66E;
	Sat, 14 Sep 2024 14:55:24 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Will Deacon <will@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 5/5] perf arm-spe: Dump metadata with version 2
Date: Sat, 14 Sep 2024 22:54:58 +0100
Message-Id: <20240914215458.751802-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914215458.751802-1-leo.yan@arm.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit dumps metadata with version 2. It dumps metadata for header
and per CPU data respectively in the arm_spe_print_info() function to
support metadata version 2 format.

After:

  0 0 0x3c0 [0x1b0]: PERF_RECORD_AUXTRACE_INFO type: 4
    Header version     :2
    Header size        :4
    Shared PMU type    :13
    CPU number         :8
      Magic            :0x1010101010101010
      CPU #            :0
      Num of params    :3
      MIDR             :0x410fd801
      PMU Type         :-1
      Min Interval     :0
      Magic            :0x1010101010101010
      CPU #            :1
      Num of params    :3
      MIDR             :0x410fd801
      PMU Type         :-1
      Min Interval     :0
      Magic            :0x1010101010101010
      CPU #            :2
      Num of params    :3
      MIDR             :0x410fd870
      PMU Type         :13
      Min Interval     :1024
      Magic            :0x1010101010101010
      CPU #            :3
      Num of params    :3
      MIDR             :0x410fd870
      PMU Type         :13
      Min Interval     :1024
      Magic            :0x1010101010101010
      CPU #            :4
      Num of params    :3
      MIDR             :0x410fd870
      PMU Type         :13
      Min Interval     :1024
      Magic            :0x1010101010101010
      CPU #            :5
      Num of params    :3
      MIDR             :0x410fd870
      PMU Type         :13
      Min Interval     :1024
      Magic            :0x1010101010101010
      CPU #            :6
      Num of params    :3
      MIDR             :0x410fd850
      PMU Type         :-1
      Min Interval     :0
      Magic            :0x1010101010101010
      CPU #            :7
      Num of params    :3
      MIDR             :0x410fd850
      PMU Type         :-1
      Min Interval     :0

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 54 +++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 17782cb40fb5..4212a8aa0d2c 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1133,16 +1133,60 @@ static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
 	return evsel->core.attr.type == spe->pmu_type;
 }
 
-static const char * const arm_spe_info_fmts[] = {
-	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
+static const char * const metadata_hdr_v1_fmts[] = {
+	[ARM_SPE_PMU_TYPE]		= "  PMU Type           :%"PRId64"\n",
+	[ARM_SPE_PER_CPU_MMAPS]		= "  Per CPU mmaps      :%"PRId64"\n",
 };
 
-static void arm_spe_print_info(__u64 *arr)
+static const char * const metadata_hdr_fmts[] = {
+	[ARM_SPE_HEADER_VERSION]	= "  Header version     :%"PRId64"\n",
+	[ARM_SPE_HEADER_SIZE]		= "  Header size        :%"PRId64"\n",
+	[ARM_SPE_SHARED_PMU_TYPE]	= "  Shared PMU type    :%"PRId64"\n",
+	[ARM_SPE_CPUS_NUM]		= "  CPU number         :%"PRId64"\n",
+};
+
+static const char * const metadata_per_cpu_fmts[] = {
+	[ARM_SPE_MAGIC]			= "    Magic            :0x%"PRIx64"\n",
+	[ARM_SPE_CPU]			= "    CPU #            :%"PRId64"\n",
+	[ARM_SPE_CPU_NR_PARAMS]		= "    Num of params    :%"PRId64"\n",
+	[ARM_SPE_CPU_MIDR]		= "    MIDR             :0x%"PRIx64"\n",
+	[ARM_SPE_CPU_PMU_TYPE]		= "    PMU Type         :%"PRId64"\n",
+	[ARM_SPE_CAP_MIN_IVAL]		= "    Min Interval     :%"PRId64"\n",
+};
+
+static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
 {
+	unsigned int i, cpu, hdr_size, cpu_num, cpu_size;
+	const char * const *hdr_fmts;
+
 	if (!dump_trace)
 		return;
 
-	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
+	if (spe->metadata_ver == 1) {
+		cpu_num = 0;
+		hdr_size = ARM_SPE_AUXTRACE_V1_PRIV_MAX;
+		hdr_fmts = metadata_hdr_v1_fmts;
+	} else {
+		cpu_num = arr[ARM_SPE_CPUS_NUM];
+		hdr_size = arr[ARM_SPE_HEADER_SIZE];
+		hdr_fmts = metadata_hdr_fmts;
+	}
+
+	for (i = 0; i < hdr_size; i++)
+		fprintf(stdout, hdr_fmts[i], arr[i]);
+
+	arr += hdr_size;
+	for (cpu = 0; cpu < cpu_num; cpu++) {
+		/*
+		 * The parameters from ARM_SPE_MAGIC to ARM_SPE_CPU_NR_PARAMS
+		 * are fixed. The sequential parameter size is decided by the
+		 * field 'ARM_SPE_CPU_NR_PARAMS'.
+		 */
+		cpu_size = (ARM_SPE_CPU_NR_PARAMS + 1) + arr[ARM_SPE_CPU_NR_PARAMS];
+		for (i = 0; i < cpu_size; i++)
+			fprintf(stdout, metadata_per_cpu_fmts[i], arr[i]);
+		arr += cpu_size;
+	}
 }
 
 static void arm_spe_set_event_name(struct evlist *evlist, u64 id,
@@ -1405,7 +1449,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
-	arm_spe_print_info(&auxtrace_info->priv[0]);
+	arm_spe_print_info(spe, &auxtrace_info->priv[0]);
 
 	if (dump_trace)
 		return 0;
-- 
2.34.1

