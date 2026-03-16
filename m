Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBAF275B05;
	Mon, 16 Mar 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659544; cv=none; b=bXPZ0N/6oYFLu7LZG3X3m/5xIZ/iYc4gqE1CkGVnoO//0q5kOPxNyXzfkH+oq9fR5Uaaz4bVDvUGTi+iWS68CTOcss1iDChpQUNA1IJ6TOfoPmizJLl4r2e/7EZV9+Fs1Tk8rWln/iAcmW/vg4HKFdsbQHhY86qd2pTYVDzmPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659544; c=relaxed/simple;
	bh=XVJ2ItiKwoxqMER29gATgAJctIcjt7z4kF3iUIBfsIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SLmAjS5t2X2tkNKgN3jMc+8IG3BGtV/DgpWUOWZ6h1QM7ClIKC1t5B0kb/INkoAoLR9Kt74B8FFg3tzE1a/XgEKahPXghorVDixAT4KYWrmUSKHsqt1o4hPC7WC901Krl2A7/UR0nximdsLgig1WxfjjCjA2mUWt4HtV7HNkEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C9371477;
	Mon, 16 Mar 2026 04:12:16 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9663F778;
	Mon, 16 Mar 2026 04:12:21 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Mar 2026 11:11:57 +0000
Subject: [PATCH v2] tools headers: Skip arm64 cputype.h check
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-tools_remove_sync_cputype-h-v2-1-07c9cdb7b2f7@arm.com>
X-B4-Tracking: v=1; b=H4sIAHzlt2kC/42NSwrDIBRFtxLeuBY1GLCj7qOEkOqzCvWDJtIQs
 vfarKCTC+cOztmhYHZY4NbtkLG64mJowC8dKDuHFxKnGwOnfKA9G8gS47tMGX2sOJUtqEmlddk
 SEkv4k2oUUou20Awpo3Gf0/4YG1tXlpi3M1bZ7/3PWxlhRBqqlZA9M1Te5+yvKnoYj+P4Apx1F
 5XEAAAA
X-Change-ID: 20260316-tools_remove_sync_cputype-h-2b0de59d5de5
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773659540; l=1878;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=XVJ2ItiKwoxqMER29gATgAJctIcjt7z4kF3iUIBfsIs=;
 b=BBlYIsPJ3q+l8/decjL2EH7RkrcCbVzxpmZ5h29EkhdF95SRTISIfvhTxDnHwe1E6vTiTMCwn
 4YlVkhkQ0fYA/Q4oTvUL8nOV0d1MuqO/7Utfox1bPmt1ED0xGceQGX2
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Some definitions in the arm64 kernel's cputype.h are kernel specific and
cause perf build failures when the header is synced into tools.

Stop checking arm64's cputype.h.  In the future, the header in tools
will be updated manually when teaching tools about new CPUs.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
Changes in v2:
- Explicitly states that update cputype.h for new CPUs (Mark).
- Link to v1: https://lore.kernel.org/r/20260316-tools_remove_sync_cputype-h-v1-1-9f0dc5931f09@arm.com
---
 tools/perf/check-headers.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index da3aca87457fdc56c96d4184f2dee88dab026d98..31826621eebdb003d0fd681ae89822225dda966f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -187,7 +187,6 @@ done
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd/ibs.h  '-I "^#include .*/msr-index.h"'
-check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
 check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'

---
base-commit: bb551508e78c886e6d3bcca6c744d3bc3fd8ad59
change-id: 20260316-tools_remove_sync_cputype-h-2b0de59d5de5

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

