Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896315;
	b=BPRA2+p49PfYr5ByyurBsOgjbRiJ65wJ9L2tralJZuX+Mz+mDqTobupWsb6eUn1NQXKy
	 gY9Fq++VcvPpdWu668zcXPzq6PdHuNvdHL+hTDa8i8f/Pl7S8X8hz4xnitelmoHqJJBeG
	 pbCceWE+aiRGYrHNZ+WyOrSfm7DijlfXlfxe+MSOjz9l+ghRpTE9eKBDMf841gRcTjESs
	 q+l4JcsUYsLky+iiNRIJjZwsLQRdhZnXelckg5ptRgDshAzimJ8SrOxGG8FYOyetxlW0k
	 wenoA4Yqfys4lVW9laob58IiP6N5gj+0Vsj3hKjxkiW7zR8z3zacY4sa3qEpDP2v+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8eK6dCF5543wx7gusgRew8o0p/wgDJF+4BN0f6r3/Pg=;
	b=BfxMxIaWaYjyGeG0gzkoLusHqUAaK9c0A0pPe+Bm1Cdmx4qCFtYOwxWx6oOD4Eki2efn
	 2d68cuZI7d1MFLACajAcO4SHkWcoSsWJcKytfp9Wh1U1sTw630YY6vFBLqn8ugQr5L1pk
	 kYDtVHfeuUAtjCxlzBAxetZhR9kosBUUytonHk+S+TmEwq1olqP+wLrkNdiOjbfPqGKby
	 /hvxko+q077g4p0g//dBs4gPG+/0v1vlaYdeLCchogD6MH0fcoxQKQrnDH8wiFtfpJ64/
	 eVw0h6Wca9y2fcpr9+czUlyE61rykOHxLCOU3ClJWHWrzu0nVxdqpyPhUwRvHpLwXZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEv37tLU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDA606D811;
	Thu,  5 Nov 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEv37tLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C120B1F00919;
	Thu,  5 Nov 2026 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896315;
	bh=8eK6dCF5543wx7gusgRew8o0p/wgDJF+4BN0f6r3/Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oEv37tLUuabKIG7b3Skp42kdnLJsIQy5B47+yBpZAF+1+5BRopMVDnFKJwLxdW9dn
	 Orn80iUI+dIgBViAq+anXu8UeeOyA86oebwQoD7fhxdYmUB84JH6l9cuDSvZfkcx9c
	 w2WMSOVzHhguW8C8skTh4Is8A+Sf77tNAqawFVan87I0N4A6wX548ZTwm7N+NqVi+E
	 BzxPRq6y1eqcBgmWc44DeEHkeA5r03ZIvQMxtWSk6K8UDGxoaEQLdof+8cEYGz6FD2
	 gtmcZqkXSVNYg4aEseellqhZZwR3c+v3iMtsk+SAtL83a2IELaWsK7Yr2nN1VMjH6h
	 v36kP/pOS9WfQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 19/47] perf/arm_pmu: Move CPUHP_AP_PERF_ARM_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:17 +0100
Message-ID: <20261105163045.38862-20-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163045.38862-1-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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

The teardown callback here just disables the IRQs for each PMUs, which
shouldn't expose any specific race while other CPUs are running.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 37cca370794a..632103c9b4d9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_ARM_ACPI_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_ARM_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_PERF_ARM_ACPI_STARTING);
+	WARN_ON(st->state != CPUHP_AP_PERF_ARM_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

