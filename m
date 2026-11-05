Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896298;
	b=VSKn5IO5opO29HykqdyPLzhLhw5+M/OHXVCqCNJlnRU8pWxbYtex4mOAHF4qI5Ja4iY7
	 jDDltvKUXdm5OSHYFhWb2bgCdcVI4HYK+8vUn6JLSiz7/TA5ctni9bg5Gc8MYFZkxaOPd
	 Ws96AwMsTqg3FLQLLwJNrSKHfKTSLWfIMP4G5QbUXRFX3KqA/8y9viyG+BkgnJ2F5voSR
	 jCDSF3Z2eZk9yuL0Cgg+cobX9+fBDimhlEjo1F8/GqtEb1mGbIJaUvNP0Jh7Fwsc0Pako
	 ricpzZznrC7YjkwGUcjDYCv3kvIp85S31zXggeWCpRm/g8jD1j5AW+5HPrWAgceCU0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896298;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uoZy21PZKOdloYoYVyjajKoOJBX8PNh6iERDsDrxxzE=;
	b=VR9Ivfh2J0caFfTtdksH83nchEXkgLoBh9RNGy0zySRLCYhiEFInZF0wd3St8CN2pgmz
	 M2DmwssJ4LamEtfEgvonv5mKzQGrStLTGeYcn14nPa00cpSOg6d7ruREGWjOibdERR0vz
	 J7VYUGlQ2WGsY71RtQIiYWlLtVmZjJDAfTrFu82viVEYbn2LWfp/SiuNRsx5fmOreTWFk
	 /i9/cAJvEbSd9n/eq6/BvB7nwrq1kyQEiDyCPYV9bAA74co8iDdJD0eYQlrVDB+59NOAw
	 kV7dZde5YHAgppK56l9oMvwi4cQPGJxZ2L1XmqBkIs0QDcfOUJA9NuUQ/Jgs3Or3xyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2voIvYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC22606EEA4;
	Thu,  5 Nov 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2voIvYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD941F000C1;
	Thu,  5 Nov 2026 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896297;
	bh=uoZy21PZKOdloYoYVyjajKoOJBX8PNh6iERDsDrxxzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2voIvYXchr2f+BSoaMdXJHwKDfnOBLiwW89axpeoYAdneA0f9m6IZkRkoIlYGlmF
	 OFW5iMzAqNzjJAySD7IVXjJltGs2xGQ5g9fr/qKvwyMRx0+I4CjCTCEXUiepznOHjt
	 VP3zW3HWoFyRGY6jOQ8ulwMxbVX4oQDWHQqKRq2cIx7P0hsuvqmalghNeRhOpQFbtc
	 9kj/EdKdIMrXiOYEwSkxdqFaswbAh1Z3aBCXAJL6c1g4LuabdLmAnR3nOt+lRnuAHi
	 PrrHNVv2w0rXCKzh0ss/XCfcUzXszweosDJKQ6KHz8wustU3/c/tUH5+SJq5WLTjH0
	 VZUAF7N4EXvUw==
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
Subject: [PATCH 14/47] perf/x86: Move CPUHP_AP_PERF_X86_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:12 +0100
Message-ID: <20261105163045.38862-15-frederic@kernel.org>
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

Here only intel has a dying callback (intel_pmu_cpu_dying()) which does:

* Deallocate the per CPU DS structure on the MSR_IA32_DS_AREA. This is
  already racy against offlining CPUs because all possible CPUs's MSR
  are written on a hardware event initialization, which still can happen
  before the CPU actually goes off.

* Deallocate PEBS buffer. This is already well synchronized against
  hotplug up callback.

Therefore the related teardwown callback can run concurrently with other
CPUs.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2dd34a38f878..2aa2e9902a55 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_X86_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
+	WARN_ON(st->state != CPUHP_AP_PERF_X86_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

