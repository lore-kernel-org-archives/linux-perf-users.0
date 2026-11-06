Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960146;
	b=Ai/F0Su/RJO5LiUFS+VLSxacPdW7vYGI7ljhKFIPFs0JF63CE03IMqs81wp+7WgQ/mjr
	 4/VCXYy30eysK6wgoDR/SGJXYTNkSsOIbahG2bQvyrgwpRXVEuH0UuAW1Oc1sHsxashfr
	 7cqL+gk4I0VWI7llK0R2OZtq6dq0B1+OGdoxLp3xmcma0D8LB/3K/us+Vl9CPpEI2udSu
	 KoOE6Lg3oelXcpml/B2RmdJN0ydHtNQMzOekQuzPbI6zPS6naiegO+2pB/hsheyVlWVqG
	 6pnFGANsFAYmpG2Z1X93SKJAlmrmpERxJujJLMCf6c8X5WGXeFjMeoyvJryEmLO0hnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yY4sdtE3dBVPlQLRrDOshaKq5NhLj8R0ice8LmyGNbE=;
	b=yzpdWXyH1W2mqkd7swbsMqBLGWkNIl5udUkbdA1doss43aG/TalKgHLDYU5lqF/qLQ0F
	 xDDx47Up/hrkCIfczcWb+9hRTDbvyptuZX7d+3WclO0zA8NT0Q8YYqANjvko2Rqy4vfT8
	 Objjx7WYmjVq8vf0NJx0PIPY6toK89ZZ0E3Sp+xNmzrtbwGFZw9j3ZDcQ/DiXkgBrfc0w
	 w0TQNbmNKQiGKkHR5VTD9hE6kL+S/4xPD2shyWka3/i019uvresT9n1YLWI8weOdMeJwJ
	 /yAdm85JxNzDDqWPxaaGFTIgW4S08lzGDLgXhg+XAPBVyaQxf2LFzFqV0FYpfVgeiAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wg3LH9M6;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726B606A33E
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C726B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wg3LH9M6
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso876505eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793960145; x=1794564945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yY4sdtE3dBVPlQLRrDOshaKq5NhLj8R0ice8LmyGNbE=;
        b=Wg3LH9M6tfBjq5I4/bIE1uXcaFA1fgWulMuDqKjZwcTyHdAE33i9Yl89ZkiXo+ioBY
         7kZBGgCeIEe8feUN7hAh4MZFZXt93GYyYJ8fWqOgpZ6jl07Lon9ANCC7G7ZasRUWBKtO
         t8g2p4TgW0znUxdTTLh+WFJnurSIJZ24yAoRtiqGG+l6qISDPIwLa0l72m5yuhTGPOKS
         FUT9uSnozdN9TJMlh1NMUoEv2Empyc1nW7WLvnhwCpgxRPQucCxYEJ4d2xZCGOoZdeDy
         OoHvbTxegXOxu0SXvk+cxei2jAM2TconBLaWDTXZj4QxSltnpkRIfwqCAWJRDXB0J8wC
         sHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793960145; x=1794564945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yY4sdtE3dBVPlQLRrDOshaKq5NhLj8R0ice8LmyGNbE=;
        b=BXM5XmdMNRBaJuQtHrQrUWkSLdP37Tec7HNLflipdkgVLoXD/5RMfDFkXyTVwr2KbZ
         1VWY/UY1TEmKcqQiMjuEQI6CagC8KLCd2vEMr4RjdRVcqPmUDsJ+qvnlNIawJMBxvbv5
         jhMOd05/cTw0aEaVqBSoGE8GThPQkhAAtbxmRot9reM1I6y3dUbpzuPSfo8TQjYubA7M
         EPwj3RnsCgY+/bv1oVuMLikpS0dc4k0De/7xKzd3BZlyYzkvKWwVdtdLy59h2cZz6fMK
         fU+1N3jKx8cYhqnWivXD63vLJj+f9Rl8p/BVmf8eEPZhfx2vylpoiRT9YdgY7l6m/QwF
         ZM6A==
X-Forwarded-Encrypted: i=1; AKwUvBx+4URG2a2rAUGy6Lm+cxm0xaQSrGu7JMGBKuv6Y1NcmUxpt1M6sDqbWCyVWFhB6EkacyL/vIxSIjWolmbJpXeR@vger.kernel.org
X-Gm-Message-State: APuU4Z+uT6M94+Z328wUrfSVsnw8a08//R4Sqp4MaJBsWIiCbcgWR17F
	hvfW5U1OcxlRD4MKVEC2HoVm17QaPCa3zrK4yQEgxqbxKvJxibDW+9Df
X-Gm-Gg: AYBFou2Et++PyE51XRC9pKy4ruIlnMAm05Gh/2zPKHH+55fB5UmLfxmvvCvwoNnmN3X
	8YbTzqX9PuLka7vubt2EEJNCO6bdMLtJnbshq6hpEgURAhYPZaSdkj+2I38NAz/3fyFeIpyW5J2
	n8RFrJ6ta6DC/Zo3ZOKV4sqd/qcifUZa30uS3QZFeh5gfnDV0Y1t61Ujcih5A0N6TLQSTB/sWgv
	d0YU2SzgJ39VyKmw65kHonm8+VOB1diQTIMKnVm8+Z0vwxd/mmTxUTjPQ54eaHVFKpVR234EpkF
	XRZydp/8jH8fP/KRYgwXsUpGAPBmuh8CigSTSGX5ircDrcxERCLmg5eoO6LB6MbZqM2sUry8kd1
	Mpw6QAbOsmWVDScTBRL6mXyq3r8VZvh/0zyRkSN6QDzhTO+rSysq6K8lusq6oeHczw3zjS61apt
	t4keHEVBqOsNXFBTuqvgAHeOReZq9OEfEBE7xsd5RbGk932waIpqjXA9zNz6dB/A+45XJ15A1za
	kIQfUWI0ulGTxVawDsdgFSNK2Tbo6GUiyp9H6Nrw8Y6AS+9tU0KUT5XxgtZWOixylFm5NVjZoj6
	ai2NRVJGlWRUPc3ZlksfBMPaH0/Ts0sRWLeEct+xEaFDUI0hMg==
X-Received: by 2002:a05:7301:4709:b0:369:d8e1:7bb6 with SMTP id 5a478bee46e88-36f75a25e2emr2791294eec.25.1793960144628;
        Fri, 06 Nov 2026 02:15:44 -0800 (PST)
Received: from localhost (vps-56c092c9.vps.ovh.ca. [15.235.184.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm4681361eec.21.2026.11.06.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:15:44 -0800 (PST)
From: Phat Dinh <phatdt1116@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: security@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Do not resurrect cpuctx->cgrp after last cgroup event exit
Date: Fri,  6 Nov 2026 17:16:42 +0700
Message-ID: <20261106101642.494674-1-phatdt1116@gmail.com>
X-Mailer: git-send-email 2.56.0
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

perf_cgroup_switch() relies on:

    /*
     * cpuctx->cgrp is set when the first cgroup event enabled,
     * and is cleared when the last cgroup event disabled.
     */

It computes the next task's cgroup, schedules out the CPU context and
then assigns cpuctx->cgrp unconditionally:

    ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
    /*
     * must not be done before ctxswout due
     * to update_cgrp_time_from_cpuctx() in
     * ctx_sched_out()
     */
    cpuctx->cgrp = cgrp;

However, ctx_sched_out() can disable events itself. If a cgroup event
has a pending disable from perf_event_disable_inatomic() (e.g. its
PERF_EVENT_IOC_REFRESH limit ran out) that the irq_work has not
handled yet, event_sched_out() consumes it inline:

    if (event->pending_disable) {
        event->pending_disable = 0;
        perf_cgroup_event_disable(event, ctx);
        state = PERF_EVENT_STATE_OFF;
    }

If that was the last cgroup event, perf_cgroup_event_disable() clears
cpuctx->cgrp:

    if (--ctx->nr_cgroups)
        return;

    cpuctx->cgrp = NULL;

and perf_cgroup_switch() then sets it again. cpuctx->cgrp is left
non-NULL with ctx.nr_cgroups == 0, so the NULL check in
perf_cgroup_switch() no longer catches it and the next switch trips:

    WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);

cpuctx->cgrp does not hold a reference on the cgroup. Once that cgroup
is removed, the next ctx_sched_in() dereferences the stale pointer:

  BUG: KASAN: slab-use-after-free in ctx_sched_in+0xb1f/0xfa0
  Read of size 8 at addr ffff8881008972d0 by task swapper/3/0

  Tainted: [W]=WARN
  Call Trace:
   <IRQ>
   ctx_sched_in+0xb1f/0xfa0
   perf_event_sched_in+0x1a/0x70
   ctx_resched+0x32b/0xac0
   __perf_install_in_context+0x475/0xab0
   remote_function+0x105/0x200
   __flush_smp_call_function_queue+0x179/0x8d0
   __sysvec_call_function_single+0x1b/0x1c0
   sysvec_call_function_single+0x66/0x80
   </IRQ>
   <TASK>
   asm_sysvec_call_function_single+0x1a/0x20

Only assign cpuctx->cgrp when cgroup events remain after the context
has been scheduled out, so that it stays NULL as the invariant
requires.

Fixes: e19cd0b6fa59 ("perf/core: Always set cpuctx cgrp when enable cgroup event")
Cc: stable@vger.kernel.org
Signed-off-by: Phat Dinh <phatdt1116@gmail.com>
---
 kernel/events/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f36a3bbaa33c..54b87584c752 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1072,8 +1072,13 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
 	 * ctx_sched_out()
+	 *
+	 * ctx_sched_out() can consume a pending disable and drop the last cgroup
+	 * event, which clear the cpuctx->cgrp. Cgroup tracking follow active cgroup
+	 * event, so do not resurrect it
 	 */
-	cpuctx->cgrp = cgrp;
+	if (cpuctx->ctx.nr_cgroups)
+		cpuctx->cgrp = cgrp;
 	/*
 	 * set cgrp before ctxsw in to allow
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()

base-commit: d095321349222961813333277881b3c74f10b17b
-- 
2.56.0

