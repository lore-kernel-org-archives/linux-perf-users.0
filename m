Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B5137775;
	Sat, 14 Sep 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726351763; cv=none; b=OmtbdyAAEuSeVBqt1iu+nccj8K1ND34VR8xilAnDaJ7iWT3rO2NaT+uh+SIVqueqB5ZzQZDf0cIYvK5z2kJbxIZKFxGlw5rBwoI5u8iVKyoBRU0x/z7BjcCj/thwPbZF9rby0B8PqlATl+h1TbmJUxWzxEs+DftGXs5BNcCAQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726351763; c=relaxed/simple;
	bh=bomcdNOvSH+gXumAWZMRBUSyFUwT1OUklkr0dC5xi2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gAfRgDGqYYHgymYC6LUDJBKAm89PNyoxeUGMjB1t6U51BCS4I4G0x4eMzJHmNqxsyMIAfhZy26O2Fjfr08AsZePwDXeR2YDZh/h2hoHt+wniuKyEqqVkqO1fB+H+eeplKvCSxDoI5GlCKbFpZchxrpRwCEUTGIBXMcEleViZYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9722B11FB;
	Sat, 14 Sep 2024 15:09:50 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 626C93F66E;
	Sat, 14 Sep 2024 15:09:19 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/7] perf arm-spe: Refactor data source encoding
Date: Sat, 14 Sep 2024 23:08:54 +0100
Message-Id: <20240914220901.756177-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As more Arm CPU variants (not only Neoverse CPUs) support data source
encoding, they share the same format for the data source packet.

To extend supporting these CPU variants for Arm SPE data source, this
series refactors the code. It converts the Neoverse specific naming to
the common naming, and then based on the MIDR stored in the metadata to
decide if the CPU follows up the common encoding format.

At the last, it extends CPU list for Neoverse-V2 and Cortex CPUs.

This patch series is dependent on the metadata version 2 series [1] for
retrieving CPU MIDR. It has been verified for per CPU mode and per
thread mode on Cortex-A725 CPUs.

[1] https://lore.kernel.org/linux-perf-users/20240914215458.751802-1-leo.yan@arm.com/T/#t

Changes from v1:
- Dropped LDS bit checking in data source parsing.


Besar Wicaksono (1):
  perf arm-spe: Add Neoverse-V2 to common data source encoding list

Leo Yan (6):
  perf arm-spe: Rename arm_spe__synth_data_source_generic()
  perf arm-spe: Rename the common data source encoding
  perf arm-spe: Introduce arm_spe__is_homogeneous()
  perf arm-spe: Use metadata to decide the data source feature
  perf arm-spe: Remove the unused 'midr' field
  perf arm-spe: Add Cortex CPUs to common data source encoding list

 .../util/arm-spe-decoder/arm-spe-decoder.h    |  18 +--
 tools/perf/util/arm-spe.c                     | 135 +++++++++++++++---
 2 files changed, 121 insertions(+), 32 deletions(-)

-- 
2.34.1

