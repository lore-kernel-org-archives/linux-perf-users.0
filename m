Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9745505F4;
	Tue,  8 Sep 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872750; cv=none; b=KXExOf7P6dZLbAqS8kaV4d1tPMUzz6+Z2whn/Bx9eOY5Df5q+XMYUW8kSu7tpcOOukTbAHIgURu/FGiJlI+cn7pk2qiJhcvB+s4T//93w55kzaR8rdI1CwBemZhWLd2/31QWjJFz5qGgWvVBU23DbMmmTm6UskzhSUc7jzlKyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872750; c=relaxed/simple;
	bh=V1/lLQAcdtn+hDCtPPbyRi2VQXlV/Q7PaQaL7rKvNq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FspW3LP8faQ5jpyfTKbmMZJgZOoipePt5OR1XVQQmF4CwDOa4CWPu6Waagi6xdfdgOP8t/P+1QHdXgVr+/E1yCT0EmRxukvoYCTzPYZNbPdoKrM1VPWhlpeow2CXE65OJQ9BhKpOcUziJY9CqLXszDrAYr0iMjBHYfmpuNwkjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPLs3rWDzKHN72;
	Tue,  8 Sep 2026 21:05:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D96FE40571;
	Tue,  8 Sep 2026 21:05:42 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S9;
	Tue, 08 Sep 2026 21:05:42 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v5 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
Date: Tue,  8 Sep 2026 13:05:10 +0000
Message-Id: <61714d93cd55cd461d5c37146713ddb9e1d04743.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxGrW7tFy3Xw1UCry7trb_yoW5Cw48pF
	srC347Jw4UW3WakwnxAF1fWF1rJw48Zr1FyrW0yw47CrsruF1UZw1fKr1j9F45X3yDJw10
	kayDKr18Gr4rJF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa
	7xRxnoUUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The current arm64 DWARF register lookup relies on 'aarch64_regstr_tbl',
a static string table. While this works for kprobe-tracer where register
names start with '%', it is insufficient for parsing register numbers
directly from raw instructions (e.g., extracting '6' from 'x6' or 'w6')
during annotation.

Since get_dwarf_regnum() is currently used only by 'perf annotate' and
does not affect kprobe-tracer, replace the limited table-based lookup
with a programmatic implementation in __get_dwarf_regnum_arm64(). This
allows resolving arm64 register names (x0-x30, w0-w30, sp, etc.) directly
into their corresponding DWARF register numbers.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 22 +++++++++++++++++++
 tools/perf/util/dwarf-regs.c                  |  2 +-
 tools/perf/util/include/dwarf-regs.h          |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
index 593ca7d4fccc..720c863d1869 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <ctype.h>
+#include <stdlib.h>
+#include <string.h>
 #include <dwarf-regs.h>
 #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
 
@@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
 
 	return perf_regnum;
 }
+
+int __get_dwarf_regnum_arm64(const char *name)
+{
+	int reg;
+
+	if (!strcmp(name, "sp"))
+		return 31;
+
+	if (*name != 'x' && *name != 'w')
+		return -ENOENT;
+
+	name++;
+	if (!isdigit(*name))
+		return -ENOENT;
+
+	reg = strtol(name, NULL, 10);
+
+	return reg >= 0 && reg <= 30 ? reg : -ENOENT;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 797f455eba0d..bacf5c13c3bc 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -114,7 +114,7 @@ int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags)
 		reg = _get_dwarf_regnum(arm_regstr_tbl, name);
 		break;
 	case EM_AARCH64:
-		reg = _get_dwarf_regnum(aarch64_regstr_tbl, name);
+		reg = __get_dwarf_regnum_arm64(name);
 		break;
 	case EM_CSKY:
 		reg = __get_csky_regnum(name, flags);
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 46a764cf322f..a25f038bbff2 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -105,6 +105,7 @@ int __get_dwarf_regnum_x86_64(const char *name);
 int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
 
+int __get_dwarf_regnum_arm64(const char *name);
 int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
 
-- 
2.34.1

