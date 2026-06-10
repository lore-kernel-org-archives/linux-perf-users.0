Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA194344DAD;
	Wed, 10 Jun 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110355; cv=none; b=a5LChmnBeo5ii2SpF06ZcCRu5b4mCl/z897InijwDWAKUWSwfz0B2hn1bDW11ExAo+qWqnoub7j4F4e5lKsZSJl3TrzsA2CrNOg6agneUp54vTutxWLHetedZa+rjPrxqbBdPsW67vh3T6L5+PPYCnHZKRJ+lWAbio/45LN7MwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110355; c=relaxed/simple;
	bh=EXMhfvwLLw040xfsGolKK1QjRG2FMg6rWYFfl1PZy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvwb9AUVgkZc1szWLDP8u0O7H/VxqjbvbQk9srgyO61mWKswCh1/VV0oAfW1D+c4Rkt7Hh1VlKmQDW8ChgujBBVS4Lqnuwez60oY1hYeFoHWBtJQET68XghSM/nTqyfqpXDc/hfrT9zKWGOFSPx0s2RF4T4EIugspDRIot2NHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk75Wxh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk75Wxh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414431F00898;
	Wed, 10 Jun 2026 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110352;
	bh=Z8LBu98PZHrCyXJxETKiHVxoJv+6W+cQ+c/mczfZabw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qk75Wxh1O7dBeUfBeGymhhitg+bRlBuAOnKGse9MljGqA6hxQmf9hQ7NwR2UUye+u
	 /XjabPrQC5EzRa2mJ2CjWxS5mNcknVIbuzTU4yKKh1EG4Goey74R3nh4h99Bk/+E67
	 0NLQqmG9rV8aG3t+uh9W0rz7wAt05NhMVIKJIIdApuqohApw+cM6NuVgT54Fxu07Gn
	 Vm+RJ0k/ut17bnJH7P11uLPPtk08rNGEU5jOj8dN2DYEaBAE2qRLv7obYxt4VsNUVH
	 CbSQPwfpTFxM59ZYHxr/aDLfjhuXJwOuHJzUrxv0yngx2PDw80fpMI8gXJjkt79D/l
	 sfDdjJyk47ATA==
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
	Kan Liang <kan.liang@intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 03/11] perf tools: Use perf_env__get_cpu_topology() in machine__resolve()
Date: Wed, 10 Jun 2026 13:51:57 -0300
Message-ID: <20260610165207.2077258-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machine__resolve() accesses env->cpu[al->cpu].socket_id after checking
al->cpu >= 0 and env->cpu != NULL, but without validating al->cpu
against env->nr_cpus_avail.  Since al->cpu comes from the untrusted
perf.data sample, a crafted file with a large CPU index causes an
out-of-bounds heap read.

Use perf_env__get_cpu_topology() which validates both NULL and bounds.
Also bounds-check al->cpu before the cast to struct perf_cpu (int16_t):
without this, values like 65536 silently truncate to 0, bypassing the
accessor's internal check and returning CPU 0's topology.

Fixes: 0c4c4debb0adda4c ("perf tools: Add processor socket info to hist_entry and addr_location")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 66f4843bb235df53..ea75816d126a14be 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include "cpumap.h"
 #include "dso.h"
+#include "env.h"
 #include "event.h"
 #include "debug.h"
 #include "hist.h"
@@ -836,8 +837,18 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	if (al->cpu >= 0) {
 		struct perf_env *env = machine->env;
 
-		if (env && env->cpu)
-			al->socket = env->cpu[al->cpu].socket_id;
+		/*
+		 * Bounds-check al->cpu (s32) before casting to struct perf_cpu
+		 * (int16_t): without this, e.g. 65536 truncates to 0 and silently
+		 * returns CPU 0's topology.  Can go once perf_cpu.cpu is widened.
+		 */
+		if (env && al->cpu < env->nr_cpus_avail) {
+			struct cpu_topology_map *topo;
+
+			topo = perf_env__get_cpu_topology(env, (struct perf_cpu){ al->cpu });
+			if (topo)
+				al->socket = topo->socket_id;
+		}
 	}
 
 	/* Account for possible out-of-order switch events. */
-- 
2.54.0

