Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E84148823;
	Sat, 14 Sep 2024 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726351769; cv=none; b=aR8TvtyUf3WeKPutOHJuYCBpaDsWkxQOxhErJRyBuC0xgXZBe75jrRLoBDWyuHvcLJxUYeVchT+Jkkk6YviBovg/WQdjoIPXZDz6EF+B/mmnRS6sLABs8bFWVy1YiytNkgPao71juO5xrfZLzXy5t+OYKhkTU1XGq80hLvt+FtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726351769; c=relaxed/simple;
	bh=tCs131liyX3NjisbwqG8GgR4OUdt7zf5z+B/vqGgsl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibfWTX3YlhzHOENnpJfOJLUxMORmg90CiFzknxUYWIc9sXAU8wDFzQjt7UFapAW0Soecn4PdOzGXs2/+rlmM58/bxbNgAIWFos0Gx24f14WuFKNnK91dxELpd30Hpqozh/xA2nmL6kf8njUA/AuO8I8wdJWjQBm8vExkJ0pM1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE1801691;
	Sat, 14 Sep 2024 15:09:56 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B2393F66E;
	Sat, 14 Sep 2024 15:09:25 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 3/7] perf arm-spe: Introduce arm_spe__is_homogeneous()
Date: Sat, 14 Sep 2024 23:08:57 +0100
Message-Id: <20240914220901.756177-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914220901.756177-1-leo.yan@arm.com>
References: <20240914220901.756177-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the arm_spe__is_homogeneous() function, it uses to check if
Arm SPE is homogeneous cross all CPUs.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7cde6584b02d..7e00cf1c287c 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -82,6 +82,7 @@ struct arm_spe {
 	u64				**metadata;
 	u64				metadata_ver;
 	u64				metadata_nr_cpu;
+	bool				is_homogeneous;
 };
 
 struct arm_spe_queue {
@@ -1374,6 +1375,30 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	return 0;
 }
 
+static bool arm_spe__is_homogeneous(u64 **metadata, int nr_cpu)
+{
+	u64 midr;
+	int i;
+
+	if (!nr_cpu)
+		return false;
+
+	for (i = 0; i < nr_cpu; i++) {
+		if (!metadata[i])
+			return false;
+
+		if (i == 0) {
+			midr = metadata[i][ARM_SPE_CPU_MIDR];
+			continue;
+		}
+
+		if (midr != metadata[i][ARM_SPE_CPU_MIDR])
+			return false;
+	}
+
+	return true;
+}
+
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
@@ -1417,6 +1442,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_nr_cpu = nr_cpu;
+	spe->is_homogeneous = arm_spe__is_homogeneous(metadata, nr_cpu);
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
-- 
2.34.1

