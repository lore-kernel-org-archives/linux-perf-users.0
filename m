Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014E7D405;
	Sat, 14 Sep 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350924; cv=none; b=AyGHqEFqqQC++AWwV4dJW1/b/NvYWUM3L9R55BdJsr1f2XlYeVFSg5udEO1LBXbG7Z/US//H8M2I7P/KGH7lUKjMG1EVoTWCbwCSOvFNMAhz8Ow1ZFSWuo0a2xrCWH1i20MFaFPTDledhq/9xWyUwa3DE4sm1gsHP3uRfOsxTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350924; c=relaxed/simple;
	bh=wptflPFYRHPNo0BAaRLEmf4xd8pDvxWY43nzDnCet3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fe5yOJP1QynosDgWvLAEsKFiY/M6jUYFpLABlizU+e5XcOmOx8UY9zue3dHMvPCu+z5FCV6tAFIKuNaty5rOzmUmTPychlqQDKYp5Hx4Ihyqv2yGCKMZ1B1Y8pFL3TfxfkdKAToLFTXLVkdl0+MTw/Dwx76coL862+rqm2TyI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 806CE11FB;
	Sat, 14 Sep 2024 14:55:44 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F63E3F66E;
	Sat, 14 Sep 2024 14:55:12 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Will Deacon <will@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/5] perf arm-spe: Introduce metadata version 2
Date: Sat, 14 Sep 2024 22:54:53 +0100
Message-Id: <20240914215458.751802-1-leo.yan@arm.com>
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

 tools/perf/arch/arm64/util/arm-spe.c | 106 ++++++++++++++++++-
 tools/perf/util/arm-spe.c            | 151 +++++++++++++++++++++++++--
 tools/perf/util/arm-spe.h            |  38 ++++++-
 3 files changed, 281 insertions(+), 14 deletions(-)

-- 
2.34.1

