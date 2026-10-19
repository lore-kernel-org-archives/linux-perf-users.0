Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE934F85C0;
	Mon, 19 Oct 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415406; cv=none; b=a4gFarMiXvZJ/yqR+N1Hj4WVcbgffkkKiSord3yBMLkkjz2w4QVEdG+2sciwyRpW4jzUPwvkvUl0l+zfhe+DKLp+2KQxFvMrZQf++H2Bh/LSMoPNbHll/PykvTYCukxydGlUVMJ1J/E/m92P4tNQoP5dSU4LdAR3yFtOTekUi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415406; c=relaxed/simple;
	bh=XOMLzrua8jW6fwKKzfLrHuCpk+XvYTexg4u3xo8uGb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McKX2fpi4kHiAdGH6AkQn/SbXEa0+d8sxdzSR9t72hnB46zF7He4Csaiwg/5z4HBPFvQcpgqZ4ELfYexWN3e0JqPbmS1q3ww3k+nNYiXLs7sG2/qE4AE8KVySJtQVM7KpRCRzubivMShCmO//OzE/8OO+hVypb/SrAYHyiZ5nH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaj/uQ0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaj/uQ0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB22A1F000C4;
	Mon, 19 Oct 2026 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415405;
	bh=5KUzkwxT6B3k7iZO7xyoYKNfooeaFIjmsalL+8Yuh5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oaj/uQ0xpKpH+RbLxHdNBhU0cH4rJi/VrWI8reVtPQ1VmXDt57S4itU06PMtqTy33
	 ul08ke7/hVuzuRe7tWsdSBPIxOv1mGIQCg6ESobCEJ3w94Hv9FoxUyStbZe+tBqLIb
	 NnLQqczJfhVQupMFx2i+0YGj+ON+cQ0hyQy7jGudFAMs3mgMFD/7zpQjG4PLV3y4QF
	 gLpgaaQMMxbcgZZ5yt584n13abXYrWYtxQkB6dFjAK2KPxFUYd8QhnOYwuQbeLHlbn
	 HcTLGCGayeRAqsO/Qd69JerrzwbcUSgFESjuqrAhnekFWFQ94/tqQFy9SevwDgByip
	 EGrXfK//znusQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH 20/49] perf: RISC-V: Move CPUHP_AP_PERF_RISCV_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:27 +0200
Message-ID: <20261019130856.49711-21-frederic@kernel.org>
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

The teardown callback here:

* Disables the per-cpu IRQ
* Disables user-mode access to the CPU counter
* Disables the shared memory snapshot of the CPU PMU.

All these operations are local to the CPU and should be able to execute
concurrently with other CPUs.

Move this teardown callback to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 95cc6655cf7b..c69a265e4383 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_ARM_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_RISCV_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_PERF_ARM_STARTING);
+	WARN_ON(st->state != CPUHP_AP_PERF_RISCV_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

