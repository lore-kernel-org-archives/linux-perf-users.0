Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4F1DAC4A;
	Tue,  3 Sep 2024 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349017; cv=none; b=Jj6n2gRtcDO0lK4HR+hL9Fof3xwqEU/9lCh6As0t8smEg08Xmfb1fYzI1oHeF6QNG7DvA3M9mfagAdZWZ0iUqAxAaxMbc0QvCUPRdfu3u6/dzw6/ykN1T6IYTah3SYcZW87aFIfw9VM5MtfdZ2FLai2ByDS2N1iE70++lZd3mGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349017; c=relaxed/simple;
	bh=vgE9/PnSmYlqsr/XBI3HRvKRzvNgYbBCFD/UgriU/yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7Z2dHS9w7HTtHdi6rkAm6YQvLpeV/2zAEjOf1krKVNAjkcalK8OS++FHTI2gZ1aFrNiah+O1dv5+/GwivlyN3sJI7T4nqjdF17ByUai9bhxSiO+EF3EZJ5nIaHHsMGMzUTHULiRf1bYuR+e2b63VN4WygobXnlLoZIxuVVaB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmfHBN6c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmfHBN6c"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482J9qP5031399;
	Tue, 3 Sep 2024 07:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=mP3leY+YIi8kc
	7JhPA+erQZcdMH0H1iLvBX6jygyMRg=; b=EmfHBN6cYMzSBmMDcUPXkdOVtAm5h
	5apRTb2OfrrAL9P/jjEF0LsECGk2HpGw4pa79heyj/XIALArl0okp67iRH2jmEu/
	hw8BMDCfVxLuXNQYww95bewqHomCoJ11OlRVLFipR3AVA0YJh2kMTgW5CKmS529u
	AkSIS/ttthhraucgzGhX5x0ojgZs4EcMD3b0yzEiY2/Ru/WPCY/HSDaOTx2rtlig
	+I87KLE4iBIpvjsJzW5Z0iwuKBYFgQoQkfD3thqBoSbYxOr7mT+MC5U8rS7IX9tX
	mmOHN/tkxCI9fVPzlBpVp4HqJlhr31tQZt5PoflMoQ57pEAgQUFL+7kEg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqmtk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:36:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4837ablv021309;
	Tue, 3 Sep 2024 07:36:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqmtk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:36:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4837Z355012058;
	Tue, 3 Sep 2024 07:36:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegpsp3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:36:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4837aYqc28050144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 07:36:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27E7120043;
	Tue,  3 Sep 2024 07:36:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0E820040;
	Tue,  3 Sep 2024 07:36:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Sep 2024 07:36:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id C38BEE0195; Tue,  3 Sep 2024 09:36:33 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] uprobes: use vm_special_mapping close() functionality
Date: Tue,  3 Sep 2024 09:36:28 +0200
Message-ID: <20240903073629.2442754-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rh0seJgz3PSyz0YTd8wI8aT97fAwWnLm
X-Proofpoint-ORIG-GUID: CK74WP8ToUZ2uas1helZlUbA1aImNxGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=825 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030059

The following KASAN splat was shown:

[   44.505448] ==================================================================                                                                      20:37:27 [3421/145075]
[   44.505455] BUG: KASAN: slab-use-after-free in special_mapping_close+0x9c/0xc8
[   44.505471] Read of size 8 at addr 00000000868dac48 by task sh/1384
[   44.505479]
[   44.505486] CPU: 51 UID: 0 PID: 1384 Comm: sh Not tainted 6.11.0-rc6-next-20240902-dirty #1496
[   44.505503] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
[   44.505508] Call Trace:
[   44.505511]  [<000b0324d2f78080>] dump_stack_lvl+0xd0/0x108
[   44.505521]  [<000b0324d2f5435c>] print_address_description.constprop.0+0x34/0x2e0
[   44.505529]  [<000b0324d2f5464c>] print_report+0x44/0x138
[   44.505536]  [<000b0324d1383192>] kasan_report+0xc2/0x140
[   44.505543]  [<000b0324d2f52904>] special_mapping_close+0x9c/0xc8
[   44.505550]  [<000b0324d12c7978>] remove_vma+0x78/0x120
[   44.505557]  [<000b0324d128a2c6>] exit_mmap+0x326/0x750
[   44.505563]  [<000b0324d0ba655a>] __mmput+0x9a/0x370
[   44.505570]  [<000b0324d0bbfbe0>] exit_mm+0x240/0x340
[   44.505575]  [<000b0324d0bc0228>] do_exit+0x548/0xd70
[   44.505580]  [<000b0324d0bc1102>] do_group_exit+0x132/0x390
[   44.505586]  [<000b0324d0bc13b6>] __s390x_sys_exit_group+0x56/0x60
[   44.505592]  [<000b0324d0adcbd6>] do_syscall+0x2f6/0x430
[   44.505599]  [<000b0324d2f78434>] __do_syscall+0xa4/0x170
[   44.505606]  [<000b0324d2f9454c>] system_call+0x74/0x98
[   44.505614]
[   44.505616] Allocated by task 1384:
[   44.505621]  kasan_save_stack+0x40/0x70
[   44.505630]  kasan_save_track+0x28/0x40
[   44.505636]  __kasan_kmalloc+0xa0/0xc0
[   44.505642]  __create_xol_area+0xfa/0x410
[   44.505648]  get_xol_area+0xb0/0xf0
[   44.505652]  uprobe_notify_resume+0x27a/0x470
[   44.505657]  irqentry_exit_to_user_mode+0x15e/0x1d0
[   44.505664]  pgm_check_handler+0x122/0x170
[   44.505670]
[   44.505672] Freed by task 1384:
[   44.505676]  kasan_save_stack+0x40/0x70
[   44.505682]  kasan_save_track+0x28/0x40
[   44.505687]  kasan_save_free_info+0x4a/0x70
[   44.505693]  __kasan_slab_free+0x5a/0x70
[   44.505698]  kfree+0xe8/0x3f0
[   44.505704]  __mmput+0x20/0x370
[   44.505709]  exit_mm+0x240/0x340
[   44.505713]  do_exit+0x548/0xd70
[   44.505718]  do_group_exit+0x132/0x390
[   44.505722]  __s390x_sys_exit_group+0x56/0x60
[   44.505727]  do_syscall+0x2f6/0x430
[   44.505732]  __do_syscall+0xa4/0x170
[   44.505738]  system_call+0x74/0x98

The problem is that uprobe_clear_state() kfree's struct xol_area, which
contains struct vm_special_mapping *xol_mapping. This one is passed to
_install_special_mapping() in xol_add_vma().
__mput reads:

static inline void __mmput(struct mm_struct *mm)
{
        VM_BUG_ON(atomic_read(&mm->mm_users));

        uprobe_clear_state(mm);
        exit_aio(mm);
        ksm_exit(mm);
        khugepaged_exit(mm); /* must run before exit_mmap */
        exit_mmap(mm);
        ...
}

So uprobe_clear_state() in the beginning free's the memory area
containing the vm_special_mapping data, but exit_mmap() uses this
address later via vma->vm_private_data (which was set in
_install_special_mapping().

Fix this by moving uprobe_clear_state() to uprobes.c and use it as
close() callback.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/uprobes.h |  1 -
 kernel/events/uprobes.c | 39 ++++++++++++++++++++-------------------
 kernel/fork.c           |  1 -
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f50df1fa93e7..2ae96c98d287 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -128,7 +128,6 @@ extern int uprobe_pre_sstep_notifier(struct pt_regs *regs);
 extern void uprobe_notify_resume(struct pt_regs *regs);
 extern bool uprobe_deny_signal(void);
 extern bool arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_regs *regs);
-extern void uprobe_clear_state(struct mm_struct *mm);
 extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long addr);
 extern int  arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 30348f13d4a7..ab19a43a4dfc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1463,6 +1463,25 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
+/*
+ * uprobe_clear_state - Free the area allocated for slots.
+ */
+static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
+{
+	struct xol_area *area = container_of(vma->vm_private_data, struct xol_area, xol_mapping);
+
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(NULL, vma->vm_mm);
+	mutex_unlock(&delayed_uprobe_lock);
+
+	if (!area)
+		return;
+
+	put_page(area->pages[0]);
+	kfree(area->bitmap);
+	kfree(area);
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
@@ -1481,6 +1500,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->xol_mapping.name = "[uprobes]";
 	area->xol_mapping.fault = NULL;
+	area->xol_mapping.close = uprobe_clear_state;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
@@ -1526,25 +1546,6 @@ static struct xol_area *get_xol_area(void)
 	return area;
 }
 
-/*
- * uprobe_clear_state - Free the area allocated for slots.
- */
-void uprobe_clear_state(struct mm_struct *mm)
-{
-	struct xol_area *area = mm->uprobes_state.xol_area;
-
-	mutex_lock(&delayed_uprobe_lock);
-	delayed_uprobe_remove(NULL, mm);
-	mutex_unlock(&delayed_uprobe_lock);
-
-	if (!area)
-		return;
-
-	put_page(area->pages[0]);
-	kfree(area->bitmap);
-	kfree(area);
-}
-
 void uprobe_start_dup_mmap(void)
 {
 	percpu_down_read(&dup_mmap_sem);
diff --git a/kernel/fork.c b/kernel/fork.c
index df8e4575ff01..ad0e16cf528b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1340,7 +1340,6 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
 
-	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
-- 
2.43.0

