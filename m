Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBD1459F6;
	Wed,  5 Mar 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141927; cv=none; b=OO6V86JDSb7KgV3Ir2jNt/seM/zdwCZTCF9bw1xzOCicLJ6QWV/i/xb79cIrg4sViR3g4txRuCRk1chdE3Dy8avt7hL0YWZj5i+/zr+bjv/6x/Y4oQmsc7ELXQq/JHaNyVPQ4SKQ1blBrcpA5/4JZiTwHxI/Yx37FoOolZCM0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141927; c=relaxed/simple;
	bh=husec6zC4tUCCXa7D4qH5d0n86OjErX8zVMGoZSzfh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R35hGLbK8zcNwOgyRd0bGxXjuDMMPEwqD23JR4nEhJsc6y3l10DUaXbpS9icWvtV/L08ShJkNVqlY8kD4qxu6kJDpUU7V2BAhb3nvWEuYcX7t5/2N3SAipzfnzsMxKUwvuVa8Mif5FuIrfgj5+mo5FPOtsW89e7cy0iytcVEMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=l19vOjYX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="l19vOjYX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=IJAI6KslVQAVb2DdkL1bXABJp7NmDgP1UiInuoXkB2w=; b=l19vOjYXGlgBq0Y0
	jpT5g/LrFyLCejZdOvCVZ6gj2AR93VkUmfOtsAQ97ynBAO6RlR7T/hPGLxTJuX4d6a5ZZxk+xpu/2
	Lghqetcss8RaR+8wOvjN3Yz7ULpEXnv8uZg+5B6owi5PO1qWJEMtNPMB4IRGsfEa2eiIQt9dskx8K
	9SceZS/Yly8WZ4vP70/QMnNjE4v6xs5pDpsdDD7ygyJDknAIPFOTNy4k9UFxBG2Qywr4cRHpj55mC
	FBkHJMwAsLVnS7gUl/QCbZF0iWpHkC9SXv1RpdRmQ1wSxQG1pZD+iuGX3P3dhYehOZTvl2bS4SEoC
	gSZPQbDKvG6rV17teQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXj-002ic7-1Q;
	Wed, 05 Mar 2025 02:31:31 +0000
From: linux@treblig.org
To: irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/6] perf core: Remove perf_event_attrs and perf_event_refresh
Date: Wed,  5 Mar 2025 02:31:15 +0000
Message-ID: <20250305023120.155420-2-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
References: <20250305023120.155420-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

perf_event_refresh() has been unused since the 2015
commit f63a8daa5812 ("perf: Fix event->ctx locking")

perf_event_attrs() has been unused since the 2017
commit f91840a32dee ("perf, bpf: Add BPF support to all perf_event types")
(Note the _ prefix version is still used)

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/perf_event.h | 10 ----------
 kernel/events/core.c       | 24 ------------------------
 2 files changed, 34 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..3ed023e63d6a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1136,7 +1136,6 @@ extern void perf_event_free_task(struct task_struct *task);
 extern void perf_event_delayed_put(struct task_struct *task);
 extern struct file *perf_event_get(unsigned int fd);
 extern const struct perf_event *perf_get_event(struct file *file);
-extern const struct perf_event_attr *perf_event_attrs(struct perf_event *event);
 extern void perf_event_print_debug(void);
 extern void perf_pmu_disable(struct pmu *pmu);
 extern void perf_pmu_enable(struct pmu *pmu);
@@ -1147,7 +1146,6 @@ extern int perf_event_task_enable(void);
 
 extern void perf_pmu_resched(struct pmu *pmu);
 
-extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
 extern struct perf_event *
@@ -1841,10 +1839,6 @@ static inline const struct perf_event *perf_get_event(struct file *file)
 {
 	return ERR_PTR(-EINVAL);
 }
-static inline const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
-{
-	return ERR_PTR(-EINVAL);
-}
 static inline int perf_event_read_local(struct perf_event *event, u64 *value,
 					u64 *enabled, u64 *running)
 {
@@ -1853,10 +1847,6 @@ static inline int perf_event_read_local(struct perf_event *event, u64 *value,
 static inline void perf_event_print_debug(void)				{ }
 static inline int perf_event_task_disable(void)				{ return -EINVAL; }
 static inline int perf_event_task_enable(void)				{ return -EINVAL; }
-static inline int perf_event_refresh(struct perf_event *event, int refresh)
-{
-	return -EINVAL;
-}
 
 static inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..c3d9ad84bb52 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3224,22 +3224,6 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
 	return 0;
 }
 
-/*
- * See perf_event_disable()
- */
-int perf_event_refresh(struct perf_event *event, int refresh)
-{
-	struct perf_event_context *ctx;
-	int ret;
-
-	ctx = perf_event_ctx_lock(event);
-	ret = _perf_event_refresh(event, refresh);
-	perf_event_ctx_unlock(event, ctx);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(perf_event_refresh);
-
 static int perf_event_modify_breakpoint(struct perf_event *bp,
 					 struct perf_event_attr *attr)
 {
@@ -13639,14 +13623,6 @@ const struct perf_event *perf_get_event(struct file *file)
 	return file->private_data;
 }
 
-const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
-{
-	if (!event)
-		return ERR_PTR(-EINVAL);
-
-	return &event->attr;
-}
-
 int perf_allow_kernel(struct perf_event_attr *attr)
 {
 	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-- 
2.48.1

