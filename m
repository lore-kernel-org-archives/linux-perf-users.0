Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB2637F11A;
	Thu,  8 Jan 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865437; cv=none; b=lU31qlVFQdw8Gs340QiLcKAF0C6Fwn+F+bLwgTL3s/28C84PLpS0e5csAje8PNB/+suKH5ggGgmjHxqQcAekgpwuorDp2egxa3Uw0pB7aAHjqfmIFUTIVwYRDugqWNnv0a6rO866wBHmi+l6lyyng5d19kfPyon5xRSQubvJgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865437; c=relaxed/simple;
	bh=0b9Ow0mtAqt8qv9s/mRWSem+q6qiDOdZa/XNwm94HnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEpP28zlJBnaZoczSAHkGm4bUrnVNUTPpPGEdnT8NIJgkOuNTM8r3HHTQ+ch+90n574FlnJ4eGPcFhAoQtG9GDX50jnRH9KO1tLVaylGtw8jjoj1dTX7WGRUa63FOvZPj7ey9rUnN+YIHZS84yImR1MjLU2Xvl0FfVFoANHk8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7627E1515;
	Thu,  8 Jan 2026 01:43:39 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C7023F6A8;
	Thu,  8 Jan 2026 01:43:43 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 08 Jan 2026 09:43:24 +0000
Subject: [PATCH v4 1/3] tools headers: Go back to include
 asm-generic/unistd.h for arm64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-perf_fix_syscall_header-v4-1-5d45d18bc491@arm.com>
References: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
In-Reply-To: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767865421; l=2860;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=0b9Ow0mtAqt8qv9s/mRWSem+q6qiDOdZa/XNwm94HnQ=;
 b=UZsCgS2Q7hHz/L1N7vpe3xw1tYtAe9DxckcSf97Qt8AbZHA6UxYe1e5IOMaPbDhYagPzkIT06
 RbJACR33otmCMvJeY8cjx+PG3MlfRUQlwtvWziRoT4mco7LH62RmZ3j
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

Restore to include asm-generic/unistd.h for fixing the issue.  This
aligns with most architectures (x86 is a special case that keeps
unistd_32.h/unistd_64.h for its particular syscall numbers) and ensures
the header is available from the start.

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

