Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1217E004;
	Fri, 23 Aug 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412819; cv=none; b=cokWsNEhmn0ZAEooyGwZjz6GqJ6YBqSjVDerdKxpwj3+5aPN0ke4GaodKVmWPY4LP0Oe046Pu2H9mhYwbH2wkIMASJ2uF4y6FKF1zUStee39igzPVbHYGySj6JIu7JsOZsjFVsMe3QXasaCeuqlUMt5dkPVWmF9/5kgpeKKRZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412819; c=relaxed/simple;
	bh=5rbaWl90Uj47ndUy3ZaQmzwKLrGiylTs/LIKcyJIsas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZzaGE7Npxc0ME/0/yx0OQ6fYwjOoyPyWCXcixhknUCIf7RTxA4vQuHT7aeECxM+MZz6ZggveObwl/RCFyCoWC0n+CQcrzRnsoDrNj0DKklLaAGXb9lbPcY9JU+yZ87yZFAN0pMZAAqgQgwbi6kiwcGZKvvTDYryI8gOd1fEjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31B8BFEC;
	Fri, 23 Aug 2024 04:33:57 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC91E3F58B;
	Fri, 23 Aug 2024 04:33:28 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 1/8] perf/core: Allow multiple AUX PMU events with the same module
Date: Fri, 23 Aug 2024 12:32:59 +0100
Message-Id: <20240823113306.2310957-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113306.2310957-1-leo.yan@arm.com>
References: <20240823113306.2310957-1-leo.yan@arm.com>
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

