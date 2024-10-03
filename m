Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87B1AAE2F;
	Thu,  3 Oct 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980999; cv=none; b=Bi6lhGLCoWrQ/iLHN/wajHRTz1rKxG0bsR/EQ6zkAJiFIR3xQjjbkqKGHR9jJZ+uxHn+qoPtHilYtgz8rTcnOYVUiUnodfqil+7iKBja5bW1yAfdxviaz5i/pGaN2aSRyKBOpkJoJQOKxHrm7HJYN5sVp6uoFxiqhk/aBMEv88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980999; c=relaxed/simple;
	bh=taS5O91N0Tq2gSZHVH7M1zXwJSgvsuitJ1eg+Gou+ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/0bSpsgMb8EUFbjvI8uxrRUCvRMMSlEHvZ5kEiwSf3onR95p5uzxtQrY6E7Bfgbb3B1TgsLXsZcI4R5zwhq4RnSCuonxX4wmGSiMhiGAsDxvVxUoDakPDzBMHeguLtlRP1Ix41pcf5NlSz2PGTjVRT3W3oUZDz+Npa0/y2LOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73E9D339;
	Thu,  3 Oct 2024 11:43:45 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFB533F58B;
	Thu,  3 Oct 2024 11:43:13 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 0/5] perf arm-spe: Introduce metadata version 2
Date: Thu,  3 Oct 2024 19:42:57 +0100
Message-Id: <20241003184302.190806-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enhances Arm SPE metadata in the Perf file to a
version 2 format and maintains backward compatibility for metadata v1.

The version 2 metadata contains a global structure with fields for
metadata header version number, header size, CPU numbers. It also
expands to store per-CPU metadata, which includes the CPU logical
number in the kernel, MIDR, and capacity values associated with Arm SPE.

This patch set has been tested the perf to decode the Arm SPE metadata
v1 and v2.

Changes from v3:
- Fixed a compilation error (James)
- Added James' review tags.

Changes from v2:
- Added comment for arm_spe_find_cpus (Namhyung)
- Corrected resource releasing in arm_spe_save_cpu_header() and
  arm_spe_info_fill() (Namhyung)
- Changed to use calloc() for allocating metadata pointer array
  (Namhyung)

Changes from v1:
- Dropped LDS bit exposing from Arm SPE driver (Will Deacon).
- To simplify the change, this series did not include multiple AUX event
  support.

Leo Yan (5):
  perf arm-spe: Define metadata header version 2
  perf arm-spe: Calculate meta data size
  perf arm-spe: Save per CPU information in metadata
  perf arm-spe: Support metadata version 2
  perf arm-spe: Dump metadata with version 2

 tools/perf/arch/arm64/util/arm-spe.c | 122 ++++++++++++++++++++-
 tools/perf/util/arm-spe.c            | 155 +++++++++++++++++++++++++--
 tools/perf/util/arm-spe.h            |  38 ++++++-
 3 files changed, 299 insertions(+), 16 deletions(-)

-- 
2.34.1

