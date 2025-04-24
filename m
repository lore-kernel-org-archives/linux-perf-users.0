Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E40284689;
	Thu, 24 Apr 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511105; cv=none; b=jbNBQ+LqRkVTd01tDF/ctC1n2nlzsWZEkr6gAh9/Rm/prOmcC3BlhBxzymPFv36BT9s4FJWsvjScQtJ1SLw32eofcc0DqpseLaf6djonXawYIr/a0ievOhT3NNiLdBZ/XhrXo+1wkyORHWICXG4T2JJQTcxIarJL47kmkrcMwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511105; c=relaxed/simple;
	bh=E8g/WnMSIPVgYxWXisJxaBHvsrMBzUmnKRw22jKI5qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViBYTare86rydVTQdbqjfccAO+tT7eyUSS5UBlACgAQNi+TIwNhEccwYbjtdOdQdOS1cB7crp7FYTG5RH4A9x/4IqWf5KV2vlqwu/aeiFoXdeaoZofbUycu3SHEIbdBKrUtrlR8pXFSYNANv14KX3JFgWeYHWBQxymz0VINtcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrhFG47z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrhFG47z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E206EC4CEEC;
	Thu, 24 Apr 2025 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511104;
	bh=E8g/WnMSIPVgYxWXisJxaBHvsrMBzUmnKRw22jKI5qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrhFG47zVZmvzup+qm0cq6XD9g3k1tWEk49QJsqzvNY2HdnpuYafLDQRBNqug0oEL
	 Smg1gian8PPPd4VbrSegGU9E1pY4NSt4CnerbXDtAzbpChhqsCElU7Qs/QXyfwXRKy
	 rxboJHcxDqPvJL6C6eBLPI3UZ1ngnlzio0srK3k52i2LTfmjZDhUaiLhFv8NvJ008U
	 xh0/OO5xJJVhAYCz2bO1gJDHJfnVwXoQHYZz0p6CXh3qFAiTg+St8er2WNy8sWyAB+
	 IF0wURGZdUJ5u1nTZECnz60u6TXKteEydgmzlJMZClRONKsKSAyhq698Km5lp/Cx+k
	 p4G1mxl4mVJGA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf: Remove too early and redundant CPU hotplug handling
Date: Thu, 24 Apr 2025 18:11:27 +0200
Message-ID: <20250424161128.29176-4-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424161128.29176-1-frederic@kernel.org>
References: <20250424161128.29176-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU hotplug handlers are called twice: at prepare and online stage.

Their role is to:

1) Enable/disable a CPU context. This is irrelevant and even buggy at
   the prepare stage because the CPU is still offline. On early
   secondary CPU up, creating an event attached to that CPU might
   silently fail because the CPU context is observed as online but the
   context installation's IPI failure is ignored.

2) Update the scope cpumasks and re-migrate the events accordingly in
   the CPU down case. This is irrelevant at the prepare stage.

3) Remove the events attached to the context of the offlining CPU. It
   even uses an (unnecessary) IPI for it. This is also irrelevant at the
   prepare stage.

Also none of the *_PREPARE and *_STARTING architecture perf related CPU
hotplug callbacks rely on CPUHP_PERF_PREPARE.

CPUHP_AP_PERF_ONLINE is enough and the right place to perform the work.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuhotplug.h | 1 -
 kernel/cpu.c               | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1987400000b4..df366ee15456 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -60,7 +60,6 @@ enum cpuhp_state {
 	/* PREPARE section invoked on a control CPU */
 	CPUHP_OFFLINE = 0,
 	CPUHP_CREATE_THREADS,
-	CPUHP_PERF_PREPARE,
 	CPUHP_PERF_X86_PREPARE,
 	CPUHP_PERF_X86_AMD_UNCORE_PREP,
 	CPUHP_PERF_POWER,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b08bb34b1718..a59e009e0be4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2069,11 +2069,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= NULL,
 		.cant_stop		= true,
 	},
-	[CPUHP_PERF_PREPARE] = {
-		.name			= "perf:prepare",
-		.startup.single		= perf_event_init_cpu,
-		.teardown.single	= perf_event_exit_cpu,
-	},
 	[CPUHP_RANDOM_PREPARE] = {
 		.name			= "random:prepare",
 		.startup.single		= random_prepare_cpu,
-- 
2.48.1

