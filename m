Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78233A9D6;
	Mon, 22 Dec 2025 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426837; cv=none; b=NQ+TUVfEZhItIDzExqy9ajfkSgUw4OHrf6doQISlJYHezA+C1m4TLgE0Y7C/zUzslw9qqtLXo7P55etV5naYJYRLLbuubuI4jDpG2PHgdeuWG4U/24GuJSRWLiXEqS4fgBX8YY/BfudsLrtWBGW374EkqdKznWJX9I8h6C1lntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426837; c=relaxed/simple;
	bh=MA3lT13EKH4mpSeSWkRjDanYzOL7mdIDaGB4+pCUzO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrgeIYYrDgS75rwZnUI9sduMwWtv2+2FXC3nNJA0kkzActQw0nf5b3QCozJkUWtKytqU7tAkz86kDVhCQeffB9v4Pe5dzEjQ7gBltpQ4XcuS7z9yaAskiBQuiD6IfYQ9Ya56br67GrJeyU3TpTH1luke32SeNs0Dp01sPMXBdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C86FEC;
	Mon, 22 Dec 2025 10:07:07 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 320AB3F73F;
	Mon, 22 Dec 2025 10:07:13 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 22 Dec 2025 18:06:48 +0000
Subject: [PATCH v3 3/3] tools headers: Don't check arm64's unistd.h
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-perf_fix_syscall_header-v3-3-eb4a8b9dfe66@arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
In-Reply-To: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766426828; l=816;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=MA3lT13EKH4mpSeSWkRjDanYzOL7mdIDaGB4+pCUzO4=;
 b=DAHDBO+U3zeZiL7jC32n2JGKborZPo5mYy2AxUcpEuai6Ay+0Rkwfsyhk7Ucsv8v/OJe1My7x
 1/Q9K+TeugIDepz0f5NenXVAAdCDtOTbrWchlZzZV/kMZmZX073R5X6
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The arm64 unistd.h in tools now diverges from the kernel header.
Comparing the two headers is pointless, remove the check.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/check-headers.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e0537f275da2f79ea9e05b91300aa1e2f996e9f1..da3aca87457fdc56c96d4184f2dee88dab026d98 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -54,7 +54,6 @@ declare -a FILES=(
   "arch/s390/include/uapi/asm/kvm.h"
   "arch/s390/include/uapi/asm/sie.h"
   "arch/arm64/include/uapi/asm/kvm.h"
-  "arch/arm64/include/uapi/asm/unistd.h"
   "arch/alpha/include/uapi/asm/errno.h"
   "arch/mips/include/asm/errno.h"
   "arch/mips/include/uapi/asm/errno.h"

-- 
2.34.1

