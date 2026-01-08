Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDED392C2A;
	Thu,  8 Jan 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865441; cv=none; b=GC98qYn+UH2W7qtPYCWIRLrPaU/91cUqH7cm2lBXUb9fJtYmB2QoNf+F7h6Nok4EaWQILIyLNZNxiKPPiqKJp+e9lVP9hZwRgi4aaoG+4YgpqjPDs60ZjkkpOFJxVuBh1ecuKKqFBVc4ccD+ayP6lugwmQd6sqg0EXjHOphhigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865441; c=relaxed/simple;
	bh=IRHGTb2KqPzTO7htoevnAj/El48Tg+1tRAZyavqk2pc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LGDN8pp592LXqxSOs0JhDdD0ApaYgDbYvlOROLDVGUdTzKB8smXyWqxjoCQ9vagfLG3znhrRw6m74c1pljc8paVvDcbXEZo3RoPngZ/olMXxc1z0Cs25kGbo5mOzjKe7WkVOaPO4obGZCx8WyP5fXZXv9tCRhuye1A7QH1OgSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D33D9497;
	Thu,  8 Jan 2026 01:43:36 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6624E3F6A8;
	Thu,  8 Jan 2026 01:43:41 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 0/3] tools build: Fix arm64 unistd.h dependency
Date: Thu, 08 Jan 2026 09:43:23 +0000
Message-Id: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADt8X2kC/3XNSwqDMBCA4atI1k1JJmnUrnqPUiSaSQ34IilSE
 e/eKJRKweU/zHwzk4DeYSDXZCYeRxdc38WQp4RUte6eSJ2JTYDBhQMTdEBvC+veRZhCpZumqFE
 b9BQhY1bnghspSbwePMatTb4/YtcuvHo/bY9Gvk6/pjw0R04ZLTOE1KYSjdI37dtz1bdkFUfYK
 ZwdK7AqPCsV4woZ/ilipwAcKyIqWEqdlbmxqNRPWZblA+0n0ABIAQAA
X-Change-ID: 20251203-perf_fix_syscall_header-e280fa931d44
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767865421; l=2150;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=IRHGTb2KqPzTO7htoevnAj/El48Tg+1tRAZyavqk2pc=;
 b=sPUuKsHEQRxYCQde8kq8HHGH++IsTSwHMrZtV1r0COUrsJqVKCg3YsrE4L+oY8AX9uwMgyB9G
 WShlMnFSDtSA6YlbAq/gIwvSPX5U6v0y9usQLm5MgnPs3EZStHrluGk
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The perf build includes arm64's unistd.h, but its dependent header
unistd_64.h is missing.

As suggested by Arnd in [1]:

  "I would suggest using the same method across all architectures:
   either we figure out how to use the generated headers on all of them
   (including x86, which uses yet another method), or we just stick with
   the old asm-generic/unistd.h copy and use that on arm64 as well."

A dynamic approach (e.g., make headers_install) may be explored later to
generate headers for tools, but that will need consensus from the tools
maintainers.  In the meantime, this series provides a quick fix by using
the asm-generic/unistd.h copy for arm64.

[1] https://lore.kernel.org/linux-arm-kernel/20251222173653.GF9788@e132581.arm.com/T/#m69a051aae5e53a65f9b10e1d13f67b3e92f4bbc7

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v4:
- Updated commit log in patch 01 to avoid confusion (James).
- Link to v3: https://lore.kernel.org/r/20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com

Changes in v3:
- Changed to include asm-generic/unistd.h copy (Arnd).
- Removed check due to divergence between the kernel and tools.
- Link to v2: https://lore.kernel.org/r/20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com

Changes in v2:
- Added a consistency check (Ian).
- Rebased on the latest perf-tools-next.
- Link to v1: https://lore.kernel.org/r/20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com

---
Leo Yan (3):
      tools headers: Go back to include asm-generic/unistd.h for arm64
      Revert "perf tools: Fix arm64 build by generating unistd_64.h"
      tools headers: Don't check arm64's unistd.h

 tools/arch/arm64/include/uapi/asm/unistd.h | 24 +++++++++++++++++++++++-
 tools/lib/perf/Makefile                    | 14 ++------------
 tools/perf/Makefile.config                 |  1 -
 tools/perf/check-headers.sh                |  1 -
 4 files changed, 25 insertions(+), 15 deletions(-)
---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20251203-perf_fix_syscall_header-e280fa931d44

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

