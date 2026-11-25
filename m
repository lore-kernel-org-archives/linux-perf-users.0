Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645428;
	b=Fh22XBNtvRDbMoQWk7pHIVPGS4nQbnI/yQtNvoNyhJIytjKooWVOIWr38mR1ZMvNcwGb
	 J+IwKO2wtIgQZtXKFtHYHjOIw9qgnNVBWuL9zTk4J54H0+16wdKhvUE4R0r1CnsAKN3+D
	 1wjQaGCDk9CKUtms31HwhXD4U9NFNVsUO0pTPj0qSsspIJo2GR0CGJ61Xz9IMiFC9SH4S
	 bjg9A6BMLdP1YHYGmmRWj8QAgwA1az0tlDysxfnbDrcA3sH0WywnwENizz9nMAy7/wrZC
	 MYA8SAjKu09tydKa+MKy7ltPlx3tg/+gVYsAPJkRMg9Q45FuXLPKLPz8Gu2X9R2rnSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JFDwj/pnESgT5RsqZkiNTJbiciIkfCBVY6ENbjGVw0k=;
	b=4hDhID8v37T3fux+MY77SGuW+1woYusg4A8vkL6V8SeGKeg+XPZ5Kdm26cT7OaSiKWit
	 sL+tYz0Xsx7kTKRssgmUKauK7ZV1+IfD63wBVqwZh9/7skGPJYwbQCdmlmH3qNlBKs4Dv
	 5Ug2QvKuzX15Ena4wGtCXM/m0jR0ij/UnMjqUv4XXqCPC5LD0RjIFSfr5RSAnOkC9XHRW
	 sWqXr4pow9g0bCIy1J3iEUdB4amyQpHZ0U1oFlkGPTw/VvGVMD8SLuixsTjt+AQ2R1tW9
	 g0xdgRxha0gArZbCmelPSdhx9pvLX5OSH/50KhE6pKmsoSdJocb9Rof1g0E4al0YHaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FH7U29fh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D4606A334;
	Wed, 25 Nov 2026 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FH7U29fh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D9D1F0093E;
	Wed, 25 Nov 2026 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645428;
	bh=JFDwj/pnESgT5RsqZkiNTJbiciIkfCBVY6ENbjGVw0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FH7U29fhqrWoUnmnlK5PZyT86FuUn/AgnUxf8pxztjah6wSOhvxZG2dg0Zeb2gQUX
	 AEwbd0DIreFMRq/S3s5w2j+iZ0Yp5jsHMXzARDzndg4NoJCeACknCfaUG78GWkZt28
	 Ex15ZAVAJsQBLJAnQtrpKSo+Xw+/4CjdtA+VRYVHbaIbENIH0jfp9osSre7vnNAoSE
	 eR8vC7UZiJbdjKGgVgVAH/phC/j8//tj+f+5C+DPAF8tMM9sBCZLtCu03iTKvLSX8K
	 jvfl4dzbs2uQmH5sy9UTnv7KGUOW9uIgkd6+BaBoyfgc5DvjgDwv+r7oVb3dgxpjj+
	 vCRFRFrhFLpKQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 19/47] perf/arm_pmu: Move CPUHP_AP_PERF_ARM_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:22:02 +0100
Message-ID: <20261125222230.22508-20-frederic@kernel.org>
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

The teardown callback here just disables the IRQs for each PMUs, which
shouldn't expose any specific race while other CPUs are running.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Michael Kelley <mhklinux@outlook.com>
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
2.56.1

