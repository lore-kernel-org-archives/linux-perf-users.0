Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE943321DC;
	Sun,  7 Jun 2026 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780874995; cv=none; b=jpKICHyrHJY70ryFaR9s81I9Ia+bSYewU08exW76gncJLzadaH51b3HEaqJpme0BinkIz1eI0ajckK9/HntoOYisbbkEOM6jDMKgyo8DR9g6lYY98Uv6uLpwFjwtsGzQBW3sI0+YtAzpv7LdLnCDFhuKbVcl6wt9syAsuvHIL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780874995; c=relaxed/simple;
	bh=DV6MxLEhw7qAh6KRaDlNzT53c+Txl827/7e6KFEnOsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyaPYy55sYZwcgqGJpEtinjUD5H820hO6p1/fru6WB3unTnIuo2bzxgkcI1EmbORPSOrLlJxftcdRy/lpOzVujmBBmNj7m+hW3DE5ApvwlvaFTWjTRXuDwqK43QVT/527O3yIC6y1nte7WUh9LsGQJ++k6yVKiyuxl7R9fT8k8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKnANGUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKnANGUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F711F00898;
	Sun,  7 Jun 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780874994;
	bh=CAPPe/vMoyb4wKCuPz6EN/06t84Hid4mzXfCYax9ccU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XKnANGUk9kJflxniuke/qjP5B1zeJyrsNtr73A3k0zvzG//Av/CcIGFLm3ztxI7wH
	 bNW9c/wpjj28hB7opHMpg6vZVzVsQM9qQyacA/Ib4/L3C2Q/VYcN0iuv4tONoS394U
	 u2re8wPuKqZclsYr2B5nrzqABj/bvSobpDZm8NxqFlpUAXo2g3eKFHMF2MjbPdmN5j
	 NbRzTGBnIVboPxaOtD6Cm/g5fOCgWP/5zNnCEU7JJ2F5dMQ1pHE/Tv+1jZxqetU2o/
	 w7MAW8UMbZfXD0Rp2KidqSvYcwWJ2oyqvKa8ivCH45drpYIG8DeVp6Gr5KEPBjCEtI
	 EgsZ1oelKPKjQ==
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
Date: Sun,  7 Jun 2026 20:29:16 -0300
Message-ID: <20260607232925.1935819-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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

Fixes: 0c4c4debb0adda4c ("perf tools: Add processor socket info to hist_entry and addr_location")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 66f4843bb235df53..66293fea64fde9fd 100644
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
@@ -835,9 +836,13 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 	if (al->cpu >= 0) {
 		struct perf_env *env = machine->env;
+		struct cpu_topology_map *topo;
 
-		if (env && env->cpu)
-			al->socket = env->cpu[al->cpu].socket_id;
+		if (env) {
+			topo = perf_env__get_cpu_topology(env, (struct perf_cpu){ al->cpu });
+			if (topo)
+				al->socket = topo->socket_id;
+		}
 	}
 
 	/* Account for possible out-of-order switch events. */
-- 
2.54.0

