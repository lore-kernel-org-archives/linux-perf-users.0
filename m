Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF7313275
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691764; cv=none; b=H/RILeisd9L4XmWSUWkT3NqL3Wb/NZi5WchU1fPs4BKp7RJnLjIRqlsTF2Uc2Yp9+SXzlraWbigQsERI/1wR7y+2xn+aBjlg8oAT85Y2DspoEOzjD/1PnmWpuoNQ+BZuFb29b2ik1kKuv35QQDYO5FsL27nVfocFGBXKCkY/4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691764; c=relaxed/simple;
	bh=3xoBw2bDa1aRqnPicAB8DpWI86H+OEIAYNEGnodX8Hw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SXcZ6TDAzDhfy08EGR4ZxZVoTR3xuYMyd0F5wL6ROM2C3l4AsNvM0/gF6rLNNYKisQ7zlfUKndCbMgU4yc+0hNlejmeJ+NPxF7jQGGQY0HO3OZrXPJ/Mmd0CrH1pcM+XQk/CHCuD6XPv/e2nelhzVkGBP5SwJSRAwRe5Pc6n40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 014831515;
	Fri, 12 Sep 2025 08:42:33 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E9D93F694;
	Fri, 12 Sep 2025 08:42:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 00/14] perf arm-spe: Support new events in FEAT_SPEv1p4
Date: Fri, 12 Sep 2025 16:42:05 +0100
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0/xGgC/5XQ0WrDIBQG4FcpXi9DPRpdr/YeY4iak0VYatBUN
 krefaaDtWU3yeV/wO//8UIypoCZHA8XkrCEHOKpBvl0IH6wpw9sQlcz4ZRL2jLa2DSaPKHJ52m
 KaTZDmEcTC6YBbWcKM9PZfQbfeGF5C6ClAEGqNiXsw9e16e295iHkOabva3Hh63V/R+ENbRTln
 RDOt07q1/ry2cdxLfzVYKfGkdneOmDgXv60dW9h9xthu8qq2vYWfU+tVko+qnBTFVXbVagqAFr
 NOwtc00dV3KnAtquiql4LFJRW0///z92a1Chbpaxg3N02LsvyA4tQbJB6AgAA
X-Change-ID: 20250610-arm_spe_support_hitm_overhead_v1_public-c4a263385434
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691758; l=3909;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=3xoBw2bDa1aRqnPicAB8DpWI86H+OEIAYNEGnodX8Hw=;
 b=h7G2UN13L76gbQNRiCS8mG3mRik67dNqIap9pSn3bd//J88FjtKVEt40z+SviI7UDKIVjcVhA
 +W62hH78jK4DqPhDaI9vS9WFoc8GcnGUcopdiIspcoA0C1m2Id8YF7n
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series adds support for new event types introduced in Arm SPE v1.4.

The first two patches modify the SPE driver to expose 'event_filter'
entry in SysFS caps folder. These patches are part of James' series
"[PATCH v8 00/12] perf: arm_spe: Armv8.8 SPE features" [1]. In case this
series will be merged independently of James' series, these patches have
have been included here.

Patches 03 ~ 14 are support new events in Perf tool:

  * Patches 03 ~ 04: Fix for remote access.
  * Patches 05 ~ 06: Refactor for data source and event bits.
  * Patch 07       : Dump new event bits.
  * Patches 08 ~ 13: Enhance memory-level info for the new events.
  * Patch 14       : Combine analysis of data source and events.
		     As a result, Arm SPE can support both HITM and peer
		     modes (See the "--display" options in perf c2c).

This series has been tested on FVP RevC platform.

Note: for a local HITM event, the emulation does not provide any info
for LLC. However, the perf c2c tool relies on LLC + HITM for accounting
local HITM. I manually set the LLC HIT flag to verify the
"perf c2c report -d tot" command.

[1] https://lore.kernel.org/linux-arm-kernel/20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org/

---
Changes in v5:
- Dropped retrieving CPU ID with perf_pmus__find_by_type() (James)
- Added James's tags and rebased on latest perf next branch.
- Link to v4: https://lore.kernel.org/r/20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com

Changes in v4:
- Refactor exposing event filter in SPE driver (Will).
- Rebased on latest perf-tools-next branch.
- Link to v3: https://lore.kernel.org/r/20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com

Changes in v3:
- Retrieve CPU number from PMU type (Ian).
- Link to v2: https://lore.kernel.org/r/20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com

Changes in v2:
- Dropped the kernel change for caching "pmsevfr_res0" (James)
- Renamed the "events" entry to "event_filter" (James)
- Added a new refactoring patch 04 (James)
- Updated memory level info for remote access (James)
- Link to v1: https://lore.kernel.org/r/20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com

---
James Clark (2):
      perf: arm_spe: Support FEAT_SPEv1p4 filters
      perf arm_spe: Use full type for data_src

Leo Yan (12):
      perf: arm_spe: Expose event filter
      perf arm_spe: Correct setting remote access
      perf arm_spe: Correct memory level for remote access
      perf arm_spe: Directly propagate raw event
      perf arm_spe: Decode event types for new features
      perf arm_spe: Add "event_filter" entry in meta data
      perf arm_spe: Refine memory level filling
      perf arm_spe: Separate setting of memory levels for loads and stores
      perf arm_spe: Fill memory levels for FEAT_SPEv1p4
      perf arm_spe: Refactor arm_spe__get_metadata_by_cpu()
      perf arm_spe: Set HITM flag
      perf arm_spe: Allow parsing both data source and events

 arch/arm64/include/asm/sysreg.h                    |   9 -
 drivers/perf/arm_spe_pmu.c                         |  45 +++--
 tools/perf/arch/arm64/util/arm-spe.c               |   5 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |  37 +---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  33 ++--
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   7 +
 tools/perf/util/arm-spe.c                          | 210 +++++++++++++++------
 tools/perf/util/arm-spe.h                          |   2 +
 9 files changed, 231 insertions(+), 131 deletions(-)
---
base-commit: 1e5881b168b94871fecd4603633a5fe6a519cbbf
change-id: 20250610-arm_spe_support_hitm_overhead_v1_public-c4a263385434

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

