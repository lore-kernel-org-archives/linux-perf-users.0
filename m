Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE651D554
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895594; cv=none; b=DJGHyMJnotlGUcqtsdd/iu4102oGv4r6fOqbGhK7+6QKLWTxx5y3EcUkudMn3MCVxh4GPPbORzESTDdDKtm/+dDjp3Bi0e6fvWqQwYICQvf8UocsVC1UYDgXgejxSmRtGGI4gIJsszKCs9MxFC6h4CyjSXKorfJ4E2KOyFEzsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895594; c=relaxed/simple;
	bh=7VJL+m7ffQeAG2Cjt+fbYfsmuv22c3Aq4E3fqj3ddFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X/+FzjJ+0xI0lER7SS4U4wnB3yahxR+ekbhbj9zUxA11YI2eAk5aQ9IQbIBqmwi/GsO2CbwtNelcjNr1dOGpWC+yovXhcrFaLSW/Pbk+xe5HvaQT2OI0xvWBDOEuf0IR+rF7q0r0CBM1Y/zwjZkPDIKQDeI9hqNisuz6qfArZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 179FE168F;
	Mon,  7 Jul 2025 06:39:39 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87F673F6A8;
	Mon,  7 Jul 2025 06:39:49 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 00/14] perf arm-spe: Support new events in FEAT_SPEv1p4
Date: Mon, 07 Jul 2025 14:39:22 +0100
Message-Id: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvOa2gC/5WOywrCMBBFf0WyNpJXH7ryP0RCkk5twDYhqUGR/
 rtpBXVpl2dgzrlPFCFYiOiweaIAyUbrhgx8u0GmU8MFsG0yI0ZYQUpKsAq9jB5kvHnvwig7O/b
 SJQgdqEYmKv1NX63BRihWcl4XgguUbT5Aa+9L6XTO3Nk4uvBYwonN1/WNxDDBFWGNENqUuqiP+
 XNnXD8H3za+0saAqlZpTrnef2zz3kR/N/L/rTRby1aBaYmqq6r4WqdpegGaQSz0gAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751895589; l=3369;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7VJL+m7ffQeAG2Cjt+fbYfsmuv22c3Aq4E3fqj3ddFc=;
 b=iMDSgBXB19NMiBat9A/Y1Mbmi4YITorXEK6tMSrYiV7DqcmC7UGOztg3Rots/XvLXvtgG9kO9
 M2QPS06SGTvCcVfx0r2NuIYAKd0z1T3C57wudFvFFiI5U+5/085V5sB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series adds support for new event types introduced in Arm SPE v1.4.

The first patch modifies the Arm SPE driver to expose 'event_filter'
entry in SysFS caps folder. This allows users to discover the event
filter is supported by the hardware.

Patch 02 is a fixing for setting remote bit. Patch 03 is for fixing
memory level info for remote access.

Patch 04 is a refactoring for using full type for data_src.

Patch 05 refactors the code to avoid duplicate definitions of event
bits.

Patch 06 dumps new event bits in raw format via the 'perf script -D'
command.

Patches 07 to 13 enhance memory-level information based on the new
events introduced in FEAT_SPEv1p4.

Patch 14 changes the logic to parse events after data source analysis.
The event information complements the data source and provides a more
complete view. As a result, Arm SPE can now support both HITM and peer
modes (See the "--display" options in perf c2c).

This series has been tested on FVP RevC platform.

Note: for a local HITM event, the emulation does not provide any info
for LLC. However, the perf c2c tool relies on LLC + HITM for accounting
local HITM. I to manually set the LLC HIT flag to verify the
"perf c2c -d tot" command.

---
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
James Clark (1):
      perf arm_spe: Use full type for data_src

Leo Yan (13):
      drivers/perf: arm_spe: Expose event filter
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

 drivers/perf/arm_spe_pmu.c                         |  36 ++--
 tools/perf/arch/arm64/util/arm-spe.c               |   5 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |  37 +---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  33 ++--
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   7 +
 tools/perf/util/arm-spe.c                          | 220 ++++++++++++++++-----
 tools/perf/util/arm-spe.h                          |   2 +
 8 files changed, 234 insertions(+), 120 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250610-arm_spe_support_hitm_overhead_v1_public-c4a263385434

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

