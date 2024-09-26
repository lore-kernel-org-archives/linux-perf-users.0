Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B51422D4;
	Thu, 26 Sep 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337108; cv=none; b=MQmYSLFfX/9YFfbvrW/brK8Zu55gSE34lh3ozvEFr004lyRmrHtB9GAiEj0qhurA9G8Ky7/AmLDSnR2AUkLOvlCyejhVL3jRBF21+w+QaoJcr35oDs02A63WXFWkN5JgK8w6wvVbq2SPcHy37SUtfdivMMwlIKQEISMP9go/vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337108; c=relaxed/simple;
	bh=Marp1ysz5EDzMedroRcw1Zxg1Ygg2QsEVvVeJfhOWtc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKI3UHP+0eFrZBijGq+wdS+pTkqFskN69iFYoKKiOcyXkS2Bv54GJ4He/v5g6HC9c2kgyJk7FXIzVoEZKpa3zfh8MlhjRrnej30CNuQxeDQJ+lLLVVq1nJJbQRBajmTo7xoNwEp8uGWHDE/PrH1Jk2SL53G03WBg9a9CbWqgc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDm405nzFzySKc;
	Thu, 26 Sep 2024 15:50:40 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id CB439140393;
	Thu, 26 Sep 2024 15:51:42 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 15:51:41 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <akpm@linux-foundation.org>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<peterz@infradead.org>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: [PATCH v3] mm: move mm flags to mm_types.h
Date: Thu, 26 Sep 2024 15:49:22 +0800
Message-ID: <20240926074922.2721274-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)

The types of mm flags are now far beyond the core dump related features.
This patch moves mm flags from linux/sched/coredump.h to linux/mm_types.h.
The linux/sched/coredump.h has include the mm_types.h, so the C files
related to coredump does not need to change head file inclusion.
In addition, the inclusion of sched/coredump.h now can be deleted from
the C files that irrelevant to core dump.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
v3:
  Use more reasonable comment for bit0 & bit1 of mm flag.
v2:
  fix comment for bit0 & bit1 of mm flag after move them to mm_types.h
 include/linux/huge_mm.h        |  1 -
 include/linux/khugepaged.h     |  2 -
 include/linux/ksm.h            |  1 -
 include/linux/mm_types.h       | 84 ++++++++++++++++++++++++++++++++++
 include/linux/oom.h            |  1 -
 include/linux/sched/coredump.h | 82 ---------------------------------
 kernel/events/uprobes.c        |  1 -
 kernel/fork.c                  |  1 -
 mm/huge_memory.c               |  1 -
 mm/khugepaged.c                |  1 -
 mm/ksm.c                       |  1 -
 mm/memory.c                    |  1 -
 mm/oom_kill.c                  |  1 -
 13 files changed, 84 insertions(+), 94 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 67d0ab3c3bba..5eb4b0376c7d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_HUGE_MM_H
 #define _LINUX_HUGE_MM_H
 
-#include <linux/sched/coredump.h>
 #include <linux/mm_types.h>
 
 #include <linux/fs.h> /* only for vma_is_dax() */
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 30baae91b225..1f46046080f5 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -2,8 +2,6 @@
 #ifndef _LINUX_KHUGEPAGED_H
 #define _LINUX_KHUGEPAGED_H
 
-#include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
-
 extern unsigned int khugepaged_max_ptes_none __read_mostly;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 11690dacd986..d4675416f0c2 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/sched.h>
-#include <linux/sched/coredump.h>
 
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..ff8627acbaa7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1499,4 +1499,88 @@ enum {
 	/* See also internal only FOLL flags in mm/internal.h */
 };
 
+/* mm flags */
+
+/*
+ * The first two bits represent core dump modes for set-user-ID,
+ * the modes are SUID_DUMP_* defined in linux/sched/coredump.h
+ */
+#define MMF_DUMPABLE_BITS 2
+#define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
+/* coredump filter bits */
+#define MMF_DUMP_ANON_PRIVATE	2
+#define MMF_DUMP_ANON_SHARED	3
+#define MMF_DUMP_MAPPED_PRIVATE	4
+#define MMF_DUMP_MAPPED_SHARED	5
+#define MMF_DUMP_ELF_HEADERS	6
+#define MMF_DUMP_HUGETLB_PRIVATE 7
+#define MMF_DUMP_HUGETLB_SHARED  8
+#define MMF_DUMP_DAX_PRIVATE	9
+#define MMF_DUMP_DAX_SHARED	10
+
+#define MMF_DUMP_FILTER_SHIFT	MMF_DUMPABLE_BITS
+#define MMF_DUMP_FILTER_BITS	9
+#define MMF_DUMP_FILTER_MASK \
+	(((1 << MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
+#define MMF_DUMP_FILTER_DEFAULT \
+	((1 << MMF_DUMP_ANON_PRIVATE) |	(1 << MMF_DUMP_ANON_SHARED) |\
+	 (1 << MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
+
+#ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
+# define MMF_DUMP_MASK_DEFAULT_ELF	(1 << MMF_DUMP_ELF_HEADERS)
+#else
+# define MMF_DUMP_MASK_DEFAULT_ELF	0
+#endif
+					/* leave room for more dump flags */
+#define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
+#define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
+
+/*
+ * This one-shot flag is dropped due to necessity of changing exe once again
+ * on NFS restore
+ */
+//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
+
+#define MMF_HAS_UPROBES		19	/* has uprobes */
+#define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
+#define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
+#define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
+#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
+#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
+#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
+#define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
+#define MMF_MULTIPROCESS	26	/* mm is shared between processes */
+/*
+ * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
+ * replaced in the future by mm.pinned_vm when it becomes stable, or grow into
+ * a counter on its own. We're aggresive on this bit for now: even if the
+ * pinned pages were unpinned later on, we'll still keep this bit set for the
+ * lifecycle of this mm, just for simplicity.
+ */
+#define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
+
+#define MMF_HAS_MDWE		28
+#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
+
+
+#define MMF_HAS_MDWE_NO_INHERIT	29
+
+#define MMF_VM_MERGE_ANY	30
+#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
+
+#define MMF_TOPDOWN		31	/* mm searches top down by default */
+#define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
+
+#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
+				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
+				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
+
+static inline unsigned long mmf_init_flags(unsigned long flags)
+{
+	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
+		flags &= ~((1UL << MMF_HAS_MDWE) |
+			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
+	return flags & MMF_INIT_MASK;
+}
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..1e0fc6931ce9 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -7,7 +7,6 @@
 #include <linux/types.h>
 #include <linux/nodemask.h>
 #include <uapi/linux/oom.h>
-#include <linux/sched/coredump.h> /* MMF_* */
 #include <linux/mm.h> /* VM_FAULT* */
 
 struct zonelist;
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index e62ff805cfc9..6eb65ceed213 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -8,12 +8,6 @@
 #define SUID_DUMP_USER		1	/* Dump as user of process */
 #define SUID_DUMP_ROOT		2	/* Dump as root */
 
-/* mm flags */
-
-/* for SUID_DUMP_* above */
-#define MMF_DUMPABLE_BITS 2
-#define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
-
 extern void set_dumpable(struct mm_struct *mm, int value);
 /*
  * This returns the actual value of the suid_dumpable flag. For things
@@ -31,80 +25,4 @@ static inline int get_dumpable(struct mm_struct *mm)
 	return __get_dumpable(mm->flags);
 }
 
-/* coredump filter bits */
-#define MMF_DUMP_ANON_PRIVATE	2
-#define MMF_DUMP_ANON_SHARED	3
-#define MMF_DUMP_MAPPED_PRIVATE	4
-#define MMF_DUMP_MAPPED_SHARED	5
-#define MMF_DUMP_ELF_HEADERS	6
-#define MMF_DUMP_HUGETLB_PRIVATE 7
-#define MMF_DUMP_HUGETLB_SHARED  8
-#define MMF_DUMP_DAX_PRIVATE	9
-#define MMF_DUMP_DAX_SHARED	10
-
-#define MMF_DUMP_FILTER_SHIFT	MMF_DUMPABLE_BITS
-#define MMF_DUMP_FILTER_BITS	9
-#define MMF_DUMP_FILTER_MASK \
-	(((1 << MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
-#define MMF_DUMP_FILTER_DEFAULT \
-	((1 << MMF_DUMP_ANON_PRIVATE) |	(1 << MMF_DUMP_ANON_SHARED) |\
-	 (1 << MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
-
-#ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
-# define MMF_DUMP_MASK_DEFAULT_ELF	(1 << MMF_DUMP_ELF_HEADERS)
-#else
-# define MMF_DUMP_MASK_DEFAULT_ELF	0
-#endif
-					/* leave room for more dump flags */
-#define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
-#define MMF_VM_HUGEPAGE		17	/* set when mm is available for
-					   khugepaged */
-/*
- * This one-shot flag is dropped due to necessity of changing exe once again
- * on NFS restore
- */
-//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
-
-#define MMF_HAS_UPROBES		19	/* has uprobes */
-#define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
-#define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
-#define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
-#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
-#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
-#define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
-#define MMF_MULTIPROCESS	26	/* mm is shared between processes */
-/*
- * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
- * replaced in the future by mm.pinned_vm when it becomes stable, or grow into
- * a counter on its own. We're aggresive on this bit for now: even if the
- * pinned pages were unpinned later on, we'll still keep this bit set for the
- * lifecycle of this mm, just for simplicity.
- */
-#define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
-
-#define MMF_HAS_MDWE		28
-#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
-
-
-#define MMF_HAS_MDWE_NO_INHERIT	29
-
-#define MMF_VM_MERGE_ANY	30
-#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
-
-#define MMF_TOPDOWN		31	/* mm searches top down by default */
-#define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
-
-#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
-				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
-
-static inline unsigned long mmf_init_flags(unsigned long flags)
-{
-	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
-		flags &= ~((1UL << MMF_HAS_MDWE) |
-			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
-	return flags & MMF_INIT_MASK;
-}
-
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..3d49d59079b9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/export.h>
 #include <linux/rmap.h>		/* anon_vma_prepare */
 #include <linux/mmu_notifier.h>
diff --git a/kernel/fork.c b/kernel/fork.c
index 60c0b4868fd4..549d7aa3bea6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -16,7 +16,6 @@
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/sched/user.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/stat.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0580ac9e47b9..13bf59b84075 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -8,7 +8,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff..f8d59a4b5ecd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -4,7 +4,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/mmu_notifier.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
diff --git a/mm/ksm.c b/mm/ksm.c
index a2e2a521df0a..dec536d6d91a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -20,7 +20,6 @@
 #include <linux/mman.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/sched/cputime.h>
 #include <linux/rwsem.h>
 #include <linux/pagemap.h>
diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..d990fb1d6233 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -44,7 +44,6 @@
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
 #include <linux/hugetlb.h>
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 4d7a0004df2c..1c485beb0b93 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -24,7 +24,6 @@
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/debug.h>
 #include <linux/swap.h>
-- 
2.33.0

