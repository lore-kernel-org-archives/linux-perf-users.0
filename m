Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BA37F8C2;
	Thu,  8 Jan 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865445; cv=none; b=obSd4/9yk8gcIV7ebt6zQu3Q2BS4E9wxsjkoSBx1yfjoFmltYF5nyrhLHhBaiTG8G0oJYrcdllFQWM2uu9houUuXX6g4ol5kbF2teNDKxmjC7K2qYxKswiAGklBJkVE5Z0BwMgTjCbP7y1Hx9ZA5nWVJvNcJnRwth/DFnNXUC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865445; c=relaxed/simple;
	bh=MA3lT13EKH4mpSeSWkRjDanYzOL7mdIDaGB4+pCUzO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJgqvFbt3fK8uZSydADNP8RlzBNMsPhmyXV5YJBh9VBLMhybdTw4jm/PgnEqPi8W6VO9haPomAq08mh5Lf9Mp25bvwi2UW2j8Os5Gshh/lqz+VcvkMGBunLNucSFm19pZ92VM3Q+OZsD6tkeFpFH2sCPNrKvQ8fPK2nHplP9oyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D0B61684;
	Thu,  8 Jan 2026 01:43:45 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 879743F6A8;
	Thu,  8 Jan 2026 01:43:49 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 08 Jan 2026 09:43:26 +0000
Subject: [PATCH v4 3/3] tools headers: Don't check arm64's unistd.h
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-perf_fix_syscall_header-v4-3-5d45d18bc491@arm.com>
References: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
In-Reply-To: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767865421; l=816;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=MA3lT13EKH4mpSeSWkRjDanYzOL7mdIDaGB4+pCUzO4=;
 b=GNQ/LtczjODiQCqnWaRCqM+WU1fkezVw0an1ovvn/23gcMcO6Ik6YXmn8+AGKVooDWrczQh52
 qEYOroLMw19D2uKGBxXatYPBBsJ7gXYUKcf3BNlc3ic8hY9aeQW3ATs
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

