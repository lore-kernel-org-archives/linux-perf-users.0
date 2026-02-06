Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBD634C9AB;
	Fri,  6 Feb 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375633; cv=none; b=HpDaO3DP+vzU7pkR9XtQW4XK8rDVmI5V9ulMVT/2qzfVbwDUKzPQebK32TR+oMF0j4nADw7o2/bYvmSmoxD/DlnXQ9tXi4jQY+/TyFi5+LQNis6EJ2Sb0S63MoQukTaaKSqTVMD6wtNhXF4ZI9Do/yuCRgVoMMmXwV/6a12E3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375633; c=relaxed/simple;
	bh=RTF/yAh8LqaG2N+p8nvUpFns/BNGuIxSgv5t7yhuUi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PArvDRNbxc5yKbA13ymsqk1ZQKDUeGbMmjN8mIq3ShkLqgo0+0spwN6+KIJFlf7p2WGm4uSONYq6n/t9+7WTWVY1V0p7hP355UoxASkrKv+R8bsxtNAVMEMCfdJbPp+UnksvuFpNNhMzh9oscCPHak3DAxs6McoKc4D3J0k9MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A199339;
	Fri,  6 Feb 2026 03:00:25 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 551F53F778;
	Fri,  6 Feb 2026 03:00:30 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 06 Feb 2026 11:00:20 +0000
Subject: [PATCH] perf kvm stat: Fix build error
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
X-B4-Tracking: v=1; b=H4sIAMPJhWkC/x2MWwqAIBAArxL7nWBCSl0lQpbcaokerCFBePekz
 4GZeSGSMEXoqxeEEkc+jwJNXcG04rGQ4lAYjDZWG23VRTL7mR+/pd3HG29PIqcodF2LTQjWoYF
 SX0LF+s/DmPMH4Mw/B2kAAAA=
X-Change-ID: 20260206-perf_fix_kvm_stat_error-a795a1dd67a2
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770375630; l=1562;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RTF/yAh8LqaG2N+p8nvUpFns/BNGuIxSgv5t7yhuUi0=;
 b=xfevmBsHSfYK1AsgCDDR8uM+fAj2bbGEBspAXY48tLXd3pmY2K238G9SCtaY0nMltSjeJ5vM9
 U4ZNJ7DhUBABtE+jHYNtbKEnVi7mfZKmcNHwDUEY4+qm/kBlsD7s7s1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since commit ceea279f9376 ("perf kvm stat: Remove use of the arch
directory"), a native build on Arm64 machine reports:

  util/kvm-stat-arch/kvm-stat-x86.c:7:10: fatal error: asm/svm.h: No such file or directory
    7 | #include <asm/svm.h>
      |          ^~~~~~~~~~~
  compilation terminated.

The build fails to find x86's asm headers when building for Arm64.  Fix
this by including asm headers with relative path instead.

Fixes: ceea279f9376 ("perf kvm stat: Remove use of the arch directory")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 1cf541385a4bdee4930b67a054906ccade7301fd..43275d25b6cbccc477ba45a901d69c67422847ae 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -4,9 +4,9 @@
 #include "../kvm-stat.h"
 #include "../evsel.h"
 #include "../env.h"
-#include <asm/svm.h>
-#include <asm/vmx.h>
-#include <asm/kvm.h>
+#include "../../arch/x86/include/uapi/asm/svm.h"
+#include "../../arch/x86/include/uapi/asm/vmx.h"
+#include "../../arch/x86/include/uapi/asm/kvm.h"
 #include <subcmd/parse-options.h>
 
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);

---
base-commit: 84cb36da81413c2dff805150b9f4db1524460269
change-id: 20260206-perf_fix_kvm_stat_error-a795a1dd67a2

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

