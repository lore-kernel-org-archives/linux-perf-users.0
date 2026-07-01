Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D22FFF8B;
	Wed,  1 Jul 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878091; cv=none; b=bvE/9ViuYECvGLOmOLeW8fadNEHkKoN0w/03mka9r0UlmtvR+cM+KEE5uQxGrF+CcJbPtD/+Sybl9ffHOm4WnEgZQlijdP7Pl3GyarMXsCk0RXPFUCh08cdEuzhdISFgVVk/SxZwvVx8QReycitsN0tWP0vQ55WmCBCEkAFUmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878091; c=relaxed/simple;
	bh=oLhAqwWv1/J5e8ZRIbHODcqFMh8X9NFJlRoCkLgSAZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKvTltlga0HrSr3yNGUPUTLN5Lv0o269cfJGazVyX0jsC/QpQ9jHSqa/JEaMZyf/X7C9UYKjUnIg53nJoQmTK1OGGDS8Y4zc1M52yCXJ+8NWxxEtkuQTmcmyigAvzTww9wxG5nQ2BEL8gEkD7YmQdpdHVZfl6fbFPRZSbPdPY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmMz4dbJzYQtpZ;
	Wed,  1 Jul 2026 11:53:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 820A740AC4;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S8;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
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
Subject: [PATCH v3 06/21] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
Date: Wed,  1 Jul 2026 03:53:40 +0000
Message-Id: <20260701035355.752944-7-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxGrW7trWDGw1fGF4kJFb_yoW5Cw4xpF
	sxC347Jw4UW3WakwnxAF18WF1rJw48Zr4FyrW0vwsrCrsruFyUZw1fKr1j9F45X3yDJw10
	kayqgr18Gr4rJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
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

