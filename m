Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896303;
	b=E31GrkL5PqdC915iYPdWHmb8f5bmOAEwP9HRfFe59y5GCejnvwuGrWV7K+3Ai+KWL4vZ
	 jVM7x9/gbxLUfaGzEztrqAi85txu6AgbgoU4UcIGP/m7AIKpzvY9PRv7Z0zocyn7nqif/
	 +4dDyEyPZ/0FKBiG1/hpW8YzJqf02lg07g5FuxLjj+tZiBjf8aMyF1D0plvMdDXB4hY9V
	 w0F9Lw4ofPaIAQLOyVh2XbjrMba/DrGZYf359iKPJ1/P1OLhAUZEYN2Cih4j+EKvT0ffl
	 DtEFVu/SXRK+lbCCSU6vdYN1CcM/mV2ZXomEfszgHlk0RbqhRG18TJsTvWFMyWHavcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jkfjkxBZ0dlvGftOpNIimQwxHyRUPcKeIdpWa4Fd/go=;
	b=nPhLIg4odnabQjuLDM2KhTJAe3HmUMZrA+HwYVMH3lmYboKKJgKCIWInHHtsvOgW8uLj
	 1B2wcIDvYxRKJlpayvJiOShpjCwH267jBz04PMK5rby2lVC6nK5AAr8Jr8/mN8z7cQ/u+
	 ChlhEm0jX0LX4PwipU0oue25+0r52GbdY6wMSnuMqMz8/Pmo83uOQ1E4/VNu6Sf32NsqG
	 5kiJdTqTOYxruUjl68J/vXyqY8mAR8NfYhyKUxbc0L8IkXjGFvKjFir6c+B63UmncXmD0
	 BWNlkY9FJwBlwEkGuHmwxxOJG3w6mGjRWKVo7JdRfsPKJIsmYBEp2DNeXyL3LL1wG3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpH8TsDf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199F606EEB8;
	Thu,  5 Nov 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpH8TsDf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB3A1F00919;
	Thu,  5 Nov 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896302;
	bh=jkfjkxBZ0dlvGftOpNIimQwxHyRUPcKeIdpWa4Fd/go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpH8TsDfzmDkpKtdcwB/FhP6RE3AaK6SA8xyvP1+nu37IsXWMD7cUWzFgYz0qbkbO
	 8TPsloC87VPd6FKVyKynxaK18v0nbVTO72vmR30PUyxKv9zkYaSMqXVC/GhqcNAj74
	 o063tOP40DZ1FjPtTaHjejC0O6LslBeUryENoIp57ehXH6cMqaEzCNfiTzk+7XRfdy
	 tPk581OezEHP1/oPmizeLI5f/OO/sXANkU1Yde5EDCqrkgtE16NUvCrXsH7zBkeG5I
	 K79Axe39gYsaf7hyvyN5+NNaymlNrtzmSA+158hHOVgvJ34msG+BoTXKlnmPwVQdp2
	 igZmyhc/pF5og==
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
	x86@kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 15/47] perf/amd/ibs: Move CPUHP_AP_PERF_X86_AMD_IBS_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:13 +0100
Message-ID: <20261105163045.38862-16-frederic@kernel.org>
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

Here the callback only restores the IBS interrupt to the normal priority
on the local APIC and running it concurrently against other CPUs
shouldn't expose any kind of race.

Move this teardown callback to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2aa2e9902a55..678cb9efce05 100644
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

