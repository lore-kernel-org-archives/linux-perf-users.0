Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860B185E64
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060435; cv=none; b=f2FwEdEJyH6/psZGC4gN2AfN51Ap3v9GL+RLj05bDuRaZE+t6HeTyWkqSSpPiwI0YpLpn7OtRJBvLx2kIMs6j8DnTzxUOA2PtLNOsdhLeMK48QR39hJybbskBriIog5RR1ZzwrVojb0/z4oEJaqLhoEZLdMjKv3dtPO7QZ4KE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060435; c=relaxed/simple;
	bh=lLQujuaQVsINKOcP87KS9IaW5lEIAgM6cp+Fl8ujQkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjmXwElNrX3APZwE+ZgyUAhxLBDsHTPsCs7IS8ph9gmTSZOvyt1JdSeSgDgtBp4aqU7oQVOiJFfYHa3pNYvLfClCwp3+3crCtHzbb4nI8FNS3fcrRZ9xHhHMhmN5YCDMs9/A5AHANMXfpSbjRSHbykrnf7BACOG063q/aF/v5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L64pt6UM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L64pt6UM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726060433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bVgk6KxCVvyf7/kqB/bzV5TeZ0PX9U997rsx8aaL5Jg=;
	b=L64pt6UMGdeRM5RFclFvleSRnImD2ZSqwFgr3/RKrgBM9Z4wHYeU06f7g3AYY6ozscINkj
	8LuN/SM4lORi//X5qaOB3ZNXRE49p6R/3woZLeyljw1NMcSabHvshlQOlBqLsu4UYdiH2S
	qd7qNVK84yio22t4Bgtglz+cHefAsNU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-hzJk0tqeP8eufD5z4fsd7w-1; Wed,
 11 Sep 2024 09:13:48 -0400
X-MC-Unique: hzJk0tqeP8eufD5z4fsd7w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76DEA1956048;
	Wed, 11 Sep 2024 13:13:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 26E1119560A3;
	Wed, 11 Sep 2024 13:13:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 15:13:34 +0200 (CEST)
Date: Wed, 11 Sep 2024 15:13:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH -mm 1/3] Revert "uprobes: use vm_special_mapping close()
 functionality"
Message-ID: <20240911131320.GA3448@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903073629.2442754-1-svens@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This reverts commit 08e28de1160a712724268fd33d77b32f1bc84d1c.

A malicious application can munmap() its "[uprobes]" vma and in this case
xol_mapping.close == uprobe_clear_state() will free the memory which can
be used by another thread, or the same thread when it hits the uprobe bp
afterwards.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 36 +++++++++++++++++++-----------------
 kernel/fork.c           |  1 +
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 493dc95d912c..b503fafb7fb3 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -126,6 +126,7 @@ extern int uprobe_pre_sstep_notifier(struct pt_regs *regs);
 extern void uprobe_notify_resume(struct pt_regs *regs);
 extern bool uprobe_deny_signal(void);
 extern bool arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_regs *regs);
+extern void uprobe_clear_state(struct mm_struct *mm);
 extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long addr);
 extern int  arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c2d6b2d64de2..73cc47708679 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1482,22 +1482,6 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-/*
- * uprobe_clear_state - Free the area allocated for slots.
- */
-static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
-{
-	struct xol_area *area = container_of(vma->vm_private_data, struct xol_area, xol_mapping);
-
-	mutex_lock(&delayed_uprobe_lock);
-	delayed_uprobe_remove(NULL, vma->vm_mm);
-	mutex_unlock(&delayed_uprobe_lock);
-
-	put_page(area->pages[0]);
-	kfree(area->bitmap);
-	kfree(area);
-}
-
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
@@ -1516,7 +1500,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->xol_mapping.name = "[uprobes]";
 	area->xol_mapping.fault = NULL;
-	area->xol_mapping.close = uprobe_clear_state;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
@@ -1562,6 +1545,25 @@ static struct xol_area *get_xol_area(void)
 	return area;
 }
 
+/*
+ * uprobe_clear_state - Free the area allocated for slots.
+ */
+void uprobe_clear_state(struct mm_struct *mm)
+{
+	struct xol_area *area = mm->uprobes_state.xol_area;
+
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(NULL, mm);
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
 void uprobe_start_dup_mmap(void)
 {
 	percpu_down_read(&dup_mmap_sem);
diff --git a/kernel/fork.c b/kernel/fork.c
index 61070248a7d3..3d590e51ce84 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1338,6 +1338,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
 
+	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
-- 
2.25.1.362.g51ebf55


