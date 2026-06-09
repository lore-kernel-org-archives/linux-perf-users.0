Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13335306B31;
	Tue,  9 Jun 2026 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967147; cv=none; b=nhKFHiygV9kZ/M6LIdu2F3/q3dxvcxav2kkzYVV7oK6jFnj+KYdUX6PNJRU0olFEC/aIPpSuGzg7kUZLb4+WQQsaYv45bJXGbOKVXLwiHxY0jTfcmKFNAYiSCrHjqkfD64g8Ah3SGjk8x5+rESC2tDzMSM5vl+zUJpMslB529mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967147; c=relaxed/simple;
	bh=EXMhfvwLLw040xfsGolKK1QjRG2FMg6rWYFfl1PZy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP8n7v1ncT1xEWr84ogzZaHcNZ2oEkeJM78vkRPEyk4AlINRnCdJz8kQGSxq0TQNmTLhXJ3jLXJotsKP876lehaKisHYaAkMzyTP64FbyGdri1rY7arJdcW3H4eO59c0yO4ervuwngaHdUnd+McfzyVhpJcKH61/5kqIGdAcn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPD4txZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPD4txZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4161F00898;
	Tue,  9 Jun 2026 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967144;
	bh=Z8LBu98PZHrCyXJxETKiHVxoJv+6W+cQ+c/mczfZabw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KPD4txZJRCos09Z2ECWvTzx35I8ELHA8XC00OpOpTg6MXnzorej0e8j5xIeukyVlR
	 XLTr9O5f2MfCE6S9dNqDpqUWcJW3dwGs+9ziOVMoU5CF1wd9aFxgh1hexzQnDL9lL7
	 S7+KnUJebm11MA+lklcw+oBzfeshDhiyIc+2Ljz60+emU0h6GiWzXztZnhAudRuBBv
	 DVQXj27NRszSg6LKtEXBdGJ9f6io+i2YTgZGf8RITHdA2Nn791R15liyw9y8FnagWa
	 yfH6PAjVDzkoG8e86Lg7u/AnqIUoXMkXoui7LHWj64gDgklF5j0fdYbuapgkTXFM/Q
	 VH7CyYvqxupLA==
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
Date: Mon,  8 Jun 2026 22:05:17 -0300
Message-ID: <20260609010526.1998472-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
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

