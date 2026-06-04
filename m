Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1D4C9553;
	Thu,  4 Jun 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606189; cv=none; b=Mrd2QMT8q3t2WoZ5dj3I6gvnpH+Iag/yYe+JbbDe1Q16iiqV2o8BEfXLYWZGb7h88XhIa0vS7kROEbcUFqGWRlGb/6vwxfHEnRYZkJo3nf+K/nRjn0J7FFlBlj3Vb7jHtZg9GKuOGKT0ft/hMSjdVMcAbTdt4hPnVVdqa2ho1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606189; c=relaxed/simple;
	bh=2Rd2MxgW6mdsvreVToz2brln03GsPRHIeYWxddl9bWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBGuQkBZG2YL8VP8IeWhKcPTvNalhDd9ByA6Tm4posPnDkBOygYZ4ZasQnZvl52KAclcpWxBJLb7RIMCCQU5v/jDYV7N/67PU6UEAkqojmJg/1BaOlpOYms1CTKR6mryWUkDp5QhfOskt018f9b1vldeoRCql7lDH/J5hFqr02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDV3vm71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDV3vm71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AF01F00898;
	Thu,  4 Jun 2026 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606188;
	bh=Ospe3Hydc6JnSKzD18hwPkawOnG8Qo0XDbVu36cURKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDV3vm71bQcWHCcDkBT8oWMMKr39D5H0s2nFIBsmcayJYaxAOAba83b2yb6bcrwkS
	 znbXUrsyJO+FfDW8/Ad8IHOyWoNyPkwNdaxPnGnZejhnekXOPFW/4eCe/JxgCZNtZ+
	 tFcJBOXzFgyqFW5KXHMzQ/25boVRyaZcDBgvXci1AsN1zjvSVSpzd2LWeVxPT+ZrSA
	 C8QramQ7SXWKeSUZVkXA6XA4/8+aiOkQ2Jy7rhPeviFp66KGcJYj3ACRb4UnFSSf9W
	 RPXKAOEtxQ2RUZgXLy6bc0onMo0eIYlxqZXvQXRTaRlwQiEUvJH0y64TrsgIS4Gjj4
	 aisqisV9Su6Tw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 4/4] perf sched: Fix comp_cpus heap overflow with cross-machine recordings
Date: Thu,  4 Jun 2026 17:49:19 -0300
Message-ID: <20260604204921.1707333-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604204921.1707333-1-acme@kernel.org>
References: <20260604204921.1707333-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

setup_map_cpus() allocates comp_cpus based on
sysconf(_SC_NPROCESSORS_CONF), the host machine's CPU count.  But
map_switch_event() indexes comp_cpus using cpus_nr derived from
bitmap_weight(comp_cpus_mask, MAX_CPUS), where comp_cpus_mask is
declared as DECLARE_BITMAP(..., MAX_CPUS) with MAX_CPUS=4096.

When analyzing a perf.data recording from a machine with more CPUs
than the analysis host (e.g. 128-CPU server recording analyzed on an
8-CPU laptop), cpus_nr exceeds the allocation size, causing a heap
buffer overflow.

Also fix a type mismatch: comp_cpus is 'struct perf_cpu *' (2 bytes
per element) but was allocated with sizeof(int) (4 bytes per element).

Allocate comp_cpus with MAX_CPUS entries using the correct element
size, matching the comp_cpus_mask bitmap bounds.  Remove the
sysconf(_SC_NPROCESSORS_CONF) initialization of max_cpu — its only
consumer was the comp_cpus allocation, and max_cpu is dynamically
updated from the recording's events during processing.  Fix the
non-compact path to use max_cpu.cpu + 1 as cpus_nr, converting from
0-based index to count — sysconf() returned a count which masked
this off-by-one.

Fixes: 99623c628f54 ("perf sched: Add compact display option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 36da451447b5e59f..4aa7833cae6e36b8 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1670,7 +1670,7 @@ static int map_switch_event(struct perf_sched *sched,  struct perf_sample *sampl
 			new_cpu = true;
 		}
 	} else
-		cpus_nr = sched->max_cpu.cpu;
+		cpus_nr = sched->max_cpu.cpu + 1;
 
 	timestamp0 = sched->cpu_last_switched[this_cpu.cpu];
 	sched->cpu_last_switched[this_cpu.cpu] = timestamp;
@@ -3573,10 +3573,8 @@ static int perf_sched__lat(struct perf_sched *sched)
 
 static int setup_map_cpus(struct perf_sched *sched)
 {
-	sched->max_cpu.cpu  = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (sched->map.comp) {
-		sched->map.comp_cpus = calloc(sched->max_cpu.cpu, sizeof(int));
+		sched->map.comp_cpus = calloc(MAX_CPUS, sizeof(*sched->map.comp_cpus));
 		if (!sched->map.comp_cpus)
 			return -1;
 	}
-- 
2.54.0

