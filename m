Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECE19B5A7;
	Mon, 24 Jun 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242861; cv=none; b=aFAdgdtVAZL4eZpExKGmhT0epUVOLKBzq5S4l8+E9Vj8uw9sVvCti1dL2A549O3tqjpUs+hsbmN4ZcdaGx4+/wTeKJ3vbCiuDuj15KGqpxwjr1bDUzvJmTs/1UAdIks3BpaSOlbxyfr65SqXrKdclZr7BAHQD3bXknjdXC51U6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242861; c=relaxed/simple;
	bh=3JEi2mm9pBJD+RvTJk9tdhJuESSkGlA9UW7AIj5AYEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPouE2VoRIpuvRj67vWf+MyGQPoLuNRtXR+sgJqu6mn3PD9diStCOEGnAhEqVyhO4PbmNfYX/5+XJlF7ry3zhMWS7hDVgX7TCndE8RDvNZ4ZaMQRy84IWr6fdWq2bYtLnfHRdlChkBsazyVE/nIs4Gpq+l+C4s6QYabQj5myYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afqkAZcT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tzrEguQF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afqkAZcT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tzrEguQF"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi83GkckFWEiz6/C9dwTxNe7sCPp8ns2flKgLfGxAk8=;
	b=afqkAZcTx6EFALmeS6d2tGXgkFryA/WJFi3Sa3LZludr/pd9tiSbzUbl390EdeNWr2XMcS
	VSyQypsRFaycQ2/XuGRjt7+9Jcm4vfKLRRJtuF9QZHaPdBqBzjDjdhSQ9HRwGJj8/b9jjj
	D2MZBdTBWgNd/oAjNpIB0VYkGwqLGMShA0R+Ws+nNf0e53bkyVZrGaLPjJgfb3H0CMzuU3
	Bv8jD3NREr6YMtYmv40KIKH4wjyMugoQ1h5ajeu22GML6TMiy91eQCCOyNV9adYSh1oSJw
	ymrrVkyv8/RbAH1Rzh7cKqSWi8ihp84Ts5XQcqdO2fDW4xLhe4atWbqXABut8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi83GkckFWEiz6/C9dwTxNe7sCPp8ns2flKgLfGxAk8=;
	b=tzrEguQFAZ2jrCuKLsYv9ZE1dkVSa+bIkCS0alM6TIr6IujyWgpjBdmUC24XF+pRj+6WA8
	nL3niHoPU1KMVACg==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 3/6] perf: Shrink the size of the recursion counter.
Date: Mon, 24 Jun 2024 17:15:16 +0200
Message-ID: <20240624152732.1231678-4-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
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

Reduce the type of the recursion counter to an unsigned char, keep the
increment/ decrement operation.

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
index 6256a9593c3da..f48ce05907042 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9781,7 +9781,7 @@ struct swevent_htable {
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

