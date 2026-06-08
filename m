Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D43EA971;
	Mon,  8 Jun 2026 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949893; cv=none; b=MGk2lh0JWAaUxk5suRcE7aJ1jftTWGVatEA87JEylUXCMtNRJZvh7vtdUrt/bdW4pV1/BJOZdW/BHlg0Itz/YYnH/THNqJ1atwA9vb7qi9W5nkGDdCXOSTvOqvxaT9XnTtHgqDqBostL1GGoVDZHNyp8ZlUAP4fO2IDUfiNuNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949893; c=relaxed/simple;
	bh=/ffXGm9Kksyrvg3z29g+RicPxKBRm9uriEFUyItqHQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZoCbXYsHSKyo90RXZl9k83XY2TuCRq8/x8RMlC43Zx2mKtZAKVYiWAn8ub148OixX8eEofLlm41+LX8+GAr1FW9BSVS4Dv7hI2IZWO152GSTfUM4Hhf9SkgXalMmGfx/Qv53Zwq94aq8fdxOqD5HequYYfbH4v61lMD4p5lT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNK271rc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNK271rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9531F00893;
	Mon,  8 Jun 2026 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949891;
	bh=JsgcVWDK/PGVV9Sj8BFVXWjYMfU3D46Fs8NDI43aCo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNK271rcrTN/AQnx37uo5OV0CBA419kt2RZfqbz5IeEvGzaD8T0Fyi3uTPV3G3HN/
	 VG4h3SFvWipz6k3LwA0ZFuN0gvkuwSOQcDrRQ44cw+RJcmCQljNTbwhGCdy1QaaHgr
	 hfQy3hA4tlrKvuSIORFYGiVPLiBnaLqkAOwGlkF7M6FPzwYa8+OqLsHv5EP7QYqExc
	 RBGFK2jSrZ16tNhlPVk/HVA8nb1IsWP5ZqXVzcpYA0Nde/DG3muS0rmITscV5Ii5ax
	 kYlUsZYD3aDyV5yqVw+x07Ya827XGcRomPF2UDygr3s5JHmsxG+BC2sh8pTA5eUVFH
	 5FP4cfJA6n3oA==
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
Date: Mon,  8 Jun 2026 17:17:43 -0300
Message-ID: <20260608201753.1979464-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
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
 tools/perf/util/event.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 66f4843bb235df53..001db00be1073ad4 100644
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
@@ -836,8 +837,14 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	if (al->cpu >= 0) {
 		struct perf_env *env = machine->env;
 
-		if (env && env->cpu)
-			al->socket = env->cpu[al->cpu].socket_id;
+		/* bounds-check before truncating to struct perf_cpu (int16_t) */
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

