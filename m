Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03021B0139;
	Thu,  4 Jul 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112672; cv=none; b=qIR1BsfbU6jz44EkTlpGfq9SJ07vrwrzezJdZg+P5yuIpHk0oMrkzabShMolWt14juQG1utv1QVRQZaDqrpPZaFt03Hxh0bHKHzZ3sHz/X3LEDxNgLfvFeY7u7s1Z8pvC/v8SaJ1l/Nyr7S0PIICOIi3noRNBIDI0XafABw3aHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112672; c=relaxed/simple;
	bh=WXw3Qwht7czrmsx9ahtRrb+RTNTA9mu6D57a61bCLb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3vNxD0SJ90fRCmy2saHJGpRBgVJsPFN7FRq1vYGqPldTvcbr5ipyuN/wRyQrHn5tDNvqS/rnaxKP5aaMwEyRZr/F3rqf1oEconA5vnfZprmOrHpzpmm0YO5HGLJbniNkUyzCBooxX0NdxrmJuw+eRCCOlgoMBAYAFsm8ZMpq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvyoeU2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I3RXEBTD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvyoeU2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I3RXEBTD"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtdLMQUS4gOabICyiywJKeAVbmQAXHIv0kkFMgjqTTg=;
	b=XvyoeU2NSNXT3ntLU9B6SfomGMoTWODkAIn72dXP6Vm4wGUQEG3u6dhgj4SffYbPQu2Nkj
	xZs0LaxjMLuUdGF4sZFcrMRRghBShQHbs/3CkSaIAaBDJ/O9JVUdeAVdEJZG9gE9a+6xt9
	5PPa/2908qE+cGEd84I/Z/4+BG1WyG6SStFHM3EAJTniuIT+cVfUYClu6zHSpjNR4ZvuFl
	GHDjqDRZXkcq7/3is93J399pKhaKEiaBJU+jyiHUSXxGR026ig5VgTGkgnOkGEfoJXzyKq
	DpygTEOsGnHEkUWy4/VKf8Ra1SlUSdqSWjGdBOOj3vQgxwq5+vl7fS/ODZwwnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtdLMQUS4gOabICyiywJKeAVbmQAXHIv0kkFMgjqTTg=;
	b=I3RXEBTDuMkqbwi0Fmuhc30oSdyx1JHC8rIa3q6kplhgGvoPWg9SPSrLDcj7zrUZKQnlds
	UBWGqHoM7YX/UjCg==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v5 1/7] perf: Move irq_work_queue() where the event is prepared.
Date: Thu,  4 Jul 2024 19:03:35 +0200
Message-ID: <20240704170424.1466941-2-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
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

