Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645418;
	b=lRJSDL/3bTf/hK/aSUjZvxyrvEX4p+uT7TMiianjCpeGkZ+xwpfWyYnyMVupYtqKC4mD
	 vNzYNAJjYu0pO7FnDGvn5NKLepp5GJ4TCviJTaWk4TgQqURsvV7SsCZ73Ne5JgiHB/dgT
	 IrkzcS86LTZuTbbZLZXdEDvsSxPBGZk5oClyU1oCQOR9U9vutkz88hvIPYm/RNBnRVnXE
	 8zIrMdQp7Acf+3ZigAakvH6PRcy8sPgSogkGEpmCfoJRNy176figwkcdSeKzvaBL9K7gm
	 NqK5lcrvq+Cv6Ixg6y3nUREF7DXAxlGLHfYbzlv0Y16Sa3p8c8kHwOubd5CloHeqDoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645418;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GI2bD7m7ax6MCCRdvTaw0Nb6OWgf3AhyNDoRYfX+ZC4=;
	b=rS6EJ8bRSUTkWYgdI/ZH2p+xjopic0Wx3GpdeRznqyQXcYyHW3zJoAfbDu9Fm6ewVdQT
	 gdlkiGqur/xfsdFkj43xLDppf15xFJf+DldMlwH6e9n+lHhvUYXmaVGn/OooW9KUil4lW
	 t9GpTja4Ast0APrwX5rAW9VUqSzGC2Xjubr54+xoYMFTLWKQw1VpppBGTQnai4+ELM28A
	 8Pb5ZaXZpT1Z6RvYGLZdoSjjKPXo5lm7NPdFhRdhB6gJVjyCxELd4nFQhrMPSiDewsQet
	 6ABcrqzpDPWRQz03YOovZRpLPzB+O1eXrPgyAN8qDeArekATQLgXU256HVQshXBV8IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcI2Yh33;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0130606A31E;
	Wed, 25 Nov 2026 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcI2Yh33
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115561F000D8;
	Wed, 25 Nov 2026 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645418;
	bh=GI2bD7m7ax6MCCRdvTaw0Nb6OWgf3AhyNDoRYfX+ZC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EcI2Yh33p4qY1XYm3einlyQcx8CQH1TX/6TAgWvstvOOC1C29V+JXqmBxXahATLYP
	 DWUyyoJU7DR5oSf4g/CECOwILalqvAfPoDnGQQmTElrBLdx1CP2DovP3IC5wRTxULf
	 hvmvvd79tz1/DWlMKk6dOAYG3gipk5rTho5QoILh6bfo5gqLjhxcWW8OQp8MYMX7AA
	 G38dLPtMDk3cA8jLRRfrU3kJ0x5MZ9jdtItdmKMaZaSNJSorBitjYEg2bI+msJrH33
	 aoqKs0qaDBMkdL2RHSA4497vH2cyRePQaRYIh1gLXT7L3Y+MfgQTWl6Z9nRjfjrU3y
	 N26qw1ww3Ktdg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 16/47] cpu: Move CPUHP_AP_PERF_XTENSA_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:21:59 +0100
Message-ID: <20261125222230.22508-17-frederic@kernel.org>
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

This state doesn't have a teardown callback.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Michael Kelley <mhklinux@outlook.com>
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
2.56.1

