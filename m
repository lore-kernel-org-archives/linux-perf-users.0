Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7815023BE;
	Sat,  6 Jul 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279272; cv=none; b=Bwc3hsk0HVyEV6ZKHfS9ZOwNIu2DztLIQWfuz1fkvPTJ8cbw1cQyK7fIGvnSrTearw/DH34Ss6yMPnyRxlSACZENUbndKhi2WcnQbMBA8uisG/iscr+VlIN6VtgDYVSQNJcAPo8oJMNhhXMlWBNyk6Chh1ErPiSu9uUAUAYi2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279272; c=relaxed/simple;
	bh=SDB//HT5ifL2Vfhc5WpzITw+lxanBfDGugSJrwrSoxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j9aZtSONLcKDM24HXONqYfp0ipifXFO5JZSihoHbFXLl0FDa8PtwJ8hdgvWE6PLTuUmaKPo5m3UBMAEbfXsVyZvPJxjg/vLqyuxPGkpkZZFkZzGu+2cw/sxE/23+/KWpRreX1igoUmBY1vkxXcSz9nL/aEV1rlNmtIT5Tj7UH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE595DA7;
	Sat,  6 Jul 2024 08:21:28 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88E133F762;
	Sat,  6 Jul 2024 08:21:01 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/2] perf mem: Support multiple Arm SPE PMUs
Date: Sat,  6 Jul 2024 16:20:33 +0100
Message-Id: <20240706152035.86983-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is to enable multiple Arm SPE PMUs.

The patch 01 is to enable multiple Arm SPE PMUs. The second patch is to
print out warning if not all CPUs support memory events, this can give
users a hint that the memory profiling is absent on some CPUs.

Changes from v1:
- Changed to use strstarts() (Ian Rogers)
- Changed to use 'arm_spe_' for searching Arm SPE events (Namhyung Kim)


Leo Yan (2):
  perf arm-spe: Support multiple Arm SPE PMUs
  perf mem: Warn if memory events are not supported on all CPUs

 tools/perf/arch/arm/util/pmu.c |  2 +-
 tools/perf/util/mem-events.c   | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.34.1

