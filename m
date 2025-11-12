Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43000299924;
	Wed, 12 Nov 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950957; cv=none; b=Ig5WOi8gladDjY37Qwc2Nr3jF0vkSsl72UXl8BVacSvaouyYrJ/CGnv4MAnRygn7NyVaMe2SjqQJshOF0C8STQu1usPkehRVzGHu8Uir6Hbs/eHCwV0zLpRf9nPKsftNkJGrwBXnFcHekZHqLjHphc/ArQHjjpaPD2sIBCotTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950957; c=relaxed/simple;
	bh=TbGdIVcjYWti3KO9ZCxxEaJhT4nujp4QoGoopE4FjoU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=a11dFG+1AWpHc/FAm07OE3eTGcfB4V7sY0ebry/T5/JLrVV5jkpsZrB1QMnNeELla9veSZiOUc5DNjASkXMf3ApMd1h90wSKFA584DjJtRjH8vtJ2eYoESR+Ef/aVGmWuF5qtYgMd5OcYEwykw6ybQfLCVqX9lL2ZFxninrMUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FBfMfNdo; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FBfMfNdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762950945; bh=pc1YSS6OJyDZMOlK98+qOmOFvcEDzx4AMBepLp5LtMc=;
	h=From:To:Cc:Subject:Date;
	b=FBfMfNdoJChWQ5IqnVB5bRbCQuuPF8KLftZsmDLZjOYViHHrDWZWV9HiaqRr2UtY5
	 6NWgiWeKfN+BMjwxovENZesfZTxlPKiVF4AvREBD87OxZqFjJ5SbP6XBHzDJx2tUH1
	 Qfz+Co7KkxPveX4cOQNDIBQ1WJdnRZmWkYp1FDSo=
Received: from zjh-os.. ([2602:fbf1:b002::1032])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 897B60CB; Wed, 12 Nov 2025 20:34:23 +0800
X-QQ-mid: xmsmtpt1762950863tf84grgr3
Message-ID: <tencent_5A81C3E27E416B65341A899C62ADD6FF0D0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoefAFwz7czs1LbderI9eLI2ARNf0JkMyz4ZhhvxZWwlx265j5MUZ
	 EzerSh/YVL31ZGGSBTPKp9W4L2N0I9aA+hxHWX1sLb/H1Kl5gvMFy5NZjD/2Toj1C2n6D5CVd5nf
	 aMB26fAEj8J41U7so4mFM1ebXKI/1jCf6l7WZC97BYi3dDT0nWzRbM19XZPg7AgkhjucowBpErBY
	 GB51FqyfwkAKfxAuibaEfEGf2R2jHXOgWsE4kQhTh3/RZzPSV1tuMJYXV455VXNSDBFNs9MyztyM
	 7A4Z6Xybu+00LAFxon2omjVTkZH8/RIVyUQYXtTahoFF+a86JEAGbAFb3FWDgswqLeix2hqE+O0A
	 v5q6Yv0l+yXHz1X65aSrWPv32ZwaUyWgrYBiODl8HPqS4hH5LdyQ90nZZaUzxZjijSh2rrqC51Uk
	 MXEL6ZsvXEuCFXOAHbmVr2p+xk2r1KQG6r+XtYaeLwQBezicJ1iPbpa8I7cERzlClih5Ac/I/q8B
	 KKwszVDO+5I7YALVJnuiiQ+kq9SRnDuGUtfmYN6Fbb/jNRnB132tnvHWr6evmCnsEp8CXbEu7Sww
	 GZTCs9Ue9LQErb/VOCiwPPEwDZF83+ByWEJZtlNEq9rUODJnj9YfhhSegmwBuJX8KHErlNDoqAVf
	 B6W2up4vhw7MgXaj3/xk9PKW+pvxU+6IgabalXy/L3TmrGLSFSJiKpsy+nXdv5KHJb1/gYvG/hk5
	 puGzqYt2LDZ0IKnIr2vkzZ827xMbyKbSHFU9QXnDIDHIyWKXG38ErslPlV7Dx7mvR9mGvw4NckMe
	 A97gQinNXHOzC3Zldwzky9b6CDPysCuMDCEAyxGYh70LKTv7V5uMlq7qROI2KvK9EPX552CsPpeh
	 9uxQdwd8izBhJbDMTG2lIxLrDw3knt3/+bhSGNNrdIVlu71RCcYSTP1R8jZQKDGsYEDaF5iS/OMG
	 cgNNod8ymyupATnUIxWu9f7SFFVsCeO8bXlJR+PSxRnpIqNQN12Novmk3zDnaRu1KKxCBqt0tvEi
	 aJhtfsUIR/Y3Fdv9D+OlJVS4vZZKZbjFQDZmRuCYSK18aDPF94k09KTG2X3TZ1rcqjJgsal4VyNx
	 twY8XL4z3oznivXaPFQtHgsLGGxg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Jianhui Zhou <jianhuizz@qq.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	jonaszhou@zhaoxin.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhui Zhou <jianhuizz@qq.com>,
	syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
Subject: [PATCH] perf: Fix lockdep warning in perf_event_throttle_group
Date: Wed, 12 Nov 2025 20:34:21 +0800
X-OQ-MSGID: <20251112123422.484091-1-jianhuizz@qq.com>
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
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1fd347da9026..253c514e9452 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2700,6 +2700,11 @@ static void perf_event_throttle_group(struct perf_event *event)
 	struct perf_event *sibling, *leader = event->group_leader;
 
 	perf_event_throttle(leader);
+    /*
+     * Disable IRQs to protect sibling iteration; for_each_sibling_event()
+     * needs ctx->mutex or IRQs off.
+     */
+	guard(irqsave)();
 	for_each_sibling_event(sibling, leader)
 		perf_event_throttle(sibling);
 }
-- 
2.43.0

