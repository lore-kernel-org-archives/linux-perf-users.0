Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A883AB285
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292569; cv=none; b=GeCdkSodoZgBPEr1R1eQVQNUJePedVAgsJGpDrXQLcowU5IZJbO8X3KC05BZGCTwJc6kmp505iEHxtO9nG63y8YR23qbU5OeLQKbe01/izRrbso4bj0CWglTRqgktYhkHdei/Vu+J/Yg+tiwEluWpEbfVT950qKucBYaZ6aV7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292569; c=relaxed/simple;
	bh=Xhl4Zk+Z9G/hrZrAOpTeVT4LR9g0qIFXYGndVpodJRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/mlZsSXrHXlA/t4T8vbBj8jffAGdVnBvjieoHsE2emM74ymJcU/exowPA/7N4s3ABBCHF77F02DyX7HC54K6lU7DVGbEoM0/FppWE8/E2Va22DcMeLlDlDizrGDS1Tny11iSF7rYhJcCyXCQn78MMt66ZLcS715FAU2WpNE62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5Yrhj+E; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5Yrhj+E"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7e6db540d17so2441202a34.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292563; x=1781897363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld//V/f0QfaYRycD8rujhv5xi8e1YzlAhgupiZPHoEU=;
        b=v5Yrhj+E5Nei9NwdmdVLZ+xslN8rqCstdYcm/Io+RX7zrp1AkSF+/8Zwc4V3saNhnk
         i1fBRDtS0ZdN+9w5nbASUTO/4r/cniTYn/GFEsaapHxRGin30HkDRG/KB8meamJ7vXdM
         Tm5RqkQ8aRKxyjC+sjxz6F479Rlmk15uH+Kl5AyW/IHGyHvknW1AZVUEUckMq6BCoXyZ
         awR/JB3/QMNk/4nXpSqStAOV38h9MN+74o6nzfe5aBJGjuDg4gXa9BFJxJRnNW7QFwLk
         2Y6/XgVvhhx5sUiSWomh6H+UFAI3E6imAqlgs/8Q2/lpRjHTMhbxy1Uidv9irBb8W/7Y
         nRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292563; x=1781897363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld//V/f0QfaYRycD8rujhv5xi8e1YzlAhgupiZPHoEU=;
        b=fyaw9sC9rRF2uljNQ6GkwntrGo7ZeKmHbIrJlvM0lhBXD8kkoA6LvGxZFWcNKncc/J
         YehywvxhGFjRz7hM3+V1PeOWxaAkb/wdvICaRLw3rMaXm/wr5TvgA48/ckViR44W1ri8
         0ZRZbxHpdrgObAtenRljp2Cfo3t5eUNh8CPqQL4a6noHvUNf1nu/bHbPrctCt5r0Ttzb
         sujHDLSecGndgnWv9wir/hEslDYEsnHFccWV3LuKjanxZ5frWRjqtBjxd20+67xQ0rv6
         hY1IhbI2B/Yvlxfw1XbDDH5XSp7uQVpxODZwzvmoKSrwyH8qjdJ08ghAP1G5DUr50t+L
         OGBg==
X-Forwarded-Encrypted: i=1; AFNElJ8eCik+u3fxL7i7MSLAeXU8a5cbJ37vVEMJBqaIZ0T1kKq4O2oG8WSCPETASrCATbH3yhWUR3A7yKA3rcyOBjko@vger.kernel.org
X-Gm-Message-State: AOJu0YxorZ/cbyU8VvFPcqaJAyZ4rYlTYRXj/0rtz+ezBWrxN+dITan2
	i52W5aUnEoYWBNejznIUo3IpKRJQk5em3agOJL22IHP4xwmHptC/iBiDptjpy3WpuAavm68UQP1
	9hylJkSr02yrrqveGLoi14MByvw==
X-Received: from jaan16-n2.prod.google.com ([2002:a05:6638:aad0:20b0:5e2:7885:115c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3020:b0:485:1173:2e4b with SMTP id 5614622812f47-48741c5f737mr622385b6e.37.1781292562500;
 Fri, 12 Jun 2026 12:29:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:01 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-14-coltonlewis@google.com>
Subject: [PATCH 13/21] perf: Add perf_pmu_resched_update()
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

To modify PMU guest counter reservations dynamically, we need to
update the available counters safely.

Introduce perf_pmu_resched_update() to allow updating the PMU struct
in between scheduling perf events out and scheduling them back in
again. It takes a callback operation to call in between schedule out
and schedule in. This accomplishes the goal with minimal perf API
expansion.

Refactor ctx_resched call the callback in the right place.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 31 ++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea5..a08db3ee38b10 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1242,6 +1242,9 @@ extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
 
 extern void perf_pmu_resched(struct pmu *pmu);
+extern void perf_pmu_resched_update(struct pmu *pmu,
+				    void (*update)(struct pmu *, void *),
+				    void *data);
 
 extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944e..ad2fc080bacac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2983,9 +2983,10 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
  */
-static void ctx_resched(struct perf_cpu_context *cpuctx,
-			struct perf_event_context *task_ctx,
-			struct pmu *pmu, enum event_type_t event_type)
+static void __ctx_resched(struct perf_cpu_context *cpuctx,
+			  struct perf_event_context *task_ctx,
+			  struct pmu *pmu, enum event_type_t event_type,
+			  void (*update)(struct pmu *, void *), void *data)
 {
 	bool cpu_event = !!(event_type & EVENT_CPU);
 	struct perf_event_pmu_context *epc;
@@ -3021,6 +3022,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (event_type & EVENT_PINNED)
 		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
+	if (update)
+		update(pmu, data);
+
 	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
 
 	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
@@ -3032,6 +3036,27 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	}
 }
 
+static void ctx_resched(struct perf_cpu_context *cpuctx,
+			struct perf_event_context *task_ctx,
+			struct pmu *pmu, enum event_type_t event_type)
+{
+	__ctx_resched(cpuctx, task_ctx, pmu, event_type, NULL, NULL);
+}
+
+void perf_pmu_resched_update(struct pmu *pmu, void (*update)(struct pmu *, void *), void *data)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	perf_ctx_lock(cpuctx, task_ctx);
+	__ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU, update, data);
+	perf_ctx_unlock(cpuctx, task_ctx);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(perf_pmu_resched_update);
+
 void perf_pmu_resched(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-- 
2.54.0.1136.gdb2ca164c4-goog

