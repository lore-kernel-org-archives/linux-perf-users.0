Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645408;
	b=WNid7dIsBwIlyhSGPtJpEnrNGjK3V1/HfdYHxPNf86+T9LnFaWHl1j/e1YSR7z1u4/Ow
	 98GUqw3UL7ecllpvbLPA1WPJenijvk+etRXMvT/mHPXbBbQUWlNuYnxM4yqHF0jeKLzOG
	 fW28kuQFm4uprrq1P88h04ZxbzK3CPTZ0rk0rHGIgA8fygdSHsWpEhGXFPXuFkLCy3qrQ
	 uaa0DjdS1c6mDPrNR8YfjnJ3sYb/WxL4cuJdws506/hu4c9b1IRcA4DleDVCEg7nZhO07
	 AyGS7MUM6+xBQjufnsntXYRJc4qNtMADwoTlWE+Sh6IaeHNx5PaQsLEnYn2+FffOwbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645408;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L6+Tjtz4gXen59dBSrmC5R5AhC8kgQiMoS0NQgdjdN8=;
	b=gQ5WjgAheCKfvqWnJO8g3tLHoHs5rxU+OnZLnZxKRXk1vxBjdQ7L0WEDTzfXTNL7zpC/
	 2hYSwIyhZkculHqDHejCsngSQoiyewfgONoKL9GTUWhLzlLQKdI+T1IRn/iOz6phKr/xX
	 jKa+L6CCm5Jcmffmf9phyHdZYyLP4PfIndnnM3XoAiOO5tjBqXSbeSi3t9cGvJZ/34zDK
	 ays6cg31/xwqDYW0koq+2w25gjiJJq89C857J1oYYrrmcApANidyeaMg9bgdSM6KceTGL
	 4XTmNR+OkUjXnpxiih043thwRGQ6EpYdbVRBi4zw15a6pwaBqGRquUArJlIIjNZEstg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6UjddVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E054606A31E;
	Wed, 25 Nov 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6UjddVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023FD1F000D4;
	Wed, 25 Nov 2026 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645407;
	bh=L6+Tjtz4gXen59dBSrmC5R5AhC8kgQiMoS0NQgdjdN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6UjddVWTopC8dyFqBFOZXTv3A39cgBzTem4mJMYyI1a9W/PbMKYoGDGf9pS1uvML
	 T7P5WZX4yBHi2JWTvIDYnoPJWjGCSEv7XHn3Yj94Jf8nI5v55c3MhamRz7VBt4dXnv
	 wuz0QmpHZImYBNUxL/zPF+Rb9jmxIbHAODi0sASPfiSV/qcCqIftYIbWk7np90BeEa
	 QlbGkMdOUKLsHnXXITck9xwPUX6GPW8EsbO7GOt+OgQstMtYYNubbbuABF6aDd3SDt
	 t8f8r0Akez0jB3asT0Hiq2Qh/ucz2uTcTmigY6h5iauppfcHTRX3fz+hYfLFJ5yIQu
	 WV0W0VnSqLRvw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 14/47] perf/x86: Move CPUHP_AP_PERF_X86_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:21:57 +0100
Message-ID: <20261125222230.22508-15-frederic@kernel.org>
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
Tested-by: Michael Kelley <mhklinux@outlook.com>
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
2.56.1

