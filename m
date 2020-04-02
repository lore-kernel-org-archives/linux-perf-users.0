From: James Clark <james.clark@arm.com>
Subject: [PATCH 1/1] perf tools: fix compilation on Arm
Date: Thu,  2 Apr 2020 14:41:28 +0100
Message-ID: <20200402134128.14493-2-james.clark@arm.com>
References: <20200330131810.GC31702@kernel.org>
 <20200402134128.14493-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200402134128.14493-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnaldo.melo@gmail.com, shikemeng@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
List-Id: linux-perf-users.vger.kernel.org

The commit "perf report: Fix arm64 gap between kernel
start and module end" introduces the following build
error with GCC 7.3.0 on Arm:

"error: implicit declaration of function ‘strchr’"

Adding the required header fixes the issue.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 94745131e89a..d41b27e781d3 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdio.h>
+#include <string.h>
 #include "debug.h"
 #include "symbol.h"
 
-- 
2.17.1
