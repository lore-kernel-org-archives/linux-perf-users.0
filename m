Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896307;
	b=zPXYn1PFbW7aNPJi+MYHKzLu3wl/3ujKYDvFPhGwtd+uY62DYsBLS035C7JsoLFCby2b
	 5+tzRb6qX8/0mz8zB2hdoqK8DUOMstIigHr8OOR8TrkXxuFK6HPVXckuL3vKdOvEnrm7Z
	 ebKYKpwQInk9bL3M0EvXmxkabWUskFjOO4A7cLfV7J1P5l5b4DVQdm1Q4j7U5uYY+EHxM
	 TqzWRr+rXhGtakGn8ZNNAMkrQyjslZsy9RCVDJC5ny86023WKzBHlHvdzt91fFk8SjmMN
	 qufJQ/IbsWBDmEV+IdfD3wmhjiW1IMFj7XiWjsD2pXdF2i8glciNEtYvIJV9QXp6biw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896307;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M0g1TqxZAXBtu+G7hNFKNUC1sBJS+hgGITTMSmHw6P0=;
	b=XCdCTo9xjFymCJFGFpRCLWY9VdOGCVg7qs2Wl0DEEFxb8rIQQw+G3JGsLVM7v1cUy+Aj
	 KQJnEQMz7aFE8hIOy56YE57DdqyDD53TvKstdu+RmQHLlU6Igis7OeJdF7v2Hl2Il9WjP
	 76uVKdJuymlS6x2HKQ5dodaLgQ9+e0cVUewAbgyAG1v8/mWL318BwYuapERfrt71GE6E5
	 qafpNNKle2kzrJjIoEss+ocSp5XVWqYnS+piRNFk3LTXopN1StXutuEq9k5UraGJxdN2I
	 ZIiS5MXD3PXqgsK3fYwNSW7828UHph2VUAIcM42NH6KLqOheKANE3lfVRDNko6mCrSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqzq4rgg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF0606EEA4;
	Thu,  5 Nov 2026 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqzq4rgg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165EA1F000C1;
	Thu,  5 Nov 2026 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896307;
	bh=M0g1TqxZAXBtu+G7hNFKNUC1sBJS+hgGITTMSmHw6P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqzq4rggM6or54Ou5AX10WjfF2kEgLwDbvv+p8jNyzM5gKmQCm/0yvP+zkD9kA/Sr
	 BITYHBBrVKvkjrym3owfZetSFs2EZgLVYDWMDwcey1qn8s8Hj0mRJgDB6PZMM92jQO
	 ymqdUBtPhSQuqmXZ3261oHBOhwBairbrU3VGyQeu/5vpw7PLr/WnVIK5mLEG8EMimB
	 sEMtGJXBLSWioallO7nxsWA4pzbe/J07H5D9cyT9KIoI9Its/vyJkNHG4LF3SPBZai
	 NRDuvKx8XOoJmjHHmcOZcmq1FkKN+qNsWy2pU6bGG0azr06k6TK8edbTcn+T9zsqfm
	 YZD2ei9BwAFFw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-perf-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 16/47] cpu: Move CPUHP_AP_PERF_XTENSA_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:14 +0100
Message-ID: <20261105163045.38862-17-frederic@kernel.org>
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

This state doesn't have a teardown callback.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 678cb9efce05..a9c5b0c1974b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_PERF_XTENSA_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
+	WARN_ON(st->state != CPUHP_AP_PERF_XTENSA_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

