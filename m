Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E612E1DC;
	Sun, 23 Jun 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719149701; cv=none; b=gxspZ9aIUr7OCY7NGBDthM/n5OC+QWNvzSthPTypA98YtCIp/PI+2gvYMuwgY0Y6nMvX5Bjpck08t+nzdSAhImMbeYOF/to29mgFOIEZ8ueZ+zuOKl17WdHxLDIB21PxF5wB1N0D3Zj37Pmbcj9RbNrIRri8QkU4v9HXpgkWZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719149701; c=relaxed/simple;
	bh=JUNE5YZE88v/xXYEatF5fX1/udizoPFiqUlrSkK8ys4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLMVSJa4UTxAZrkpJcYPt6khUE6Nrh6l6B/I8XLLtLCXmda9sYSGaySiYuSREOB1i4qrc6lUdk3HkU1u8wOEEZXxLWwd614bgyEsveVLeKygZK3/ht/qmCYwnMPUV3PTPZWYy4ga2kQqSY07KFhhG6sWjng8pU+DMwuw28DftEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 112ADDA7;
	Sun, 23 Jun 2024 06:35:17 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 464BF3F64C;
	Sun, 23 Jun 2024 06:34:49 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/2] perf mem: Support multiple Arm SPE PMUs
Date: Sun, 23 Jun 2024 14:34:35 +0100
Message-Id: <20240623133437.222736-1-leo.yan@arm.com>
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


Leo Yan (2):
  perf arm-spe: Support multiple Arm SPE PMUs
  perf mem: Warn if memory events are not supported on all CPUs

 tools/perf/arch/arm/util/pmu.c |  2 +-
 tools/perf/util/mem-events.c   | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.34.1

