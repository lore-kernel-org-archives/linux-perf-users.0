Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749333254A9;
	Mon, 22 Dec 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426832; cv=none; b=Yv0cOPHRApABqmGiGjf5A1GGjtqgpzs9huY6Db2msY9fws+N4IBBuJQCxvL89oyTaWsuN6VK69Wg6zQBo4EfzbQnOuMLRPwGuNixiA9ATPkBr7LSsY6M7XC3HAkZyKQppcpLk4ofDFjYVi3FxWdN/WXrdOa1F3qaUEyoRD7AEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426832; c=relaxed/simple;
	bh=3GGmnu9L+vEPuc5bdxYE1+VuUPd7yTZFcPM6++7EGEI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CIYGM3STMsM9RatuzWlOpK8yOhMCui6d5ZLpn0JIEz5Kyi/1pBLiWuhwPbB/4uE6ywl8em0K989xNDgWCHJWRc5pMMSLJU2r1/Pl6XZ/w4qw41hqT4KbBhGuSKIjpkPhu+0nOHBxQoTCn7trDKEqelr/id0WkY+nNEZdG9Li2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8029F497;
	Mon, 22 Dec 2025 10:07:02 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3100F3F73F;
	Mon, 22 Dec 2025 10:07:08 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/3] tools build: Fix arm64 unistd.h dependency
Date: Mon, 22 Dec 2025 18:06:45 +0000
Message-Id: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWISWkC/3XNzQqDMAzA8VeRnteR1k6dp73HGFJtOgt+kY4yE
 d99VRh48fgPyS8L80gOPSuThREG5904xEgvCWtaPbyROxObSZA3ISHlE5KtrPtWfvaN7rqqRW2
 QOMoCrL6nwijF4vVEGLd2+fmK3Tr/GWneHwWxTf+mOjWD4MDrAmVuc4Um0w9N/bUZe7aJQR4UA
 eeK3BRR1BmIDAEPyrquP1i4V/0CAQAA
X-Change-ID: 20251203-perf_fix_syscall_header-e280fa931d44
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766426827; l=1970;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=3GGmnu9L+vEPuc5bdxYE1+VuUPd7yTZFcPM6++7EGEI=;
 b=M3Yx6C2flDgR3hN54QK7PGE9R1b214eL9FEugqc+WzbrS99eH6bt0G+GExiiZd+pdSnKxRMhm
 C6/BN/yVyajDo7cw/E7+AUMQZxKwYa6J8GcfZODzYVym8KWnE3oa7d+
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
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251203-perf_fix_syscall_header-e280fa931d44

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

