Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896320;
	b=VzrNqNMeDa4xvbf/kOBcVB19g4nsK1EE0Tog8CyE3mFGBpAdQibj8YUlwdNp/qZqIPlw
	 fwB8I32dXQmWbh/86fot8DUIPoqXkbYOrv8lt9MCnE2eP00rDLUpjet/nLnxnhpIkQpWO
	 VQpNMpABtNlmToH4GXGpe/DKdGSogHnnwF8zoIEVJ/xVvYi8K78ilstejcCHreRjVMJ3J
	 Po6iD3vOU67n7+0jpAGY1SC3gFEqWvHcE6HsYL0lQyn9zcZ/Do2wpHz/IoNuusf0T1xXA
	 5i4GDfL6syPmdJ6Fx34fo4PTq7EL3fgtsAIuOGzbVHPx58Ehdr7U0GymIH7F9EK+ihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CMdjBqNF/pO6bYMdOgcluToMIhQQh1hiiuAxJteGYu4=;
	b=hc0qa0kWVuOsqYU9J7eVBSyv4kC8McJnrZ69xUBV8+ao+OHvottEGkecS/YI4xEIKppg
	 p3jy1BIH1wTGMuPYlmy8e3N5tkpJzxE0r2gvBgH51RhIEuOR2PXD7myP064aZjhEqcqDP
	 wH8CtAQM1uOdBd1/HPmhLQo2BC/KR8k93l22qUik0jHnv2dc+buMbtJI50Bu2A8HUixIx
	 tsowI4h2p69XhDD3Jb8tmwwD+1SJXKSv3Z1HK9c11VxBrPQSO+rfNUdiUefosDzD52yf5
	 IgIPzehhrZi6l5hDvtww2FYtFRKvVPDmGjlo9A29jEr11asmtEfQ99cBdQTAff1NMXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDvJ9qdB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1065606D827;
	Thu,  5 Nov 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDvJ9qdB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3721F000C1;
	Thu,  5 Nov 2026 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896319;
	bh=CMdjBqNF/pO6bYMdOgcluToMIhQQh1hiiuAxJteGYu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TDvJ9qdBH+WUMPO4fuK/P55+u3Ym0yFWxIUcvYuJH7olLIOxg+4HZBED2hcnjgmgh
	 TyzS+wDdp4Xt0Lj+u9QIFpxDUzkuApH2HVzCkQv3ZSR3MreSNnWEPq0NCM8e7932jC
	 ctWHvhEAxaSp9DUfpHV7rhhDtUgxo0alYLinELA3sv3YjkwPusUCUzwqXZo9Eq/YFw
	 2FbBOx5XnNzQURZyO+SztT3IuzXBr9s6yhNIushxZXnD0VLyqGGaH7oKxx6xkpdLJr
	 w2QzBNPFkbZINHz/zcSuV0KLw0JbWuHItRAgwsXsyLQu4q3V2X1jTl1O3/yYx3vsS0
	 kMScCDg08lkpQ==
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
	linux-riscv@lists.infradead.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 20/47] perf: RISC-V: Move CPUHP_AP_PERF_RISCV_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:18 +0100
Message-ID: <20261105163045.38862-21-frederic@kernel.org>
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
2.53.0

