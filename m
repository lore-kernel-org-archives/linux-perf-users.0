Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4A2D2490;
	Mon, 22 Dec 2025 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426834; cv=none; b=bpYt1Q00w5DATIqn9pHA4Q+WZzjFKw0jb8LT2CTUnhi0m/WwYVZS/Hlet1kTx0OHMTUzdI0gFRwJ5ltjyJWKFKmEhLB5oOwHGZuD1FIVVqacSOVrJe0ghzhlF4Z9mcGT3kAk78BU1Y7DNVCWnri2kTSeK3nTJTrTkMKj+af4UcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426834; c=relaxed/simple;
	bh=nXnG7k5Zaz0I0X/x3m53iHeMEFKI92DwooDSckcZXCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaRMuaQPLDv5dHm5FCYvmVM5vlb6fOGwwQLmG4V4ygxsnbHnZTF7MBgV7U39yMZgulpx5ckOfrbDpsEnKPkOEs1/lEtlFHZrM6FxkETbF2XnB6MFxvGp+CGUVWSbU4dpO7MsYYmOBjEDSYCGycpP3gCiZ1bpmKC+Q7l9RDehdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E214FEC;
	Mon, 22 Dec 2025 10:07:04 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33D63F73F;
	Mon, 22 Dec 2025 10:07:09 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 22 Dec 2025 18:06:46 +0000
Subject: [PATCH v3 1/3] tools headers: Go back to include
 asm-generic/unistd.h for arm64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-perf_fix_syscall_header-v3-1-eb4a8b9dfe66@arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
In-Reply-To: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766426828; l=2774;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=nXnG7k5Zaz0I0X/x3m53iHeMEFKI92DwooDSckcZXCM=;
 b=lz6syXqe69RtFm++hX5Xmj9yTWjg4kqDXlCktmLwbkewbJngJFIQKsKhrwdbQZuJKJUUdBbvf
 GUH+KdG90CkCCMzIItd732mDuRiudv3OSxIEv90WuEi7CKfWmo7tMFy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The header unistd.h is included under Arm64's uAPI folder (see
tools/arch/arm64/include/uapi/asm/), but it does not include its
dependent header unistd_64.h.  The intention is for unistd_64.h to be
generated dynamically using scripts/Makefile.asm-headers.

However, this dynamic approach causes problems because the header is not
available early enough, even though it is widely included throughout
tools.  Using the perf build as an example:

 1) Feature detection: Perf first runs feature tests.

    The BPF feature program test-bpf.c includes unistd.h.  Since
    unistd_64.h has not been generated yet, the program fails to build,
    and the BPF feature ends up being disabled.

 2) libperf build:

    The libperf Makefile later generates unistd_64.h on the fly, so
    libperf itself builds successfully.

 3) Final perf build:

    Although the perf binary can build successfully using the generated
    header, we never get a chance to build BPF skeleton programs,
    because BPF support was already disabled earlier.

To fix the issue, it restores to include asm-generic/unistd.h.  This is
consistent with other architectures and ensures the header is available
from the start.

Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/arch/arm64/include/uapi/asm/unistd.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index df36f23876e863ff0a9e88473d5339f7ab69516d..9306726337fe005e3cf3e1ffd38dc6356191fa95 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -1,2 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm/unistd_64.h>
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_MEMFD_SECRET
+
+#include <asm-generic/unistd.h>

-- 
2.34.1

