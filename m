Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108212FFF90
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700245; cv=none; b=HTa6DlYn8WRP/QGLJNM2ky8bF2tqRTdUhvQ93/woN2c9XNqPeCOuCjt7V5VG+0wJTzM2AlkywYgkOIF3zsCYTQd2EFIeX2FH797zM+qCxn3OSUeuACK8i4Oy7cuSGHtH4H3FoUJNsjzkrmEzmRL9FnFctM1JiYCzVG791BcOraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700245; c=relaxed/simple;
	bh=s6zouHGfzlbdM9bU4V4mCEZQVs8KbkxJL7IwbS8nspY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnlQ5WgoShUzcT+ZqKDX4yQiQYJos0qcAkeSHbtUocIkmJLRAs8gAEmBKWu2xcoSy6HLoVpKh50+5DSoDSzMLVq0Y3wzi77E2qj/0hq8qobrxt/Buxbx/4PWERhOX4XD7IqiX3JXEm+lgJr8zX8Or7vdfp3qnawD+a5r+HSjQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWrf4+l5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWrf4+l5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so61938465e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784700242; x=1785305042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DSkp41rRW1p6ikGl5y3iIJHVrGT+fyE8j3a8p7TH2S4=;
        b=NWrf4+l5T9mo26u97nU37JEo4dUU6urIWUEmP68pHJ5+yzY/6luPFp/8PoDoMRQ/fo
         migRQuBxvVo1McuBNxZbYXNL6zWH0po7csccSorq/+7ZKl8cZ2c7h4RHAb+SDv9KKeY9
         M54JmCdshHOxSqy+YVQ2fsRY035YqU67JMZDvbOD19QLMvlcBoZCvQAZ7xUAu279ZvcH
         LX0Wm3b8AQFm92iHuT7PXnNCI0XAhII8fw+ut30+Khs5kty4KW7HaDTCHriy7atNZlL+
         6HtR3leDhBLImLGVuTcnTGPrNLkxxkxesDIqTJ4mGcGWjDcOQXZAMjqedtuA6q9AbMJm
         MaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784700242; x=1785305042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSkp41rRW1p6ikGl5y3iIJHVrGT+fyE8j3a8p7TH2S4=;
        b=WZZoYAdMv43YwqBLQAKgwz/ecxZK+Car5NhQmQW6oNk1hZ/n1mkTPkBPeU2x5ymuer
         1q643gbdB3bgFk4USKcpxRelr+fNo3IGp62wxdXBDUjFmjVLj+OQ8TRleAItFgk+Uhfg
         OJAPYQE0reb46Vkz1nf+8S+MtOBKWDCM1TavTuooutjjfoq8TAZd5AuUlJOKsGxDiRkL
         0LRQQXp0HHC8OBhP2SAgdOC3T4XQvTV3eX6g1GEMcV1PYFHaB3Jk5YYx/sKLu5+OQ0hy
         PukTQIkC3HEt4Lb2nvQAZA/GrLK3CShu1k+IbXKCYgUlCuLECBDvXxJZy8dQmVWkp5K1
         rycA==
X-Gm-Message-State: AOJu0YyXM+1lA9I5FV15CBKz4h141be+0lFSKmVc9AkQu1BJbWfq1Zmu
	w+USrWKJ+SMtG/zqIEOebgUVIJJLA4RgMexu22uyDKwLS3+q/SZifcHh
X-Gm-Gg: AR+sD10xL9i3CHH95YChS/9dQvGst3iucIFcIkzixjERQY4TEVuiZZfw/Gp6rNgeWu8
	AhUI5RSTfXjRZ+t/aGPwhqeZDlwcnRM+iUeYWdvPczBfcae7PrfqjMV2ScqOpVss8a402zH+hH2
	xkD2oedJKxG72f9olJ2wpKog4HBwDiLAAEr/uNtPtJzf00r8uMM2EfgsFZZz6YZham/vgrsbJf3
	v+AbGGrXRhvfrc9KYPReJvUTz69EcXDypPJZCOZcEaze3Z/gGTXensXyRuzWieusRwiAClPEaFL
	306/z5qi+6IRgl+OPmK8rc77wOFCozeOW5m/1rJg05axotX7CDIX3VYVxDUPE44DA9JEf35UQi1
	geCKS/d2bd3ru2J0dC2oFD+HWeGhN0HOU6Ef2Isnfsvwe3iFUBEHJTKMSzwmXSwKRs1HDHZ3C+3
	ssXlczoeEeSgExb+Qt6A==
X-Received: by 2002:a05:600c:3b19:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-4954a3db76amr243838215e9.11.1784700241833;
        Tue, 21 Jul 2026 23:04:01 -0700 (PDT)
Received: from Rafael-PC ([179.223.114.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956d475e24sm9452865e9.0.2026.07.21.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:04:01 -0700 (PDT)
From: "Rafael B. Dias" <rafaelbttdias@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	security@kernel.org
Subject: [PATCH] perf/core: unaccount mmap pages from the charged owners
Date: Wed, 22 Jul 2026 03:03:53 -0300
Message-ID: <20260722060353.24-1-rafaelbttdias@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <CAFhB66oYbThmK59NiT1YwFZ4z=xkNxj9paga4EJW+mGFHa8f8A@mail.gmail.com>
References: <CAFhB66oYbThmK59NiT1YwFZ4z=xkNxj9paga4EJW+mGFHa8f8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf mmap accounting splits pages between user_struct::locked_vm and
mm_struct::pinned_vm. The first mapping that allocates a data ring stores
the charged user and numeric pinned amount in perf_buffer, but it does not
store the mm that received the pinned charge.

A perf event fd can be mapped by more than one process. If a different mm
owns the final VMA close, perf_mmap_unaccount() subtracts mmap_locked from
that final mm instead of the mm charged at allocation. Repeating this
across short-lived donor processes creates a negative pinned_vm balance
that can fund later perf mappings beyond RLIMIT_MEMLOCK.

AUX has the same last-VMA assumption. It also subtracts locked_vm from the
data ring's mmap_user even when a different user created the AUX mapping.

Retain references to the mm charged for the data ring and to the user and
mm charged for AUX. Use those stored owners during final unaccounting and
release the references after the counters are restored.

On a two-CPU 6.12.94 KASAN guest, an unprivileged receiver with
RLIMIT_MEMLOCK=0 accumulated 16,385 pages of cross-mm credit and mapped
65,540 KiB on the vulnerable kernel. The same reproducer returned EPERM
with this ownership fix. No KASAN report or warning occurred. The patch
also builds kernel/events/core.o with x86_64_defconfig on the same base.

Fixes: 26cb63ad11e0 ("perf: Fix perf mmap bugs")
Fixes: 36b3db03b474 ("perf/core: Fix the mlock accounting, again")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI-Codex:gpt-5.6-sol
Signed-off-by: Rafael B. Dias <rafaelbttdias@gmail.com>
---
 kernel/events/core.c     | 27 +++++++++++++++++++--------
 kernel/events/internal.h |  3 +++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..bf046e44de20 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7006,7 +7006,7 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 }
 
 static void perf_pmu_output_stop(struct perf_event *event);
-static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb);
+static void perf_mmap_unaccount(struct perf_buffer *rb);
 
 /*
  * A buffer can be mmap()ed multiple times; either directly through the same
@@ -7021,7 +7021,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	struct perf_event *event = vma->vm_file->private_data;
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
-	struct user_struct *mmap_user = rb->mmap_user;
 	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
@@ -7043,8 +7042,13 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked,
+				&rb->aux_mmap_user->locked_vm);
+		atomic64_sub(rb->aux_mmap_locked, &rb->aux_mmap_mm->pinned_vm);
+		free_uid(rb->aux_mmap_user);
+		mmdrop(rb->aux_mmap_mm);
+		rb->aux_mmap_user = NULL;
+		rb->aux_mmap_mm = NULL;
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
@@ -7116,7 +7120,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * Aside from that, this buffer is 'fully' detached and unmapped,
 	 * undo the VM accounting.
 	 */
-	perf_mmap_unaccount(vma, rb);
+	perf_mmap_unaccount(rb);
 
 out_put:
 	ring_buffer_put(rb); /* could be last */
@@ -7258,13 +7262,15 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
-static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb)
+static void perf_mmap_unaccount(struct perf_buffer *rb)
 {
 	struct user_struct *user = rb->mmap_user;
 
 	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
 			&user->locked_vm);
-	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
+	atomic64_sub(rb->mmap_locked, &rb->mmap_mm->pinned_vm);
+	mmdrop(rb->mmap_mm);
+	rb->mmap_mm = NULL;
 }
 
 static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
@@ -7330,6 +7336,8 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		return -ENOMEM;
 
 	rb->mmap_locked = extra;
+	rb->mmap_mm = vma->vm_mm;
+	mmgrab(rb->mmap_mm);
 
 	ring_buffer_attach(event, rb);
 
@@ -7411,6 +7419,9 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 
 		refcount_set(&rb->aux_mmap_count, 1);
 		rb->aux_mmap_locked = extra;
+		rb->aux_mmap_user = get_current_user();
+		rb->aux_mmap_mm = vma->vm_mm;
+		mmgrab(rb->aux_mmap_mm);
 	}
 
 	perf_mmap_account(vma, user_extra, extra);
@@ -7512,7 +7523,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			mapped = get_mapped(event, event_unmapped);
 			if (mapped)
 				mapped(event, vma->vm_mm);
-			perf_mmap_unaccount(vma, event->rb);
+			perf_mmap_unaccount(event->rb);
 			ring_buffer_attach(event, NULL);	/* drops last rb->refcount */
 			refcount_set(&event->mmap_count, 0);
 			return ret;
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index c03c4f2eea57..9bdf586735e8 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -38,6 +38,7 @@ struct perf_buffer {
 	refcount_t			mmap_count;
 	unsigned long			mmap_locked;
 	struct user_struct		*mmap_user;
+	struct mm_struct		*mmap_mm;
 
 	/* AUX area */
 	struct mutex			aux_mutex;
@@ -49,6 +50,8 @@ struct perf_buffer {
 	int				aux_overwrite;
 	refcount_t			aux_mmap_count;
 	unsigned long			aux_mmap_locked;
+	struct user_struct		*aux_mmap_user;
+	struct mm_struct		*aux_mmap_mm;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
 	int				aux_in_sampling;
