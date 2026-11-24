Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511594;
	b=JXgRMu9iO9J4zYsqd0/dVbVMW6SGQXxB32lAJLGSHx7D29WFgmPPz882TUqG2K0Jr8vB
	 eRUmr9qbwTKEQ+B+iUnGhjDtz2s+UeZmlwmuAGwzFZXSGw8zWqsxACV6bpMwegq8MZW17
	 Ii69ACs/ZbWdJK7NxUu808MKbleBW7jAHxAc61EaKR5HWIMrSIjHmdGVOkgfoaiVhTToL
	 EzCxxBT7PlkN3czbpxpquRUaFRe0nqE9VPf9hmOmMofz3wfPd7hBlC+INJ+NUzr3UY9Gi
	 rE27NLRNFrdhphc3784j4pz5zUj2Nrq6kuamk+0VqpqCJH854HW6YzskIonJz+6jM5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=285F8rEC74nMX2FnbEwp9EQ7OPlK3L+w9+JpHnSwueo=;
	b=QPVweEHjuQ9YAbC1Y3CcncfwOhGCZVtbPbPF3LZFKtpAx43iIn7YWceu+BYVRXGm7QPv
	 GbNntSYbXm8H3W/5nlGW8iE9JfJb2YcwbVhko8ozD3gohu472GchT/1oplXAg54kYgFac
	 qh8cj7e7Vk4hAgyrY9F96ZGrG7Vlfki2iBz4lEITXgEj0IvObQVvEXbILQzPNYs7MaDnA
	 aUEDo90ajZcEVRJ4QA68G+pKf0ndAXwWqeVp91U6ce0pwFd3b0g7mKsoBMDzRsBhb70aS
	 NTBbuBS5KEdiYhbBjlseRvXrpGa/FiaOGnlTTAvqfpOpWjEuKnSwYLayiAM4HgaPVZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="friSTd/w";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46057606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46057606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=friSTd/w
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so4042779f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795511591; x=1796116391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=285F8rEC74nMX2FnbEwp9EQ7OPlK3L+w9+JpHnSwueo=;
        b=friSTd/wC23LUdCRxN5gUfhpqzosug7ADsYKJjMIPbKooCwIRZVm3kva3/zbPUTh7A
         1vBrfDeM1ioBbu1C+f/GKfZOG9NMhQVs3f0EE5MhdV0oONW9HGizBK6Wjwbuuiz9jOOy
         EaPxQGSudCOUBwHxbikdjbLW8zIlRqH6qwDGzatQC+PNfdQcpCB9ItK04QbgSjA+5kk8
         WnM7EhnhsfP60oSm6w57Cn1KGTVRq47US6ktQ7zXx+1uBMavgPYsl2JKJaJ7ClzrtHL5
         bnu+NSPUMGb0w2AuYYEIPWc730iCPLbGdNTHQuMtmT6MiKGjffMLtpWNK9HBH53mNAIR
         6iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511592; x=1796116392;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=285F8rEC74nMX2FnbEwp9EQ7OPlK3L+w9+JpHnSwueo=;
        b=JqKyId8NktrM8WdiMut4XPqJFMKJRwbCCLeyVK7/loRG3FdCpQjoFWh7ddJDCHYFcp
         kx/M8jheElJr0u++K9wkQoU6pjuYxiCTuikRmg4Xdp4kybP00lRMLt1a92z/tV80/kYm
         a7ssq2YW4aE+4qX+M/huBD6RQopxzezIzNRNlyvPxKIyqVE/4rpOvOBRCXeHQJ8U9K6m
         u2tNEe5BLln3gWfAy/lxAPzA83RezsjsdhCgWKjsdOSBxB4wWHobUFwa+5KGj15RYo6f
         FQujosGNikV2UZ+itr0EiVhkCHbCGSuG/i8OZ4/1eK2x4j5UappEt6KL0xe13WNWsZ4G
         la1A==
X-Forwarded-Encrypted: i=1; AL+hErEwAx6eOcIrUTBiS1VwcE29yO1rijc9Gyl/+22YuIF6QkV2x2anG76+FZtAPsnopQFSOpgE/ukn0aLLifXNvR9f@vger.kernel.org
X-Gm-Message-State: APuU4Z/DZHZFnuJVNS9Z/vYuhWVc4LmexJEhNA8dRjER9aw3xqqQUy44
	vQD/4vi31SyjTn2Bw9PzOvFNXfGgwZQ6J+yx2x1BZchF4A2sMd4y9oXAN3dNy9fp
X-Gm-Gg: AZFdTZfTjSUnPdfgokC0i9jEKDmDEuTW9/0jldf4ShVn1nYDUSJKw1S93l3P+uli9Tj
	pZKFOv2sD//TX0TTo/FJwdeAKHpRpF7JiC2e5icQ/7d//W8Alb13/Ly3ncUIsuvBEPMdX4dAn0a
	uxIa4wfq8op87+Hx1CsG/InDLqrmou39LbJpljsue/9PMjS4QwMqAXMpzZa7u/JDjyk8Jwml/y9
	s61LbUuToXIsxgzDyyn3lf00UNdJitkK3GzEhgrH9kcFxIUImsdtvLZfsq1FjzqwJFte6352Jo+
	8os1ju9Pv3Pb5Bg4/iws3hMsp0raBJN3pDFOK5k/ZJ+MA9tvA5/h0zxzoVY74aqGK6M2aaN9md3
	cuplqik5kXmYauiuxSAaOaFMDoxR6Krotxa9evgQbA1bhrc8MNrAi00CukKrdk8UHJNkv3RG6kl
	y4ARGltakjuvzTLhX8XiPKlLQd3hzHeyRBW70/wdN5NomoKXItr5Ir6omCIraLLc0i7auHqB4RA
	m5KIk5F9jmU2wcTg5mlrrwNJjCBMXywM0T7SeqFjOm2XeYID5ec4ccmbdcvmare/9OVedVqfQ3x
	u0OY/359ALULQ/0x60YFWCvr0vgzjXA=
X-Received: by 2002:a05:6000:4705:b0:4a9:3fba:5eef with SMTP id ffacd0b85a97d-4abb5db6cd8mr25609288f8f.24.1795511591322;
        Tue, 24 Nov 2026 01:13:11 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:4770:2100:9c14:8a7c:ec54:34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa397asm27559136f8f.48.2026.11.24.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:13:10 -0800 (PST)
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
Subject: [PATCH v2] uprobes: avoid postponing return-probe SRCU lease expiration
Date: Tue, 24 Nov 2026 11:12:52 +0200
Message-ID: <20261124091252.567037-1-thnkslprpt@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

prepare_uretprobe() reprograms the per-task return-instance timer on every
successfully installed return probe. If a traced outer function remains
active while nested traced calls arrive more frequently than the timeout,
the shared timer keeps moving forward and the outer instance can hold its
SRCU read-side lease indefinitely. This delays unrelated synchronous uprobe
unregister operations that wait for the same SRCU grace period.

Keep the first pending expiry by arming the per-task timer only when it is
not pending. prepare_uretprobe() is the only rearming producer for the
current task's timer. Order return-instance publication before the pending
check, and order the timer core's detach before the callback reads the
return-instance list. These full barriers prevent both sides from missing
an instance at the expiry boundary.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
v2:
 - use timer_pending() and add_timer() for the per-task single producer
 - explain the actual store/load ordering for the full barriers

 kernel/events/uprobes.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..838e0080ae1b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2052,6 +2052,13 @@ static void ri_timer(struct timer_list *timer)
 	 */
 	raw_write_seqcount_begin(&utask->ri_seqcount);
 
+	/*
+	 * expire_timers() calls detach_timer() before invoking us.
+	 * Order its pending-state store before loading return_instances.
+	 * A publisher that saw the timer pending must be visible here.
+	 */
+	smp_mb();
+
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
 
@@ -2304,7 +2311,16 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 	ri->next = utask->return_instances;
 	rcu_assign_pointer(utask->return_instances, ri);
 
-	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
+	/*
+	 * Order the return-instance store before timer_pending() loads
+	 * the pending state. Either the callback sees this instance or
+	 * we rearm the timer.
+	 */
+	smp_mb();
+	if (!timer_pending(&utask->ri_timer)) {
+		utask->ri_timer.expires = jiffies + RI_TIMER_PERIOD;
+		add_timer(&utask->ri_timer);
+	}
 
 	return;
 free:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
