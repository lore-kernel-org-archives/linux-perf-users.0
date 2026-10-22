Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634276;
	b=SepUmWOlu4eNUtAu941ra5hBAU679DGefWKpcxNbGRXimeabNuJlIFsVQWapp46XDlNw
	 QKlSxac/yrkHy0Pr9377K2+om1nkv5FW0K3+sXr0CIKRDMVEN2EZzuH+SmM8eZRN+blVC
	 adNm+CVV0xs3ii+xKxsxBzkBkyZsTUQlwLEdqsjAJjnxirMj9FN+U7KT5B4L/JU3YGPaS
	 JzVCLkJqsoxeBX33rz6pKM7zE/Je5AKes6igQID3XZ/XK7gG2tSszSLcBNrUEBBPw3QSF
	 JRjB7d245hc05dUtKM4JxdaxNQvqiV6IUnJbS+TpbcwX7gCj9WpxbC/l+JxnRU5IdoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fW9kk5xIMv5VRWKeoldYnyO29pC8D9VMf22Va3ehq2w=;
	b=vafcFYqa/gVmfVl5fwPOexvE2XRk2nbWw7bTjWCYP7OYG08Bym0jtkXnlyOGKH8ivVxr
	 2oXQofBZL9dnFHOlRKoglHi5Yt3JD7+rfPFRlYiH2f8/hbxJRq9i84D732zu8pfHv4Ooh
	 kFLlyxjG3AlMYYvsecx6B65B7ruettC4vi/C9l6VF9qQcISyojp7JHoWsnRa/OF7A3s34
	 LlMGujSNlz2sw374AKjtT0lCKopaO/BeGw7cZLwmdSdBhtAsaukqFYNa/En86vwpVUG9b
	 IeyKqckMQ/VM77uuC0ycKulvItXBwW3fte3jvZKuNZgGEQKVo1dfxcoKsvpbmbk1gwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kvZAYc+1;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFE606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kvZAYc+1
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1091154a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 18:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634275; x=1793239075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fW9kk5xIMv5VRWKeoldYnyO29pC8D9VMf22Va3ehq2w=;
        b=kvZAYc+1CpoMf04ISXJf7cuLi7nULaJQjveKdR+IHz28RvsVivM0zvQyH+vdCLzIIi
         uk77pd2erzg1H4buNmrwCp0kZ6EbIzK3ITeVdgHUn1Hok/k3PdvjgtPUb+mAQqMeDNGT
         ghxMIfYFK3KZodMu5F/mdkyFvVwvmwHm2SGmb6YYPRdYJrNfqqQ9SRBLlxgai4WlA3xv
         rCy2iFIkprELx/qtFYFpdh6HCyM0Hu4nvIhHNHj2DYuHGA3uP2101ryOEthBQtrEZC99
         6UnsLSb4U4M9YPwGENfVVBL0JR+Z/ZXw57HFLsC434cFz4UqgxgCg58X/km8iSbsD2Kg
         4aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634275; x=1793239075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fW9kk5xIMv5VRWKeoldYnyO29pC8D9VMf22Va3ehq2w=;
        b=JJ3tcMRDr3yTTeIsZSXIsVORBaGimzDsjWYKwmKALf0RhDqi5l7gfryIo0ZXaCwco6
         fyq0wW5Ip23HTWMf4Q/+AfKeFMcowGXjr8lvJce62aqE+8SmjNL2Nb1ZW7msTrnvvca/
         ozvbynN5cbfr0vzyOak5blojMOAFk5nfxA01UDFPBZph4wa9YXrb24NRSGNf+HExFrxO
         xhrOXx1baWOZETroVyuhyb2B7tKgPBfo+zYwy6W4znrqd+iZaWfJNvofizFKGI1z85fY
         M0U1X1WXMsZmOSKARF2OEJ9K71/k9yVvxiFvtQ1CvqRMmz3J5Fo+tKJAXZYhVtFoZwxc
         wJNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYt9RVjXz7GHVOZ7emNjoTxdxpY7A+5BIngGjRK96VA8/xoNcImUyc8gQ3aai3ftWBDNe7D6d3bzcIiGAk5MTS@vger.kernel.org
X-Gm-Message-State: AFq9FYIUr/Gq0HYtzhHdmXPB7iQ5sk2rBR1Blzc1yoZVdTMqWM+4SoCG
	DvLoXbiF0I/Fa3nQoiwK0pQDbR+UQ9em/vRBv7COTn6xJ7lNfna+Nctw
X-Gm-Gg: AYBFou2D9TQoX/g2EYnU3NCD+bh2xrK+htbOcRmPg00pOgdi4AdoVxWu1FDHaJzWLBJ
	A9Xvd2PI9Dw/I03HfF/VHfgaeBGWLYlYkn9F5yoQwbO3xFgX7HBiZTMEe/tkron6V4/vwArnkM7
	+2GUNIPfF1HUhYLazYT1Web8UkpVAFvSfE3emENeyEWtFkw8+eMb98vJCMqnqq9DqT4NeuKRRbM
	PZHVZmuT3xy+4JOvHhhs5gxLckeg4cAm5Pmm53lsPUm5VoqB46mb3Ocy22oqC0Kps7LtRIFj1Po
	GjnqwvPRKgW7vbCucTULGQJ9nCjigbSdQTtGM0K2R+IJmul9u3tbLREqK0XY4ztrq3g3DAjGXLZ
	p35uk+YH0DYHd4UKiReqeEeA2vcz9xFvNo3sYJWsFFGwDWwlqaIFWHSLSPAtNEnkdgbz5rlbdyT
	S1PiJbbrUBqw4XaP6BZiacG+QIyStFD8d4o3yJRHHpHSE2SSj9WOxLrknyBdVB91fNt4oRQY2sJ
	8Y7D2lRgWc7W2PorpsjPYUkp1BL0+ZQx4UC6mPL15cNKSDX8Gtt5uPF3JBm4lTBhcEIC0B5ali5
	t2PB+fmQ7v7EBajqdIxDqTBedrjK6jRmsVHhFDrU1RD6hA9rYodq7hqoSJQR69U8bXpG4JnAkT7
	yRvqdXENRiAUfdvptcBRvQ0qT
X-Received: by 2002:a17:90b:4b0a:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ad86f45340mr3130506a91.31.1792634275135;
        Wed, 21 Oct 2026 18:57:55 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490d4bfsm1991495a91.10.2026.10.21.18.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:54 -0700 (PDT)
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
Subject: [PATCH bpf-next 6/9] uprobes: Don't sleep on mmap_lock with dup_mmap_sem held in dup_mmap()
Date: Thu, 22 Oct 2026 01:57:09 +0000
Message-ID: <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
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

dup_mm() takes dup_mmap_sem for reading and then dup_mmap() sleeps on
mmap_lock of the parent. When another thread keeps that mmap_lock busy
register_for_each_vma() waits for the reader, and every other fork() in
the system waits for the writer. The parent doesn't have to map the file:

  A thread 1:  mmap(MAP_POPULATE) -> mmap_read_lock(A)
  A thread 2:  fork() -> percpu_down_read(&dup_mmap_sem),
               mmap_write_lock_killable(A) sleeps
  tracer:      percpu_down_write(&dup_mmap_sem) sleeps
  others:      fork() -> percpu_down_read(&dup_mmap_sem) sleeps

dup_mmap() needs both locks. Don't sleep on one of them while holding
the other. Sleep on mmap_lock and trylock dup_mmap_sem. If that fails sleep
on dup_mmap_sem and trylock mmap_lock, and so on. Taking mmap_lock and then
sleeping on dup_mmap_sem is simpler, but then all threads of the parent
wait for mmap_lock as long as the writer holds dup_mmap_sem.

Both are taken in dup_mmap() now, so release dup_mmap_sem there too.
Commit 8ac662f5da19 ("fork: avoid inappropriate uprobe access to invalid
mm") moved that to dup_mm() to hide the child from uprobes until mmput()
when dup_mmap() fails. Since commit 43873af772f8 ("mm: change dup_mmap()
recovery") dup_mmap() removes all vmas of such child before it drops
mmap_lock.

dup_mmap_sem is released before dup_userfaultfd_complete(), so the monitor
that doesn't read UFFD_EVENT_FORK no longer blocks every fork(). During
that wait register_for_each_vma() can find the child, while no task points
to its mm. The next patch deals with that.

Thread 1 of process A loops over mmap(4G, MAP_POPULATE) and munmap().
Thread 2 calls fork() in a loop. Nobody maps the file. Process B calls
fork() in a loop. 32 cpu VM. Median (max) of 15-25 runs, msec:

                         the longest fork() in B    attach
                         before      after          before  after
 uprobe_multi, 1 uprobe  206 (219)   0.10 (0.30)       220   11.7
 uprobe_multi, 4 uprobes 208 (428)   0.08 (0.32)       219   13.5
 perf_event, 4 uprobes   419 (424)   0.10 (0.44)       632   11.4

During detach: 265-293 -> 0.19-0.37.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/uprobes.h |  5 +++++
 kernel/events/uprobes.c |  5 +++++
 kernel/fork.c           |  4 ----
 mm/mmap.c               | 19 +++++++++++++++++--
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d34dbc0fbbfe..6d74efa80d04 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -211,6 +211,7 @@ extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
+extern bool uprobe_try_start_dup_mmap(void);
 extern void uprobe_end_dup_mmap(void);
 extern void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm);
 extern void uprobe_free_utask(struct task_struct *t);
@@ -277,6 +278,10 @@ uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end
 static inline void uprobe_start_dup_mmap(void)
 {
 }
+static inline bool uprobe_try_start_dup_mmap(void)
+{
+	return true;
+}
 static inline void uprobe_end_dup_mmap(void)
 {
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a9274016c55d..92ccb730278f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1927,6 +1927,11 @@ void uprobe_start_dup_mmap(void)
 	percpu_down_read(&dup_mmap_sem);
 }
 
+bool uprobe_try_start_dup_mmap(void)
+{
+	return percpu_down_read_trylock(&dup_mmap_sem);
+}
+
 void uprobe_end_dup_mmap(void)
 {
 	percpu_up_read(&dup_mmap_sem);
diff --git a/kernel/fork.c b/kernel/fork.c
index 10f2d05d816a..8fd6be932afe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1539,11 +1539,9 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk))
 		goto fail_nomem;
 
-	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
 		goto free_pt;
-	uprobe_end_dup_mmap();
 
 	mm->hiwater_rss = get_mm_rss(mm);
 	mm->hiwater_vm = mm->total_vm;
@@ -1558,8 +1556,6 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
 	mmput(mm);
-	if (err)
-		uprobe_end_dup_mmap();
 
 fail_nomem:
 	return NULL;
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bf26b0f1e6e..6ce654e33e3b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1713,8 +1713,22 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);
 
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
+	/*
+	 * Take mmap_lock of oldmm and dup_mmap_sem of uprobes.
+	 * Don't sleep on one of them while holding the other.
+	 */
+	for (;;) {
+		if (mmap_write_lock_killable(oldmm))
+			return -EINTR;
+		if (uprobe_try_start_dup_mmap())
+			break;
+		mmap_write_unlock(oldmm);
+
+		uprobe_start_dup_mmap();
+		if (mmap_write_trylock(oldmm))
+			break;
+		uprobe_end_dup_mmap();
+	}
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -1883,6 +1897,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
+	uprobe_end_dup_mmap();
 	if (!retval)
 		dup_userfaultfd_complete(&uf);
 	else
-- 
2.55.0

