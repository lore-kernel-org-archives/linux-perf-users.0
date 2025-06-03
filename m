Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7C2236F8;
	Tue,  3 Jun 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939636; cv=none; b=W4beeeSL7WaJqy7exCbFHVGFrb/tHR5mS638vlrWzHVBYmOtxjXoU1bhoDE+l9uBOhqqg1qqjHVulNaWiHjQtnFD1PKhV7CA8l60pAiks2QITjI8WkR7V1h/5QSz5ZR4yyDNdab0NaSLAsCPvsyC3Dw6okyaCG52TIWkFULCnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939636; c=relaxed/simple;
	bh=jWw3s1a/AY/y1xwQIxxaCgV83PdUz2ciIda4uyzidXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFOVUbZMVMQA2odzWPB3KJd1f/aRD8QmUqNik5X6q1ubDin5orFFNUun/tJEStKanGeEBnPRN947i5iNsYH/ek8fkE1JJrFcSYJkAj6B8OGsAuj01PFrH29dlz+kS1J/A6USKEjO62iOc4OMLLfj+HUOkrL2RxSN0xN3QfJETtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JCQGZjze; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JCQGZjze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dD
	eyhuFFoQ6/K4lWQy4ZVtm1IyFV5jCQTLNwpE/GG9Q=; b=JCQGZjzePj0jp5Xa0n
	ico3hqH9ZBTeITHXcyHIxUHZn2YONjhOmLYD7P1ffEXen/GE4fm8SQGKU84fCVAS
	3sRChrT6hWoEQAWo/JhwYpD5zgu5eyAzyC8NOkSGGDgs9ZfvDn/G8sueHW1FUGYc
	1Ra9VAHpbMYJ+UKPcsVnsluLI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXr+lBsz5oOoiAFw--.27977S4;
	Tue, 03 Jun 2025 16:33:17 +0800 (CST)
From: David Wang <00107082@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mingo@kernel.org,
	yeoreum.yun@arm.com,
	leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH v2] perf/core: restore __perf_remove_from_context when DETACH_EXIT not set
Date: Tue,  3 Jun 2025 16:33:04 +0800
Message-Id: <20250603083304.34132-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250603032651.3988-1-00107082@163.com>
References: <20250603032651.3988-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXr+lBsz5oOoiAFw--.27977S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4ftw15uFy3Xw4kAF1DWrg_yoW5JF4kpw
	s7CrnxK3y0q34qvw4ayr1kWwn8Cw4kJFZ0q3WDKw13XFWrXrW5XF1xKFW3Zrs0yr92qa47
	tw4093ZrW3yqka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREoGPUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gBhqmg+n-RC7QAJsC

commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting
bug at task exit") made changes to __perf_remove_from_context() to
coordinate its changes with perf_event_exit_event(), but the change are
unconditional, it impacts callpaths to __perf_remove_from_context()
other than from perf_event_exit_event(). One of the impact is to cgroup,
which is not properly handled and would cause kernel panic with high
probalibity during reboot on some system[1].

To confine the side effects, make the changes to
__perf_remove_from_context() conditional, restore to its previous state
except when DETACH_EXIT is set.

Closes: https://lore.kernel.org/lkml/20250601173603.3920-1-00107082@163.com/ [1]
Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: David Wang <00107082@163.com>
---
Changes:
Address yeoreum.yun@arm.com's concern about missing cgroup event.
---
 kernel/events/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95e703891b24..e2c0f34b0789 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2466,7 +2466,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
-	enum perf_event_state state = PERF_EVENT_STATE_OFF;
+	enum perf_event_state exit_state = PERF_EVENT_STATE_EXIT;
 	unsigned long flags = (unsigned long)info;
 
 	ctx_time_update(cpuctx, ctx);
@@ -2475,19 +2475,20 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_EXIT)
-		state = PERF_EVENT_STATE_EXIT;
 	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
-		state = PERF_EVENT_STATE_DEAD;
+		exit_state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
-	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
+	if (flags & DETACH_EXIT)
+		perf_event_set_state(event, min(event->state, exit_state));
+	if (flags & DETACH_DEAD)
+		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
-- 
2.39.2

