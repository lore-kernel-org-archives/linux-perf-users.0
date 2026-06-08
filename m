Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1412CDBE;
	Mon,  8 Jun 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882289; cv=none; b=VhIrHrvGB5ZpK9ZP4r4P6EIMpjXoFSXasZQQfC9UdDe25IOKjn7zbhewLh+6D6IZTStsU/FLNAQeNLCuBf2KCIQ1MN2j3gEjVj9PDJ6o+wYpIlA1gov49YJ4sqPP6flG8LcOS1mfcGTcNOxaq9+H5+r4GgwTS4SzcNXAg6fAqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882289; c=relaxed/simple;
	bh=DV6MxLEhw7qAh6KRaDlNzT53c+Txl827/7e6KFEnOsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlkqdihZfMtc21nFYiiEinPUwNrNm7ecjkneCj69pxhDqJJzQuv31eXLnpgm0O7N/bchGNDB2ccq/IcrIpRUXyxQ0k4BUy0I4Mf4x8zGnDd3niMu64eyAXeRYXNQu2/bmwOG6F4sBaDGkhfoIL6gS9cELT9p72Hl3wBF8g1qFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSKobBKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSKobBKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D481F00898;
	Mon,  8 Jun 2026 01:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882288;
	bh=CAPPe/vMoyb4wKCuPz6EN/06t84Hid4mzXfCYax9ccU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSKobBKLA/AR6FsNGXnybTIrCJd1X98i/Z2d0++Z2LAxVZ5rso0/Mx9++T0DW9E6u
	 kDjFTQOxUy7cjUl8UhoeyZEnvPB9Mq3je+Ss0ZTQfUYcEApVJL4c5GNIHVfeTtF5xD
	 QUHdwKPDyNglQQrxoYCjd+ZWMwBYbRKfqYt52Yg5DSS6TJ61FnIfJV/bDNxM3uAbHW
	 lOAMQL/jDqZY2m8cwu43m0ykG2u8HTJUI1udVUdZaoDQaiGtvqk6UnttVvOEPF0jne
	 IiCW1dj4khDVYV5Y7DMRvc3GNuYRjryTIGKGfvihfY8JOqNY9zviC5dkSkI8xeexAx
	 KCNPCmgCwMZJQ==
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
Date: Sun,  7 Jun 2026 22:30:47 -0300
Message-ID: <20260608013057.1942953-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
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

