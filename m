Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B627326954;
	Tue,  6 Jan 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701294; cv=none; b=ExFDIh7aU93eESEe0v5CGGcqbvtpGeooEflA8DgXYI7WC4t2Leo4XzouvGsFsdp1fkmtZLTaXvYbUwLmrvqXzJvLrfegm28TPyxNqbdWGicBvpUGEFOOYXB4olaPDUz8UrahfEKZ+F376TH1cv+FHzACYCFb3gtcm0Qdv884ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701294; c=relaxed/simple;
	bh=mbAdR0C9J/IerSiXzkSVdYRxp0+AnNR/yDsPxR5pTdI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HDlFHgjPBkZkMN0Vxwj7D/k1myM8QpHgqMZLA+9gMSSGfgkJ/5DLAIYpPNBv+7MToMAr8paZORK1OVol6asZkPeoxiuO7KYmad45bDyXxVD8ONHgJgamhnCsUXwLNb0h6WgrO2BKk0jCLv1hL1CnlAM3smeraT0Eg6hFrE+dRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BC4497;
	Tue,  6 Jan 2026 04:08:04 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B093F5A1;
	Tue,  6 Jan 2026 04:08:08 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH RESEND v4 0/8] perf arm_spe: Extend operations
Date: Tue, 06 Jan 2026 12:07:50 +0000
Message-Id: <20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABb7XGkC/4XOPU/DMBAG4L9SeSbId3b8wcRAV4YyIhTF8bn10
 Cay2whU5b/jBtGqA2GxdD69z71nlilFyuxpdWaJxphjfyiDfFixbtcetlRFX2aGHGtukFcDpdD
 k0zD06di0ad/kgUaoROUUBa9Cp7VDVuJDohA/Z/qdbdZv69cX9lH+dzEf+/Q1Xxxh3s645eZvv
 Dy80h5CK6UFQP9cto9dv79c+omj/ScOUHMnOiNMra/xS6MRry2Ag15gsDDoJZDUUhG4e0bcmFJ
 xgRGFISU6a9AG6+09I38ZxYGrBUYWxjn0IIUTRvEbM03TN+gMwHvaAQAA
X-Change-ID: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767701288; l=2519;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mbAdR0C9J/IerSiXzkSVdYRxp0+AnNR/yDsPxR5pTdI=;
 b=/mrgpUgbJPsrV8VNbqs+FZeyynJb4/99wdMj9qi8+nGSky1W9bxS5zaW3bqxbpWQDI7ya7oNg
 +tDXy2gyDrqBh3NXLCnAxoLtl8lp3Z8eQAWkk44sTYq+b94r9KoBNES
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series sets the operation info into sample's data source and
SIMD flag, and updated the document.

No changes compared to the previous version; this version is only rebased
onto the latest perf-tools-next branch.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v4 (resend):
- Updated for Ian and James' review tags.
- Link to v4: https://lore.kernel.org/r/20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com

Changes in v4:
- Updated for Ian and James' review tags.
- Rebased on the latest perf-tools-next branch.
- Link to v3: https://lore.kernel.org/r/20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com

Changes in v3:
- Rebased on the latest perf-tools-next branch.
- Link to v2: https://lore.kernel.org/r/20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com

Changes in v2:
- Refined to use enums for 2nd operation types. (James)
- Avoided adjustment bit positions for operations. (James)
- Used enum for extended operation type in uapi header and defined
  individual bit field for operation details in uaip header. (James)
- Refined SIMD flag definitions. (James)
- Extracted a separate commit for updating tool's header. (James/Arnaldo)
- Minor improvement for printing memory events.
- Rebased on the latest perf-tools-next branch.
- Link to v1: https://lore.kernel.org/r/20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com

---
Leo Yan (8):
      perf/uapi: Extend data source fields
      tools/include: Sync uapi/linux/perf.h with the kernel sources
      perf mem: Print extended fields
      perf arm_spe: Set extended fields in data source
      perf sort: Support sort ASE and SME
      perf sort: Sort disabled and full predicated flags
      perf report: Update document for SIMD flags
      perf arm_spe: Improve SIMD flags setting

 include/uapi/linux/perf_event.h          | 32 +++++++++++++++-
 tools/include/uapi/linux/perf_event.h    | 32 +++++++++++++++-
 tools/perf/Documentation/perf-report.txt |  5 ++-
 tools/perf/util/arm-spe.c                | 56 ++++++++++++++++++++++++---
 tools/perf/util/mem-events.c             | 66 +++++++++++++++++++++++++++++---
 tools/perf/util/sample.h                 | 21 +++++++---
 tools/perf/util/sort.c                   | 21 +++++++---
 7 files changed, 205 insertions(+), 28 deletions(-)
---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

