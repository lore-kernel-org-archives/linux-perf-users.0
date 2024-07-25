Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610E17550
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889999; cv=none; b=Wi/nZMNweW3LDY2IsFrFDzejSEGeeAN2/ty6JVMuQL838Sf8DbQSYwCeATIHYW1EKbIK4gmxA+45z3SM/hGez0TqIVggaxdcvowGLpFEltVz8PZsAYKLscnSav1LUfCzmI/sx8YFJftq0alGhvzQXIjYUQVNCerjHTOsMJF/LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889999; c=relaxed/simple;
	bh=uji+3wEGNm9iu1ykMB2XjID4SnIk4F2J1yWdXg0rVf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNpxsmARnEiS4zRynLA8XXzqiBJUPCr2qA/0Fnx+lsrGcZucF3XpmyBCsUW7Yg0lIhOkIcU468wI9grOtBaLf7coVMpREdAHgb2XKnNUn7GvtbU3t0z8MQdtgK5I2H5w0w6CN5IT7fm4CehHbT275l5yaHKPxAe13ytJFjKzIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22241007;
	Wed, 24 Jul 2024 23:47:02 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA2CC3F73F;
	Wed, 24 Jul 2024 23:46:35 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/4] perf auxtrace: Support multiple AUX events
Date: Thu, 25 Jul 2024 07:46:16 +0100
Message-Id: <20240725064620.1651819-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to support multiple events with the *same* type in Perf
AUX trace. As the first enabled instance, the patch series enables
multiple Arm SPE events (e.g. arm_spe_0, arm_spe_1, etc) in AUX trace.

The solution for support multiple AUX events with same type is not
difficult. As the events are same type, the trace data shares the same
format and can be decoded by the same decoder. Essentially, this patch
series is to extend the AUX trace flow from support single PMU event to
multiple events.

Note, this series does not support a more complex case - different types
of AUX events, (e.g. Arm CoreSight event and Arm SPE events are enabled
simultaneously).

Patch 01 are to use the 'auxtrace' flag for support multiple AUX events.
By using the evsel__is_aux_event() function, the core layer iterates the
whole evlist - which allows the buffer index can be matched to
corresponding AUX event.

Patch 02 is a cleanup for removing unused 'pmu' pointer in the
auxtrace_record structure.

Patches 03 and 04 are to configure multiple SPE event in architecture
dependent code. The old code is only initialize the first AUX event.
with this series, it initializes all SPE PMU events.

Changes from v1:
- Added comment in patch 01 for iterating AUX events (Adrian)
- Added patch 02 for removing unused field 'pmu' (Adrian)


Leo Yan (4):
  perf auxtrace: Iterate all AUX events when finish reading
  perf auxtrace: Remove unused 'pmu' pointer from struct auxtrace_record
  perf arm-spe: Extract evsel setting up
  perf arm-spe: Support multiple Arm SPE events

 tools/perf/arch/arm/util/cs-etm.c     |   1 -
 tools/perf/arch/arm64/util/arm-spe.c  | 108 +++++++++++++++-----------
 tools/perf/arch/arm64/util/hisi-ptt.c |   1 -
 tools/perf/arch/x86/util/intel-bts.c  |   1 -
 tools/perf/arch/x86/util/intel-pt.c   |   1 -
 tools/perf/util/auxtrace.c            |  25 ++++--
 tools/perf/util/auxtrace.h            |   1 -
 7 files changed, 82 insertions(+), 56 deletions(-)

-- 
2.34.1

