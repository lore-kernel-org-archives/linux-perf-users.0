Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324593C4167;
	Sat,  8 Aug 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191869; cv=none; b=iHLSdaP4D5Wo0yL4Maln+It8Eg4mjbZ6w6qn02jhyY9nX4jVOLSFm8whBKQ7NEpiWH99yjPOAn5VrM/v7mgYjq0tq+thmlMaQdYrHuxfe0r8IDeqL1e3SqOc0OLemyapQHrACySKFmaon5C5rk+IGg4bV6PaffrH0/w0AzfUpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191869; c=relaxed/simple;
	bh=V1/lLQAcdtn+hDCtPPbyRi2VQXlV/Q7PaQaL7rKvNq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWkVZn4WfulXk6b/GsflmBJCHDQ/K3tf6nflHV4a7FCG4w+2ivPvZvJxygbD6RcCv4TJ3FbQWSN8G6WwA/qzcBZ1SH8KfqnBYs27K24SbC17YEP/PLLJvmOmO6yYMvCOKyAuH5jAETCku8x4KEKhzdfcZaR5O7iSEonl/6Mj/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hHKtH4hcMzYQvgS;
	Sat,  8 Aug 2026 20:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CDE65408E1;
	Sat,  8 Aug 2026 20:24:17 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S7;
	Sat, 08 Aug 2026 20:24:17 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
Date: Sat,  8 Aug 2026 12:23:42 +0000
Message-Id: <20260808122400.2961238-6-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808122400.2961238-1-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxGrW7tFy3Xw1UCry7trb_yoW5Cw48pF
	srC347Jw4UW3WakwnxAF1fWF1rJw48Zr1FyrW0yw47CrsruF1UZw1fKr1j9F45X3yDJw10
	kayDKr18Gr4rJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

