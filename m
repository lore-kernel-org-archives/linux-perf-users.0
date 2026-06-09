Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026936A030
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019466; cv=none; b=R1SgEWRkdCVbml1bZvh2UAxbS71uyP+g+dN57FFdd+KyoK9/2BBmL/jRZdMPhaxE7AjjfM3z5SLhfSHygyjgkc7/aa6EDqpvb/1p3j+TJJy5C+go8ly5XiI1YXkJf/S61QRgaAOgjmdNl5RBoHLNLisvxz92Youz/YgPzy5GWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019466; c=relaxed/simple;
	bh=NKP3/2B1F6kVPLprL70LvEkW/5yNWBgLqHT1gvu0ZEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EC33dg5fKJJ5yxOe2wsLxBLnWhbem4c+zXJU+OUcVr+efCozVbzDHhAhxZS8hp5VTsKOnpVdERbcrlnhWqQSw3t/jP/cmmAjqPiEtnyFGhBxMQi579R58o0sCa6G0Es4xvkquxyeCi2pWTeP16YZmIuvFG0Upq5/1WwxLDmPC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV5IwGZ7; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV5IwGZ7"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso861206a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781019463; x=1781624263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugNb2Z9vQfU1zjSBllu0erAwx0ETb1zliLM0vQU6x4M=;
        b=cV5IwGZ7w7dDPu+UNT3NtCf+pD31KjAeUqXQHlaInnv5BG/1cpt3ASqT0FBmX+I1rv
         l5R1EYYfu2hR0BvU/HWZEEctom4PDE1NNdJEd3zHB2Lfk2g7eLYO4AVyxeFoVgDl7OrJ
         zRsxVrWmR9V1BYlFjf1Foo8bcm9fhx0BhdodOP5XxekziSA55gbGXFin2g87F3BvPnxg
         LJJ9NHmCuSvZ8Ir3pqb/vqK+YDNdRkQnZK5rKYdaPM9hlsVp0njnApcA4EPuchSRuIzx
         v6lkW3wCLUmai/Rxlw6vRPSsf4yxwHW7Sfnk0b2AG16Te3G6U73zWQCOn48oqW4Xk1vA
         OqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019463; x=1781624263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugNb2Z9vQfU1zjSBllu0erAwx0ETb1zliLM0vQU6x4M=;
        b=snnN0OI4SMQ//3pHWXVAdNElPzKtIv0HA59Thva1hNAnmoM/rLrC/VxcrbtBS+h0uQ
         A8OneAPrykt8ZHSXjXHOPfjqRzw6tTisbRuMcudIjnO2PoD3auZVu2v6/ABPLvbdM/+e
         ujWwsMrSRdxBZe74vELGRAr0s7FNDjm6b/7fmoOMIVPgU/FwZENKsT/0/i99cF4qbJU/
         j/yKg+GEM39TJEKr5Ooy6Xu6qwcdCjOrgXSEC5i6OjI/iIZEub1QDUNe3z9iv+DcE7sY
         liDwCLiGUaJkqaaQyv+ptKbuEx4xiP00WrQy/QvHSFg2e7jka0MSPZ7vbWbf8Kf4Qamv
         R3Bw==
X-Forwarded-Encrypted: i=1; AFNElJ+9Ugj9qZlA5dfuS0zZ4qU+vmMmDyRcnzYR1xD+F10F5Dpln0BOpROgndE0ScceDQWa1IN1rqV+erkGux0MZmD8@vger.kernel.org
X-Gm-Message-State: AOJu0YwQd6T1966x0SOJHJwpy+uPicPOFZgpd5tGAnzpdmo1YadcHWnC
	9OSRdHHa7dValmfRWIxpViNXRN64ckCLrYn6nICLXuK/ifW2xAPXiE8C
X-Gm-Gg: Acq92OHoR5kOZtvU9A58bejNXXZaBsjKHbNeeVsAQE4ggZDGbG8D6nGki3YZHC2SF2S
	JHuGqIWGDYIpdXNazrRl95C+3FkP/2QmF8fulH1LimNt7HaR1wUnucyKyvNVwXaBenQcp5BVg3c
	szJTbGm2cajIYh4uTCcO7pD+u6C2mEYD8J9eqkOHDuzE/UYASF8kPXu7enquMoUCkvRfbAq89tz
	P3SIsXI+LIeBoCYiO0bpAF0gBv2SsGBizZMFM8Dd5+KOWPlAi43r637ESxi1tlv/5NTdCbuOhcA
	X5pMu08MybJWBtT08nPGWI1N9juyqyTYscsw6BSQEWcwP7hAYs/bXhP1EGbdzD1I5BYUJmtra21
	QkrvwGL/yYA9ht3VBLChr42KFVnTzZBwSBAIzoEpEcek0Xw3MSZ50J8ZSA3dP76+Km7XwuMRbMs
	sooxsMNU3fPl5ciew7K3tGo89+s3OZj9+j+wmFr/yYEEqITj4FAssWDpgmwaUaIwxQoFQ=
X-Received: by 2002:a17:90b:3949:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-3751c4552b7mr4035862a91.0.1781019463425;
        Tue, 09 Jun 2026 08:37:43 -0700 (PDT)
Received: from LAPTOP-1HUHJV8R.localdomain ([2408:8642:893:d2da:8d02:522d:941f:95bb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm19771849a91.10.2026.06.09.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:37:42 -0700 (PDT)
From: l1za0.sec@gmail.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v2] perf: avoid lockdep warning in self-monitoring perf_event_open
Date: Tue,  9 Jun 2026 23:37:24 +0800
Message-ID: <20260609153724.7878-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <3230100410@zju.edu.cn>

A lockdep warning: possible deadlock in __perf_event_task_sched_out is
reported by a modified Syzkaller-based kernel fuzzing tool we use.

The warning is triggered on the self-monitoring perf_event_open() path.
When perf_install_in_context() targets the current task, it goes through
task_function_call() and the synchronous smp_call_function_single()
self-call path. The reported lockdep chain contains:

  rq->__lock -> ctx->lock

and an existing reverse dependency from:

  ctx->lock -> ... -> p->pi_lock -> rq->__lock

The current fix adds a fast path for task == current in
perf_install_in_context() and calls __perf_install_in_context()
directly.

This fix removes the self-call path for the reported self-monitoring
case. It does not change the scheduler-side locking order in
__perf_event_task_sched_out(), so it should be treated as a targeted
mitigation for this trigger path.

Signed-off-by: Haocheng Yu <3230100410@zju.edu.cn>
Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..97837242db32 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3199,6 +3199,15 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_mb();
 again:
+	if (task == current) {
+		unsigned long flags;
+		preempt_disable();
+		local_irq_save(flags);
+		__perf_install_in_context(event);
+		local_irq_restore(flags);
+		preempt_enable();
+		return;
+	}
 	if (!task_function_call(task, __perf_install_in_context, event))
 		return;
 

base-commit: 33d8d8ec31b591952ded59d596c2f3db45004937
-- 
2.51.0

