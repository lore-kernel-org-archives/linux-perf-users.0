Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5D15E5A2;
	Tue,  6 Aug 2024 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977311; cv=none; b=nPk+xqpiCQueLF7P729k7P75CFoyAtwg7IU2o85oun/vFU2cZNoACx0EKdn3ksHcsWAuQOR9Zjq5Y6O9EqUjDEps5eHrV5Ta6dAm4HoWVDgP+qyfgAoiL51tGkXvNLvmZyymXTgtQBGjLjofa9nGfnMBUhdQH0XiTskFFpXPLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977311; c=relaxed/simple;
	bh=iHwWKhcfH4WORNFTN3y6I/5tWUdWV07PGCCTKxFnIXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mau9MN2zOQlGix65CuavZi1X/Zo5D2IKrRLphpj4Aahwrs+jUX+H70q4odQQU1VRCRbbwqerU7ZXXdwFNDQTvYb3qP2Dm7fPCo9esmPIXa9Kz/zlpnxpDT31K2agbVlOVWfkoaCcNURPmil6RnOQ0T2ZweSPiDKzIUD9s+4ZczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 631401063;
	Tue,  6 Aug 2024 13:48:55 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA7513F766;
	Tue,  6 Aug 2024 13:48:27 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 1/5] perf/core: Allow multiple AUX PMU events with the same module
Date: Tue,  6 Aug 2024 21:48:09 +0100
Message-Id: <20240806204813.722372-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204813.722372-1-leo.yan@arm.com>
References: <20240806204813.722372-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit changes the condition from checking the same PMU instance to
checking the same PMU driver module. This allows support for multiple
PMU events with the same driver module.

As a result, more than one AUX event (e.g. arm_spe_0 and arm_spe_1) can
record trace into the AUX ring buffer.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..fdb8918e62a0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12344,9 +12344,10 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 
 	/*
 	 * If both events generate aux data, they must be on the same PMU
+	 * module but can be with different PMU instances.
 	 */
 	if (has_aux(event) && has_aux(output_event) &&
-	    event->pmu != output_event->pmu)
+	    event->pmu->module != output_event->pmu->module)
 		goto out;
 
 	/*
-- 
2.34.1

