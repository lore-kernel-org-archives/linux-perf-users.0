Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634283;
	b=aQo7g5ANu5swhVp7PsoqKAsy2CTd729Ix6erUm/yD6ep0DKAuTXy5maBvNVOCIjOTltF
	 s0mYsmqNxqCpEZOxEodEG6ACmL8t3jLWva1KLv005md9stQxc5RinCbcYxm10XpVtU9IX
	 npOFw6upsEkX22+axzyNwJGDx8w6jKie74f7btCDzCgpdls/xDGGxs/GRV8KGTANE0Da7
	 gNGF03dhQ4SaT6ii5zZvdsQNSHwqwSgT/w+dD2K3Kd7/mUhtHmHiUrswaVEmCNVy7CKpy
	 HbKiLh7nWii8YFYUdBww8977uq+maWy2fkpHkvNRWXGbPejhHJ/3Xu2RI6IpAndDXDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
	b=m6MaRM4rgsG3YKb9iWlGU7dQ0qjRAwwC0BQFtRyD86mpxLGqkYTwwaBwQJFK9dlkqPar
	 U8N1DImllkeZuOphy+UJLZrxExysY617YKYpK+EekAbiShC46/g5wf6l9UrvEa++O0u34
	 g/CPo4WOeBrq4g9N6y3acz619sQ6pXJth1UTibfEHIszRmcYyovcjd7axkoau1FIbShWN
	 O0VA9imLYPkE0Kt+Akhsen+0fa3PVyc3uTvYX7QbrCYENdEwtk0A0e4qpwP8XrThxObBe
	 fkPt7XziCJkf50vp344iXaVtrHn06GuqHAu1/w6S0AtN5ILaEUcW2EEILF8SBA16btg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFKEKRsq;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1328606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1328606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFKEKRsq
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8fe8e343fso9015985ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634282; x=1793239082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
        b=IFKEKRsqFaZjucw+rqR4ryTGBSp6IDf1i5gaP/nvE9Wndr/QCOZn/7yv9UpaKZHjDW
         8/qyEA5iS19EeITAWkeyWrMT+JTRum1RMsLopl0wBBbhATjbhMHOkwMspb7/m6mO/BmT
         pfVK8W7BlQpeEkx7qfVaNeDcMUgnW4ewjeTmIoIFaKAue3DgHNDQZS/6PVOffg3EDz9t
         k9mZgSSMef4WmBGQmCR6sCoBnqW9r1Hm6mhecwOw4RqmvPO1etWZqFuPJzYWB7QaFvPK
         PNESNeRhCzNr+XEjblAL7LZO5n9/FCFC9VKwF+DgX0t7XnCL861klOfl4Nys4q4D2M7y
         OkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634282; x=1793239082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
        b=BCHWcvG5zFPHwOpgagXWo3gXHEC+5BIxtXg+MrsO6APJNCM3SGalob+HUe5Xj9bNJQ
         n87buccTqpFOB/6Hl20ihvenzHsI/ejLAXRRm9hvFqm4drDQeLUUVNKZmsSCsBh6qGk1
         vhJ7ZxR49DNyMksKVkgInuCROhAVAunOjEHmuqzdL9FTMRqpcfZEvCU8679N2h35T8Uq
         LkQbQCG0fj2y6/Mg6uctAu5PJSOtjwbxVAMsETpQYVITRkQKdLOdko2MrsieWhPYObAj
         itNnb3dfr4UQtLqOqV6+k7c2WiB9YzVr6U76htlIVxOkC1EWSSwaE3QUsROz4KLSFOGu
         5+0w==
X-Forwarded-Encrypted: i=1; AKwUvBy7mn957w3vZ1WEz35JyLlE6GX8TZ+X5t6W2OI0+19BFdwPGPuy6AjGrE22s+Ko327ZJNhByfWC1k/vWMwpVcWq@vger.kernel.org
X-Gm-Message-State: AFq9FYJzsX6DuqT4t7QBYIFJuRxtgmlNM9dxxl5ytlmaRHI0O2p+IQge
	UHzBnutl+YerWjADP01j/j+rSULedJWyO97rCoJKCoX07YYq+nHjKRib
X-Gm-Gg: AYBFou0d7YKEzu6ZMzM2PwwE9y4WkU8pmN00yU3xYw1kx5AaWgPp3x7o0faCbxU6pG7
	trt2wZl0Sy2/9QZF53vzebgC81PiJ3DHMtNM4IlcNghCMl4Ym9bD3KgHNp8oe7tr9W1yAIYkwlN
	7+gp+4cApgTBCQY3pbp/LzWZWY/WaT3+kShB+ECv02yXgJb8aYWMstcp0VN+Okjm3mMUEbPZTCv
	2cXGV5B5T70eGRIE+RRWox+x/+PyISOag27rbnA1/sJLAazGlNVcRzZboRQs8j9EJXPAPsWLzAV
	sPUPx3+MU5DgMD0pomqfzBPGtGbBXBE5QA63fuGp8BCWLOAm11079upDtmF6tEXd/f53c3iqxxT
	TxxtA9cncVvvo8nrXQMD0GTy+sUxcmwR0Fqh4k1oH1QTkJs9VvZ1iEnniJ9ektht7yvpQXwq7tf
	4qicwcvizXidWsYLc9vzL/mpDJ3Mv7NHE1I/XrglMtV0M+jk/yWrb7hVzp0k8UbIrikhrvjqGy2
	vpeTNWgJ0lbD1bsHpZxN5O6TWPiIJ/FZYn3Brle08K6UQ0s0b8HPa8hQOEo/8WUlbwVXDBXSZQU
	WHD6IrGHdzMxKi0k870IFSLnKHr/IaEtkUQZFtKw7+MzaCu12zXslGr+kABPDj1jfoQ+eX2P111
	SqrwJISxgYi3d2hhkbcfMflhe
X-Received: by 2002:a17:90a:e7c8:b0:3ab:d45c:59e2 with SMTP id 98e67ed59e1d1-3ad86f1b28fmr2821607a91.55.1792634281882;
        Wed, 21 Oct 2026 18:58:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5edsm1751706a91.8.2026.10.21.18.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 7/9] fork: Let the new task point to its mm before uprobes can find it
Date: Thu, 22 Oct 2026 01:57:10 +0000
Message-ID: <20261022015712.1297331-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

uprobe_perf_filter() compares event->hw.target->mm with mm. The target of
an inherited event is the new task. copy_mm() sets tsk->mm after dup_mm()
returned, but register_for_each_vma() can find the new mm as soon as
dup_mmap() releases dup_mmap_sem. No task points to this mm yet, so
the filter says that nobody wants it.

The walk that removes the breakpoint, because another consumer of the same
uprobe goes away, sees !filter_chain() and removes it from the child.
Nobody installs it again, and the inherited event doesn't see this child.

It's an old bug with a short window. The previous patch releases
dup_mmap_sem before dup_userfaultfd_complete(), so with UFFD_EVENT_FORK
the window is as long as the monitor likes.

Set tsk->mm at the end of dup_mmap() before it releases dup_mmap_sem.
Not earlier. The new task can be reached via its perf events and from bpf
progs. They shouldn't find mm that is half copied. Clear tsk->mm when
dup_mm() fails after dup_mmap(). Do both under task_lock() like exec_mmap()
and exit_mm().

The tasks with such event fork, while another consumer of the same uprobe
comes and goes. 5 cpu VM, 90 sec and 7000 children per run. The number of
children that the inherited event didn't see:

  without this series          11 to 24, 8 runs
  patches 1, 2, 5, 6 only      23, 12, 21
  this series                  0, 0, 0

With UFFD_EVENT_FORK monitor that reads the event after 5 sec the child
lost the breakpoint in 5 of 5 runs without this patch, and in 0 of 5 with.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/fork.c |  9 ++++++++-
 mm/internal.h |  3 ++-
 mm/mmap.c     | 14 +++++++++++++-
 mm/nommu.c    |  3 ++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8fd6be932afe..5a2f571b64b7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1539,7 +1539,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk))
 		goto fail_nomem;
 
-	err = dup_mmap(mm, oldmm);
+	err = dup_mmap(tsk, mm, oldmm);
 	if (err)
 		goto free_pt;
 
@@ -1552,6 +1552,13 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	return mm;
 
 free_pt:
+	/*
+	 * dup_mmap() has set it if it succeeded. get_task_mm() must not find
+	 * it after the mmput() below.
+	 */
+	task_lock(tsk);
+	tsk->mm = NULL;
+	task_unlock(tsk);
 	/* don't put binfmt in mmput, we haven't got module yet */
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
diff --git a/mm/internal.h b/mm/internal.h
index 9e3be236f18c..70e40306d881 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1520,7 +1520,8 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 			  pgd_t *pgd, void *private);
 
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
-int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
+int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+	     struct mm_struct *oldmm);
 
 int remap_pfn_range_prepare(struct vm_area_desc *desc);
 int remap_pfn_range_complete(struct vm_area_struct *vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 6ce654e33e3b..3167272a77ad 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
 
@@ -1705,7 +1706,8 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 	return true;
 }
 
-__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+__latent_entropy int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+			      struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp;
 	int retval;
@@ -1897,6 +1899,16 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
+	if (!retval) {
+		/*
+		 * As soon as dup_mmap_sem is released uprobes can find mm via
+		 * the rmap tree and ask the consumers if they want it. The
+		 * filter of an inherited perf event looks for mm in tsk->mm.
+		 */
+		task_lock(tsk);
+		tsk->mm = mm;
+		task_unlock(tsk);
+	}
 	uprobe_end_dup_mmap();
 	if (!retval)
 		dup_userfaultfd_complete(&uf);
diff --git a/mm/nommu.c b/mm/nommu.c
index 68b05565e15a..7529e03d3f2c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1885,7 +1885,8 @@ static int __meminit init_admin_reserve(void)
 }
 subsys_initcall(init_admin_reserve);
 
-int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+	     struct mm_struct *oldmm)
 {
 	mmap_write_lock(oldmm);
 	dup_mm_exe_file(mm, oldmm);
-- 
2.55.0

