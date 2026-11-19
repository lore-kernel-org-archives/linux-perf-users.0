Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114357;
	b=v8iIq97Uy4IUyNQI0QS+X0MrQNWf50R07GVoQY9mJne4WfNsbyLQhDrVzvo7LgNsIv+m
	 jol90SxJJLm37Sdb9qUa6uw+HugnQ2QwoKOQqlX92un8ugkfRB1YXQPuJnZi6mgP2C7th
	 kKWSmCJqm5bskPX7ULVYOYgQ85ei3sLQAsYbg5W35SXFGCDuYRx6uM+u+0dFiysPBlSv/
	 uJbKMI/gocjcC41cnhz+HtKuHcigk+v/fG6IWZp9QgGuPXG+CUfqV/YWID9X4P6NTy/+W
	 TIRP06MjFYSFztfDJgZqlPI5XtsGNkQl3hN4j2ey51gEntErfaz0QfsANcmJXFaKlJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RoqvmCK2qkOodjdsXGnbvnsvP/GHWBE0XmbngxrSrDA=;
	b=muVnNxpZyZx0vr48zcAjp+jlnzloFfGOAN0NKCQBe6cNiG/VnqI/0nnaKpSh4hDCJSE8
	 cagzc6IoDr+iyipN6TG/GcgIHE4hhaw15HenwLGF2XJBHVeqRa1wm62sB2zZGsW9Ir2pZ
	 ZHL9lZw5cp7iP/6udQJjhVuqRC7pwu5h1QvOwKeLYIaZJEvinAUkq74n6x7fEbFPOz5oB
	 TVFFyaPC+c48DAoKSX/V44sU/TnM22miyMUZ4LIImKylrsV9p6t7/0g5J+0W6A6Fy+AGM
	 3gMXa65SJ9z0UFZad+YPMW74o3oSZBfjZqL3p1hyH3DMRlxBJsSSzS4uQ1GnBw5PehA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXp1GWxB;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FA60A3807
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB9FA60A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXp1GWxB
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-55bf11583d9so12532b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114356; x=1795719156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoqvmCK2qkOodjdsXGnbvnsvP/GHWBE0XmbngxrSrDA=;
        b=LXp1GWxBz4BQO+5ChJ5iHi+LMVxnGCibmcW+OAbXSoYGVn+oqoMBmxNuesmOAsGC6o
         18laB4HO9D5oHbMOe6+LNgTo5RiHHS88CIaT7wmgpk8tmarTt3/AD88WF/uu703//hOs
         gJBEjrnoNQuBKJEVKzkZqEUa+x04iA2KWgUpr0W44XNOPwOGnF3X1cK2DnmDm3KsETjn
         wpO7CnL3ijvrZBLM/IN8rnJFb4lRdyZNx6Yw5U04MOgrE3/DzwLVTOCYdwih3qImrCDi
         N9FiXWN7AQmU+y+SKoTuDCmDRp4RZyGqOcNXpk/nklAFHIPJ7jz22gZhjvqmCoqze6cK
         L1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114356; x=1795719156;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoqvmCK2qkOodjdsXGnbvnsvP/GHWBE0XmbngxrSrDA=;
        b=w3VGBtaT+7dqSlizNPVThmGxWOYZAOPO8xw9TKTIKeIVZD37s8xwEkjc2hzuTUkqzP
         LOaM1HWXJz6BB5vREZsuH/2ZyHiSpkuDXq+ORaLrrppY+iQFy54sFWWicq9LZe7aQPJx
         Oxe1ihUgiFVchldeoGyG4GpqlADDKN2m5zdeCF+UmUqSv2ugfglyfiWK+Ga6mtrdYKHB
         kdZtFacPjWTJn2pr1Nka9dLBqG0xs4vevR8JNDrlQ33tUSS8RRdeFL/Ps+99lvKGou0z
         o0SsX5qv6Ot0SkwN7NnR/+r/c/3pgHzNaQiJdYFdwRlSfgfjVwVfFHU+Q+KBYd9/cv6/
         B/oA==
X-Forwarded-Encrypted: i=1; AL+hErGwr+xvM0xM4CbZuWO/r8sp3WzZFQW9zrqYnrKIgw9hn3ovYYibItMXlQWamEfxoqvg0WGUWM8A0yG37caWkvra@vger.kernel.org
X-Gm-Message-State: APuU4Z81PIsuiVgFIui9kGxxmQor3EHMfTikghPcTPV12U3DWn0zt3YL
	+rqajBOGU6FxWpLuJCS6etTL4j6V1MW/g3+lV9HHnrbsjQQ9mGnFhvrl82IWNYDr+q0jukMa032
	feRLnv3QYFPR+wWcxQcNG7saYdw==
X-Received: from ilen3.prod.google.com ([2002:a05:6e02:13a3:b0:524:d8ac:6887])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6b8e:b0:521:561a:8e8c with SMTP id 5614622812f47-5797d6add74mr1519937b6e.33.1795114355656;
 Thu, 19 Nov 2026 10:52:35 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:02 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-21-coltonlewis@google.com>
Subject: [PATCH v10 20/33] perf/core: Prioritize kernel-owned pinned events
 when scheduling groups
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When scheduling event groups in visit_groups_merge(), pinned and
flexible groups are ordered by group_index (creation order). Normally,
kernel-owned pinned events such as the hardlockup NMI watchdog are
created at boot with group_index 0 and are scheduled ahead of userspace
events.

However, if the NMI watchdog is disabled and re-enabled at runtime
after a userspace pinned per-CPU event is already active, the
watchdog's group_index is larger than the userspace event's
group_index. When hardware counters are constrained (for example, when
PMU partitioning reserves counters for a guest and leaves only one
general-purpose counter for the host), the userspace pinned event
claims the remaining counter first and merge_sched_in() transitions the
kernel watchdog event into PERF_EVENT_STATE_ERROR.

Order pinned kernel-owned events (is_pinned_kernel_event()) ahead of
userspace pinned events in perf_event_groups_cmp() and
perf_less_group_idx() while leaving flexible groups ordered by
group_index for normal round-robin rotation.

Suggested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 kernel/events/core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dbc42ded5f698..6b82029b8ebc5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -237,11 +237,16 @@ class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
 
 #define TASK_TOMBSTONE ((void *)-1L)
 
-static bool is_kernel_event(struct perf_event *event)
+static bool is_kernel_event(const struct perf_event *event)
 {
 	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
 }
 
+static bool is_pinned_kernel_event(const struct perf_event *event)
+{
+	return event->attr.pinned && is_kernel_event(event);
+}
+
 static DEFINE_PER_CPU(struct perf_cpu_context, perf_cpu_context);
 
 struct perf_event_context *perf_cpu_task_ctx(void)
@@ -1781,7 +1786,8 @@ static inline struct cgroup *event_cgroup(const struct perf_event *event)
  */
 static __always_inline int
 perf_event_groups_cmp(const int left_cpu, const struct pmu *left_pmu,
-		      const struct cgroup *left_cgroup, const u64 left_group_index,
+		      const struct cgroup *left_cgroup, const bool left_kernel,
+		      const u64 left_group_index,
 		      const struct perf_event *right)
 {
 	if (left_cpu < right->cpu)
@@ -1824,6 +1830,9 @@ perf_event_groups_cmp(const int left_cpu, const struct pmu *left_pmu,
 	}
 #endif
 
+	if (left_kernel != is_pinned_kernel_event(right))
+		return left_kernel ? -1 : 1;
+
 	if (left_group_index < right->group_index)
 		return -1;
 	if (left_group_index > right->group_index)
@@ -1839,7 +1848,8 @@ static inline bool __group_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct perf_event *e = __node_2_pe(a);
 	return perf_event_groups_cmp(e->cpu, e->pmu_ctx->pmu, event_cgroup(e),
-				     e->group_index, __node_2_pe(b)) < 0;
+				     is_pinned_kernel_event(e), e->group_index,
+				     __node_2_pe(b)) < 0;
 }
 
 struct __group_key {
@@ -1853,8 +1863,9 @@ static inline int __group_cmp(const void *key, const struct rb_node *node)
 	const struct __group_key *a = key;
 	const struct perf_event *b = __node_2_pe(node);
 
-	/* partial/subtree match: @cpu, @pmu, @cgroup; ignore: @group_index */
-	return perf_event_groups_cmp(a->cpu, a->pmu, a->cgroup, b->group_index, b);
+	/* partial/subtree match: @cpu, @pmu, @cgroup; ignore: @kernel, @group_index */
+	return perf_event_groups_cmp(a->cpu, a->pmu, a->cgroup,
+				     is_pinned_kernel_event(b), b->group_index, b);
 }
 
 static inline int
@@ -1863,9 +1874,9 @@ __group_cmp_ignore_cgroup(const void *key, const struct rb_node *node)
 	const struct __group_key *a = key;
 	const struct perf_event *b = __node_2_pe(node);
 
-	/* partial/subtree match: @cpu, @pmu, ignore: @cgroup, @group_index */
+	/* partial/subtree match: @cpu, @pmu, ignore: @cgroup, @kernel, @group_index */
 	return perf_event_groups_cmp(a->cpu, a->pmu, event_cgroup(b),
-				     b->group_index, b);
+				     is_pinned_kernel_event(b), b->group_index, b);
 }
 
 /*
@@ -4024,6 +4035,9 @@ static bool perf_less_group_idx(const void *l, const void *r, void __always_unus
 	const struct perf_event *le = *(const struct perf_event **)l;
 	const struct perf_event *re = *(const struct perf_event **)r;
 
+	if (is_pinned_kernel_event(le) != is_pinned_kernel_event(re))
+		return is_pinned_kernel_event(le);
+
 	return le->group_index < re->group_index;
 }
 
-- 
2.56.1.708.g77570a6a1d-goog

