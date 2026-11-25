Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645413;
	b=IpDemwLhKOOMHXG6vi1Bt7NzDf0MgAsJzY5/uDWF/2cdaJEMQlz12Z7GPlUlHGUIoI31
	 Un8WcPRaih17hD2lad47UP+cSweu5bAcfloHeTxR/SnmYMkOCO/4eNw0RI+gcD+azmPix
	 Jv53huGmk74zdMZKnVP+ro6mdVQA3NcVkqsRgWay9yfDyfK8q46Zz4IUU4msOOSzoZmlF
	 LcIN8REnWfs83XWiw06b0gjEN+st3QKcHi6T4NyiBZXuplGJp6ARTI/OzFs1lzjW+n0qu
	 qeVeCC8h9+21MH/QyMk0yfIXk+D/y97s2oOAI4TdWG046whnJXLHVBPpt4gJ+stpaMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+CvwWfPtMP1Sj+lI2GAc+Iqjnwn50p0H/UvHgpHxKkQ=;
	b=Aqzzq00lRQi5oAisgzVC/YZ0Xz/TJm9AYGc9wn0iGxnUhL23yEnrQSZLuLPbw7gbCgmT
	 aKzbi5uhVWWgpivRT5Dpve5AApBNqPA+lSaCIFmcXo4M/XjCbnalvf10Brz9BMUiGMHl4
	 rUtkTN2atixQv64lN3RXogPNVm+TwL7h87JzjYhzxoTD1DPlLcE+a7r/4YdO3OTU+nbNA
	 V80hP9b/M2A1mgzQXpok1IkvDJmwbrtm7SirSyRRG6wLpO+VmAKwUQ74apiESEd/oHkuM
	 Gjhe6q96OlI7qTcAb9CwIA7MO+1d8LM/pS/9W53vgb49mYdydzCZQ8WxejHEAh0qlbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH4Qz3Ng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E39606A31E;
	Wed, 25 Nov 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH4Qz3Ng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF911F000EB;
	Wed, 25 Nov 2026 22:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645413;
	bh=+CvwWfPtMP1Sj+lI2GAc+Iqjnwn50p0H/UvHgpHxKkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bH4Qz3NgpjMoMmfkaMXxSIi34JdzN33b1HNR/rsDtklB7TMapUByMRej2+jicVPv+
	 2zLfIvwGwV9SKgMZBkd2A+JpxLR+8bVBQtzheMSmKywkc3dC9VL50AcQ3UzxA8nv+d
	 VlCyVH5OwRI4aSzKLk5tUPlGviSSk8S23cqc/2FhDB1Mn3B62OW2mkUbL+7jXD4oMr
	 ZfYcDM0aW+xEuNkxiWExiSjWOtcsrEG7FmgzCPgvXpu0c0IULqyimiIL9HTSKP3xQI
	 O5dNQWwZ2Ev+gUZv04g2+aR4Yk6u1AInXG/efZzcs5jRXZtu+G9enxrEU2+42d49gS
	 8+RkPANaXdQMg==
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
Subject: [PATCH 15/47] perf/amd/ibs: Move CPUHP_AP_PERF_X86_AMD_IBS_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:21:58 +0100
Message-ID: <20261125222230.22508-16-frederic@kernel.org>
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

Here the callback only restores the IBS interrupt to the normal priority
on the local APIC and running it concurrently against other CPUs
shouldn't expose any kind of race.

Move this teardown callback to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Michael Kelley <mhklinux@outlook.com>
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
2.56.1

