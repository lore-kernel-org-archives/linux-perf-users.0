Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642238424C
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856252; cv=none; b=htz1elRTBFpQ8plsZHIx9WXTkFAA9iAWoocPwFc/lAobc0chvGwxNoOg3Za2hzqupF9+ly9yCH7tGyqbxGqzGuCIM/6pDQJWmB72pHXWVnJi+UmsgWBmiTf0iktnAf6jEX4a4l6i1vMG8GneFd5K4hJYg10wu43PjZ4JFOHFY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856252; c=relaxed/simple;
	bh=vTqde+jQUkD8nWmPm68T8gS25xyBW9YLSU7qR+8zCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPT/5TVZDlnOLp+ejxFkFjyGRuTYdz3Q9+9D4a1aFxDEHyJx6wz24nu++eftiOzzwYvstJ3HBBAgpJyyFEzc4NoevDFEyddyJ+6PLX+8Q/c/kAo27knKzR4+p9txbl+LO4c0wjkLECjtQgdizbQCWfARbXfDp0IlGOGMBuhs9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pw4leN1e; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw4leN1e"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1521773a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856250; x=1790461050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpCsP86xi2oPmXXsXdzzX0b/0jZcnB8+PgHESN6kqeA=;
        b=pw4leN1e6nde8tNpQ+nYZjyqfFWjNs5FppBBGtL8aPV+v+xAbruIcfEqnxkz4EQ/Yc
         SebiluAbj2lNF3r1mkZS5AGiS4HO5T4S/xO+I4tY2bAJT8WcAMkTEUE8X491+yXc+NmM
         SKLclGBPMj6bUG5nwoFxA1Wsmoc01PG2PuZA8aoq7mRGWd2KeGWbUSvBcx7TLQuXWQ8y
         3qbgwlzk1upXq6O/1BJUbEL4W1bCot0N6vK3gydBR/cSPybiffyROgju/C/HJBCUgKIt
         RuBkXS9VBlZneUsrjP5aWijhvDQN3YOXrSEsq7UvbfYj0zOjgn9edLfUrt5LS4Ho/PUN
         ZeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856250; x=1790461050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpCsP86xi2oPmXXsXdzzX0b/0jZcnB8+PgHESN6kqeA=;
        b=spboPnRPwH6DJ+0o0Nnrj23l2PBUxLR3z53P7f52O3VFItBsUjqeILCHyhbv6pZ61d
         24O/yfOBDJZgGLvjUQf2+yBoUOFL6vEDxjij1YsFvFAOhcnt67lcBMElR43RMwkKZcr5
         IREVGKghzNzCS6i1D+XjnO77pR4GUxpLad+6VUe11Z9jP2rxc0vDGmmsCOl3eIngGQoW
         bMMyWv+/wAu1tS/wV7ku35DSTIO714ZEpK04br19esxdIFJm/rxUxyB/fqLbIw2GzcWR
         VGC4/qNnKd1nvULpahzBPPC4Z9sOn4gMbOfmQzopTNFZ9NZWW6XksJo4cYERzTCszrcd
         Nxmw==
X-Gm-Message-State: AFuF++mjl/BhGsXlwZoZUvkBxErkWA/M9cI5oCkKi7RtUB8o6JeoF+JH
	G7BNw5PmodJG0/7HO7jo3Ia4VpJtbQdruAZ8bFvw4S14Huw2Oj3+Uc3J
X-Gm-Gg: AYBFou1H3YOLSaq1mdiY7aovSjdA4QBF6iYnswNiikoXsrbiLa6y/z2n6v1DOYfaztl
	Mz953I/2Rr20qy453Ifh2f4QTKgOGA3k4pgboQP0OXrQ9e38vs+Gco7M2NNJzoQo9L2Q4SYmvjU
	2X6Fog6CO8g8Z9ssr5UnnXso4UAdauaUvH1hn6pOu+V6BFRxX0ND4LF48mlFVWOx9eZeygsaJZM
	sOjL9VFPZlcYi+3JID+r/3umGL+C1dQQhBJF9bgvmPpWAJ5+r7Ls+GL3NWmcku49j6rjfCn9j5r
	FnBIK5eCSQP/n3QCN5G8R4IWuyG+ocCtn+8sMh4YL5DF7WuQsd1weEBAFJ5LzSycyHxo/xRX6md
	9hWTT/VMjPKaI9zdLbX/q8P0kupXvTGQoYp9GWOTRzJXdup13on6wVOM6ZRahWL6B32K+zv86pD
	s0i4XRf3Issc8G9S0fl65ebDq82n91Sp/Gl6XsQqoSvGeV3XJzxPIWM61cZCchIfWAyyzAyGS2m
	U2cs7hdOaBMKwrGuKZytbKOSRw1Xmo7vbRnFpTdYi9pesTTx7F6DTtA4YwEyNTpatHMuoawmsRf
	zTbMSeASxg==
X-Received: by 2002:a17:90b:2d0c:b0:39e:6c68:c77d with SMTP id 98e67ed59e1d1-39e6c68ca07mr5314348a91.51.1789856249893;
        Sat, 19 Sep 2026 15:17:29 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm6269131a91.11.2026.09.19.15.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:29 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: fix locked_vm leak on alias mmap() and cross-MM pinned_vm underflow
Date: Sat, 19 Sep 2026 22:17:28 +0000
Message-ID: <20260919221728.3707189-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In perf_mmap(), mapping an output ring buffer onto an event via
PERF_EVENT_IOC_SET_OUTPUT / alias mmap() increments user->locked_vm and
mm->pinned_vm without recording the accounting MM on the ring_buffer or
releasing user_extra onperf_mmap_close(), causing a permanent locked_vm
leak and a cross-MM pinned_vm underflow when the mapping is closed in a
different process. Store the accounted mm_struct on struct perf_buffer
and unaccount against the original mm_struct on close.

Fixes: fae85b7c8bcc ("perf: Start the restructuring")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe33fe15689d..2be9301dcd7c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7050,7 +7050,11 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 
 		/* now it's safe to free the pages */
 		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		if (rb->aux_mmap_mm) {
+			atomic64_sub(rb->aux_mmap_locked, &rb->aux_mmap_mm->pinned_vm);
+			mmdrop(rb->aux_mmap_mm);
+			rb->aux_mmap_mm = NULL;
+		}
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
@@ -7272,7 +7276,7 @@ static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *
 
 	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
 			&user->locked_vm);
-	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
+	atomic64_sub(rb->mmap_locked, &rb->mmap_mm->pinned_vm);
 }
 
 static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
@@ -7311,7 +7315,6 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			 * Success -- managed to mmap() the same buffer
 			 * multiple times.
 			 */
-			perf_mmap_account(vma, user_extra, extra);
 			refcount_inc(&event->mmap_count);
 			return 0;
 		}
@@ -7338,6 +7341,8 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		return -ENOMEM;
 
 	rb->mmap_locked = extra;
+	rb->mmap_mm = vma->vm_mm;
+	mmgrab(rb->mmap_mm);
 
 	ring_buffer_attach(event, rb);
 
@@ -7399,7 +7404,8 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 
 	if (rb_has_aux(rb)) {
 		refcount_inc(&rb->aux_mmap_count);
-
+		user_extra = 0;
+		extra = 0;
 	} else {
 		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
 			refcount_dec(&rb->mmap_count);
@@ -7420,6 +7426,8 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 
 		refcount_set(&rb->aux_mmap_count, 1);
 		rb->aux_mmap_locked = extra;
+		rb->aux_mmap_mm = vma->vm_mm;
+		mmgrab(rb->aux_mmap_mm);
 	}
 
 	perf_mmap_account(vma, user_extra, extra);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index c03c4f2eea57..f10eacd8b590 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -5,6 +5,7 @@
 #include <linux/hardirq.h>
 #include <linux/uaccess.h>
 #include <linux/refcount.h>
+#include <linux/sched/mm.h>
 
 /* Buffer handling */
 
@@ -38,6 +39,8 @@ struct perf_buffer {
 	refcount_t			mmap_count;
 	unsigned long			mmap_locked;
 	struct user_struct		*mmap_user;
+	struct mm_struct		*mmap_mm;
+	struct mm_struct		*aux_mmap_mm;
 
 	/* AUX area */
 	struct mutex			aux_mutex;
@@ -67,6 +70,10 @@ static inline void rb_free_rcu(struct rcu_head *rcu_head)
 	struct perf_buffer *rb;
 
 	rb = container_of(rcu_head, struct perf_buffer, rcu_head);
+	if (rb->aux_mmap_mm)
+		mmdrop(rb->aux_mmap_mm);
+	if (rb->mmap_mm)
+		mmdrop(rb->mmap_mm);
 	free_uid(rb->mmap_user);
 	rb_free(rb);
 }
