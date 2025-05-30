Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47B220686
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597370; cv=none; b=ChB5926ZcwvBvbK+43nhfpOtIoq43H80pRuBsyuaEGIlJP6WPsd1Lus+s7ZB75HVeTTe6VSFzcbOBll0FjPg+upxk1RZ0dgYDJX1kiTcR7SjhSzQcp7+PUcr10a3pzPeOu2vHTwm4isEFhmTP5PH7FBINJF7xshejYlVsXccoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597370; c=relaxed/simple;
	bh=HWUbzvJ0czQHj89YGQM3u0dk16ZJgWmPR8JTmwOLaAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T55mcSmX4ylGw0bmAaKl78sYRhvN6MfX7wIm7B0aYrkEx7ZRO+zm/r3K0u31h1SanIx5tM68DsTNONumTJzfLPPMYFZrov/OBtu2JM2FaDypiEta5IrNMQfKfBXT4nsfapsGSY6/GsZHeRnHO2VlvoNbMBWktDxgIHdnXSnU1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i+8bKHHV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i+8bKHHV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2353a2bc210so3129335ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597367; x=1749202167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlcCT7HpVRiKFCiWQ8GjTfMWomzbPQPS5hEo4l8oJpI=;
        b=i+8bKHHVu0Iwh+zALug//jSVJrcArOw6+1Sb2X6JYatwx0UBHy5421qx7NXWu/ZxbF
         ubtHM2AsBEMIoFzuk9lY5UfMjZU6imL1Z/wNa+88TU2vHdC/0qZw8IKsCrJ/z5l4UUIP
         4tdt8H2iPqD+a4ll95djQDmPnJ8PO4U6359RE0QkHs/sbfIQAl4yzBhi/lVzBB4X2e/c
         +dzZy19UlwSn6pBOKLY5LDSsfZbjblPBmDYvQh5MgywpsVLy5zFaCljULT4cwzRUWIUh
         QUip7XlnryUZDvUSIQt8XnwlZW0/5WOOILHikCQUy1UNbvWQb08L7fnPDpJOiVNB8IXD
         mN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597367; x=1749202167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlcCT7HpVRiKFCiWQ8GjTfMWomzbPQPS5hEo4l8oJpI=;
        b=VtUf/K8956S8+T1BwiSeV6KF9f2+OYqP9iOxM7O5NAkQme9b0vIkR4qc0KLf4o7tva
         vPIJvQ+qbxfkQpkUT7P5HBZlO90QfWrcL8Agq56mG5UK8cPCyFAdmMEd7K5awOTPc3iW
         LQpczsOq3hSV4DBCzQreCSXGSVYL9buY17F2AqGoURgclDIQl0mk6LXz8u9B576jHAbG
         g9ZL+JQgX71uWggCS1XbHV7yLdnrjAXInjQy6hiO6OpTcuptmtBMu3Fl06fSShRkimq9
         jyvrB2/amJU3LCaZvmI2wenL5nE8unwFWpki5y5A0zmyjXxLEMGaV4w1D1Rp1iQcOtNh
         40bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD39xk6nL9tDHZZ+YdTigWTl2R9D4AIJ22Gxopv6fJgg0q123Z53jYvon2HBgsbLuo7r8nO3A3aTVK2JHkGceI@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZCIN7PCWWitKd8STvDn4nb16MQrB4c9Sx5TSYEbi93bC+aGm
	PkxUaQHVR/zIrQ7XSXtXA7I8XsFLz/SJ9Z5FafCgOgLGmuS2dg1hh01T2NTPWlDnWlg=
X-Gm-Gg: ASbGncsLa08WGBovXBneSMuXWtWeWTUvZFFrROSHvkN4QwBkbAnj1eP96ZR9+B/JD1o
	kgz3n06R9OgRP5RsqyxvjsSebJjCxYtq6pD46uH6hoM6D8j8klltT/dEjoax8Kt3K5UaYvEtGm2
	uEi3UzUespp6QAXCSf6dPXksrnkp3nmZiDRifg9yR0L6lnBFHI+/R5h0Z+i475apxFSffF7PhVt
	IatFt/11e0vxZUirb0dXbMkeYTqBlBMjmKFYX/nUJZud5wCLNBpZso4sp4DdM9/oROND5nOc6dv
	1fYN0gdAgBgmbF8OT/3dS0UZMuSUXVKQhnOciYduyTrzls4b5M+OlNNZn3K1SOaNHxMK8e85b4e
	xlXiIGnSrYg==
X-Google-Smtp-Source: AGHT+IHhT+/kCKbFwXp40FdH2tTAUVIIkiKVWdZUIpWhrB1L0an0nzdMBrvxVW8z9SoZzZut7sVHuQ==
X-Received: by 2002:a17:90b:5288:b0:312:ec:4128 with SMTP id 98e67ed59e1d1-31250476af1mr2024876a91.34.1748597367284;
        Fri, 30 May 2025 02:29:27 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.29.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:29:26 -0700 (PDT)
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
Subject: [RFC v2 04/35] RPAL: add member to task_struct and mm_struct
Date: Fri, 30 May 2025 17:27:32 +0800
Message-Id: <aed20a6acacb2646fe45ed2ba5ada800095b5dbf.1748594840.git.libo.gcs85@bytedance.com>
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

In lazy switch and memory-related operations, there is a need to quickly
locate the corresponding rpal_service structure. Therefore, rpal_service
members are added to these two data structures.

This patch adds an rpal_service member to both task_struct and mm_struct,
and introduces initialization operations. Meanwhile, rpal_service is also
augmented with references to the task_struct and mm_struct of the
group_leader. For threads created via fork, the kernel acquires a reference
to rpal_service and assigns it to the new task_struct. References to
rpal_service are released when threads exit.

Regarding the deallocation of rpal_struct, since rpal_put_service may be
called in an atomic context (where mmdrop() cannot be invoked), this patch
uses delayed work for deallocation. The work delay is set to 30 seconds,
which ensures that IDs are not recycled and reused in the short term,
preventing other processes from confusing the reallocated ID with the
previous one due to race conditions.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/service.c  | 77 +++++++++++++++++++++++++++++++++++++---
 fs/exec.c                | 11 ++++++
 include/linux/mm_types.h |  3 ++
 include/linux/rpal.h     | 29 +++++++++++++++
 include/linux/sched.h    |  5 +++
 init/init_task.c         |  3 ++
 kernel/exit.c            |  5 +++
 kernel/fork.c            | 16 +++++++++
 8 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 609c9550540d..55ecb7e0ef8c 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -26,9 +26,24 @@ static inline void rpal_free_service_id(int id)
 
 static void __rpal_put_service(struct rpal_service *rs)
 {
+	pr_debug("rpal: free service %d, tgid: %d\n", rs->id,
+		 rs->group_leader->pid);
+
+	rs->mm->rpal_rs = NULL;
+	mmdrop(rs->mm);
+	put_task_struct(rs->group_leader);
+	rpal_free_service_id(rs->id);
 	kmem_cache_free(service_cache, rs);
 }
 
+static void rpal_put_service_async_fn(struct work_struct *work)
+{
+	struct rpal_service *rs =
+		container_of(work, struct rpal_service, delayed_put_work.work);
+
+	__rpal_put_service(rs);
+}
+
 static int rpal_alloc_service_id(void)
 {
 	int id;
@@ -75,9 +90,16 @@ void rpal_put_service(struct rpal_service *rs)
 {
 	if (!rs)
 		return;
-
-	if (atomic_dec_and_test(&rs->refcnt))
-		__rpal_put_service(rs);
+    /*
+     * Since __rpal_put_service() calls mmdrop() (which
+     * cannot be invoked in atomic context), we use
+     * delayed work to release rpal_service.
+     */
+	if (atomic_dec_and_test(&rs->refcnt)) {
+		INIT_DELAYED_WORK(&rs->delayed_put_work,
+				  rpal_put_service_async_fn);
+		schedule_delayed_work(&rs->delayed_put_work, HZ * 30);
+	}
 }
 
 static u32 get_hash_key(u64 key)
@@ -128,6 +150,12 @@ struct rpal_service *rpal_register_service(void)
 	if (!rpal_inited)
 		return NULL;
 
+	if (!thread_group_leader(current)) {
+		rpal_err("task %d is not group leader %d\n", current->pid,
+			 current->tgid);
+		goto alloc_fail;
+	}
+
 	rs = kmem_cache_zalloc(service_cache, GFP_KERNEL);
 	if (!rs)
 		goto alloc_fail;
@@ -140,10 +168,27 @@ struct rpal_service *rpal_register_service(void)
 	if (unlikely(rs->key == RPAL_INVALID_KEY))
 		goto key_fail;
 
-	atomic_set(&rs->refcnt, 1);
+	current->rpal_rs = rs;
+
+	rs->group_leader = get_task_struct(current);
+	mmgrab(current->mm);
+	current->mm->rpal_rs = rs;
+	rs->mm = current->mm;
+
+	/*
+	 * The reference comes from:
+	 * 1. registered service always has one reference
+	 * 2. leader_thread also has one reference
+	 * 3. mm also hold one reference
+	 */
+	atomic_set(&rs->refcnt, 3);
 
 	insert_service(rs);
 
+	pr_debug(
+		"rpal: register service, key: %llx, id: %d, command: %s, tgid: %d\n",
+		rs->key, rs->id, current->comm, current->tgid);
+
 	return rs;
 
 key_fail:
@@ -161,7 +206,31 @@ void rpal_unregister_service(struct rpal_service *rs)
 
 	delete_service(rs);
 
+	pr_debug("rpal: unregister service, id: %d, tgid: %d\n", rs->id,
+		 rs->group_leader->tgid);
+
+	rpal_put_service(rs);
+}
+
+void copy_rpal(struct task_struct *p)
+{
+	struct rpal_service *cur = rpal_current_service();
+
+	p->rpal_rs = rpal_get_service(cur);
+}
+
+void exit_rpal(bool group_dead)
+{
+	struct rpal_service *rs = rpal_current_service();
+
+	if (!rs)
+		return;
+
+	current->rpal_rs = NULL;
 	rpal_put_service(rs);
+
+	if (group_dead)
+		rpal_unregister_service(rs);
 }
 
 int __init rpal_service_init(void)
diff --git a/fs/exec.c b/fs/exec.c
index cfbb2b9ee3c9..922728aebebe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/rpal.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1076,6 +1077,16 @@ static int de_thread(struct task_struct *tsk)
 	/* we have changed execution domain */
 	tsk->exit_signal = SIGCHLD;
 
+#if IS_ENABLED(CONFIG_RPAL)
+	/*
+	 * The rpal process is going to load another binary, we
+	 * need to unregister rpal since it is going to be another
+	 * process. Other threads have already exited by the time
+	 * we come here, we need to set group_dead as true.
+	 */
+	exit_rpal(true);
+#endif
+
 	BUG_ON(!thread_group_leader(tsk));
 	return 0;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 32ba5126e221..b29adef082c6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1172,6 +1172,9 @@ struct mm_struct {
 #ifdef CONFIG_MM_ID
 		mm_id_t mm_id;
 #endif /* CONFIG_MM_ID */
+#ifdef CONFIG_RPAL
+		struct rpal_service *rpal_rs;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 75c5acf33844..7b9d90b62b3f 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -11,6 +11,8 @@
 
 #include <linux/sched.h>
 #include <linux/types.h>
+#include <linux/sched/mm.h>
+#include <linux/workqueue.h>
 #include <linux/hashtable.h>
 #include <linux/atomic.h>
 
@@ -29,6 +31,9 @@
 #define RPAL_INVALID_KEY _AC(0, UL)
 
 /*
+ * Each RPAL process (a.k.a RPAL service) should have a pointer to
+ * struct rpal_service in all its tasks' task_struct.
+ *
  * Each RPAL service has a 64-bit key as its unique identifier, and
  * the 64-bit length ensures that the key will never repeat before
  * the kernel reboot.
@@ -39,10 +44,23 @@
  * is released, allowing newly started RPAL services to reuse the ID.
  */
 struct rpal_service {
+	/* The task_struct of thread group leader. */
+	struct task_struct *group_leader;
+	/* mm_struct of thread group */
+	struct mm_struct *mm;
 	/* Unique identifier for RPAL service */
 	u64 key;
 	/* virtual address space id */
 	int id;
+
+    /*
+     * Fields above should never change after initialization.
+     * Fields below may change after initialization.
+     */
+
+	/* delayed service put work */
+	struct delayed_work delayed_put_work;
+
 	/* Hashtable list for this struct */
 	struct hlist_node hlist;
 	/* reference count of this struct */
@@ -68,7 +86,18 @@ struct rpal_service *rpal_get_service(struct rpal_service *rs);
  */
 void rpal_put_service(struct rpal_service *rs);
 
+#ifdef CONFIG_RPAL
+static inline struct rpal_service *rpal_current_service(void)
+{
+	return current->rpal_rs;
+}
+#else
+static inline struct rpal_service *rpal_current_service(void) { return NULL; }
+#endif
+
 void rpal_unregister_service(struct rpal_service *rs);
 struct rpal_service *rpal_register_service(void);
 struct rpal_service *rpal_get_service_by_key(u64 key);
+void copy_rpal(struct task_struct *p);
+void exit_rpal(bool group_dead);
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 45e5953b8f32..ad35b197543c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -72,6 +72,7 @@ struct rcu_node;
 struct reclaim_state;
 struct robust_list_head;
 struct root_domain;
+struct rpal_service;
 struct rq;
 struct sched_attr;
 struct sched_dl_entity;
@@ -1645,6 +1646,10 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_RPAL
+	struct rpal_service			*rpal_rs;
+#endif
+
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..0c5b1927da41 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -220,6 +220,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_RPAL
+	.rpal_rs = NULL,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 38645039dd8f..0c8387da59da 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -70,6 +70,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/rpal.h>
 
 #include <uapi/linux/wait.h>
 
@@ -944,6 +945,10 @@ void __noreturn do_exit(long code)
 	taskstats_exit(tsk, group_dead);
 	trace_sched_process_exit(tsk, group_dead);
 
+#if IS_ENABLED(CONFIG_RPAL)
+	exit_rpal(group_dead);
+#endif
+
 	exit_mm();
 
 	if (group_dead)
diff --git a/kernel/fork.c b/kernel/fork.c
index 85afccfdf3b1..1d1c8484a8f2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/rpal.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1216,6 +1217,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->mm_cid_active = 0;
 	tsk->migrate_from_cpu = -1;
 #endif
+
+#ifdef CONFIG_RPAL
+	tsk->rpal_rs = NULL;
+#endif
 	return tsk;
 
 free_stack:
@@ -1312,6 +1317,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+#ifdef CONFIG_RPAL
+	mm->rpal_rs = NULL;
+#endif
 
 	if (current->mm) {
 		mm->flags = mmf_init_flags(current->mm->flags);
@@ -2651,6 +2659,14 @@ __latent_entropy struct task_struct *copy_process(
 			current->signal->nr_threads++;
 			current->signal->quick_threads++;
 			atomic_inc(&current->signal->live);
+#if IS_ENABLED(CONFIG_RPAL)
+			/*
+			 * For rpal process, the child thread needs to
+			 * inherit p->rpal_rs. Therefore, we can get the
+			 * struct rpal_service for any thread of rpal process.
+			 */
+			copy_rpal(p);
+#endif
 			refcount_inc(&current->signal->sigcnt);
 			task_join_group_stop(p);
 			list_add_tail_rcu(&p->thread_node,
-- 
2.20.1

