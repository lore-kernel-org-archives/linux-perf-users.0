Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A0EED8;
	Sat,  5 Apr 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743862700; cv=none; b=Xt0uCU5Z9bJnsCi8rMTRqmuPsRIlWPxmwTa5mOdDw2xV6EwNZX0fP9Kmgz2NMpRewvfVbQe+jvUS0YFqJrR/gymMEd0CRkm6O5OVGPstyCGvjTGkOeJDvYNkki2uta60WAy1bQ7W+hghqtbxGVeiQzvLi9/Djqcz5Fi4FNLniZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743862700; c=relaxed/simple;
	bh=XEjfPkQ0xDf3298mOZu4CUGzRm/UeFS1ndsXjAJED9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM8PeYIxjg6EgGFJaNI3RzyZ/S9e7qArW6UUU+m4uhhycJ/GFQcbEi2ZkjpYrJCrIp+zuJCqtpy3f06FDIp3ZZbRCYTv4RKQbTHIq/z+eigG7znIm0VRmPQtoaphl4bWUgD9xEIRziLN8B8jBMKzwT5hgMqOYGpM56h0pcn5YoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEjxiEWq; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEjxiEWq"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-af9065f0fc0so1992052a12.2;
        Sat, 05 Apr 2025 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743862698; x=1744467498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Flo9A1xpfb3u2VecU2C1QdOzijhYyfyrS/0Oo29D4es=;
        b=DEjxiEWqkMZ4G7pV1ahoHKVYvnlGh8SjhffZzWKas61bjnueWqEfGqszGC8W7X6VB9
         Dc7ArQN3DVbmaZGUtwUia5+uLY5G524Yt4Q5QL5CQAdKJZ21vzu2nrCkbjm9wdbr8NKO
         MCik7qDINhB9IKCllr/6xQlDBmEwVPBUrp82UP13J416gHClbxs98lzuGJ+UU//e+0YK
         zbnQgSA2h3nR2H2RpeS8tqcwFXqhQzBNxkctByYfK1eD+rCOcYc78vvPCfOtoNOrZjrE
         hGuxlnDLYX9CPkFDDxSXs4fd7P0od1GICdIQCwHSeE12KnIXK/ULeRwPyVptiBWW0pCH
         VWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743862698; x=1744467498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Flo9A1xpfb3u2VecU2C1QdOzijhYyfyrS/0Oo29D4es=;
        b=coE5WUbT3dn621JcdacLKcIf7kONkrVpOaJvf0TRoHTk/5MbU84YLudOg6rNcR16MK
         F4wjF8k4nqeMoxTnBQDu0cDDj0emGFrjPdtSlHQL0F+S0W0CF3UTYGwvv8Ytk6QU972B
         5cJCT2WCfb1dlzPZQ0lZa6JzxVuJz+ICodVjJJJMD3kozK3crmAoJnoeNrvCa4+P04w0
         sebS6huWwKFjk0P+hiuBeFwLROqO/X1Q4nqDi99/DAp47hlr+08FUYHNyMknymTYVAdo
         cy+omPPoXu+y4+4Oh9+rrv7iCuKvThiLkNpSKlomB9J70RJvuDfaAzJFjqOkIHFNe1wC
         WdeA==
X-Forwarded-Encrypted: i=1; AJvYcCWCG7g52lhKp7Hd6U7WTgkuZ4TkXv1rWchccDy6JzEhe8SGCIH+K72Y3v3U4aMl3d29hhSMRyqr0f+mgUA=@vger.kernel.org, AJvYcCXblX5Om8rTK8ckeloCtZYZtELQAuJ+p7AQtZEmlDgku23yVoeKgCe2U/swz9sLnL0tNXzgeG1WbLPcxB2IeV+Pmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4pb4JFL/U1IFuSxMVySqYH8tV7aphv1DrPadxaT/asvfHFiP
	wdkQzSA69Bn0kO8a8lK8z05ZXfxypgbxQ2HfVQuVBO2HDIlUqSHp
X-Gm-Gg: ASbGncvMTyK20QcAiGw0D7mKtpX9PkmvYiajdcSRB7Sfc3j9/Lol49PxMD4X71yIiBe
	y2rMqTsbl0gHVtKt0SvYXSR6aqbiePe+SB7gwjLdBo6XLR1cYZa0+qBHi/Dw492bV/dgO5mK8J9
	ORtqr0uMxTwAz+9SucYxZJBDtzpNPCjm7797WwrF6UmytiUCfx+Vu2T2Mb/genRs3B9eA9zOrwr
	4rarx+JQviI387YSIQicAqTfYz6UFcBU/6CE9vo99I/TOUbdzHsrbWClXokfpF4NX1SfEK0T1yL
	rbmEG8PRIcwtDr8ivD0pEEqvu/UfomPOylOcZSEsDkvX6mrWhUaGtuIJdcAB
X-Google-Smtp-Source: AGHT+IG1l1fUb+vj79kWm4gxgX7cPBckhYi8BFLzhtqeH8SfToaC5EGkGpV6VDxUoOHz/fYbKD/+EA==
X-Received: by 2002:a17:902:ce06:b0:224:3db:a296 with SMTP id d9443c01a7336-22a8a047ba3mr102453765ad.2.1743862698009;
        Sat, 05 Apr 2025 07:18:18 -0700 (PDT)
Received: from localhost.localdomain ([27.38.130.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865dfd7sm50208505ad.136.2025.04.05.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 07:18:17 -0700 (PDT)
From: Qing Wong <wangqing7171@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qing Wang <wangqing7171@gmail.com>
Subject: [PATCH 2/2] perf/core: Fix broken throttling when max_samples_per_tick=1
Date: Sat,  5 Apr 2025 22:16:35 +0800
Message-ID: <20250405141635.243786-3-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405141635.243786-1-wangqing7171@gmail.com>
References: <20250405141635.243786-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Wang <wangqing7171@gmail.com>

According to the throttling mechanism, the pmu interrupts number can not
exceed the max_samples_per_tick in one tick. But this mechanism is
ineffective when max_samples_per_tick=1, because the throttling check is
skipped during the first interrupt and only performed when the second
interrupt arrives.

Perhaps this bug may cause little influence in one tick, but if in a
larger time scale, the problem can not be underestimated.

When max_samples_per_tick = 1:
Allowed-interrupts-per-second max-samples-per-second  default-HZ  ARCH
200                           100                     100         X86
500                           250                     250         ARM64
...
Obviously, the pmu interrupt number far exceed the user's expect.

Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 kernel/events/core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 29cdb240e104..4ac2ac988ddc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10047,16 +10047,15 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 	if (seq != hwc->interrupts_seq) {
 		hwc->interrupts_seq = seq;
 		hwc->interrupts = 1;
-	} else {
+	} else
 		hwc->interrupts++;
-		if (unlikely(throttle
-			     && hwc->interrupts >= max_samples_per_tick)) {
-			__this_cpu_inc(perf_throttled_count);
-			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
-			hwc->interrupts = MAX_INTERRUPTS;
-			perf_log_throttle(event, 0);
-			ret = 1;
-		}
+
+	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
+		__this_cpu_inc(perf_throttled_count);
+		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
+		hwc->interrupts = MAX_INTERRUPTS;
+		perf_log_throttle(event, 0);
+		ret = 1;
 	}
 
 	if (event->attr.freq) {
-- 
2.43.0

