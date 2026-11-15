Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758383;
	b=GNH1xxDOMEXyE8305JnMDu75SjHgZpPGbGexj68fHPZ17wRId/AE9UcC0Hn4Rplvs7sT
	 U4r40KdnoUSy4EXFaCmm4hXY0n95SY2Xz3yAbgbXDuOPN275knqwz+xJS4TDCvXH2JKAS
	 51yEYwSh8kxTFwIsGI9gk4ig0DVQ4ws2hyFmR+wB7f80aAOr0pHCEFXKxEmx2fw++VupD
	 WVpvs3qxqVG01lF4mIFx3hBZVGSfjM6qV27mxxijDThna0M4jxQU5ShgqyfkB/xmEHAx1
	 uSf3MTav5wR2OIpH9Ps2dystAegUue7biV+e8H/qldB2nr6ZUvDIJka8AIW4rNmzeRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xTFQQMhK3UJMqexJFys6E1k1C7+dAh9ayaPYXn833+U=;
	b=ye/Ps4DtYt3ufjklJv7c3gSUu4qAYkF6c/MHcPSqQfkoJ8cyiSxgKdrZpfSuqJzolM5c
	 33XN0UXQY/mUmPlcF5g/a/NFcAqbORlLQAOlxZ8y7Av/n/+doEAl96OwW0gCcZ4xn82hJ
	 gMUE43BvvyFSe94t3gyFECdQ3xrw9D8enXgUUGg3XZeNTd5PQrsfF0l/JaAP5i5VgjSTs
	 9InojZHplQWqITztvoS0gfDuD5sX1e6RfiloGdoouRCDzfzsC/V7Vskvujj3XdwCYuppT
	 qvklLbo9JVxzpnZ0LrtviJClWWLnZuuOZDbFhSzSw5trNXfmPWWKyvKbUFHW1smbvWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygKzYaSv;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B798606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 15:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B798606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygKzYaSv
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so21521745e9.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794758381; x=1795363181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xTFQQMhK3UJMqexJFys6E1k1C7+dAh9ayaPYXn833+U=;
        b=ygKzYaSvRhuzclPrvO3frMENam1XSgQqd7Xx9HDScTKCo8NIirBjMJiwM8H2cUbGsP
         O83Ax50tu+QQnbI40TxRpVBEgnveKIPH9iMgCGtcuy0JbVlDvcSuvtNkhBp911k90K/7
         idl0x1HqblOmNZ/fuTPHAOqtVVCYmyZP0Y4ZlpITuGRu/CdCaQQDk80f805XYmuC6X++
         DQZpxIuf76ogO7YxehSVTpbc0VorNB1MDesZnwNSI2pD4WAXuXo0kVGr1fCZ4Jwqp6Gu
         Idk9JZxXmych7XxEJFCp+kyD4vi3OKMNbSgh8PiI835smjhw5Ila3ypE1OXgiztbGni3
         OQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794758381; x=1795363181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTFQQMhK3UJMqexJFys6E1k1C7+dAh9ayaPYXn833+U=;
        b=2UyFavbZe5vboZtIzMt0KTn+5cZitAgK+xcFe4IimPHLB7yMI2trRZrXcHLG2zIOh4
         HUGtdGpuiiTnHNu3nfAGzJbPV1n7iHx2U6MwKNlVtZTb9WMuOPfIoRNngytQBDu3fwIJ
         AoIulCJQ8zv4pm7Z6hp5gU8HE/MO22lH1JrCc2NnkgTCbetCXk0xsgOdqWYE5KwwDOpj
         NzB9vPxuBF6lRltYEVvo4LySy32+uZLMFA8wcI3pwhoxmFHteca3+yXacJX8XZeN/v/j
         oHEqMN8JgZ8toRpNIQBGUPN7X5FjGT4tY6g5IFUAQ8ccf4E7lEy+Xd5/Yj3CbIf1EGiU
         C/6Q==
X-Forwarded-Encrypted: i=1; AL+hErG0LYXF5EF2sIsiEYMddqqM9hYoCXzrqZAGK8JnrTm7dlA4ZCahZvdgwGQdNi/vkgtMWjvpQTAwQ1BuukcD9a6z@vger.kernel.org
X-Gm-Message-State: APuU4Z+5OS9BqXSkdKYJCGchQ4lZ3lbFtlnHspf0oA/5tHUlRVtmH40/
	BgZT9yRUonIX1BC4h3IDWsUa1gBn4NNi5ZhGDcLgdIVinVuGjV/xRN7M
X-Gm-Gg: AYBFou3ZXd49fu7j76H3uXf6/dzpBCF7PyWfoJeUilD0yrMQlT8q+P96DN705su+uw0
	ZbyeR22XfYtiatuYhp7i42AtvUGIXzLq4f/D0CHNI5DPxU51xbu2Po4JOxnwgGsKx0xi3y7kZnL
	8SXRRyWmMQNqf8gHXg4jCR2/QI48KMOpg67NIo/lvbsjDb527kgSBjlO1L1vJjFtSM1PAAlIuyw
	ogNT/LUrAZ17tr1MbjqfEA+//W+XJSjs1jwudpLGVeqFZfUVREK+tqJo/LEGESxfieXBCBAAKdQ
	jFSMPUaUQU+BnCz22O0u/pZzEyaoxVjl9U45zQ7Kj+kAHiReTpTHv+AEl5wkdrhThhp9aU2gG/o
	oPQKRoClNEAffeOnwTVIxITOVlo6Q+8Ohs1lUIAHA8mv426/lA2mKE1Ypwx5ulAnsC9f26kaylm
	zaGCluE91WxTHhY9uoIuO2xXrdZmauSGTD4gNKiir6+zKcBNbca5znZYylQNgCLdy2Gg3TkYRSH
	P8vl2sPJ5ZHw/em96JySmKg8V0SbUesuinznN6lJhelPfjYBfHl6Cj3Jb5lhucBc6/w1tA4/gE9
	8QxkjeM8P+j8/QhfTuOuLWs+eail81T+NA==
X-Received: by 2002:a05:600c:8909:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4bb55a83e95mr127075265e9.24.1794758380829;
        Sun, 15 Nov 2026 07:59:40 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:474b:1700:f61b:bfec:b5f1:a453])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdfebsm204511085e9.7.2026.11.15.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:59:40 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: andrii@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] uprobes: avoid postponing return-probe SRCU lease expiration
Date: Sun, 15 Nov 2026 17:59:21 +0200
Message-ID: <20261115155921.260878-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prepare_uretprobe() reprograms the per-task return-instance timer on every
successfully installed return probe. If a traced outer function remains
active while nested traced calls arrive more frequently than the timeout,
the shared timer keeps moving forward and the outer instance can hold its
SRCU read-side lease indefinitely. This delays unrelated synchronous uprobe
unregister operations that must wait for the same SRCU grace period.

Use timer_reduce() to preserve the earliest pending expiry. Pair a full
memory barrier after publishing a return instance with one before the timer
callback traverses the list. A publisher that observes the earlier timer
as pending must then be visible to that callback - otherwise the producer
rearms the expired timer.

In an x86-64 QEMU reproducer with nested traced calls every 10 ms, an
unrelated tracefs event disable took 7,740 ms on the baseline and 70 ms
with the change. A corrected monotonic-clock regression run measured
2,210 ms versus 79 ms, with 15 additional long-lived timer-boundary
cases and process exit/exec checks passing. Narrow LKMM store-buffering
litmus tests observed the lost-rearm outcome without both barriers and
forbade it when both were present.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/events/uprobes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..82065863a6c1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2052,6 +2052,9 @@ static void ri_timer(struct timer_list *timer)
 	 */
 	raw_write_seqcount_begin(&utask->ri_seqcount);
 
+	/* Pair with prepare_uretprobe() to avoid a missed rearm. */
+	smp_mb();
+
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
 
@@ -2304,7 +2307,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 	ri->next = utask->return_instances;
 	rcu_assign_pointer(utask->return_instances, ri);
 
-	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
+	/* Pair with ri_timer() after publishing the instance. */
+	smp_mb();
+	timer_reduce(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
 
 	return;
 free:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

