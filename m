Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAC1D0DF2;
	Tue, 27 Aug 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777511; cv=none; b=urzacfgX2a9kYYQ3qabMzBW5mYhW2Qo9xA8lbKCgDmaIHLbtncya5fSgs/d28+YkrpS8QSidSpE6TAgU0WDWv1yB/xq9PZbtaJ2qU+W4F3aHyCmT5oo1wiM/ytHkgZMMui3Yh0/JHvUeMcNXkgFvEPJvWQaqu6VqOUkGpeNy0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777511; c=relaxed/simple;
	bh=i+OhJeYlw8XeUzwjw5n2khlDVtqfGb6HAVqAWL+2p64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTvUwIpAeFX8MGa+69zj26iELTewLnu7F1hK0K03Ke2OTr5alc00TOU5f6eXYvqe7qSODfWFql+jQa7AMMTcp2uhu6POtrBpLnuEtzKURRM7euFvZtLK3SGk77SLDRQfHr1jFooJ+a/os30Ni3RBkcXl8r7+Ybyc36uMpZrtUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84E071424;
	Tue, 27 Aug 2024 09:52:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 525CB3F66E;
	Tue, 27 Aug 2024 09:51:47 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/7] perf arm-spe: Introduce arm_spe__is_homogeneous()
Date: Tue, 27 Aug 2024 17:51:21 +0100
Message-Id: <20240827165125.3311306-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827165125.3311306-1-leo.yan@arm.com>
References: <20240827165125.3311306-1-leo.yan@arm.com>
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
index 2ab9078d49fc..e7ad52215066 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -82,6 +82,7 @@ struct arm_spe {
 	u64				**metadata;
 	u64				metadata_ver;
 	u64				metadata_num_cpu;
+	bool				is_homogeneous;
 };
 
 struct arm_spe_queue {
@@ -1316,6 +1317,30 @@ static u64 *arm_spe__create_meta_blk(u64 *buf, int per_cpu_size)
 	return metadata;
 }
 
+static bool arm_spe__is_homogeneous(u64 **metadata, int num_cpu)
+{
+	u64 midr;
+	int i;
+
+	if (!num_cpu)
+		return false;
+
+	for (i = 0; i < num_cpu; i++) {
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
@@ -1384,6 +1409,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_num_cpu = num_cpu;
+	spe->is_homogeneous = arm_spe__is_homogeneous(metadata, num_cpu);
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
-- 
2.34.1

