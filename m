Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619B13CF98
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488372; cv=none; b=adD/6JYAJdpPK+HSRsof1RzcjO3nxBv3Dop/cehNp17/ybXB8iiwweh0FFtoPzRtsDjkOqJ2m9dS296iU0Nh9m+WcvkYVWRTYIync65/irR4Vn/3SJyTgA62aYEEq2XTuPk8fbO4fXajRmf5JEN1TB4kIE3+DtYm/9UK7TN2DHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488372; c=relaxed/simple;
	bh=o5hEtqrZtZQ+GSVgDLW9bBqacTp65v2v47VvU5C1Xzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=anLncitwog6g53Q30ltfqNJKJyj0UhaNRkjUE4A9NbgOQyr0ZpjRPkYYZxDlz0ARur4LESqhZr/o4u+hbJkle4/rRbek/SXDV6T4PtA+sAK1HstV9G0fhFHRUVUlx+t885XtiahlCQt7HWFO5PbEEyKhw4dadk6dKy2dOMmme20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkN+rIti; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkN+rIti"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664fc7c4e51so123555317b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488370; x=1723093170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jpGgyT7HBtCD2+qsQsy2UlEb4EuF6pmeTb/cXO1/UxM=;
        b=ZkN+rIti2elF487h8bEnad9m4z9wexBo93WdgLwhKl2TNafiFo6ghxdilnsbQcvqAp
         JglNh3a25oOQpgCd3/swOmspLdDb2LdLqUdtcsk+5U4r22gkkOrn1v8VlUtGMNQzVgKt
         hhocWxqeto7hBUNMx6n5bSDQ2l7rkCs2mmaFAqHuBr4zmXqftdHFVlptZ5Inf9mp8LB3
         8/VSYQtoHCzS+0AtPm26qkPbXM9qPx1VKn3F9Hvyl3+hibJZja2HeyriIQhdXNw1bYaV
         9CF393DOUPcolSCA5Y0uvXiB7LxBfjWuEsTDKif0x/HWiNNa8eCykvJUBNJHT1TTmBZx
         uq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488370; x=1723093170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpGgyT7HBtCD2+qsQsy2UlEb4EuF6pmeTb/cXO1/UxM=;
        b=j2DYPKpoPKYG/cE9KHUg8zuEMyb0qOE1mBzzrtWd/n2udTX377wFBpuJG/eSr8TG4E
         pVVCIispn6lxgX8QKC+9I5Ybke/iY9wuwyh96sgN4rUjg+Uso/wz7x8M+gv8ZcX6kJlK
         9xem/HpYm6MGQs2+A7yzzr5TcO/aNzl7+PnZ3VRyfvL9HXevdgbrvNkoRtUPNp4pQKIW
         D59O3weIym30oL6jM2GXQl/m7vOeAMUnPOVZtMG1SpDLwoaGxWE8Yr/LcH69J7k4Y5Is
         vzphgLbnVaUHmsRTP0DZDL2527YwWQOcUFNVeBerM94exGL+Emoo9p41PTplwxyi/3Pp
         vCcA==
X-Forwarded-Encrypted: i=1; AJvYcCW2NFFEydDBCYVzgyAjwW7PGzSsj0kHoEaP65iANdQbWwm7lME2yWeltzo6gF9cqdDa9Vkq/QS9HDzMeixzUXXS6dZTa1Wpuu/SmWt71+/L0w==
X-Gm-Message-State: AOJu0YwgoLkymLd7fdOwSobG+5fZSnXnG9yTUn+n1MSj58tSjLficIIY
	9VoUUQnGlTHRmKewz1vjNuwTFdy9p8owkrzdEYbChybA+GD5oFvbnUmT0VmTa2pRJvXA/r1/KP0
	VchmRHA==
X-Google-Smtp-Source: AGHT+IE36C0k9NJpJpbVp5XW9qqNl7CG6TduA9fccCY/71DaZJCFFGgQWLIivQyA9lnhS41mowX8N3sFiVCM
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:18c5:b0:e05:faf5:a19e with SMTP id
 3f1490d57ef6-e0bcd2553f4mr2378276.6.1722488369672; Wed, 31 Jul 2024 21:59:29
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:19 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-11-mizhang@google.com>
Subject: [RFC PATCH v3 10/58] perf: Add generic exclude_guest support
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

Only KVM knows the exact time when a guest is entering/exiting. Expose
two interfaces to KVM to switch the ownership of the PMU resources.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/perf_event.h |  4 +++
 kernel/events/core.c       | 54 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 81a5f8399cb8..75773f9890cc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1738,6 +1738,8 @@ extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
 int perf_get_mediated_pmu(void);
 void perf_put_mediated_pmu(void);
+void perf_guest_enter(void);
+void perf_guest_exit(void);
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
@@ -1831,6 +1833,8 @@ static inline int perf_get_mediated_pmu(void)
 }
 
 static inline void perf_put_mediated_pmu(void)			{ }
+static inline void perf_guest_enter(void)			{ }
+static inline void perf_guest_exit(void)			{ }
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57648736e43e..57ff737b922b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5941,6 +5941,60 @@ void perf_put_mediated_pmu(void)
 }
 EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
 
+/* When entering a guest, schedule out all exclude_guest events. */
+void perf_guest_enter(void)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+
+	lockdep_assert_irqs_disabled();
+
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+
+	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
+		goto unlock;
+
+	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
+	ctx_sched_out(&cpuctx->ctx, EVENT_GUEST);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
+	if (cpuctx->task_ctx) {
+		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
+		task_ctx_sched_out(cpuctx->task_ctx, EVENT_GUEST);
+		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
+	}
+
+	__this_cpu_write(perf_in_guest, true);
+
+unlock:
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+}
+EXPORT_SYMBOL_GPL(perf_guest_enter);
+
+void perf_guest_exit(void)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+
+	lockdep_assert_irqs_disabled();
+
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+
+	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
+		goto unlock;
+
+	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
+	ctx_sched_in(&cpuctx->ctx, EVENT_GUEST);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
+	if (cpuctx->task_ctx) {
+		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
+		ctx_sched_in(cpuctx->task_ctx, EVENT_GUEST);
+		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
+	}
+
+	__this_cpu_write(perf_in_guest, false);
+unlock:
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+}
+EXPORT_SYMBOL_GPL(perf_guest_exit);
+
 /*
  * Holding the top-level event's child_mutex means that any
  * descendant process that has inherited this event will block
-- 
2.46.0.rc1.232.g9752f9e123-goog

