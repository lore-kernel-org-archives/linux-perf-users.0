Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3D54652
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597416; cv=none; b=hmPVo2BqFm7xhnG4nKZK0irfDjdvoBZVsWusjpWRerwG06p5U70dpuF7TaPzYsiSF9666D0UpgYBUMIZhcUaa4JbeXRNEXbRUKmM2MkuT6bclJjTELcPMYFvGEq+XKs4nH5sEIE+lbxnB1pZBzewd9DpCRvybxkFKVfS4z2hW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597416; c=relaxed/simple;
	bh=422OX9nkZoEDUi615uXpiGE4CKGrzo9OxUzw3vP+lYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ltk6sz9rq45cTXaWbk8xoB0+gc/+J0pdc2533eDIe9RbTqEnPqU4onp87RlB+mzP7TMD0WpQYh2v29bqprCCU1xYTLNnLNkw1tsZJol+A+TZgaJMHySxekalLcMqY/chnLb7XOEP+VOVK2yk2N0Tvk+nWxRDdQKiuOaONsfdfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YmPlmkBx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YmPlmkBx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3119822df05so1883138a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597413; x=1749202213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flixYT7qZa2BQQysi97LfHe75SLaTmZqxePIcANrNj8=;
        b=YmPlmkBx4f/H8kQ0ZSI35VDZkWg/orrROUWKIlf7Aycmim9cqmVwVuIduIQTOwcP4f
         TCSZbKbCGTlElnr3Q/Dm+6xt9JaMCPiYZA6C21WTQl2Dy2CKCzE/YbSd86UgSmHjeQal
         1hmkOFVD0plnR4eqIjjgLoB66bknFnLXnLS6hnVrDb+sJH56gW7c8rBEwT9QPMkbfS2t
         NPyolzsP/U82hAIXrgEwlYno8BQ4P0VrUpWjMoB9Ea2csF+sI6je3SSkxBtf/5UCTJcB
         olpZZNTnwtpXc+laNjtJTjf3bh1vLLT8VzBzf6miP71a8RqHxVokecWnL4etjfNR1y0S
         yb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597413; x=1749202213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flixYT7qZa2BQQysi97LfHe75SLaTmZqxePIcANrNj8=;
        b=D+mX8Qfarob1HEaGXxI7xOp132EHpnTzqytaJfYjXIoebkSXCo48gHQMfl6xrOcsYz
         Y/CJ9r5unUI70I890i8wIB/+Yq+KVX0kDvf5N3Dc0r7RSohhielIiIb6kO78tFGFUMyK
         sz7HN4dAmDs6TnAgqMLBy9U2zjvP0lN/hE6mzm3Ddpr5wNt/yi03wL6CNnz01VnXWL0T
         /hEQnelpR52q+EkJrDNAbjUNVNYVKj9OqBTM2rEGiZVK3/mL4cK1uzmk6IFVTooN5TjN
         k0kUlsGECxRa8WZ79UF1iWGREyOeZq7l4RIcZ94tOR/0mlWFYVhSJJ+KzGONWurLScO9
         NRyg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ij5SXUn1fx3hBgc+rkDabgEGb8ipu9f4d+rm7vycElTdCGeDwljTmZxg7cIwJfTQx3wz3bjGS/E4hXcu0rwI@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4Yu3BPKli1alHt0x95uinc6bRcqZLrgdcsd1HfQxx23ssw+u
	6MyGh43d1uKf4/U0gMeCJ9SSX3cHb4zrFXTM+gKTfnd2jbNNk5Ec43qtD0EZ500HlTI=
X-Gm-Gg: ASbGnctSRzbAc6H2O2zfupvUQpDrxoO4KopGub1N/tRQhEROi12OxtM0W3WQSyPO2Nt
	f3FHytjwT3B/J3gAcJ88os8j2XlVDrBGwshLYQK4Wfin4LNx430XNV3Uo4gWOgFaHzxkP4+BS1n
	tjHzaDjFHxoVvn4HDrGDNuA726HMQMvAkT6hWlce6bwJ9V5V5TlwmmaJ7QG1C+Ipr5k8Jp4UsnV
	Q6tVQATDaM9qwY59TVLo3npCJs/P3XtzS78ox9GYzBdWZdUorYSfkGJurcYxKnGfkprBfnRc8Mo
	oEfukziYDTiWXMh1Mib7ExffS6wtvBjK8ineHXKgHsl/Z1YCugt2NZOm3niv9r8QXRejb7tLVe0
	JdIs1xRjzV5XhHru95KLV
X-Google-Smtp-Source: AGHT+IHA2yGD8wMUj4lSxB67R095/h8/6O6yJ7zAmlSwm5/Pic/viWYeW3kwOjE2By4p9s+RPQhz5w==
X-Received: by 2002:a17:90b:1d50:b0:311:fde5:c4b6 with SMTP id 98e67ed59e1d1-31250344995mr2204788a91.6.1748597413513;
        Fri, 30 May 2025 02:30:13 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.29.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:30:13 -0700 (PDT)
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
Subject: [RFC v2 07/35] RPAL: enable shared page mmap
Date: Fri, 30 May 2025 17:27:35 +0800
Message-Id: <11d4a94318efc8af41f77235f5117aabb8795afe.1748594840.git.libo.gcs85@bytedance.com>
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

RPAL needs to create shared memory between the kernel and user space for
the transfer of states and data.

This patch implements the rpal_mmap() interface. User processes can create
shared memory by calling mmap() on /proc/rpal. To prevent users from
creating excessive memory, rpal_mmap() limits the total size of the shared
memory that can be created. The shared memory is maintained through
reference counting, and rpal_munmap() is implemented for the release of
the shared memory.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/internal.h |  20 ++++++
 arch/x86/rpal/mm.c       | 147 +++++++++++++++++++++++++++++++++++++++
 arch/x86/rpal/proc.c     |   1 +
 arch/x86/rpal/service.c  |   4 ++
 include/linux/rpal.h     |  15 ++++
 mm/mmap.c                |   4 ++
 6 files changed, 191 insertions(+)

diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index c102a4c50515..65fd14a26f0e 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -9,8 +9,28 @@
 #define RPAL_COMPAT_VERSION 1
 #define RPAL_API_VERSION 1
 
+#include <linux/mm.h>
+#include <linux/file.h>
+
 extern bool rpal_inited;
 
 /* service.c */
 int __init rpal_service_init(void);
 void __init rpal_service_exit(void);
+
+/* mm.c */
+static inline struct rpal_shared_page *
+rpal_get_shared_page(struct rpal_shared_page *rsp)
+{
+	atomic_inc(&rsp->refcnt);
+	return rsp;
+}
+
+static inline void rpal_put_shared_page(struct rpal_shared_page *rsp)
+{
+	atomic_dec(&rsp->refcnt);
+}
+
+int rpal_mmap(struct file *filp, struct vm_area_struct *vma);
+struct rpal_shared_page *rpal_find_shared_page(struct rpal_service *rs,
+					       unsigned long addr);
diff --git a/arch/x86/rpal/mm.c b/arch/x86/rpal/mm.c
index f469bcf57b66..8a738c502d1d 100644
--- a/arch/x86/rpal/mm.c
+++ b/arch/x86/rpal/mm.c
@@ -11,6 +11,8 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 
+#include "internal.h"
+
 static inline int rpal_balloon_mapping(unsigned long base, unsigned long size)
 {
 	struct vm_area_struct *vma;
@@ -68,3 +70,148 @@ int rpal_balloon_init(unsigned long base)
 
 	return ret;
 }
+
+static void rpal_munmap(struct vm_area_struct *area)
+{
+	struct mm_struct *mm = area->vm_mm;
+	struct rpal_service *rs = mm->rpal_rs;
+	struct rpal_shared_page *rsp = area->vm_private_data;
+
+	if (!rs) {
+		rpal_err(
+			"free shared page after exit_mmap or fork a child process\n");
+		return;
+	}
+
+	mutex_lock(&rs->mutex);
+	if (unlikely(!atomic_dec_and_test(&rsp->refcnt))) {
+		rpal_err("refcnt(%d) of shared page is not 0\n", atomic_read(&rsp->refcnt));
+		send_sig_info(SIGKILL, SEND_SIG_PRIV, rs->group_leader);
+	}
+
+	list_del(&rsp->list);
+	rs->nr_shared_pages -= rsp->npage;
+	__free_pages(virt_to_page(rsp->kernel_start), get_order(rsp->npage));
+	kfree(rsp);
+	mutex_unlock(&rs->mutex);
+}
+
+const struct vm_operations_struct rpal_vm_ops = { .close = rpal_munmap };
+
+#define RPAL_MAX_SHARED_PAGES 8192
+
+int rpal_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_shared_page *rsp;
+	struct page *page = NULL;
+	unsigned long size = (unsigned long)(vma->vm_end - vma->vm_start);
+	int npage;
+	int order = -1;
+	int ret = 0;
+
+	if (!cur) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Check whether the vma is aligned and whether the page number
+	 * is power of 2. This makes shared pages easy to manage.
+	 */
+	if (!IS_ALIGNED(size, PAGE_SIZE) ||
+	    !IS_ALIGNED(vma->vm_start, PAGE_SIZE)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	npage = size >> PAGE_SHIFT;
+	if (!is_power_of_2(npage)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	order = get_order(size);
+
+	mutex_lock(&cur->mutex);
+
+	/* make sure user does not alloc too much pages */
+	if (cur->nr_shared_pages + npage > RPAL_MAX_SHARED_PAGES) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+	if (!rsp) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!page) {
+		ret = -ENOMEM;
+		goto free_rsp;
+	}
+
+	rsp->user_start = vma->vm_start;
+	rsp->kernel_start = (unsigned long)page_address(page);
+	rsp->npage = npage;
+	atomic_set(&rsp->refcnt, 1);
+	INIT_LIST_HEAD(&rsp->list);
+	list_add(&rsp->list, &cur->shared_pages);
+
+	vma->vm_ops = &rpal_vm_ops;
+	vma->vm_private_data = rsp;
+
+	/* map to shared pages userspace */
+	ret = remap_pfn_range(vma, vma->vm_start, page_to_pfn(page), size,
+			      vma->vm_page_prot);
+	if (ret)
+		goto free_page;
+
+	cur->nr_shared_pages += npage;
+	mutex_unlock(&cur->mutex);
+
+	return 0;
+
+free_page:
+	__free_pages(page, order);
+	list_del(&rsp->list);
+free_rsp:
+	kfree(rsp);
+unlock:
+	mutex_unlock(&cur->mutex);
+out:
+	return ret;
+}
+
+struct rpal_shared_page *rpal_find_shared_page(struct rpal_service *rs,
+					       unsigned long addr)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_shared_page *rsp, *ret = NULL;
+
+	mutex_lock(&cur->mutex);
+	list_for_each_entry(rsp, &rs->shared_pages, list) {
+		if (rsp->user_start <= addr &&
+		    addr < rsp->user_start + rsp->npage * PAGE_SIZE) {
+			ret = rpal_get_shared_page(rsp);
+			break;
+		}
+	}
+	mutex_unlock(&cur->mutex);
+
+	return ret;
+}
+
+void rpal_exit_mmap(struct mm_struct *mm)
+{
+	struct rpal_service *rs = mm->rpal_rs;
+
+	if (rs) {
+		mm->rpal_rs = NULL;
+		/* all shared pages should be freed at this time */
+		WARN_ON_ONCE(rs->nr_shared_pages != 0);
+		rpal_put_service(rs);
+	}
+}
diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
index 1ced30e25c15..86947dc233d0 100644
--- a/arch/x86/rpal/proc.c
+++ b/arch/x86/rpal/proc.c
@@ -61,6 +61,7 @@ static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 const struct proc_ops proc_rpal_operations = {
 	.proc_open = rpal_open,
 	.proc_ioctl = rpal_ioctl,
+	.proc_mmap = rpal_mmap,
 };
 
 static int __init proc_rpal_init(void)
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index caa4afa5a2c6..f29a046fc22f 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -173,6 +173,10 @@ struct rpal_service *rpal_register_service(void)
 	if (unlikely(rs->key == RPAL_INVALID_KEY))
 		goto key_fail;
 
+	mutex_init(&rs->mutex);
+	rs->nr_shared_pages = 0;
+	INIT_LIST_HEAD(&rs->shared_pages);
+
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
 
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 3bc2a2a44265..986dfbd16fc9 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -110,6 +110,12 @@ struct rpal_service {
      * Fields above should never change after initialization.
      * Fields below may change after initialization.
      */
+	/* Mutex for time consuming operations */
+	struct mutex mutex;
+
+	/* pinned pages */
+	int nr_shared_pages;
+	struct list_head shared_pages;
 
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
@@ -135,6 +141,14 @@ struct rpal_version_info {
 
 /* End */
 
+struct rpal_shared_page {
+	unsigned long user_start;
+	unsigned long kernel_start;
+	int npage;
+	atomic_t refcnt;
+	struct list_head list;
+};
+
 enum rpal_command_type {
 	RPAL_CMD_GET_API_VERSION_AND_CAP,
 	RPAL_CMD_GET_SERVICE_KEY,
@@ -196,6 +210,7 @@ struct rpal_service *rpal_get_service_by_key(u64 key);
 void copy_rpal(struct task_struct *p);
 void exit_rpal(bool group_dead);
 int rpal_balloon_init(unsigned long base);
+void rpal_exit_mmap(struct mm_struct *mm);
 
 extern void rpal_pick_mmap_base(struct mm_struct *mm,
 	struct rlimit *rlim_stack);
diff --git a/mm/mmap.c b/mm/mmap.c
index bd210aaf7ebd..98bb33d2091e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
+#include <linux/rpal.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1319,6 +1320,9 @@ void exit_mmap(struct mm_struct *mm)
 	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
+#if IS_ENABLED(CONFIG_RPAL)
+	rpal_exit_mmap(mm);
+#endif
 }
 
 /* Insert vm structure into process list sorted by address
-- 
2.20.1

