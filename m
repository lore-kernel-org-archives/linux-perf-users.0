Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882A21FF38;
	Mon, 16 Mar 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658696; cv=none; b=QuC+2CVa1smpogCWy0crHIn8VSrTIPQBPJ8YFBrgGtp310zCMXUI9wudbffu2sWp0lwNY3L+SUiOPUOKqSFJGq3CRQlxGqnpOK7HbboTfO+Jogol6YvVrLkkYuEFx2FsA1yeZM0JFgR/q8Vw4Mkyu/wAYUl8f86DRN4J7OfQ7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658696; c=relaxed/simple;
	bh=zUxxvxb4LDG0zq8Z9zGEcgceeXazQFHtp5LJ4W6Ixpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GwFXn+FJpFW2Bo4Q9U8ZkZOnfXNHhW8xCDifUWS18S0q+VHrT1mvC/X+5guCl/EAt+eFOEF/e+BnAPdWm+iEuXNlFXAtdm/21OW5oW/D35SqjG3bPnGOmdopM/xpMjLaYWx+wTDWiC/oEdZqKIpdzPaCZPlmLHfIh5MHk6vHOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFFCD1477;
	Mon, 16 Mar 2026 03:58:07 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A691F3F73B;
	Mon, 16 Mar 2026 03:58:12 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Mar 2026 10:57:55 +0000
Subject: [PATCH] tools headers: Skip arm64 cputype.h check
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-tools_remove_sync_cputype-h-v1-1-9f0dc5931f09@arm.com>
X-B4-Tracking: v=1; b=H4sIADLit2kC/x3MQQqDMBBG4avIrBuIEYX2KqUETX7rQJuEjIoi3
 t3g5sG3eQcJMkPoVR2UsbJwDAX1oyI39eELxb6YjDadbupOzTH+xGb84wore3DWpWXeE9SkzKA
 92qdvS6kcUsbI231/f87zAml59t1tAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773658692; l=1617;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=zUxxvxb4LDG0zq8Z9zGEcgceeXazQFHtp5LJ4W6Ixpo=;
 b=XQ7DMjp5KfVq2Lrfm/zTPXLd1PkzRMfq9hmXqileqJKh+b06XPamlSVY/mkR/xm7i4iajxlOC
 7eYBIw/2TnkB8v9/ErVEGZUoessg8Q4xhHOiJOAKBagEK5oG0eRMcZI
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Some definitions in the arm64 kernel's cputype.h are kernel specific and
cause perf build failures when the header is synced into tools.

Stop checking arm64's cputype.h.  In the future, the header in tools
will be updated manually as needed.

Signed-off-by: Leo Yan <leo.yan@arm.com>
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

