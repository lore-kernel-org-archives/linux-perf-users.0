Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661121;
	b=DNeiLc0fQ97HIXbqbBQxAa3FdRGxFTxTIwmLQ0GJCvQcjA1qT6RKg0Wg25pgWAcR+QoO
	 Ey0lNK9ViB4l/oG94hHoBK3f7m11moGsPgKrx7fubwnMjyJxYZlXGlQMFvpxQAs36W533
	 3mlZ1Dxr3V8qTHsLYzg46lHEqaKtyuqmJEtuIrhIBZJkffARoiUEA0tS1gUSMthBmjz9N
	 x51WgMZMYfRT5iXATSXu1VLfN+3X0I3xogshLiz/vi1YQqjucU3oWkbZc8e/9YlWV8nFE
	 xaUizxMcJHa5aiAvaBnQQMsGHBuD0YVj7t7e5orj4KMBARkrIir87wKum/tbUd5DGAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=EBzcLWZZbm28xGNzws1a2EKWf3kVoVN3oPjNMg6oWJs=;
	b=VgHK9m8fGMiGzD0gL0b+enY1L3jX7HEtC50+NVtBqiQSuHJ7PgqJkWdqGGCUHnduxScD
	 MnSY2EDkLJUJyYWu6QLJ49vO3CQqyI52IOpgrRDpOCSD3MhH6lhhgFoEWinCuEBcl586j
	 mswxm0cHZaAUW2eGghd6vPlDkCsC6ttqgl9umGRzGwb0co9Fe0FZ9BqO1dLTR/uKH4PrM
	 e3Hsg3+VZWq8IpJbydaEaV7vzrr3c/FfMIsYdJNSsbKsLzfdLiLH632lBsNK7yp9bBMq4
	 fl0P7s2Ca8O1BxwhwiXT4YUaQulaNFUqcONqb674WgiKbwbNTqcStbJfJsmEd+FzuEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dKx1GMQk;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA7606A32C
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EA7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dKx1GMQk
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4541018eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 15:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793661120; x=1794265920; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBzcLWZZbm28xGNzws1a2EKWf3kVoVN3oPjNMg6oWJs=;
        b=dKx1GMQka+i1MOP/Adf6/y+TirUPihCS072qQf18Ny8Lc+CqE6Xgg9lO4A8jk5gBmR
         m8+vjJ7Ejf1AKzxW5qIKcSkUS1TGAQzmjnviAfdb3l9aiLZUv5dRfFdwAdFWz/U1hrBc
         edZRdKMxUUoc15bhWBeoEIe2ANX63b6xNPfjEB7KHn1+3VFjH2NU6GYUFaXjBAIETTLz
         MTI90hPNsvVnG2Lq6HfnGkThwz9UrJhJiFVqjpYIcwXqWurexkVRAYl16NVqunmORmSO
         99oYf2BnoAU/APoZ2li+pMMH0zGFe3KE6Is1dV++bpyqRdpcbsjkz+8hpRPgwcJshDh3
         NN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661120; x=1794265920;
        h=content-type:mime-version:user-agent:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EBzcLWZZbm28xGNzws1a2EKWf3kVoVN3oPjNMg6oWJs=;
        b=BpZy1qg9Zq9CjAC/15SwdaX4+ITsEMnjXvrWb1P5/wE73c1PodzANj3ROrzhc1UWVr
         C46XJXYVMih0QpOMC8buFJNj23s+SWF6Epm6XvHoxphAp0k9raQNR1SBDWjRkr4eAKWE
         8mLlS/xuY1pKgQlVVBIV0tVDlyXjBFwT6uGUk9TLB+QTnr8rjwWbNBzyLvuwSFEmQmeU
         E31iEMvUGSd13aZO5jiUjuSwfu1heu1YE0lIF94PEOiI5ar6l5SCXQq4NjHMVrUhttdQ
         J6sbRFlytiSxhfdArcI4bRo8TX2oIkV/30RfWOpdJ/KVust0hyXsLSGAC86P2h78JVRp
         MJSA==
X-Forwarded-Encrypted: i=1; AKwUvBy8OlyCuApS/yCLiqwaiez9LjJ5ah9Ng69NEosFAx1mvgwV88iCBd/eHMf0RvxcDoBWXQ5qxXGBT7q8CeMGm7TX@vger.kernel.org
X-Gm-Message-State: APuU4Z9bq7NTJX8amSFXzCQlABEQqXPWswkfuDIkOTyblIjCi1WyoEQn
	kMIIynXo9hCpCvnNWVKgTelGVtqmFWsJ72gN6LlleBcWQohse1Wg3q96XWZWOgPgHQ==
X-Gm-Gg: AYBFou2m4rQd+GO9rQAi/brSs5EL2f6aN10bO7hWf/vQg9dIC48hv+aW4ldBL5phPUl
	2iBPaOO151xZwaqZWUMk4oXj+Kv6VTXWR7tobWOa8+UkucUbA9Nghjity3gfapjD+D7BMB6xXPy
	AbbjXoQAxN/BI8Opa8WGFHgk77nyrRtbDkxY0gDg0OZkFw71cy48C8hVEWQy8Gnh9nttmZ/C+PZ
	KUrCHoXQeTANtOxiUXQof+HnM21ARyQJPSn/fZyCfNg9IAhA0gAM4llx6XDUkRW/mTQyScn8vlZ
	xGbRbC2nCNr7ybS17YC15W8MUR1uDGfnCQOzHZ4F8ajUtCw14Qf+t9tCnGjRv1JAXEobysSwPoC
	3WIPJd2hX+K75ubCaKnZvUma9WD8Ak/gNtG+omwRVLQERCPKE2Ogr/cMZswNW2Ou1VpJjpG26nq
	UNPtwiqArWjxNHT4LkEmtqHyzyVKzs1eT5sVuFmB492YeGl76gSUbHdUUZ5Yz8pFWKkoQiHBh8A
	wlPjcdGDdID3UvbQe147Z6s5UPOCfTA+FTZy6X5+TZdvDPFAZlezKBAzM+Q5lqpPJlSe1HaLrUL
	ESIGZoAH5qZpcKIUuHRdeSXZEgwCR3LjQ0eylfBxOHooqSqASze1VleS5hTo
X-Received: by 2002:a05:693c:895c:20b0:359:ef9:9be3 with SMTP id 5a478bee46e88-36a4236a466mr16854339eec.11.1793661118925;
        Mon, 02 Nov 2026 15:11:58 -0800 (PST)
Received: from bsegall27.localhost ([98.45.141.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36b13bd87b2sm594382eec.28.2026.11.02.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:11:58 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: fix racy update of cpc->hrtimer_interval
Date: Mon, 02 Nov 2026 15:11:56 -0800
Message-ID: <xm26se1ihlqb.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Updates to cpc->hrtimer_interval can race with reads either in the
hrtimer itself, or other calls to perf_mux_hrtimer_restart. This is not
exactly expected to be a common config change, but it's easy enough to
fix.

Since there's already an IPI to each cpu to restart the timer, and all
reads are with irqs disabled, just move the update onto the target cpu.

Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interval per PMU")
Signed-off-by: Ben Segall <bsegall@google.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/xm265wykhyrv.fsf%40google.com
---
 kernel/events/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea71420..3415e4e3c26db 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1330,20 +1330,25 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
 	raw_spin_unlock_irqrestore(&cpc->hrtimer_lock, flags);
 
 	return 0;
 }
 
-static int perf_mux_hrtimer_restart_ipi(void *arg)
-{
-	return perf_mux_hrtimer_restart(arg);
-}
-
 static __always_inline struct perf_cpu_pmu_context *this_cpc(struct pmu *pmu)
 {
 	return *this_cpu_ptr(pmu->cpu_pmu_context);
 }
 
+static int perf_mux_hrtimer_interval_ipi(void *arg)
+{
+	struct pmu *pmu = arg;
+	struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
+	int ms = pmu->hrtimer_interval_ms;
+
+	cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * ms);
+	return perf_mux_hrtimer_restart(cpc);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
 	int *count = &this_cpc(pmu)->pmu_disable_count;
 	if (!(*count)++)
 		pmu->pmu_disable(pmu);
@@ -12763,17 +12768,12 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	mutex_lock(&mux_interval_mutex);
 	pmu->hrtimer_interval_ms = timer;
 
 	/* update all cpuctx for this PMU */
 	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		struct perf_cpu_pmu_context *cpc;
-		cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
-		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
-
-		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
-	}
+	for_each_online_cpu(cpu)
+		cpu_function_call(cpu, perf_mux_hrtimer_interval_ipi, pmu);
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
 
 	return count;
 }
-- 
2.56.0.385.gac671c819a-goog

