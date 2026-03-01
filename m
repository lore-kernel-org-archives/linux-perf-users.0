Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394A3043D6;
	Sun,  1 Mar 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387025; cv=none; b=R6KzEYs3cDHGOAnGIDSBPcdiDWtNxsGQkRXvvSzSgpHHT6YT8Tgx/AjlOWIa6MRWNeKFompTFpKWq3GBak8B8VYrZcKpYefDeBWoG7p1POaqaZI7RbsBJqJJb+bnos5tihHP1TFcjW1iEbaNA6oVhzPfsqqON2BZXjqDdq6UTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387025; c=relaxed/simple;
	bh=vg6MhX+A7zzaI6K9MctKF6S0i3fznKXA0VoWmnCYPt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a98uYHKR0t8g9csljNA/jT+mEBFHHftf2+N+cDhpZaZ14qccD8yclWbQtS/kH11PSuUyc8yUHpiAud0y+16a7MUDdeG+eE00nO8toSO4JXsMzjLF1i0YZ/3f4KbpByTVR3GwCik3pF5VmsTfTEI9GmNenaIfplCBuS/H/HEEAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A08A2150C;
	Sun,  1 Mar 2026 09:43:27 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DD5D3F73B;
	Sun,  1 Mar 2026 09:43:32 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 01 Mar 2026 17:43:25 +0000
Subject: [PATCH] perf kvm stat: Fix relative paths for including headers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-perf_fix_kvm_stat_build-v1-1-e3d1ce3a5084@arm.com>
X-B4-Tracking: v=1; b=H4sIALx6pGkC/x2M7QpAMBRAX0X3txVXW3gVafm444ZZG1Ly7pafp
 845DwTyTAHq5AFPFwfebYQ8TWCYOzuR4DEyYIYqQyyFI2+04Vsv16bD0R26P3kdhawUlpU00hQ
 KYu08Res/N+37fpVSyd5pAAAA
X-Change-ID: 20260228-perf_fix_kvm_stat_build-5962895f5f36
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772387012; l=1406;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=vg6MhX+A7zzaI6K9MctKF6S0i3fznKXA0VoWmnCYPt8=;
 b=vmja94TQZWLeXCdeYVKp9vuPKci+t7f+1eFPhBPaHb6UPtuuH/JFnzecHf9DpeT9HFIz9A4+O
 aHpZbteBfitAskeoUwmHFItsX1dgHyzL9WI7QySJ+/9A0mKTNcVeYZV
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add an extra "../" to the relative paths so that the uAPI headers
provided by tools can be found correctly.

Fixes: a724a8fce5e2 ("perf kvm stat: Fix build error")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 43275d25b6cbccc477ba45a901d69c67422847ae..0f626db3a4392d7bd77417be16a2dfd4f4b1e34e 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -4,9 +4,9 @@
 #include "../kvm-stat.h"
 #include "../evsel.h"
 #include "../env.h"
-#include "../../arch/x86/include/uapi/asm/svm.h"
-#include "../../arch/x86/include/uapi/asm/vmx.h"
-#include "../../arch/x86/include/uapi/asm/kvm.h"
+#include "../../../arch/x86/include/uapi/asm/svm.h"
+#include "../../../arch/x86/include/uapi/asm/vmx.h"
+#include "../../../arch/x86/include/uapi/asm/kvm.h"
 #include <subcmd/parse-options.h>
 
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);

---
base-commit: 977000589d30f8d4f0777893711199350d474363
change-id: 20260228-perf_fix_kvm_stat_build-5962895f5f36

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

