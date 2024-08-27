Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26741CF2A1;
	Tue, 27 Aug 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777080; cv=none; b=Nq+Q60nPf0cQJ4ia99SFXecy6Zibj5pcrIU19I4j7QC6Ko05vPUoWP6+eXgMcKUYj7u/QdT+UV2QnBHVPezo1LPikQvtjbkOjpGLNgNbBdFSY4zgrLqPRKcQelzZsuw8a+1+Mhf0V1VHjbD71+1MO0oNp+6x0LdbHgO/j2Ax894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777080; c=relaxed/simple;
	bh=V/Mx6UmPvAZO25sfpSpaGRuBkLZfRrqE0UWC1bA96gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtPwYBoYuGLmRyydp/vY6LLasLhpDXUPwid1+7iHo1Pp+vfvskc8wn9oUWHatS4qZp7Kl7YtlfW8QDmD03joZCJsvtZ4V49Crrp6trf7YU8ZCyZxYJdsxMBRfDSIpiovmpzHZxOERN29CLo2wWmDtU7uKlGlrcQRF9osg/mJkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A45F13D5;
	Tue, 27 Aug 2024 09:45:04 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E08393F762;
	Tue, 27 Aug 2024 09:44:35 -0700 (PDT)
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
Subject: [PATCH v1 2/9] perf auxtrace arm: Refactor error handling
Date: Tue, 27 Aug 2024 17:44:10 +0100
Message-Id: <20240827164417.3309560-3-leo.yan@arm.com>
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

Refactor the auxtrace_record__init() function to use a central place to
release resources and return value. This unifies the exit flow, and
allows the PMU arrays can be used throughout the function.

No functional changes; this is a preparation for sequential changes.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 35 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 3b8eca0ffb17..74630d2d81dc 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -125,6 +125,7 @@ struct auxtrace_record
 	struct perf_pmu *found_etm = NULL;
 	struct perf_pmu *found_spe = NULL;
 	struct perf_pmu *found_ptt = NULL;
+	struct auxtrace_record *itr = NULL;
 	int auxtrace_event_cnt = 0;
 	int nr_spes = 0;
 	int nr_ptts = 0;
@@ -147,9 +148,6 @@ struct auxtrace_record
 			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
 	}
 
-	free(arm_spe_pmus);
-	free(hisi_ptt_pmus);
-
 	if (found_etm)
 		auxtrace_event_cnt++;
 
@@ -159,31 +157,36 @@ struct auxtrace_record
 	if (found_ptt)
 		auxtrace_event_cnt++;
 
-	if (auxtrace_event_cnt > 1) {
+	if (!auxtrace_event_cnt) {
+		/*
+		 * Clear 'err' even if we haven't found an event - that way perf
+		 * record can still be used even if tracers aren't present.
+		 * The NULL return value will take care of telling the
+		 * infrastructure HW tracing isn't available.
+		 */
+		*err = 0;
+		goto out;
+	} else if (auxtrace_event_cnt > 1) {
 		pr_err("Concurrent AUX trace operation not currently supported\n");
 		*err = -EOPNOTSUPP;
-		return NULL;
+		goto out;
 	}
 
 	if (found_etm)
-		return cs_etm_record_init(err);
+		itr = cs_etm_record_init(err);
 
 #if defined(__aarch64__)
 	if (found_spe)
-		return arm_spe_recording_init(err, found_spe);
+		itr = arm_spe_recording_init(err, found_spe);
 
 	if (found_ptt)
-		return hisi_ptt_recording_init(err, found_ptt);
+		itr = hisi_ptt_recording_init(err, found_ptt);
 #endif
 
-	/*
-	 * Clear 'err' even if we haven't found an event - that way perf
-	 * record can still be used even if tracers aren't present.  The NULL
-	 * return value will take care of telling the infrastructure HW tracing
-	 * isn't available.
-	 */
-	*err = 0;
-	return NULL;
+out:
+	free(arm_spe_pmus);
+	free(hisi_ptt_pmus);
+	return itr;
 }
 
 #if defined(__arm__)
-- 
2.34.1

