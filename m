Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601B23EABC
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641413; cv=none; b=XZCzHgndmNv12A/hDU2jJ+QO7DY/ljEPYVyjs1vOpo7KGpyAkZiidrL5ZuLR2pG8dbK94Z9qyuja4KQyJ1MnE1W+t4ClnmBH7wtYLz5jQrbosPXNUp2e2dpeW4WFQSxOk+wfXqBaY//MazagKXQUbA/XOr576C0npEyNwyk1a34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641413; c=relaxed/simple;
	bh=Rbdsud5ILBxTXWpv2HKpv9K7HCW+fl3XIjnnc/huKMo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=US7drR2dvQvwLV7UxN+eN8zLFUfoXldFpuyciooSlcEDmvuPXJrhafFryjjX6kjN4h/HpqnNRkY2E8yuOrjXKGhJPvX0YgKq/YWl/bc11SiM6fN6zPXQ+WUYvhOk81yZtb1Eba4o9KJb4tWm+apVSdBxCU9JxlHNz9oHZa1cwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SU9GS2ls; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SU9GS2ls"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FD6A3161;
	Wed,  8 Apr 2026 02:43:24 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C8E23F641;
	Wed,  8 Apr 2026 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775641410; bh=Rbdsud5ILBxTXWpv2HKpv9K7HCW+fl3XIjnnc/huKMo=;
	h=From:Subject:Date:To:Cc:From;
	b=SU9GS2lsuw09ZppHPRec6OL7hwFzl6BdvLtVIcG0TD6luMFVAIHiyS3bHFhmohHjX
	 nivETOqAOakfPNb/tapsv8js43m2Afjr9YYAgoj/PXfR7whxj6hbd2fb4W4nL7/IDw
	 M9L0m8lti1WBXPS/kGNegolmHYhXDXOE7JXXnoeo=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 0/4] perf arm_spe: Extend SIMD operations
Date: Wed, 08 Apr 2026 10:42:30 +0100
Message-Id: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcj1mkC/43Q32rDIBQG8FcpXi/DczT+2dXeY5QQ43H1oo1oF
 zpK3n2mZS0dLNuNcJTvdz48s0I5UmEvmzPLNMUSx0Md2qcNG3b94Z2a6OvMkGPLDfImUQ5d+Uh
 pzMeuz/uuJJqgEY1TFLwKg9YOWY2nTCGeLvTbts67WI5j/rxsmmC5vaKWm9/RevBGewi9lBYA/
 Wt9fR7G/bLhGkf7Rxyg5U4MRphW3+JLowlvLYCDXmGwMuglkNRSEbhHRtyZWnGFEZUhJQZr0Ab
 r7SMjvxnFgasVRlbGOfQghRNG8R9/8q+4Mdo5a21QdG8xz/MXtpW03RECAAA=
X-Change-ID: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775641408; l=2534;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Rbdsud5ILBxTXWpv2HKpv9K7HCW+fl3XIjnnc/huKMo=;
 b=HTjaKAOMU4fkrxEsINjopu1ZKsjwIrEYDIVSxKHLJDJHTOFbiJfKoINFRHEhn7kKOSRlVB3cB
 XsrkNpV+9ukC4ieiTIbKF03LXsS1oo306Zc6O+ooIdIxgn9q7sPnrbJ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series extends SIMD flag for Arm SPE and updated the document.

Since I failed to get perf core maintainer's review for uAPI header
updating for data source fields (since last year's Sepetember), this
series I dropped uAPI changes and sent only SIMD flag changes, hope
it is easier for perf tool maintainer's picking up.

Anyway, uAPI patches will be sent out separately.

This version is rebased onto the latest perf-tools-next branch.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v5:
- Dropped uAPI header changes for data source fields updating.
- Link to v4: https://lore.kernel.org/r/20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com

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
Leo Yan (4):
      perf sort: Support sort ASE and SME
      perf sort: Sort disabled and full predicated flags
      perf report: Update document for SIMD flags
      perf arm_spe: Improve SIMD flags setting

 tools/perf/Documentation/perf-report.txt |  5 ++++-
 tools/perf/util/arm-spe.c                | 26 ++++++++++++++++++++------
 tools/perf/util/sample.h                 | 21 ++++++++++++++++-----
 tools/perf/util/sort.c                   | 21 +++++++++++++++------
 4 files changed, 55 insertions(+), 18 deletions(-)
---
base-commit: dc647eb00969cd213c84d6caee90c480317e857d
change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

