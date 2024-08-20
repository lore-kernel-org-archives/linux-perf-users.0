Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A6C148FEB;
	Tue, 20 Aug 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179672; cv=none; b=rYpNpdBClFBOtULNl6QIz5kLzB3LmGbFggWy2HM2fVt4gyOmB1Ox22zmEQTswby0Ne0KqLoX7wmBLGgo3jUp9Z1eYOzU7pGUqfSgXoRLAfESinrK1iRvzbaw2Jze2ts2zYYRSDwvDerEsFgamN27Q9ijZgUd/Nh/+byWw1ySFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179672; c=relaxed/simple;
	bh=5rbaWl90Uj47ndUy3ZaQmzwKLrGiylTs/LIKcyJIsas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTZemrv0WYVdjUexRohNzXslqFy87a6fKfRfWzxJHAldHV2iYuZHe5bEcF2um6rze8lKtiuxuHi9HMIz3AwoaonI2Mm0d9ECWrCd5QnPhzTMxVu+VKMY+Q4y7iAVXRRCFKXG8KDXYuydgYfe1DxjVFP6KwfGSeVamDrLEqqsUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B678FEC;
	Tue, 20 Aug 2024 11:48:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B82AA3F58B;
	Tue, 20 Aug 2024 11:47:46 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 1/8] perf/core: Allow multiple AUX PMU events with the same module
Date: Tue, 20 Aug 2024 19:47:24 +0100
Message-Id: <20240820184731.2937551-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820184731.2937551-1-leo.yan@arm.com>
References: <20240820184731.2937551-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit changes the condition from checking the same PMU instance to
checking the same .setup_aux() callback pointer. If PMU events have the
same callback pointer, it means they share the same PMU driver module.
This allows support for multiple PMU events with the same driver module.

As a result, more than one AUX event (e.g. arm_spe_0 and arm_spe_1)
can record trace into the AUX ring buffer.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c973e3c11e03..883c457911a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12345,9 +12345,16 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 
 	/*
 	 * If both events generate aux data, they must be on the same PMU
+	 * module but can be with different PMU instances.
+	 *
+	 * For a built-in PMU module, the 'pmu->module' pointer is NULL,
+	 * thus it is not feasible to compare the module pointers when
+	 * AUX PMU drivers are built into the kernel image. Instead,
+	 * comparing the .setup_aux() callback pointer can determine if
+	 * the two PMU events come from the same PMU driver.
 	 */
 	if (has_aux(event) && has_aux(output_event) &&
-	    event->pmu != output_event->pmu)
+	    event->pmu->setup_aux != output_event->pmu->setup_aux)
 		goto out;
 
 	/*
-- 
2.34.1

