Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D13211;
	Tue,  3 Jun 2025 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748921261; cv=none; b=Q8DeUaZpKldM/eHW1XdekYsDpVLzqRhHCLs7QJ4nY8iSYiL3bhJKKLMW+ziAH+ttZ1FBWFNu6yMsFbM5rBTL2TqWlX4IMbMPE4oiOCvEA+th1vspVDNvrtDaPQUmIz26W0QiOvr22yuYxl0kVjhBEfuPHhYKe1xnNX+cNmCagh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748921261; c=relaxed/simple;
	bh=qoOBDlUPF7WsnUb9ArxRohE398Vyf46FNJjRMK9clAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrpwvjHhkRxURy+3+hMp6GiGv7sYTTQ8F2Zc1utO99LMEvPun2nvKq5WO8AIcKJRmPeXPB8bd2MqsIUBYE3agwhXuie1zMzo88M3ad+X9RMEArYsk3Yy/ivfU9XAJXPQfPp7ZMum20NCnzzr1Ei8OYxnUOo0sd4PnsDjIhwibpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JSzHk9X5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JSzHk9X5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oQ
	j/8FWq0vvPTv9DKxvy8u85jrpI3Px81QRZ6pou8UU=; b=JSzHk9X5+HM8QrBYIQ
	behw/C08422zihPrdqAWEeym4xmZ8K2Q13wHhkWYSAoQWEPmLGuBk23GFuUhEvcp
	Qrl1EUE0X1SQUW1vopbD5pLUPkbIbK58JUJqabroSc6EXN+hbOgLkn23vGSVpidQ
	6Nr2Xu3cuWwEmoYsZIHWJvF68=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCX70x8az5o6vFIGA--.18825S4;
	Tue, 03 Jun 2025 11:27:09 +0800 (CST)
From: David Wang <00107082@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mingo@kernel.org,
	yeoreum.yun@arm.com
Cc: leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] perf/core: restore __perf_remove_from_context when DETACH_EXIT not set
Date: Tue,  3 Jun 2025 11:26:51 +0800
Message-Id: <20250603032651.3988-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX70x8az5o6vFIGA--.18825S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4ftw15uFy3Xw4kAF1DWrg_yoW8Kw1kpw
	s7CrnxK3y0q34qvw43tr1kWwn8Cw4kJa90q3WDKw13XFWrXrZ8XF1xKFW3Zr4Yyr92qa47
	tw4Ig3W2g3yqka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUhL8UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBlhqmg+WcTy7QABsv

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
 kernel/events/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95e703891b24..6a7e3f5c5af5 100644
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
+	if (flags & DETACH_EXIT)
+		perf_event_set_state(event, min(event->state, exit_state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
+	if (flags & DETACH_DEAD)
+		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
-- 
2.39.2

