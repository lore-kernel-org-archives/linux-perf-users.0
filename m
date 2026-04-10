Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5733BBCF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806629; cv=none; b=A1ROsIntkhijN3CGy0Jo0vmIFLK3JbEf8nixwF1kQtXutUqR9DKAkTMAW5tEtfGkrOAbmnax6xMTnmZc0YuSmSy6d6vBVko2T+i1eK5RLTyG6HTALA/1smjJeodeCr5Kdk8Z27/GNQw+TjwCS5EN2OLkzFljDo61mUYe7RKXazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806629; c=relaxed/simple;
	bh=kePsosaY5HmDwmc+PdQQ/5g3eaPAL1GR0LrHxwQp03w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CoIs3yYfBSN1+lrRtqlUTYI7RX8JASHAGGhPz/6YD0LzZHpkRHKQp/N0xwKkGi1JUCDgfXIgWjTQ8Y1Gq+S49v6eFdS34JNGZgNwZFcvn5Vn3qXXTo2/3j4AOiYvHPYJqXMVovhw1Ga6A6T0pZpDQuybomBkb+7+4aQAlnOw9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=My2EjVPK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="My2EjVPK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C731CE2;
	Fri, 10 Apr 2026 00:37:01 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78E4B3FAF5;
	Fri, 10 Apr 2026 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775806627; bh=kePsosaY5HmDwmc+PdQQ/5g3eaPAL1GR0LrHxwQp03w=;
	h=From:Subject:Date:To:Cc:From;
	b=My2EjVPKBYBkyyQsKKTg+u4F8gF4MaMb/tFdDqBzcJBJqWB49G6HwchFA+1yE+a0W
	 ASGsVI6iS2IOnEL7ZY2JZ65mlY44RnwGMSBYQ9YB49bWuuIeaOXbucdIMGLFV8U1rz
	 hTagseIB/xGV+sdD14AtHfYmtOwnGK8QuIULIqms=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 0/4] perf arm_spe: Extend SIMD operations
Date: Fri, 10 Apr 2026 08:36:57 +0100
Message-Id: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmo2GkC/43R30rDMBQG8FcZubaSc/LfK99DpDTJievF1pLMo
 oy+u+mGKxOs3gROwvfLR3JmhXJPhT3tzizT1Jd+ONZBP+xY2HfHN2r6WGeGHBW3yJuRcmrL+zg
 O+dR2+dCWkSZoROM1pahTMMYjq/ExU+o/LvTLa533fTkN+fNy0wTL7hV13P6O1oU3JkLqpHQAG
 J/r6WMYDssN1zi6P+IAinsRrLDK3OJLowlvLYCD2WCwMhglkDRSE/h7RqxMrbjBiMqQFsFZdMl
 Fd8/Ib0Zz4HqDkZXxHiNI4YXV/Meb/CturfHeOZc03bdQawu5+TNqYZQP1GmEiq3MPM9fqoLcy
 VgCAAA=
X-Change-ID: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806625; l=2385;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=kePsosaY5HmDwmc+PdQQ/5g3eaPAL1GR0LrHxwQp03w=;
 b=FUxnAiTZVrIMIIkhYW3edPoqtLlb5pFfzAVzZygUkAKUjgfP7kpj2F/1nLwau9r2ScOXg7Wl+
 6LsGxi4adzfBDwUpWss1phnJjAhN+8WG22qkFw8Ed+QFMavpOHTbarx
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series extends SIMD flag for Arm SPE and updated the document.

This version is rebased onto the latest perf-tools-next branch.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v6:
- Rebased on perf-tools-next branch (Namhyung)
- Link to v5: https://lore.kernel.org/r/20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com

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
base-commit: 4cf1f549bbcdfea9c20df52994bb342677472dcd
change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

