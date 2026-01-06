Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A5314A7A;
	Tue,  6 Jan 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700640; cv=none; b=py91aAkoJsHHVOS+dxMBD6Q60ki+B49ThOnjxu0UQx5zUYzum4GGflbXei9LTo87kdvL2QLkLfWy8aSvyKAyA7RS2/JQT7BtR8CDuKcwyKRzlc3AUPA9/McPWq0fgAJ09kQWt1vjnEb20d+eGy8wxiD725IorGNsw/0PQV2zIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700640; c=relaxed/simple;
	bh=unpUmPsbVAfanae3vr0BHr49OvQu961hhpbtWX7uHo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a56YpDD2EP53jgZN1tSSeoXwxodfjmba0hXTftiQh7Gr7tM378pgsLxDMbim7qHf6pEwcOuC6RNk/VSwM5bmkBynZjoUqhAK5JyMjkLaxTK9ZVRdRFxnEfUA6M9jhIVwNXFX97yLLvo/UFnGzkIvolt33jXOY7bJwsJRIqgEEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAA56497;
	Tue,  6 Jan 2026 03:57:09 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957F33F5A1;
	Tue,  6 Jan 2026 03:57:14 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 0/8] perf arm_spe: Extend operations
Date: Tue, 06 Jan 2026 11:56:45 +0000
Message-Id: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH34XGkC/4XOwW7DIAwG4FepOI8JGxJgp73HNEUJmJVDGwRdt
 KnKu89ppVY7rLsg/Vj/Z59Fo5qpiZfdWVRacsvzkYN52omwH48fJHPkLFBhpxwqWaimoX2WMtf
 TMNbD0AotILWcekqxT8HaCQXXS6WUvy702zvnfW6nuX5fNi2w/V5Rr9zfKD9K2ghpNMYDYHzl6
 XOYD9uGax39P3WATk06OO06e6tvFy14uwIU2AcMMoPRABlreoLpN6PvDJ/4gNHMUK+Dd+iTj/7
 OrOv6A4O9d/GLAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767700634; l=2305;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=unpUmPsbVAfanae3vr0BHr49OvQu961hhpbtWX7uHo8=;
 b=gb6BTTD8pfdDx+a3M1Ccdd4U8S69lekuJdESkBK6thzPsJMKLYY9HvO231FNX4hc0oq3/sNmf
 R9fC3LbKPZsDY9bIqx25BC+dBDjI9w22ZEc5Bjpqdw83FIDuPl+fNfz
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series sets the operation info into sample's data source and
SIMD flag, and updated the document.

No changes compared to the previous version; this version is only rebased
onto the latest perf-tools-next branch.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v4:
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

