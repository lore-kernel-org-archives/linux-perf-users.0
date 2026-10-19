Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73AA4F96BE;
	Mon, 19 Oct 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415386; cv=none; b=cE213l0inrAYsu/AKyPVQjmmMtUlX5YYqeEVecb+1HA2W3FpG2bEYRJBruS5kDYTMg362bNPQQYg7Mp1cRfdDZ8IYIxuK+8v+ChRHZSVn69X76Xs6xq/p2cNCLvRDA1WUQNUPdR4Yq8s+2Zr3ZhK7Wc6cgfEvwA1PCVl8ceTbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415386; c=relaxed/simple;
	bh=w1BrRRipaOkIbZu4fuKp4PSlvBlYXbfQrZNXQhM/Y2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH/DFDk01dmulbXSCzMxHuzxj91GA5oMnpjHd0XX+eZYKkPfIvlQ1HUB7x9aNmQTpVQS3pOHmwF8+jD82uYANUk53GVj2+Or/oruZe6Y3kAY5/N6D84p53a7zjUfCScAY9g0cZ0NxSOfNdcYoPAxCgfy3igqBVCa9eyt95pCEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0L9xKH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0L9xKH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB851F000C4;
	Mon, 19 Oct 2026 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415385;
	bh=ehQznJ1A7d3/2oa5IlIxaIerl/qML7ZXU0JTRcCKZcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0L9xKH2wgCvow6XotvkYeWctkk34LTYqAe//09SuPdqWBLgtYJC3QvzmnQx05Z1B
	 mNOw8GJFlNDxvGj/gb49OKlnQjx0iedidMGGX6tchlBi/ayD+NZ7ATLihhm1De0Sii
	 AEhqI8WQH0fjaziDwKUqdDvLfIlnuQLPp102dLUsP6ayyMx37joykKtNGA/UDp7K9R
	 p7tm3TwH4HmimRjJuxTzSF/l0l8fk0rBGvm8CiFBih96vJ9h8SKhSuIrTzyjvdRjJb
	 5fCNFtmCNvaTy5fU6OFVq0fBzQ+pNYDAQyK9Y+4EphqaId1c3Iomuj4s5I7vGGMpBQ
	 sVeXRhvyvCgEw==
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
Subject: [RFC PATCH 14/49] perf/x86: Move CPUHP_AP_PERF_X86_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:21 +0200
Message-ID: <20261019130856.49711-15-frederic@kernel.org>
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
index 5ac2a925f7d6..c37fa1272d57 100644
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

