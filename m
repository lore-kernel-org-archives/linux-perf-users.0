Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E311A291;
	Sun, 21 Jul 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593299; cv=none; b=bs1P6EAA+jTaIaUrtR1rjDrpXhVS6qFdjNbtF2MGRuYYqUQWWttyXWAsm6oD/8nv7ZRnHT4x/gs1OX+gLy3oaz9NQdVJJhUN+OVkRXoAaUCRC3xwA6ONd1pzf1oHxZfQS+OoFwe/Q+tL+exzXme/RG+TG823Arx2Sf2LI/jyXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593299; c=relaxed/simple;
	bh=YlpVqxBoKtMvshHpmfdBTA6GaVIdCC1wPU9eAji78BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADMn2jQLnpePisSWDgutePAo3eB8vQRxXrHg/eJsnF9zDqpqY2qOa2OT0x97U7t7inyrPm8hAVsJSfPyn0DcQmwWptTQ6/Xa/01e8w6Q+s7GobjbefQtd06Ru6CuPVssuUcNPnvoeh5lVP/7TsKL7fEcCiizjSZ+Gx9lsDaUkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556EAFEC;
	Sun, 21 Jul 2024 13:21:55 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 575443F73F;
	Sun, 21 Jul 2024 13:21:27 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/6] perf auxtrace: Support multiple AUX events
Date: Sun, 21 Jul 2024 21:21:07 +0100
Message-Id: <20240721202113.380750-1-leo.yan@arm.com>
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

Patch 01 is a minor refactoring for dereference PMU pointer from evsel
structure.

Patches 02, 03 and 04 are to use the 'auxtrace' flag for support multiple
AUX events. Firstly, we need to set the 'auxtrace' flag for Arm and s390
AUX events (Intel PT and bts have set already it). Afterwards, by using
the evsel__is_aux_event() function, the core layer iterates the whole
evlist - which allows the buffer index can be matched to corresponding
AUX event.

Patches 05 and 06 are to configure multiple SPE event in architecture
dependent code. The old code is only initialize the first AUX event.
with this series, it initializes all SPE PMU events.

This patch series has been tested with the normal 'perf record' command
and 'perf mem record' command.  And verified for the decoding commands
'perf script' and 'perf mem report'.

I observed one prominent issue is for per-CPU profiling. For example,
when specifying option '-C 2' for profiling on CPU2, in this case the
'arm_spe_0' event supports CPU2 but the 'arm_spe_1' event does not
support the CPU. As a result, 'arm_spe_1' event reports failure. This
is likely a common issue for support Per-CPU profiling with multiple
PMU events and every PMU event only support partial CPUs. This issue
will be addressed later.


Leo Yan (6):
  perf pmu: Directly use evsel's PMU pointer
  perf auxtrace arm: Set the 'auxtrace' flag for AUX events
  perf auxtrace s390: Set the 'auxtrace' flag for AUX events
  perf auxtrace: Iterate all AUX events when finish reading
  perf arm-spe: Extract evsel setting up
  perf arm-spe: Support multiple Arm SPE events

 tools/perf/arch/arm/util/pmu.c       |   3 +
 tools/perf/arch/arm64/util/arm-spe.c | 107 ++++++++++++++++-----------
 tools/perf/arch/s390/util/auxtrace.c |   1 +
 tools/perf/util/auxtrace.c           |  15 +++-
 tools/perf/util/pmu.c                |   2 +-
 5 files changed, 78 insertions(+), 50 deletions(-)

-- 
2.34.1

