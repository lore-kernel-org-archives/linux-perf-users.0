Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6A2236E8;
	Wed, 10 Dec 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377915; cv=none; b=ZCieOYFsfPspbRoNWo1q70pnC5lxk6zFBESfacp/BCQBlyXFOTBnrRwfuWmQyvAHEfgyojcGeexh9o/XCnOrUZfueEq0xl2iCgjaXC93oYf3b5VX0rDdVYjs0AcFd8cUvLomR9d/JX6pi9K+FwUGdx42iMJaQLwKfJQvqSvq0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377915; c=relaxed/simple;
	bh=yvoSzS8tbtymMGwetG3HBDWv7plELrvOOfPbygBGJMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o3bcYQCmoTuXDBo3cwg0mAGIyGCK2bF5u0xouyo5OHUCHueLjnURuhOcmm2DZ/qIgnkuvr7XvKS9q0Q/pplvRhGjZf4jiwrn8YYSMdo8MM/aT9C6vaPYO2ELGDDA2Fwlt4BldtFHBzXEH6azShJjBkir7Hd6ekSKvRE8lTU4Kec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B725F153B;
	Wed, 10 Dec 2025 06:45:05 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B35CA3F73B;
	Wed, 10 Dec 2025 06:45:11 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/3] tools build: Fix arm64's unistd_64.h dependency
Date: Wed, 10 Dec 2025 14:44:54 +0000
Message-Id: <20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaHOWkC/3WNQQrCMBREr1L+2kiSRltdeQ8pJSY/NtA25UeCp
 eTuxoJLl2+YebNBRPIY4VptQJh89GEuIA8VmEHPT2TeFgbJ5UlIXrMFyfXOv/u4RqPHsR9QWyS
 GsuVOX2phlYKyXghLazffu8KDj69A636UxDf9OdVfZxKMs0eLsnGNQnvWN03T0YQJupzzBzxoh
 Q+8AAAA
X-Change-ID: 20251203-perf_fix_syscall_header-e280fa931d44
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765377911; l=1719;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=yvoSzS8tbtymMGwetG3HBDWv7plELrvOOfPbygBGJMw=;
 b=cXOuaQ3/vcACMSeGA1wc/mnb6KfUB9o5pFPbzer/gc1JoK1X3RkKnxkdImSmRr51Q7ZOqs5aZ
 AdOC/1Lz5x+BIPIWZwh2DUUeLxVhsQhj3wEdfYVZoQ7TFEF93Tp+yrr
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Arm64's unistd.h is included in the tools build, but its dependent
header unistd_64.h is missing.  This results in only a partial set of UAPI
headers being available, forcing tools to generate unistd_64.h dynamically.

Because unistd.h is widely used across the tools directory, relying on a
dynamically generated header is fragile, especially when a tool builds in
multiple stages, each of which may include unistd.h.

This series addresses the issue by adding a generated unistd_64.h
directly to the tools tree, ensuring the header is available from the
start and eliminating build failures due to header dependency.

This series has been tested with Arm64 cross-compilation and confirmed
that the BPF feature is enabled in perf.  It also verifies libperf
in-source builds with applying this series.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Added a consistency check (Ian).
- Rebased on the latest perf-tools-next.
- Link to v1: https://lore.kernel.org/r/20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com

---
Leo Yan (3):
      tools headers: Add arm64's unistd_64.h
      Revert "perf tools: Fix arm64 build by generating unistd_64.h"
      tools headers: Verify arm64's unistd_64.h

 tools/arch/arm64/include/uapi/asm/unistd_64.h | 335 ++++++++++++++++++++++++++
 tools/lib/perf/Makefile                       |  14 +-
 tools/perf/Makefile.config                    |   1 -
 tools/perf/check-headers.sh                   |   9 +
 4 files changed, 346 insertions(+), 13 deletions(-)
---
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251203-perf_fix_syscall_header-e280fa931d44

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

