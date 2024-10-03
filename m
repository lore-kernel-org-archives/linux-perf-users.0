Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B751AC458;
	Thu,  3 Oct 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981623; cv=none; b=DZGTbyyj0u+GCW28uW5x7V7LX+990O+t3bm53zGCDg4JiojzsnzB05WJhaY14Cv27JC/r1e2mVLhIWzDlitQZqfowwzvn1QxueowoGuC4T55AFQlQrvv0q7DzMrWnNLwFxNc9WS4RheUap3bJpbzIfigPMUoCZamsomT9+StdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981623; c=relaxed/simple;
	bh=cnYH9+j/2xzSAgWt5LIGXESMWUTDhvWf1z7KxVbTeAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsvGZfjEEr2WI6Z3JjvlTc5Hrp+mxsMmNcAbobdEf3xlwlX60+BcKF2eChDWJq2BVs7bs7Y2n1rDrKw8mXBJJ161Oj+fq0hUxKZgflidE92+duqDvPyUFl75ip14vqujETh3J92YzilK2DN9dhv7L5vPjB0y1OQKCPz8DY8HcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48AFD14BF;
	Thu,  3 Oct 2024 11:54:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B75103F640;
	Thu,  3 Oct 2024 11:53:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 3/7] perf arm-spe: Introduce arm_spe__is_homogeneous()
Date: Thu,  3 Oct 2024 19:53:18 +0100
Message-Id: <20241003185322.192357-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
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
index b0e9eb6057c3..587943b6bdb8 100644
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
@@ -1419,6 +1444,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_nr_cpu = nr_cpu;
+	spe->is_homogeneous = arm_spe__is_homogeneous(metadata, nr_cpu);
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
-- 
2.34.1

