Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD919B3CE;
	Mon, 24 Jun 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242861; cv=none; b=OmMqdo+vhJzuaNVESZW1/+3NEDjAQJJfN++aG/VjywQuxzz/1enrQHYukwnyIPXfKN/1z3RRW+hy6d/zMDVe6BT42llhx8c9x1OwCEgej5PpqvpqX3s3S8Y49Se/LUulVnRbv1uXgp4NDDIiXQb1fv+1t2tuZ30t6BobTTaoJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242861; c=relaxed/simple;
	bh=kC5TCeCXVnotUYnZW4koAmgq/beJ1ja5YqoIVqHEq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp8MYxtytY0YhH29c5AxjHq+TNjJSMBjwHxbCc3ZRMR4Up+gcFPKomdqZdvGF04Y6uLswY733heQExRR4/49AHM1KRjNRNpbSCffZy81eLiYee9CEfUjTxRnh1gvs++GB1dCANf4ozvMSUiszt+C6O+5sf2qb8VgUSXIFGAqOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2UD3NRX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odwh5+KR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2UD3NRX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odwh5+KR"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31fHSUjnkfqCuDeXZGlbP04Jz3JzNZ4WYRhzRxDpIFo=;
	b=l2UD3NRXBxB0yYObGI8FrUHvymKtHRWQgany4CSk+ETMF+inUBXnvuSBAtuonwfrK8Scbp
	UZYEB9+qeW+OFAJpwEdHQEhWNvHDB1pu9w3/FLJZf7gTs/7IXCc36rpQeAv4IAR5/Vw6PB
	YuKmu2gJ65Xb6mBYCSgeIFuM3ue0ep8jqOLmREOIuiJ2/7/JI/yqNAfSumBaCisZUdNGlk
	N8eZtDLtTu5CYsglp7s3oFn3TSAb4ccOfMJJnnwziP7uTl8LYPPMQ9uK4aG3z2Dc/9Hwu+
	ryIslLHfVgkUkZW0bVtDtyLGOiC3/4tYEC4hGntwrDTuoEx0zd8knv8AyEYnRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31fHSUjnkfqCuDeXZGlbP04Jz3JzNZ4WYRhzRxDpIFo=;
	b=odwh5+KR0F4tcN1Xm+KDepmvbkFaZ3WBZ5fggnyRuKUwnFCZbvixg/FRsjSXMKKPFWHrca
	Bk9mp1zQoUnilkBw==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang  <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 1/6] perf: Move irq_work_queue() where the event is prepared.
Date: Mon, 24 Jun 2024 17:15:14 +0200
Message-ID: <20240624152732.1231678-2-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only if perf_event::pending_sigtrap is zero, the irq_work accounted by
increminging perf_event::nr_pending. The member perf_event::pending_addr
might be overwritten by a subsequent event if the signal was not yet
delivered and is expected. The irq_work will not be enqeueued again
because it has a check to be only enqueued once.

Move irq_work_queue() to where the counter is incremented and
perf_event::pending_sigtrap is set to make it more obvious that the
irq_work is scheduled once.

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 586d4f3676240..647abeeaeeb02 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9738,6 +9738,11 @@ static int __perf_event_overflow(struct perf_event *=
event,
 		if (!event->pending_sigtrap) {
 			event->pending_sigtrap =3D pending_id;
 			local_inc(&event->ctx->nr_pending);
+
+			event->pending_addr =3D 0;
+			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+				event->pending_addr =3D data->addr;
+			irq_work_queue(&event->pending_irq);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -9753,11 +9758,6 @@ static int __perf_event_overflow(struct perf_event *=
event,
 			 */
 			WARN_ON_ONCE(event->pending_sigtrap !=3D pending_id);
 		}
-
-		event->pending_addr =3D 0;
-		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-			event->pending_addr =3D data->addr;
-		irq_work_queue(&event->pending_irq);
 	}
=20
 	READ_ONCE(event->overflow_handler)(event, data, regs);
--=20
2.45.2

