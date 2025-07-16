Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF314A09C;
	Wed, 16 Jul 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673917; cv=none; b=V6bo71slNRV4LoRUkrKWZs/CO2u/rv5sNSRBm/2yIl7Tu3rM49Lq6WHYlqypu9SSsapVNOg7P4izQLUQKK2r3bacutLenQx+3Ky5OoCYG9ufw4qGijLMH7AfYU3YGTmbd+YptBTaj3IEJji4LWOdUmrfEu9yVvW4ypvwYdCl6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673917; c=relaxed/simple;
	bh=hyGCvrbtw2qdIGIIhqoYr9iBtmwCIV5oIyf682Dj/kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngyHKxEYs8skNLgjYKY3AkgW/b6wEdgsFHKoJDkUSmHcB5k4UjHdPvT+hCqAB5Sw/P27n1cEkzeTjS/ZPwK2qkVaiXPmi4SjLMAZdwQJMEGITgN/RI9OApxoGfCoboB/2JPDTEQAkx04P3zkRIJG7Fq/gwYPehINuw2F/aEjlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=A29ps5it; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="A29ps5it"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=3vytiuZjE/mNXoVykFb8Ntwh9jcp42Gui1jhUZYM32c=; b=A29ps5itkp7tMOka
	KQrPFZ0Tc5o1ixpBHyUnm7d3A0V3Kf6TZes9Y/iXCfNb0SmMUZCRbdhxoScrngTqmatJJI5p6IibN
	WE6HTNBm91Wy3GtipxCqZZPbqJTcmPz33MPFY1YAYUcSKiBFTeDQpq7JUtodCxlOlOcIx9KQ5Karn
	gEgXRKocCuADuyipPF0o8MJDvJvvlWDCDUvw5bCphm06d8xFy87fiNuzEQyYqu31UhkyHDLLwFwh4
	jXFh0UjeGOJVenJXDFIw9hwz2eE5D+gO91cRAWmPd8BlbUMV5aF7529t0bSadEVGIniVyaSNMh+qk
	WdqOJXnvMn5jdR7Zsg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uc2Xp-00GQnU-3A;
	Wed, 16 Jul 2025 13:51:38 +0000
From: linux@treblig.org
To: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org
Cc: alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf core: Remove perf_event_attrs and perf_event_refresh
Date: Wed, 16 Jul 2025 14:51:37 +0100
Message-ID: <20250716135137.247266-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
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
  This was originally sent as part of a set with a load of tools/perf
  cleanups, Ian pointed out it needed to be separate.

 include/linux/perf_event.h | 10 ----------
 kernel/events/core.c       | 24 ------------------------
 2 files changed, 34 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683..4cecd5122404 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1224,7 +1224,6 @@ extern void perf_event_free_task(struct task_struct *task);
 extern void perf_event_delayed_put(struct task_struct *task);
 extern struct file *perf_event_get(unsigned int fd);
 extern const struct perf_event *perf_get_event(struct file *file);
-extern const struct perf_event_attr *perf_event_attrs(struct perf_event *event);
 extern void perf_event_print_debug(void);
 extern void perf_pmu_disable(struct pmu *pmu);
 extern void perf_pmu_enable(struct pmu *pmu);
@@ -1235,7 +1234,6 @@ extern int perf_event_task_enable(void);
 
 extern void perf_pmu_resched(struct pmu *pmu);
 
-extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
 
@@ -1945,10 +1943,6 @@ static inline const struct perf_event *perf_get_event(struct file *file)
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
@@ -1957,10 +1951,6 @@ static inline int perf_event_read_local(struct perf_event *event, u64 *value,
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
index 22fdf0c187cd..4b84e808eef7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3340,22 +3340,6 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
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
@@ -14196,14 +14180,6 @@ const struct perf_event *perf_get_event(struct file *file)
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
 int perf_allow_kernel(void)
 {
 	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-- 
2.50.1

