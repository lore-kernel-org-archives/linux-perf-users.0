Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261B4FC35A;
	Mon, 19 Oct 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415402; cv=none; b=ocxoicaVJdXdyrLrC+qk2ia0zcdpSjoEhv1ZUOaF99RQTgsvjPiuU1EH4fxwFHGLiNdOA/Ly5qnCzpvBqNVQlpVoJ5Rs7MMl6E3pA+e4jzskDcSmHFyWRZ7Iv9b3jLW6nKZg92jPY7LB1WtOdDQU71JewUfudzI9pRyrBKFl/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415402; c=relaxed/simple;
	bh=+FVcX8diseZGGhX2/sAOON5TiO6ws1KZs4OjOfONp/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHJCS6NtIe7jnmC3QCiMnIkvHh9riugJ0Dtc4APtbqu3DLzHQ9tD8RVdFjjNXbZ5nNPXvvD+iT+KAbSdMdNHdlo2YG6uHocwppBm/mPZt2GJWJJRSSK+7lYHTaTbwBK9MFlfYG6wAlXvpEZkJ7M3G/Ur1v8ojgSkMTfTAxwbOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmqdzGiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmqdzGiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C471F000C5;
	Mon, 19 Oct 2026 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415401;
	bh=ViPzMqMMtYsXD2twtgRR0dhAxzp9lQPh6+izbO2fRX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmqdzGiCKgvstUEqVR2BglPOe5LKWWO9W9V/oXmhCRIV5E0DJnZJloDgfjzQWeNTy
	 ChOBZ4eOFyPHTgN0pgLEBHSaSIwxiCQwtN0OOzHuUCbf+B82vPlbeof1hXjI3Ub+fz
	 /Ej1WvwxSNpggi/xEQ8ehQyqE9OG1ZnPDhy/PrNPowdGY0Rt8X5BLWXX6MaOGdVZ3Z
	 clXvyx47u2RFDip8O21nOI2lnpyYjO7Pu+E2mZJ+lz9/tKu2ksklUKrOPTvQgmJy+8
	 HNGUTfOR5kxWQ8kASR5kF2b0LwjfIwc3HorGrfIYtMxOV2ctgl5KV+h+0r/Ml7phZx
	 eItNbsi+dSV+g==
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
	linux-perf-users@vger.kernel.org
Subject: [RFC PATCH 19/49] perf/arm_pmu: Move CPUHP_AP_PERF_ARM_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:26 +0200
Message-ID: <20261019130856.49711-20-frederic@kernel.org>
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

The teardown callback here just disables the IRQs for each PMUs, which
shouldn't expose any specific race while other CPUs are running.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 7d7e2d1eda9b..95cc6655cf7b 100644
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

