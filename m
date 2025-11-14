Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F1146A66
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091260; cv=none; b=Ney+2WVTU3LukFvY8vFQLT2jKNLZdIorFoXvBm6cX4nznGqkdnGJacPt1tsY4+qMw5oQ2WoAgFZS8vg1Hy640hk43lTC0gSmtLvYK0sIh3BpuDGOP3xY4G0wN7Ki64uz3K+ch+S5Fg+TEiihWUNJWf3W8MpMMnaU7FhNnLVuyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091260; c=relaxed/simple;
	bh=eypeEOGS4DTZUcPlaH9EVqH033dMbd2jWX5a0gNfGyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgbeU0M68UpAcy+IW8Q+XVXOvK5WbthAV76+C7KyFkmGb/vs57uc5W7nW+W/4RgJSxJIPpPCfEFEpNqnUxhgFRY05ReHeAOBzc1ArbwrqmXTOiKsJSQPeZ2J4dYdyiKN9yTIooFgqhlKblS96kxIruZWYoQmEYKsZS30SBRO32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=diTjSPFn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="diTjSPFn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1444262b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 19:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763091258; x=1763696058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06rxs18soTzDGgvX4jMIEpe66BQCyuI5RVVlwhCORYg=;
        b=diTjSPFn+bKUbjdnhppqtIrEfdXuvv0VHaXUAaXL5Z7h+fyZmG5Q4PMzYwxDm1GLoL
         z6JOqAl/tYr2tk/XQWxv33JDgjiHTjDVMMPq8qpfLOrxF5WSdIrU/TIlUOTgnUtFexq6
         CjTbpra+dD6srQlqR5b97WcNgqPzgJHC2hSAL0munrKB2pt30H1EdM8lEB8X6pohOXY5
         8AX1dcFE1r8DGIeiklOsTy/WkYx+B7LQrUzZZI3ISnsRHkYn7iqhxpLLp+nTKm1QeRty
         UtPN7ietfSw/zpECd4V9Sh0qjNECWD7FXGEucOj1/i/xeEBdIa7h46tGconFNJw9Kq8H
         IhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091258; x=1763696058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06rxs18soTzDGgvX4jMIEpe66BQCyuI5RVVlwhCORYg=;
        b=vmoOBDIoIvUTVzuf3bv3CiJSmCN2POLhFnoyTJgoSmQa7fMkoD6HlZ/QoTKzKSj1Mz
         rLQ8s51VfeSe5f0EEU7S4JbBafUsGiPMho9ZJun4d8hprO0gyKZWOz6DNzyp6D4k4/46
         TR/vDDqAb2SiZEfViUs4WD8bECxK19T6fUN7xTPnQJRWlk45W5wrFkSwCQ7LTTxlsys/
         3mCDCshn3STLixyrvM6vuWg5VQ4EPzfyNHrs+pvNyYGfqr85NqMZQvObg8ps/8V2epWL
         pKq7XTUVrOq6amhKUY6UAOutLAViIOzGFRX9veZYmytG8muE3V1TuhoFAbSt2mL/ro6Q
         VaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8zLwOK3IgT1r+MLdLbUdc21APrMlYS07BrvYmM0zhJjTNLFrZLNQ94RJg5gwlKVg4nAm583+1hd2HvS46m7o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eURe8N03WFmLwgV4PqdvSTsTVri3IzlXd8Z0qP5uycFlZI9D
	PEX7Kv8BnxYh0I89sd0+222LPmd9DrhklxpHK1utQGdP41wyIEK4EUhwB/tvgnCFvzs=
X-Gm-Gg: ASbGncuoG96kneGApfi1pjLmvM/7m0NsnRCWSkMqjKegzm9hsaVCh1MjezbkkQ3loko
	c7Lb8LU8x48DaYah1/HlGhnbHWozLeZA3dkbzZYZQdMMv/OaJR/7ycKoIQqug2UGMo143A/yjub
	V/i9krtgejA6n5Wn03NrlIU82YQXejwlndJD+s0VelkOUuBAmKgIpzbpi3jlgPKrM57C022uusk
	UhoAyy88atl3JH/j4HRKmI9qzKEyQzKokYJ0DJLk7ZVyzekP6jNqnQhstrk1YRu83Bn4sPhAh9C
	YoabEL/CcJo5sLxvt7wQO4Ie/OzHdv6vYsS8t7EgtQ0yzCvFjdUq3TuScVd1jElix/dfx3Fg5zY
	TDouEfkdYthtcCcU5UKG7LN90XKOrLVD4+mvzQqdzXA2U2lH99gf/2tAYFlwiKOQHLLLEpdnRMO
	zjGeg2BIKXeOq4HdG9An/CBqEqBEt6ptCrh2jyGA==
X-Google-Smtp-Source: AGHT+IHxKhWOLK7ixe3MOL0Ju5wRKPpe/wyqhOmYIo/Pknu5a7BOoAwSwSzFp5FswHA7DxNLm8+Y3Q==
X-Received: by 2002:a05:6a00:12c5:b0:772:8101:870c with SMTP id d2e1a72fcca58-7ba39bc0759mr2295198b3a.11.1763091258072;
        Thu, 13 Nov 2025 19:34:18 -0800 (PST)
Received: from T179DVVMRY.bytedance.net ([2001:c10:ff04:0:1000::7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92782d39bsm3671231b3a.63.2025.11.13.19.34.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 19:34:17 -0800 (PST)
From: Liangyan <liangyan.peng@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	bigeasy@linutronix.de
Cc: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	zengxianjun@bytedance.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liangyan <liangyan.peng@bytedance.com>
Subject: [PATCH v3] perf/core: Fix pending work re-queued in __perf_event_overflow
Date: Fri, 14 Nov 2025 11:33:49 +0800
Message-Id: <20251114033349.3048-1-liangyan.peng@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20251109164122.80138-1-liangyan.peng@bytedance.com>
References: <20251109164122.80138-1-liangyan.peng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We got warning below during perf test.
[  467.100914] [      T1] WARNING: CPU: 0 PID: 1 at kernel/events/core.c:5147 put_pmu_ctx+0x2ef/0x3c0
[  467.107702] [      T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Kdump: loaded Tainted: G            E       6.18.0-rc4-dirty #114 PREEMPT(voluntary)
[  467.109835] [      T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1
[  467.111027] [      T1] RIP: 0010:put_pmu_ctx+0x2ef/0x3c0
[  467.122081] [      T1] Call Trace:
[  467.122463] [      T1]  <TASK>
[  467.124822] [      T1]  __free_event+0x337/0xa50
[  467.125306] [      T1]  perf_pending_task+0x10f/0x3b0
[  467.125824] [      T1]  task_work_run+0x140/0x210
[  467.127413] [      T1]  exit_to_user_mode_loop+0x10e/0x130
[  467.127965] [      T1]  do_syscall_64+0x26d/0x2e0
[  467.128453] [      T1]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  467.129025] [      T1] RIP: 0033:0x7f01d22349ca
[  467.135157] [      T1]  </TASK>

A race condition occurs between task context and IRQ context when
handling sigtrap tracepoint event overflows:

1. In task context, an event is overflowed and its pending work is
   queued to task->task_works
2. Before pending_work is set, the same event overflows in IRQ context
3. Both contexts queue the same perf pending work to task->task_works

This double queuing causes:
- task_work_run() enters infinite loop calling perf_pending_task()
- Potential warnings and use-after-free when event is freed in
perf_pending_task()

Fix the race by disabling interrupts during queuing of perf pending work.

Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Reported-by: Xianjun Zeng <zengxianjun@bytedance.com>
Signed-off-by: Liangyan <liangyan.peng@bytedance.com>
---
v3: Refine commit log suggested by Sebastian.
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cae921f4d137..7c63e5fdd334 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10433,6 +10433,16 @@ static int __perf_event_overflow(struct perf_event *event,
 
 		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
 
+		/*
+		 * Task context queues the work via task_work_add() but has not yet
+		 * set event->pending_work when the same event overflows in
+		 * IRQ context. The IRQ path, seeing !event->pending_work,
+		 * queues the work again.
+		 * The double queuing causes corruption in task->task_works.
+		 * Prevent this by disabling interrupts around the critical section.
+		 */
+		guard(irqsave)();
+
 		if (!event->pending_work &&
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
-- 
2.39.3 (Apple Git-145)

