Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F5396D10;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209735; cv=none; b=FCuSQOzzf+LTnQswD58z6709D8J7Sz7CRxnV79b0XEaulSAfBBs7EZVSIX1pbkrCdbSwTaDd13WHUr7bfXCG3g8A/upKrEsEdKij9DOjOe2oq1xOSxSHqcmkzbIj4xBcZqO4CKJu2AP4pTUtrb+h1ktSVOV7OW+A1wZssRonMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209735; c=relaxed/simple;
	bh=oLhAqwWv1/J5e8ZRIbHODcqFMh8X9NFJlRoCkLgSAZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9FVdlagaN2bzF+XgjhJ2jXUFz2fieWkwUWwf+9kSMtfU8FC+eH4Q+jDCVeohf6v8VmzQgu61Hih1xBmq2QwZ08ieHXApkJNVrPdP8gNZ8+wLFF6VBHjAJ5RFYZlVE4qoJRqNNugP32Wra3qZ42UZYdQ3VIsnVI+bdCI2JGt34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS81PnqzYQtvD;
	Fri,  3 Apr 2026 17:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 99E6840593;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S8;
	Fri, 03 Apr 2026 17:48:49 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 06/16] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
Date: Fri,  3 Apr 2026 09:47:50 +0000
Message-Id: <20260403094800.1418825-7-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxGrW7trWDGw1fGF4kJFb_yoW5Cw4xpF
	sxC347Jw4UW3WakwnxAF18WF1rJw48Zr4FyrW0vwsrCrsruFyUZw1fKr1j9F45X3yDJw10
	kayqgr18Gr4rJF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
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
 .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 20 +++++++++++++++++++
 tools/perf/util/dwarf-regs.c                  |  2 +-
 tools/perf/util/include/dwarf-regs.h          |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
index 593ca7d4fccc..be55fc2a4f38 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <ctype.h>
 #include <dwarf-regs.h>
 #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
 
@@ -10,3 +11,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
 
 	return perf_regnum;
 }
+
+int __get_dwarf_regnum_arm64(const char *name)
+{
+	int reg;
+
+	if (!strcmp(name, "sp") || !strcmp(name, "wzr") || !strcmp(name, "xzr"))
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

