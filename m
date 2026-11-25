Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645434;
	b=AtIZuhppQDzlrptMSLFSS9JAMeQT1+nWLEAznpdzSgBc4RYWN69zL6jQBLKwAtpGKwpf
	 zToTxdYrSrIncolKPu4/GMMNF1xNQ5KsJHt3wkw1j4/tLgM+1B9UomAcCS9xbzJirZVHe
	 cKlgqSW/Cq35iVJhMefzBk7XvYxDS9rjjEBCeR9ZmekZxwCsPeuFthRtaEvaHSOcA+4wC
	 znF6JDg6OVffPzZ/gR1cej23tj53b5db0ZcoUW9oDHSC0FWyaFEfoxQsepezYn5Trvwbn
	 PTEyaiQtlBUEC/cH9k5l+Xz7dAnfvXmcNJ6Jrw5ylGStTiyXPIPauSNt/fn74Y2Qx8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nXrLOU8GsMiHDNNHwzWSVTpu9xEsISBEn05wWpz4LO4=;
	b=3B4pZBVPsRnjvjuuB4+9N8C2NikG4kHoe1thIcJtqpVpmGjnXHLUCIbD9PRKjA8h8MID
	 pMQH5uQ0XNnHpsZZKr9QuNXWw+wbwA460ccg+wGDRkwxv8hkO3LoGXWMnyb+lqQSvmqge
	 FXdT5j/qLw43GlS87WkKEXBeRZIF/IJx9oV4P+qhmoX7FUT5QvOuNmyD4LoBvIAk1r+71
	 1NH8t9lXaoBJH7JGC31dvG3sxYbIcdDpLUA+cRVXVfKS3398X5YD+109Ghm7P7GUxQ4bV
	 s7oB4UALu7SM9RG/Rpu9CYDm+cPLLGb59p4eLbO5s9FttAEPlw5iSpUcJF7rYihFkIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3NigmJs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1E606A326;
	Wed, 25 Nov 2026 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3NigmJs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D41F01561;
	Wed, 25 Nov 2026 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645433;
	bh=nXrLOU8GsMiHDNNHwzWSVTpu9xEsISBEn05wWpz4LO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3NigmJsNMTYGt1pNe8/ahLrDCJt00f5KT16hyX0WhLAF5mR/fIlkOtUMf1xGty7P
	 x11APHol0hGF0htdKo1ykF7JPMUW6fXtR+A5CnyH0P2mYa2RAccV4ZMlFLQGLydVkn
	 ctuIuR0IxbXMWV6UEyry6gU7D/BdtFn426YcIed/2PSTLazmf1WBNHmpuKtNi2etOs
	 x9Qn6BRXZUmwwSlPtZHUdwAcGegAWFfswwidCoViOUyXzYILbZHDCbUDAudH2mi8mv
	 9s/lH/ZtizW96ULug1Rl5/ddU1KR3DSeW5ihwUWi0bfI9tgc8zcMzVGDUCy33xIEcj
	 OhT3oHw/iLgAg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	linux-riscv@lists.infradead.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 20/47] perf: RISC-V: Move CPUHP_AP_PERF_RISCV_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:22:03 +0100
Message-ID: <20261125222230.22508-21-frederic@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125222230.22508-1-frederic@kernel.org>
References: <20261125222230.22508-1-frederic@kernel.org>
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
all the teardown callbacks while temporarily stopping/pausing all CPUs
in the system. This doesn't mix well with running RT or isolated tasks.

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
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 632103c9b4d9..2ad19f3f2563 100644
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
2.56.1

