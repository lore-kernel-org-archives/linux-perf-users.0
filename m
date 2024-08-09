Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60619147D;
	Fri,  9 Aug 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205702; cv=none; b=f2RfdfQWX2owYRdn/TsSe40gC7L5VTXp/tqZRXO6NtrvkXFOQ99ZGH9Lh0MvAnn9AV2FHirkYe30ZyqAvQwIKw+ZnyXJqcQOg2/sR66m7EeDpJGc6SULtF+bbJST+Vagimp1v9BWymWIV5BGrqbELSZuPqWZLfGE25PNNy7T8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205702; c=relaxed/simple;
	bh=dmvGzamLflE7hsQ0NvVBFble5SoWp76e5mNhJG5gMPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYeSLiD32M7G/K7mczHyurpNR6S0rA4YfXS4ZNDR2e+KVtbxAw4h25T1PjNCqfplOyuM1FTUov/ZcS+1be/TfdunA1LhbbcFxI3X6ySPCcMziesLo2GXuW6pLXgvB4gxkByJijhUpujLUqUeJSDBRzMZIdvkxQC/Oz8ytrVEVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56DEE1684;
	Fri,  9 Aug 2024 05:15:25 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B72D93F6A8;
	Fri,  9 Aug 2024 05:14:57 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 1/8] perf/core: Allow multiple AUX PMU events with the same module
Date: Fri,  9 Aug 2024 13:14:40 +0100
Message-Id: <20240809121447.2078084-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809121447.2078084-1-leo.yan@arm.com>
References: <20240809121447.2078084-1-leo.yan@arm.com>
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
index aa3450bdc227..f450e6a91b1a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12344,9 +12344,16 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 
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

