Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616084F7992;
	Mon, 19 Oct 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415391; cv=none; b=V4IuzP+I7ZVSY67iSK+yNQ5yhqtBnC0k1ZPYZ+NYQTPLzm3EU7BBR7VqId4da8zQ56MIdTw0e14ZNyUJrPUfw119LB78GpIt4jSDrmVnld/3IN9CLBiIwqCtzBjX127yw0w4TnitC3QQqloCktQkvMHMBEY/86MH3so93dee41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415391; c=relaxed/simple;
	bh=yYrOIWQL/opyTpIrb2xKNBMWwuA14YOKesInV9W9lk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PisZt9jN+lDgSxZmwtPlkBEGxoi5lbMUki/SD66TwzIxkL0KCxFCvcJKQ7OXeaDSWqjaktHhnlYxq+AzVnymMN9dyGK0gH5rXEE3pEmhEjDgOLOAyyec6u6TGnZVfGLn4GtA96hKLUt8l/v3IFuSQR/zHzDzBLMXDInvCejWpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bReEH9di; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bReEH9di"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C881E1F000C5;
	Mon, 19 Oct 2026 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415390;
	bh=O3Zt04kvxbk1MJcF/cLaxfsFvhF9W+DPXd59cPFSbSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bReEH9diQcycv48vWoIt8PmIA4QtS6I7GyHsUBul/fM5pmoDmVw+Hug1aaHGoyCKx
	 1WyWveQSDmDHNiZzHqjU9EItKTgPWIQn+/1pb67RQAkaeV3b/MIupUHpDToxRmAMH4
	 6Ld+qY2xd9RPBrncHt0cOGjaCPwd+d/rf+vLCC9MbEdqslJ3o9TJvKfYEpu1hlRjbv
	 JRIAVbfEC0YTLB7h9fnPDtqPuRpF0Y0yqvAlVom2XEL62qqKojl0IT1k+qC79bhQDi
	 dGVlcJULgQC2hQ1zbw8lOJWmUk9pzhUFeYM5UVYS9f+K6ZltUnjSY+OmO2Pk5jonjV
	 MUyUQ/xl9+53Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 15/49] perf/amd/ibs: Move CPUHP_AP_PERF_X86_AMD_IBS_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:22 +0200
Message-ID: <20261019130856.49711-16-frederic@kernel.org>
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

Here the callback only restores the IBS interrupt to the normal priority
on the local APIC and running it concurrently against other CPUs
shouldn't expose any kind of race.

Move this teardown callback to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c37fa1272d57..5a46372a8501 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_X86_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_PERF_X86_STARTING);
+	WARN_ON(st->state != CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

