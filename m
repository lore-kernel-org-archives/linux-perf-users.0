Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEAE35C6B7;
	Tue, 22 Sep 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039610; cv=none; b=NfdcPX2zdUNa/d1jqez0aMdSi0ZDm02QrY9US4Rtrv8XykcYosb3denvEvcZMt476yRMsnwbT7YFHdeUZi2gCHWSXBk84keVOxj3SwU/TYUCxnf8jj+DA81XBhlsD3C4g8h8bV3PAVwkvVAhN7wT05xEQNXZ5B1PyohiDmWzPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039610; c=relaxed/simple;
	bh=Ej+weExnuvVg70R3r/g50KjZGMf2VssZCojSw8Yq/vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UywzmsL0rwikoU0nYhpXvvEPMxefZMX90TX0ewtQT06sTXVHxmCRHCvRQimR+lmyWJjNfSBFbykrIgQk5jj8iO1kxFYi4fqergSBTT/2wHvxCJ3QxjkSULY1cSLOzpBP1sw0yogpfs6qTgPuXhPgJCFesQ7EOBtBu3q+mtMDQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+AKq3jn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+AKq3jn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11E12C2BCFC;
	Tue, 22 Sep 2026 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039610;
	bh=Ej+weExnuvVg70R3r/g50KjZGMf2VssZCojSw8Yq/vs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M+AKq3jnswkOZ20GbUf6Umzl7HgKevNtShVxbz1NhWPCCfrLwfiGZVPK23YJlNbu2
	 efBTEwzrIRwXwbC4X2ROOzbtehV4M2V/naSpL0vV8S3OheDC90/YoDhMKfRr/qpMM4
	 n6pxtJq3PccHBgmU7tUP+w4rP7py/QdIc8iLGoMQ7pKn+f6HJFgiD4eI1UuMJmRPYl
	 C8018zNjatXw6DfHIu+u1jnb7VZy1rmMdTU/FrQDi01HjN3zgMEV8NLAPScknrCkO7
	 EX3h/FlyOp/u2iXexXsBSkgRQNs0V6/h0i3Y7n3LxW3GEL3r+8lO9hZ2uQhBKuEopm
	 1AXk6wgwc9jwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7259C982FD;
	Tue, 22 Sep 2026 01:13:29 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:13:26 -0400
Subject: [PATCH 3/3] perf/core: publish perf_event_cache with release
 semantics
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-perf-core-v1-3-ac56a719c02b@vt.edu>
References: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
In-Reply-To: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039609; l=1494;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=9z+ZbfX8GmgFVzF7LoEQWgxvxhbbqsC/PXink/Dvp1s=;
 b=/70/JM8ao0JfXA+VcpOryBnR41mfWf9xjIYk3gz4OXDmfOP19Wd5NrCTzSFwjArTlKZ++Kqap
 tBzOO0xuW58CIFQyCix5JW7wg5t7AIPKjOJP6ASSRmcPYnqO7R4sO79
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

perf_event_init() creates perf_event_cache with a plain store, after the
pmu_idr has been set up. free_event_rcu() reads the pointer with a plain
load from an RCU callback on any CPU.

Store it with smp_store_release() and read it with smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3b5c59263..74cfb13fe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5313,7 +5313,8 @@ static void free_event_rcu(struct rcu_head *head)
 		put_pid_ns(event->ns);
 	perf_event_free_filter(event);
 	kfree(event->addr_filter_ranges);
-	kmem_cache_free(perf_event_cache, event);
+	/* Pairs with the smp_store_release() in perf_event_init(). */
+	kmem_cache_free(smp_load_acquire(&perf_event_cache), event);
 }
 
 static void ring_buffer_attach(struct perf_event *event,
@@ -15404,7 +15405,8 @@ void __init perf_event_init(void)
 	ret = init_hw_breakpoint();
 	WARN(ret, "hw_breakpoint initialization failed with: %d", ret);
 
-	perf_event_cache = KMEM_CACHE(perf_event, SLAB_PANIC);
+	/* Pairs with the smp_load_acquire() in free_event_rcu(). */
+	smp_store_release(&perf_event_cache, KMEM_CACHE(perf_event, SLAB_PANIC));
 
 	/*
 	 * Build time assertion that we keep the data_head at the intended

-- 
2.43.0


