Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700301D2F57;
	Tue, 27 Aug 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777095; cv=none; b=tyTyOouB899XJlO9gporxy53/ngMkTsS4IWjFHAOKY9qGUbpvY0G82m16L+XPRBORP6vf37nNXyTv7SoGpiRx8derfr3fxWmJOc1lyf60Hr6zNYPmp+FMOtnlyWTVX9/f0dy0IUPiPVXwV5PfzuONh41tybVAluQVFvezGBQjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777095; c=relaxed/simple;
	bh=/joNrTFVMowWX3/F9L6uO79qu75G2Dg5653xcJLYnxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGfCtK+/l1nCVr3LGUKAGsIZ/IU1lVxorQaZypju2TSR0u7WnjlDDP7aZnKZnDhVbGT8HHa2HA3QfkDv/Isgwiye4a+UB3KM+/8l7xWbHPGxSCBwvT2KuqfdUbRtfRWe8Xi8eWgYgy1U7nd7WHkFGxCGtp6vND6jLlLHqhFSEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50CF613D5;
	Tue, 27 Aug 2024 09:45:18 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03B043F762;
	Tue, 27 Aug 2024 09:44:49 -0700 (PDT)
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
Subject: [PATCH v1 8/9] perf arm-spe: Support metadata version 2
Date: Tue, 27 Aug 2024 17:44:16 +0100
Message-Id: <20240827164417.3309560-9-leo.yan@arm.com>
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

This commit is to support metadata version 2 and at the meantime it is
backward compatible for version 1's format.

The metadata version 1 doesn't include the ARM_SPE_HEADER_VERSION field.
By checking the header size, it distinguishes the metadata is version 1
or version 2 (and any new versions if later will have). For version 2,
it reads out CPU number and retrieves the metadata info for every CPU.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 76 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 1e87342f4bd8..87cf06db765b 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -78,6 +78,10 @@ struct arm_spe {
 
 	unsigned long			num_events;
 	u8				use_ctx_pkt_for_pid;
+
+	u64				**metadata;
+	u64				metadata_ver;
+	u64				metadata_num_cpu;
 };
 
 struct arm_spe_queue {
@@ -1044,12 +1048,16 @@ static void arm_spe_free_events(struct perf_session *session)
 
 static void arm_spe_free(struct perf_session *session)
 {
+	unsigned int i;
 	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
 					     auxtrace);
 
 	auxtrace_heap__free(&spe->heap);
 	arm_spe_free_events(session);
 	session->auxtrace = NULL;
+	for (i = 0; i < spe->metadata_num_cpu; i++)
+		zfree(&spe->metadata[i]);
+	zfree(&spe->metadata);
 	free(spe);
 }
 
@@ -1256,24 +1264,81 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	return 0;
 }
 
+static bool
+arm_spe_has_metadata_field(struct perf_record_auxtrace_info *auxtrace_info, int pos)
+{
+	return auxtrace_info->header.size >=
+		sizeof(struct perf_record_auxtrace_info) + (sizeof(u64) * (pos + 1));
+}
+
+static u64 *arm_spe__create_meta_blk(u64 *buf, int per_cpu_size)
+{
+	u64 *metadata = NULL;
+
+	metadata = zalloc(sizeof(*metadata) * per_cpu_size);
+	if (!metadata)
+		return NULL;
+
+	memcpy(metadata, buf, per_cpu_size);
+	return metadata;
+}
+
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
+	size_t min_sz;
 	struct perf_record_time_conv *tc = &session->time_conv;
 	const char *cpuid = perf_env__cpuid(session->evlist->env);
 	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
+	u64 *ptr = NULL;
+	u64 **metadata = NULL;
+	u64 metadata_ver;
+	int num_cpu = 0, i, per_cpu_sz;
 	int err;
 
+	/* First the global part */
+	ptr = (u64 *)auxtrace_info->priv;
+
+	/* Metadata v1 has no the ARM_SPE_HEADER_VERSION field */
+	if (!arm_spe_has_metadata_field(auxtrace_info, ARM_SPE_HEADER_VERSION)) {
+		metadata_ver = 1;
+		num_cpu = 0;
+		min_sz = ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
+		per_cpu_sz = 0;
+		ptr += ARM_SPE_AUXTRACE_V1_PRIV_MAX;
+	} else {
+		metadata_ver = ptr[ARM_SPE_HEADER_VERSION];
+		num_cpu = ptr[ARM_SPE_CPU_NUM];
+		min_sz = ARM_SPE_AUXTRACE_V2_PRIV_SIZE +
+			 ARM_SPE_AUXTRACE_V2_PER_CPU_SIZE * num_cpu;
+		per_cpu_sz = ARM_SPE_AUXTRACE_V2_PER_CPU_SIZE;
+		ptr += ARM_SPE_AUXTRACE_V2_PRIV_MAX;
+	}
+
 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
 					min_sz)
 		return -EINVAL;
 
+	if (num_cpu) {
+		metadata = zalloc(sizeof(*metadata) * num_cpu);
+		if (!metadata)
+			return -ENOMEM;
+
+		for (i = 0; i < num_cpu; i++) {
+			metadata[i] = arm_spe__create_meta_blk(ptr, per_cpu_sz);
+			if (!metadata[i]) {
+				err = -ENOMEM;
+				goto err_free_metadata;
+			}
+			ptr += per_cpu_sz / sizeof(u64);
+		}
+	}
+
 	spe = zalloc(sizeof(struct arm_spe));
 	if (!spe)
-		return -ENOMEM;
+		goto err_free_metadata;
 
 	err = auxtrace_queues__init(&spe->queues);
 	if (err)
@@ -1283,6 +1348,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->midr = midr;
+	spe->metadata = metadata;
+	spe->metadata_ver = metadata_ver;
+	spe->metadata_num_cpu = num_cpu;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
@@ -1343,5 +1411,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	session->auxtrace = NULL;
 err_free:
 	free(spe);
+err_free_metadata:
+	for (i = 0; i < num_cpu; i++)
+		zfree(&metadata[i]);
+	zfree(&metadata);
 	return err;
 }
-- 
2.34.1

