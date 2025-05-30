Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62F1E8323
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597448; cv=none; b=qmChmm4F79H/VuCIYlx+3gt8cq+kmFmAb90FafjlbREsHZTl9r5QCe8Xt6sN2kgDuECEh3oM9Pytb/JPf36JfDacxx+ftyHYMOoi3z2XfwPgTf1gHvIYF4Df0P6K8s4JpPSQ8UmyU8lB5sFAHMDm9oMNC1hSmgxdhTOWNBQ+gO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597448; c=relaxed/simple;
	bh=cZEQ0MqKbOvC/as7YQeo0L+z+hUgvHRxc+aL7T32ukk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvlCeFZsusFWQfRe6gN0T2NIWT/I6MoxfYOiO8ZGu9S/0EhcbV9cPAJoN2xh76yLyS2zk4t04fgL1PcBs2gQZ92oSBn1/nhA7xAdmFgXsfgtal72QF8m6X/hrqLxn8uajh0bC5tpt+2pizdSbnSXAztlY8/toNtCn8Itb/A21hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZfFuStJw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZfFuStJw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af6a315b491so1532830a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597444; x=1749202244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCkN3xSvk7RNOqtTsnso8pu1jgTl1XSXrm3OEL9CcBU=;
        b=ZfFuStJwx/BN5fNeH96ss/AySEuyezo8B0bfDe8tMKyDwgL098ciD8jt8L7GdT+AlT
         ghBvvwMCIn8m3u2zk+iDtRMlyZ4g0Zcp9gInoNmbl6OGZ4vXHi4HMNUYrwiqlHbvhgXR
         rOFyRJhGmYpfIytDCZKohBYk3yZnd3yBQ9/4MUiB6ISpvVQSxazUuD+bvWfR3ni8HGYJ
         2WTZMlh4DZ8KVZ1OBH3QcQq7I7T58qKyfJaDApCuMtPfvBwndFZarGroYdhHLjBTioAi
         ksl/sMIeWv6qiH/hLRFjub5+vtaw/gEWfNwOEBIDS+PBybSHccw4P2ANkboLgheKQw8R
         nL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597444; x=1749202244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCkN3xSvk7RNOqtTsnso8pu1jgTl1XSXrm3OEL9CcBU=;
        b=LVpBR6vLxHfO1XyjS5fBgP8gFiUIEqanpjn7tYQ71Az8D87S6xEn2wsLskyvWuKPuN
         wAm4McMCpEhwq0ArQzBQpeYeyX21PDUZoHudoLW191nhDXi+WU43dTUPf/c01kjoeuu2
         vr5Ry+bUEBL6wAaz1hEZNterGgiVv3axA5Lz6fg2HcuTECH2ZSt7FbxU+5bP0wt6rMTI
         WYcpxht3WTPGabEAr951ryap3glwuSrudfVJTwj7ipO3n+MIUjAF9nD7O+DQul1tDBp2
         epa23xidVMB2tf7TVYOF7qFCyElBLa5rwS9wFMcrO07QBoQps5f3gd33Hvn2bZNk9SEb
         1dag==
X-Forwarded-Encrypted: i=1; AJvYcCVtoPDnZRuTWQQ/3gPjblMVuoZYjf36Qs/FH+jR9pA5GuwZX3mbLsyauxiieCZLOW1heYbYoSIHEOrr8szF3mzs@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+yJzHq9+L8r6nDbTZwadWOgZLE4GV0z6FiGSiUv1ggdO4CQv
	ULQd0htPsgf6e/+2H+f8oGHI5leLySGXOw/+kQ8ocOvVqXPd6DSqyAW9vj0QeGY0lJU=
X-Gm-Gg: ASbGncvQC1GEf7GbwaMw6gQ/QX2/34X7JABi3gNun8Ww/Zo+Vcgvp3nBE/ZvB8mAk96
	nmLImlzFIDxe2EnCj9M5ya+pbNBOdoEw+nQJKgWUOqNW4CUBQpSxtuMOv3ImJjPTc1cTyOCsVav
	7xn5XyHhHh3AylwYhALQeVVrUn91Gr4v07c4rRwh6V8ECwAvkI5YHn/bYHVxcPJqaHy+ZUauJPv
	klq+G+EuTlE/nq7OwIsUz1GiTzDPJAG3+6IVLZ61nZ4jYBo/+9GgNeV64pVqHIjHA83K4d5IRu2
	7DUJEaXspl+ubhHT76TbtiYqcyYAIogLzbfQVgnWs402wE5+BtzSUBvco4CzC/36qyOVxlEkWPs
	JSUTzn31YlQ==
X-Google-Smtp-Source: AGHT+IGxnH4FN8v0lfXoJ+KLdg1DAlTGeu78x7GO8KMsAYvLDaxWhgMloZ/K96UmZpYHSFOIcwKPxQ==
X-Received: by 2002:a17:90b:2248:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-31250427cdamr2068655a91.25.1748597444187;
        Fri, 30 May 2025 02:30:44 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.30.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:30:43 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 09/35] RPAL: enable address space sharing
Date: Fri, 30 May 2025 17:27:37 +0800
Message-Id: <2b5378f3686fd2831468e65c49609fbb19072b43.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RPAL's memory sharing is implemented by copying p4d entries, which requires
implementing corresponding interfaces. Meanwhile, copying p4d entries can
cause the process's page table to contain p4d entries that do not belong to
it, and RPAL needs to resolve compatibility issues with other subsystems
caused by this.

This patch implements the rpal_map_service() interface to complete the
mutual copying of p4d entries between two RPAL services. For the copied p4d
entries, RPAL adds a _PAGE_RPAL_IGN flag to them. This flag makes
p4d_none() return true and p4d_present() return false, ensuring that these
p4d entries are invisible to other kernel subsystems. The protection of p4d
entries is guaranteed by the memory balloon, which ensures that the address
space corresponding to the p4d entries is not used by the current service.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/include/asm/pgtable.h       |  25 ++++
 arch/x86/include/asm/pgtable_types.h |  11 ++
 arch/x86/rpal/internal.h             |   2 +
 arch/x86/rpal/mm.c                   | 175 +++++++++++++++++++++++++++
 4 files changed, 213 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5ddba366d3b4..54351bfe4e47 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1137,12 +1137,37 @@ static inline int pud_bad(pud_t pud)
 #if CONFIG_PGTABLE_LEVELS > 3
 static inline int p4d_none(p4d_t p4d)
 {
+#if IS_ENABLED(CONFIG_RPAL)
+	p4dval_t p4dv = native_p4d_val(p4d);
+
+	/*
+	 * Since RPAL copy p4d entry to share address space,
+	 * it is important that other process will not manipulate
+	 * this copied p4d. Thus, make p4d_none() always return
+	 * 0 to bypass kernel page table logic on copied p4d.
+	 */
+	return (p4dv & _PAGE_RPAL_IGN) ||
+	       ((p4dv & ~(_PAGE_KNL_ERRATUM_MASK)) == 0);
+#else
 	return (native_p4d_val(p4d) & ~(_PAGE_KNL_ERRATUM_MASK)) == 0;
+#endif
 }
 
 static inline int p4d_present(p4d_t p4d)
 {
+#if IS_ENABLED(CONFIG_RPAL)
+	p4dval_t p4df = p4d_flags(p4d);
+
+	/*
+	 * Since RPAL copy p4d entry to share address space,
+	 * it is important that other process will not manipulate
+	 * this copied p4d. Thus, make p4d_present() always return
+	 * 0 to bypass kernel page table logic on copied p4d.
+	 */
+	return ((p4df & (_PAGE_PRESENT | _PAGE_RPAL_IGN)) == _PAGE_PRESENT);
+#else
 	return p4d_flags(p4d) & _PAGE_PRESENT;
+#endif
 }
 
 static inline pud_t *p4d_pgtable(p4d_t p4d)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b74ec5c3643b..781b0f5bc359 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -35,6 +35,13 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
+/*
+ * _PAGE_BIT_SOFTW1 is used by _PAGE_BIT_SPECIAL.
+ * but we are not conflicted with _PAGE_BIT_SPECIAL
+ * as we use it only on p4d/pud level and _PAGE_BIT_SPECIAL
+ * is only used on pte level.
+ */
+#define _PAGE_BIT_RPAL_IGN	_PAGE_BIT_SOFTW1
 
 #ifdef CONFIG_X86_64
 #define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
@@ -95,6 +102,10 @@
 #define _PAGE_SOFT_DIRTY	(_AT(pteval_t, 0))
 #endif
 
+#if IS_ENABLED(CONFIG_RPAL)
+#define _PAGE_RPAL_IGN	(_AT(pteval_t, 1) << _PAGE_BIT_RPAL_IGN)
+#endif
+
 /*
  * Tracking soft dirty bit when a page goes to a swap is tricky.
  * We need a bit which can be stored in pte _and_ not conflict
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index 3559c9c6e868..65f2cf4baf8f 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -34,6 +34,8 @@ static inline void rpal_put_shared_page(struct rpal_shared_page *rsp)
 int rpal_mmap(struct file *filp, struct vm_area_struct *vma);
 struct rpal_shared_page *rpal_find_shared_page(struct rpal_service *rs,
 					       unsigned long addr);
+int rpal_map_service(struct rpal_service *tgt);
+void rpal_unmap_service(struct rpal_service *tgt);
 
 /* thread.c */
 int rpal_register_sender(unsigned long addr);
diff --git a/arch/x86/rpal/mm.c b/arch/x86/rpal/mm.c
index 8a738c502d1d..f1003baae001 100644
--- a/arch/x86/rpal/mm.c
+++ b/arch/x86/rpal/mm.c
@@ -215,3 +215,178 @@ void rpal_exit_mmap(struct mm_struct *mm)
 		rpal_put_service(rs);
 	}
 }
+
+/*
+ * Since the user address space size of rpal process is 512G, which
+ * is the size of one p4d, we assume p4d entry will never change after
+ * rpal process is created.
+ */
+static int mm_link_p4d(struct mm_struct *dst_mm, p4d_t src_p4d,
+		       unsigned long addr)
+{
+	spinlock_t *dst_ptl = &dst_mm->page_table_lock;
+	unsigned long flags;
+	pgd_t *dst_pgdp;
+	p4d_t p4d, *dst_p4dp;
+	p4dval_t p4dv;
+	int ret = 0;
+
+	BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS < 4);
+
+	mmap_write_lock(dst_mm);
+	spin_lock_irqsave(dst_ptl, flags);
+	dst_pgdp = pgd_offset(dst_mm, addr);
+	/*
+	 * dst_pgd must exists, otherwise we need to alloc pgd entry. When
+	 * src_p4d is freed, we also need to free the pgd entry. This should
+	 * be supported in the future.
+	 */
+	if (unlikely(pgd_none_or_clear_bad(dst_pgdp))) {
+		rpal_err("cannot find pgd entry for addr 0x%016lx\n", addr);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	dst_p4dp = p4d_offset(dst_pgdp, addr);
+	if (unlikely(!p4d_none_or_clear_bad(dst_p4dp))) {
+		rpal_err("p4d is previously mapped\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	p4dv = p4d_val(src_p4d);
+
+	/*
+	 * Since RPAL copy p4d entry to share address space,
+	 * it is important that other process will not manipulate
+	 * this copied p4d. We need mark the copied p4d and make
+	 * p4d_present() and p4d_none() ignore such p4d.
+	 */
+	p4dv |= _PAGE_RPAL_IGN;
+
+	if (boot_cpu_has(X86_FEATURE_PTI))
+		p4d = native_make_p4d((~_PAGE_NX) & p4dv);
+	else
+		p4d = native_make_p4d(p4dv);
+
+	set_p4d(dst_p4dp, p4d);
+	spin_unlock_irqrestore(dst_ptl, flags);
+	mmap_write_unlock(dst_mm);
+
+	return 0;
+unlock:
+	spin_unlock_irqrestore(dst_ptl, flags);
+	mmap_write_unlock(dst_mm);
+	return ret;
+}
+
+static void mm_unlink_p4d(struct mm_struct *mm, unsigned long addr)
+{
+	spinlock_t *ptl = &mm->page_table_lock;
+	unsigned long flags;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+
+	mmap_write_lock(mm);
+	spin_lock_irqsave(ptl, flags);
+	pgdp = pgd_offset(mm, addr);
+	p4dp = p4d_offset(pgdp, addr);
+	p4d_clear(p4dp);
+	spin_unlock_irqrestore(ptl, flags);
+	mmap_write_unlock(mm);
+
+	flush_tlb_mm(mm);
+}
+
+static int get_mm_p4d(struct mm_struct *mm, unsigned long addr, p4d_t *srcp)
+{
+	spinlock_t *ptl;
+	unsigned long flags;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	int ret = 0;
+
+	ptl = &mm->page_table_lock;
+	spin_lock_irqsave(ptl, flags);
+	pgdp = pgd_offset(mm, addr);
+	if (pgd_none(*pgdp)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	p4dp = p4d_offset(pgdp, addr);
+	if (p4d_none(*p4dp) || p4d_bad(*p4dp)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	*srcp = *p4dp;
+
+out:
+	spin_unlock_irqrestore(ptl, flags);
+
+	return ret;
+}
+
+int rpal_map_service(struct rpal_service *tgt)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct mm_struct *cur_mm, *tgt_mm;
+	unsigned long cur_addr, tgt_addr;
+	p4d_t cur_p4d, tgt_p4d;
+	int ret = 0;
+
+	cur_mm = current->mm;
+	tgt_mm = tgt->mm;
+	if (!mmget_not_zero(tgt_mm)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cur_addr = rpal_get_base(cur);
+	tgt_addr = rpal_get_base(tgt);
+
+	ret = get_mm_p4d(tgt_mm, tgt_addr, &tgt_p4d);
+	if (ret)
+		goto put_tgt;
+
+	ret = get_mm_p4d(cur_mm, cur_addr, &cur_p4d);
+	if (ret)
+		goto put_tgt;
+
+	ret = mm_link_p4d(cur_mm, tgt_p4d, tgt_addr);
+	if (ret)
+		goto put_tgt;
+
+	ret = mm_link_p4d(tgt_mm, cur_p4d, cur_addr);
+	if (ret) {
+		mm_unlink_p4d(cur_mm, tgt_addr);
+		goto put_tgt;
+	}
+
+put_tgt:
+	mmput(tgt_mm);
+out:
+	return ret;
+}
+
+void rpal_unmap_service(struct rpal_service *tgt)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct mm_struct *cur_mm, *tgt_mm;
+	unsigned long cur_addr, tgt_addr;
+
+	cur_mm = current->mm;
+	tgt_mm = tgt->mm;
+
+	cur_addr = rpal_get_base(cur);
+	tgt_addr = rpal_get_base(tgt);
+
+	if (mmget_not_zero(tgt_mm)) {
+		mm_unlink_p4d(tgt_mm, cur_addr);
+		mmput(tgt_mm);
+	} else {
+		/* If tgt has exited, then we get a NULL tgt_mm */
+		pr_debug("rpal: [%d] cannot find target mm\n", current->pid);
+	}
+	mm_unlink_p4d(cur_mm, tgt->base);
+}
-- 
2.20.1

