Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF731B3F06;
	Thu,  4 Jul 2024 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112674; cv=none; b=fN2yKMfqXfNQuJV/JLA6IPQYwkwX+cLLZv/eX+eoF0A41ot+ONYBg2NkcRdp0ZPVWahwzNUFR784OodVtfi+OVxA/IhaNz4o+XTaRksX/wrRuXWBiEWz/1fH0JIZlST5tCDSI5tw1VH0jrNSmZ8QV4aFDlQZTlXDkIOvBHLCNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112674; c=relaxed/simple;
	bh=aH/OGvLUI9SJrDSPzGOMJ+Bjl+QQ78TExgwXePwAdS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+67qzquwrQsIha+quyM58k0hmISCVGxH5yR1q2+HIuK27IZfQW1MmzDuox0BfsmKS+2/rvXYPZ9uTCAPd3rVGQ5j60BC0RswzGdxEwCjtYpAU9X37T0rIbyCTaBul0Uy/7KNmpzgrENQVWgBuN9K4zYVgjWMy0Qh85ZfaYWkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1BvjwNtL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzOH1PyB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BvjwNtL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzOH1PyB"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHWQ5GgUYoJtg5IuAZ3WhjnGiXq5JPhWYhqyDGJpC1Y=;
	b=1BvjwNtLyO2iJGLwlK0SZK0RFlhFekkVP17WSg7czIyyP9gDOU0lBbOv1CyqnCBw9sov0m
	vRKtsREuAMBRHYBoXkJCNa7vSlEFb+NjhcI5P3KCHC7iL6ZRpAOHPdhOM63t9vrpwRZeQm
	DpZh1pkMfvbHOQoZ0wqHsKw42Qd4Th6T81vcuiLl5BZS45i994+FyupPTYN4EL9QDlgDuf
	7tVH54bOz/0XOde8ibtJl/FQLbDtsfYmp211EY7/5WtYirVNXPHcx1o/TEgYA7qyPO7zgW
	rteAarjZBpqnJ1Gc/qk4IXMNLHmSL5gW9DxlnTggjrTdJ0lWXMZveJMRsLIjqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHWQ5GgUYoJtg5IuAZ3WhjnGiXq5JPhWYhqyDGJpC1Y=;
	b=BzOH1PyBNSVd6ur7CbdUDdPBVz/8DWbcCnFPzNiks5GrqiyDSlVxmMhieFfKGW3Gw/SapY
	TkEbquVojCLDh/Bg==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 4/7] perf: Shrink the size of the recursion counter.
Date: Thu,  4 Jul 2024 19:03:38 +0200
Message-ID: <20240704170424.1466941-5-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are four recursion counter, one for each context. The type of the
counter is `int' but the counter is used as `bool' since it is only
incremented if zero.
The main goal here is to shrink the whole struct into 32bit int which
can later be added task_struct into an existing hole.

Reduce the type of the recursion counter to an unsigned char, keep the
increment/ decrement operation.

Tested-by: Marco Elver <elver@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/callchain.c | 2 +-
 kernel/events/core.c      | 2 +-
 kernel/events/internal.h  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392cf..ad57944b6c40e 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -29,7 +29,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
 				 sysctl_perf_event_max_contexts_per_stack));
 }
=20
-static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
+static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
 static struct callchain_cpus_entries *callchain_cpus_entries;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c278aefa94e76..bd4b81bf63b6d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9776,7 +9776,7 @@ struct swevent_htable {
 	int				hlist_refcount;
=20
 	/* Recursion avoidance in each contexts */
-	int				recursion[PERF_NR_CONTEXTS];
+	u8				recursion[PERF_NR_CONTEXTS];
 };
=20
 static DEFINE_PER_CPU(struct swevent_htable, swevent_htable);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c033..f9a3244206b20 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -208,7 +208,7 @@ arch_perf_out_copy_user(void *dst, const void *src, uns=
igned long n)
=20
 DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
=20
-static inline int get_recursion_context(int *recursion)
+static inline int get_recursion_context(u8 *recursion)
 {
 	unsigned char rctx =3D interrupt_context_level();
=20
@@ -221,7 +221,7 @@ static inline int get_recursion_context(int *recursion)
 	return rctx;
 }
=20
-static inline void put_recursion_context(int *recursion, int rctx)
+static inline void put_recursion_context(u8 *recursion, int rctx)
 {
 	barrier();
 	recursion[rctx]--;
--=20
2.45.2

