Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145026B76D;
	Thu, 26 Jun 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928388; cv=none; b=E3cT8E5acInzpnBA+ZUtaGwq4ytv1RPcxIDnWnlF/gsKVWFCHLKwn9ZIDnYlikJPSQOUjAZmNl9Ye/dX8YQ9tz2uJVmK8dw6VrgyN+rTtBVA4WZhTnCet0Bu6uMB3Ux2iNJx1ehopvAnHvi6DQaEtsKGYs08RyXi8/P0mu/w16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928388; c=relaxed/simple;
	bh=YZeTdplEFjKWkNAT3oKIZ/KV32S6JL60kCYy7TB+ar8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mU4+ouI8fLJzt+JYR5pgPcmjUF4WHAmDSSu4nY+EYjSPJLxwXSl4d9ThS6KQjBP+6KO4frlbo7pYaU00wk1Cv9UKLshc6qoL4rjLx6MZpCMEeAqIR5z4DYpPeZ79ZguhY92GgNoexeO4abKIpgS5nxufsyYQ4KrAxe/wqD8l2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kpqqG7o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lvTaFlHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kpqqG7o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lvTaFlHB"
Date: Thu, 26 Jun 2025 08:59:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750928384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXcm48g55NG0qwnxjRI7N+tlNvL13RoYy6cviIT+ATc=;
	b=4kpqqG7o9/RPkgDf5x0de4uYkiDOUmXtCIznjLwPS0Vsykot7bi+L+i5toX1wgChw3YpPv
	JsrTXKp0XDv05h2gda1sw/ksnpVXTfnwVEN9zr7Dsivol6Fzcpyihn/jgcgh1IaZfKTgku
	ZJu8JxIYVM8SyZ9IDK/65q2N2kQi0WLsQkKkl2PA+JFgU4sssvX+Bh9TdVH/WeU+ipPgIo
	zY70Ljw/c7U9WcIBF2/OATWKFkL6pglwrToABd/N6wGX102ZRHfsDnfrwWydRX22/ifJeP
	k5V6E48bPISDPCoas4FxjoGQzwi72h2hSYsmza5W0rydAv9w8c/u6FdfSWFW3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750928384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXcm48g55NG0qwnxjRI7N+tlNvL13RoYy6cviIT+ATc=;
	b=lvTaFlHBsj4UCVVPQf1SQvW9nGpNsufvoKkuyOJ275TIDFGRTJSkImsWjUxjz1/M8fTtBu
	NvPYNRMIV5mCcoAw==
From: "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/aux: Fix pending disable flow when the AUX
 ring buffer overruns
Cc: Leo Yan <leo.yan@arm.com>, Ingo Molnar <mingo@kernel.org>,
 James Clark <james.clark@linaro.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@redhat.com>, Liang Kan <kan.liang@linux.intel.com>,
 Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-perf-users@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250625170737.2918295-1-leo.yan@arm.com>
References: <20250625170737.2918295-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175092838323.406.18028759665594118727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1476b218327b89bbb64c14619a2d34f0c320f2c3
Gitweb:        https://git.kernel.org/tip/1476b218327b89bbb64c14619a2d34f0c320f2c3
Author:        Leo Yan <leo.yan@arm.com>
AuthorDate:    Wed, 25 Jun 2025 18:07:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jun 2025 10:50:37 +02:00

perf/aux: Fix pending disable flow when the AUX ring buffer overruns

If an AUX event overruns, the event core layer intends to disable the
event by setting the 'pending_disable' flag. Unfortunately, the event
is not actually disabled afterwards.

In commit:

  ca6c21327c6a ("perf: Fix missing SIGTRAPs")

the 'pending_disable' flag was changed to a boolean. However, the
AUX event code was not updated accordingly. The flag ends up holding a
CPU number. If this number is zero, the flag is taken as false and the
IRQ work is never triggered.

Later, with commit:

  2b84def990d3 ("perf: Split __perf_pending_irq() out of perf_pending_irq()")

a new IRQ work 'pending_disable_irq' was introduced to handle event
disabling. The AUX event path was not updated to kick off the work queue.

To fix this bug, when an AUX ring buffer overrun is detected, call
perf_event_disable_inatomic() to initiate the pending disable flow.

Also update the outdated comment for setting the flag, to reflect the
boolean values (0 or 1).

Fixes: 2b84def990d3 ("perf: Split __perf_pending_irq() out of perf_pending_irq()")
Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Liang Kan <kan.liang@linux.intel.com>
Cc: Marco Elver <elver@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org
Link: https://lore.kernel.org/r/20250625170737.2918295-1-leo.yan@arm.com
---
 kernel/events/core.c        | 6 +++---
 kernel/events/ring_buffer.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f74646..7281230 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7251,15 +7251,15 @@ static void __perf_pending_disable(struct perf_event *event)
 	 *  CPU-A			CPU-B
 	 *
 	 *  perf_event_disable_inatomic()
-	 *    @pending_disable = CPU-A;
+	 *    @pending_disable = 1;
 	 *    irq_work_queue();
 	 *
 	 *  sched-out
-	 *    @pending_disable = -1;
+	 *    @pending_disable = 0;
 	 *
 	 *				sched-in
 	 *				perf_event_disable_inatomic()
-	 *				  @pending_disable = CPU-B;
+	 *				  @pending_disable = 1;
 	 *				  irq_work_queue(); // FAILS
 	 *
 	 *  irq_work_run()
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index d2aef87..aa9a759 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		 * store that will be enabled on successful return
 		 */
 		if (!handle->size) { /* A, matches D */
-			event->pending_disable = smp_processor_id();
+			perf_event_disable_inatomic(handle->event);
 			perf_output_wakeup(handle);
 			WRITE_ONCE(rb->aux_nest, 0);
 			goto err_put;
@@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 
 	if (wakeup) {
 		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
-			handle->event->pending_disable = smp_processor_id();
+			perf_event_disable_inatomic(handle->event);
 		perf_output_wakeup(handle);
 	}
 
