Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4C4F6466;
	Mon, 19 Oct 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415395; cv=none; b=KMEI2ycGqI/YPfv1iL7wdJpjk6PPWdA3x/Nve45N1SgCc1W4kdAgO/qLsGW5G0ysgCMAdK8EmGKRqSZuB+mffscsxxaTCRF3SY+NzYghP3BFS2lb95Nd2HfTs7YjR2r/J5ybAJ2iVx/VwNIk8yDcWQj9LSINgPO3xmJnBsZoNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415395; c=relaxed/simple;
	bh=xhbcid4awYtIfo2lynkIvt5nmZU+jAMrW0hLor/9geY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/wzfPW9Akkg/I2E+A/+Hd0L1RLSlym36Xuz5jRU5rlqumESSQolcKXWKePc9ZlldgRUkAFxC2Y/dbYrz0IshXjsir449Zp1BFF3xdJVkHYPRLQZmT/qAzHU5Hrg8h4jxmQL7ino6HnZXh+MprWjaTwyY0a4oT+1FaZimTlqHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2qG8hV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2qG8hV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B7C1F000C4;
	Mon, 19 Oct 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415394;
	bh=6hXQl+zNVR3lDmBRZdgLpcRixFxhz+tO2HHJJfE9T20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2qG8hV2QqD42d3XalcdrpqtnVhMxBRjbkj6arkz50CBz7nBtuS3mznGWS4T9SaRu
	 r2PTF4YC8g1NxoSFt9mdM0MGzAk1pR/9cesd6oZGFNOybrn1dVIq1bKXPSv3YJ9z2D
	 SbqB125baSuLU+QtgaRfzoo4Zn0YWhIj1Duwnu3Ru41fPUsiP9S3/FdDTLm7tuA6KD
	 V0F4wH4WuU47s8OuXP5s1Ylr05l6ILIXs7Q7l+psSoZx3qBBEG2/o/HPcbcWAdasil
	 8QXoNTmC46dohAUI2pv57Oqwivc3WuECMT70SsZtLewKn7WFLBIlxgjAqoHKhpAydR
	 rIJRFCHpzK1wA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-perf-users@vger.kernel.org
Subject: [RFC PATCH 16/49] cpu: Move CPUHP_AP_PERF_XTENSA_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:23 +0200
Message-ID: <20261019130856.49711-17-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019130856.49711-1-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
all the teardown callbacks while stopping all CPUs in the system. This
doesn't mix-up well with running RT or isolated tasks.

In order to transition smoothly from global stop_machine to finer
grained synchronization between teardown callbacks and the other CPUs,
a new stop machine post function has been introduced to be executed
after the main one with IRQs still disabled while other CPUs can exit
stop_machine().

This state doesn't have a teardown callback.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5a46372a8501..c20a822df803 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_XTENSA_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
+	WARN_ON(st->state != CPUHP_AP_PERF_XTENSA_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

