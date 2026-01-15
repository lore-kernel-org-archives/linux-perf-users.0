Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED017B505;
	Thu, 15 Jan 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476749; cv=none; b=WpEKYg0QNhXsqn98Y5tcGisbXMBMn/w0o/PXPtUONoLZ97GfwzAglf2VFCleVvfil/SiCqESlP8Fdz51YPCBs5Cxc1URtbF4naOC5APVaNB3p49/8vPubP8OEOq9nNceylEbVUHUF1/axQXNHbs/L/vL2FttQaJOLmMinuA6naY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476749; c=relaxed/simple;
	bh=G1YeJBcyn3SAlFVX0H4veINc+FEujHMcxM6dGaC5Wg0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=a8OkEu48HwN4eup4EgtqpRowFp3+IJ8ekM/UVqiqsE4XWk3UdehZnTLZrswqJRvrfvLKWBEvmtvCwK516eTdAWMHh+jvh1ZWEGkIaL3l5J+kHngwzZ0+epfjNaTHNQCZPXA4Mdj2HwfoGmkEZYRcDoqNT0ebtXG9p3ITuM4RYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UUmqVB3/; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UUmqVB3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768476740; bh=hA0qdgR1cFVZjH+/sy8lmDWeUKr/aqvoxEAO+ynyC28=;
	h=From:To:Cc:Subject:Date;
	b=UUmqVB3/fmsFwmlbX4K4n1GfI/+kjY5UK1fPSlzKnpp8omKfh3pI/B4LndxIeEdD1
	 LWs2XAr4YsTH74jnSE8y/RSPRFVmpcJopeWt3NK7d5nT5SvWWLuX7lkrRt/hw5LstZ
	 q9swEV/W1Bgb5GIx5aAJ+ZHr3CB9A6CrH2tJhJTw=
Received: from zjh-os.zhaoxin.com ([58.33.105.3])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 7C6A7A8D; Thu, 15 Jan 2026 19:31:06 +0800
X-QQ-mid: xmsmtpt1768476666t7q72pcoz
Message-ID: <tencent_5A703E5C2568858C7AA39E5381D5AABF4C07@qq.com>
X-QQ-XMAILINFO: NiqRxxT6irokzK5VvVbBi9/tzwPGtjxW6uz8TZ/NhU7NdU2KwxGKAPhWu2kvhG
	 Y6w+aOle/NKZKzpABgRyxq8mZQpM+pSKjfEdPuHLPTDSbTgJeq5hNdI95K7H6TDATVix2Nbz9Vdd
	 vYEcKwJkOpmGzrT1vYhBEKP+PpcWjrf+8TYTLX0/7oJFBVISsJn1KfW5d0MFRlswubpujY1EAMV0
	 8nDBzNR5WCokJdG1U/wwPsxGte25/QVdEWhGG4/eRfx2xKCd2ZTa4va27AQa5bg398wrFAuE8puU
	 I7+4X3lSam2+aMzpk2eikyrEiTEv1hxxAMEcXTjg78M7v4aOJwrE8qWx0OlovR4KUcJ3ogyb/q7x
	 6nKbcX3NnsvU3GruReaqkoQsxSiTua5jgJoYGEKcE6Zqdz+Eo96cjY/Cj71Rxj74tqu76eTKPXUg
	 bI4N+n5Nnk8dB8ExUJBMPv1VPUoIiFjaPmjx19KdCVKl/LeYfDQXmJ15uyVlH1z7WPwVVo24HPv8
	 vrGxfjQCWbDzOeQMt7cdh/QRU+Jo/CU90YARMB9gDKwSgPohmtquzX3hdBXVWIqxpef5pd/gwOuA
	 5EPg3iivP1C3wt6xYQWA9m1s1tL5nkfBSr5N9bT1zmPhBtDjV6Ddu15R+BKjhmmafEetJARVip+J
	 c6/xSAZvXwdwmtX4YfsaoDtJOjBtEQ+DfzbhaKc3M3DC8rA65pCrgePH7rf+5DvclIISWbmF3epc
	 +K6coNpPHK5M0rjpKYXdZJKej4MzKZSlyjFGkYM53iT0py8RqSSNkIejZVU7dJtqIzCqZyrAJo8O
	 Ns0piLE1cmmobYmIYBCgx2GE7XGRk+ZJoXjWV0usVa1nnoeH5vEifwGNfvhJqQVIlcgdspKobPVR
	 6qEHncDZj1rxh2RWlSDiX+EPtDTw22QoIDLt9FSFIfZbxPs+ZhihCaWfJGu0BBXNhytRgtUw4Bi4
	 qLacV9jtnJuYr3qF1VehZknVn9k15VnmzWtA2bHyr3v4Mm4ciNRgCxJ3V11ykzaVLe9j32IjrIhJ
	 OC04nfXKRQjJjGbbOD2ZsPzWPO783xKausLifo6w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Jianhui Zhou <jianhuizz@qq.com>
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
	dapeng1.mi@linux.intel.com,
	jonaszhou@zhaoxin.com,
	Jianhui Zhou <jianhuizz@qq.com>,
	syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
Subject: [PATCH v2] perf: Fix lockdep warning in perf_event_throttle_group
Date: Thu, 15 Jan 2026 19:31:03 +0800
X-OQ-MSGID: <20260115113103.738455-1-jianhuizz@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf samples a tracepoint like trace_lock_acquire with high
frequency, it can trigger a WARN_ON in perf_event_throttle_group()
due to lockdep assertion failure in for_each_sibling_event().

The issue is that for_each_sibling_event() requires either:
1. Holding ctx->mutex, OR
2. Having IRQs disabled (since ctx->lock is IRQ-safe)

The call trace shows the problematic path:
futex_wake
  lock_acquire
    trace_lock_acquire
      perf_trace_lock_acquire
        perf_tp_event
          perf_swevent_event
            __perf_event_overflow
              __perf_event_account_interrupt
                perf_event_throttle_group
                  for_each_sibling_event [WARN]

In this tracepoint path, IRQs may be enabled and neither ctx->lock
nor ctx->mutex is held.

The fix adds guard(irqsave)() protection around the sibling list
iteration in perf_event_throttle_group().

Reported-by: syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69122cb3.a70a0220.22f260.00ff.GAE@google.com/T/
Signed-off-by: Jianhui Zhou <jianhuizz@qq.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v2:
- Collect Reviewed-by tag from Dapeng Mi.
- Resend as the patch was likely missed

v1:
https://lore.kernel.org/all/tencent_5A81C3E27E416B65341A899C62ADD6FF0D0A@qq.com/

 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5b5cb620499e..032cb8cfe59c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2698,6 +2698,11 @@ static void perf_event_throttle_group(struct perf_event *event)
 	struct perf_event *sibling, *leader = event->group_leader;
 
 	perf_event_throttle(leader);
+   /*
+    * Disable IRQs to protect sibling iteration; for_each_sibling_event()
+    * needs ctx->mutex or IRQs off.
+    */
+	guard(irqsave)();
 	for_each_sibling_event(sibling, leader)
 		perf_event_throttle(sibling);
 }
-- 
2.43.0

