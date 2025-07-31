Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B922D2389
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968428; cv=none; b=CtiRj7Qu8dsQik6uo0JysBWVAJ8D2noFY1TS22iCYMrfWcK2ana6PkCzdryFb8rzPS9RGrV/m/bw7R1GzXoFkObmtV7iZr7jOvWJHCTgszmiJZCLyCRCPbghXu5BUacynO9VCVuoXDC5Wma2ctZL2OcsfryjVbUw7KBw/1u4wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968428; c=relaxed/simple;
	bh=MGXl2cnLbu4zu2dy1/bFgNlB0vBOPNcA8WyrHKceQEM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YlIIbpjbq4y0oUf/ihCVJoEdxQX76/JKoMDTWHFZUi2H8A6PnzJsQXBDfkMlftz3fMT6mrfw0ficxMr1D2rq77VG/vBDpExTPc8ZTEAuMNiO8zYhpyQD4IxwVjqjw/KILJcLeVJFPUZ+iFG6qUlardrM79EN9KuQFbzEKML7mXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BFD51D13;
	Thu, 31 Jul 2025 06:26:56 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9590E3F66E;
	Thu, 31 Jul 2025 06:27:02 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 00/15] perf arm-spe: Support new events in FEAT_SPEv1p4
Date: Thu, 31 Jul 2025 14:25:35 +0100
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9ui2gC/5XQQW7DIBAF0KtErEsFDLZpVr1HFSHA4xqpDggcl
 Cjy3YtTqUl2zvKPNO+P5koyJo+Z7HdXkrD47MOxBvm2I240x2+kvq+ZCCYa1nJGTZp0jqjzKca
 QZj36edKhYBrR9LpwHU/2xzvqpBEtgGokSFK1mHDw51vT16Hm0ec5pMutuIh1+npHEZTRjoleS
 uta26jPuvnuwrQW/mnwoiaQm8FY4GA//rX13sIfb4TtKq9qOxh0AzOq65pnFe5qx7rtKlQVAI0
 SvQGh2LMqH1Tg21VZVackSsaq6e7/PCzL8gvahYbmLAIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=3708;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=MGXl2cnLbu4zu2dy1/bFgNlB0vBOPNcA8WyrHKceQEM=;
 b=+JYI9uWYTJO9WrwmWrsWwJfv4HEfGmxWG1DWAYwnqNQQ3JSY9M+a54sa1lOH4kCwX3BWddZY6
 PaRS+fK5vllBLikshvdbJjiFGmA3+OGROoQr+FMFs0HyixMzpc27qqy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series adds support for new event types introduced in Arm SPE v1.4.

The first two patches modify the SPE driver to expose 'event_filter'
entry in SysFS caps folder. These patches are part of James' series
"[PATCH v5 00/12] perf: arm_spe: Armv8.8 SPE features" [1]. In case this
series will be merged independently of James' series, these patches have
have been included here.

Patches 03 ~ 15 are support new events in Perf tool:

  * Patches 03 ~ 04: Fix for remote access.
  * Patches 05 ~ 06: Refactor for data source and event bits.
  * Patch 07       : Dump new event bits.
  * Patches 08 ~ 14: Enhance memory-level info for the new events.
  * Patch 15       : Combine analysis of data source and events.
		     As a result, Arm SPE can support both HITM and peer
		     modes (See the "--display" options in perf c2c).

This series has been tested on FVP RevC platform.

Note: for a local HITM event, the emulation does not provide any info
for LLC. However, the perf c2c tool relies on LLC + HITM for accounting
local HITM. I manually set the LLC HIT flag to verify the
"perf c2c -d tot" command.

[1] https://lore.kernel.org/linux-arm-kernel/20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org/

---
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

Leo Yan (13):
      perf: arm_spe: Expose event filter
      perf arm_spe: Correct setting remote access
      perf arm_spe: Correct memory level for remote access
      perf arm_spe: Directly propagate raw event
      perf arm_spe: Decode event types for new features
      perf arm_spe: Add "event_filter" entry in meta data
      perf arm_spe: Refine memory level filling
      perf arm_spe: Separate setting of memory levels for loads and stores
      perf arm_spe: Fill memory levels for FEAT_SPEv1p4
      perf arm_spe: Improve CPU number retrieving in per-thread mode
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
 tools/perf/util/arm-spe.c                          | 220 ++++++++++++++++-----
 tools/perf/util/arm-spe.h                          |   2 +
 9 files changed, 241 insertions(+), 131 deletions(-)
---
base-commit: e0c9c1e67156b257e9f1e97e4e372961e4e03fcf
change-id: 20250610-arm_spe_support_hitm_overhead_v1_public-c4a263385434

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

