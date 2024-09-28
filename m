Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019251607B2
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Sep 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727553367; cv=none; b=aSBsfnJdItD9N4Wq6OyNod3rLqZz4l7zbj+Bt2DpKzpIDuTDgkeQEO2cdlmlvgqD0SOxfKQYGjFD06K9LAl/gulLWtiuG68EzWxugI6hLMKmfpmK47PJwe4JQgc3qobNBs0F4YwF/Fhv+SjODHM2l/mQzfGhHkaJFIJxU/wHw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727553367; c=relaxed/simple;
	bh=6EpHXHoDVKXKp+vaml2MgoIIch5ZqP1eRQ4CDNHbN7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIGKh7GpLQAm3xo+7XJBc08YCW6nmh6yqlyQOZEcoiZj6ZoNDPO+9j7/qDWHcDfbHHcrneRHF2Z/xuu+cLGl/5Pzgo7kz5tpl2F5YMhYDa1ydmvbzzkaHngDrYGOtlHcoKE8Ch/e7JEEqm7MLpish/P37A5ozbs3w4ocEkrBlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A26231688;
	Sat, 28 Sep 2024 12:56:34 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40C6A3F64C;
	Sat, 28 Sep 2024 12:56:03 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 4/5] perf arm-spe: Support metadata version 2
Date: Sat, 28 Sep 2024 20:55:46 +0100
Message-Id: <20240928195547.59780-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928195547.59780-1-leo.yan@arm.com>
References: <20240928195547.59780-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is to support metadata version 2 and at the meantime it is
backward compatible for version 1's format.

The metadata version 1 doesn't include the ARM_SPE_HEADER_VERSION field.
As version 1 is fixed with two u64 fields, by checking the metadata
size, it distinguishes the metadata is version 1 or version 2 (and any
new versions if later will have). For version 2, it reads out CPU number
and retrieves the metadata info for every CPU.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 95 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 70989b1bae47..52cee7401ff4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -78,6 +78,10 @@ struct arm_spe {
 
 	unsigned long			num_events;
 	u8				use_ctx_pkt_for_pid;
+
+	u64				**metadata;
+	u64				metadata_ver;
+	u64				metadata_nr_cpu;
 };
 
 struct arm_spe_queue {
@@ -1016,6 +1020,73 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
+static u64 *arm_spe__alloc_per_cpu_metadata(u64 *buf, int per_cpu_size)
+{
+	u64 *metadata;
+
+	metadata = zalloc(per_cpu_size);
+	if (!metadata)
+		return NULL;
+
+	memcpy(metadata, buf, per_cpu_size);
+	return metadata;
+}
+
+static void arm_spe__free_metadata(u64 **metadata, int nr_cpu)
+{
+	int i;
+
+	for (i = 0; i < nr_cpu; i++)
+		zfree(&metadata[i]);
+	free(metadata);
+}
+
+static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
+				     u64 *ver, int *nr_cpu)
+{
+	u64 *ptr = (u64 *)info->priv;
+	u64 metadata_size;
+	u64 **metadata = NULL;
+	int hdr_sz, per_cpu_sz, i;
+
+	metadata_size = info->header.size -
+		sizeof(struct perf_record_auxtrace_info);
+
+	/* Metadata version 1 */
+	if (metadata_size == ARM_SPE_AUXTRACE_V1_PRIV_SIZE) {
+		*ver = 1;
+		*nr_cpu = 0;
+		/* No per CPU metadata */
+		return NULL;
+	}
+
+	*ver = ptr[ARM_SPE_HEADER_VERSION];
+	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
+	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
+
+	metadata = calloc(*nr_cpu, sizeof(*metadata));
+	if (!metadata)
+		return NULL;
+
+	/* Locate the start address of per CPU metadata */
+	ptr += hdr_sz;
+	per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
+
+	for (i = 0; i < *nr_cpu; i++) {
+		metadata[i] = arm_spe__alloc_per_cpu_metadata(ptr, per_cpu_sz);
+		if (!metadata[i])
+			goto err_per_cpu_metadata;
+
+		ptr += per_cpu_sz / sizeof(u64);
+	}
+
+	return metadata;
+
+err_per_cpu_metadata:
+	arm_spe__free_metadata(metadata, *nr_cpu);
+	return NULL;
+}
+
 static void arm_spe_free_queue(void *priv)
 {
 	struct arm_spe_queue *speq = priv;
@@ -1050,6 +1121,7 @@ static void arm_spe_free(struct perf_session *session)
 	auxtrace_heap__free(&spe->heap);
 	arm_spe_free_events(session);
 	session->auxtrace = NULL;
+	arm_spe__free_metadata(spe->metadata, spe->metadata_nr_cpu);
 	free(spe);
 }
 
@@ -1267,15 +1339,24 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	const char *cpuid = perf_env__cpuid(session->evlist->env);
 	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
-	int err;
+	u64 **metadata = NULL;
+	u64 metadata_ver;
+	int nr_cpu, err;
 
 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
 					min_sz)
 		return -EINVAL;
 
+	metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
+					   &nr_cpu);
+	if (!metadata && metadata_ver != 1) {
+		pr_err("Failed to parse Arm SPE metadata.\n");
+		return -EINVAL;
+	}
+
 	spe = zalloc(sizeof(struct arm_spe));
 	if (!spe)
-		return -ENOMEM;
+		goto err_free_metadata;
 
 	err = auxtrace_queues__init(&spe->queues);
 	if (err)
@@ -1284,8 +1365,14 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->session = session;
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
-	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	if (metadata_ver == 1)
+		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	else
+		spe->pmu_type = auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE];
 	spe->midr = midr;
+	spe->metadata = metadata;
+	spe->metadata_ver = metadata_ver;
+	spe->metadata_nr_cpu = nr_cpu;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
@@ -1346,5 +1433,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	session->auxtrace = NULL;
 err_free:
 	free(spe);
+err_free_metadata:
+	arm_spe__free_metadata(metadata, nr_cpu);
 	return err;
 }
-- 
2.34.1

