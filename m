Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5713DD516;
	Thu,  4 Jun 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603909; cv=none; b=QufBGpvVcdT1MWV2sXVYJ/LpFIg/YvkDDv0oFXw3tDO+NWVtyDhPYXQk+X6Lu8oIw+YWd+m+zYOglS+JKfA156PP9J/ral1nLO3N5CZaprISSUpmMmv3waoYargvaSxRp/0FAXWyimDa95ehy16GglekDJNgyi+p6vJEzzlVNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603909; c=relaxed/simple;
	bh=pY8JER7xP2Hc+mwd7u9XFPM0lsumhggPajxIp/IvA3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRs+k0Or7sV0hQI3bNSDj5Y1zqM0mwpj8TqRTUjkaXoTaAPuc5RnNYbY92+6GT4S3rhcFX3DK1P1+o1RSj9e3i8iROIfUpjXRDLOZM2QQVTMAtAKAbKGV1Q8H6qP/BvMnuaOlsI4dY79BpLnnyWlOD9NWWYrUyvq0ylfQNknb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wus6LPz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wus6LPz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A761F00893;
	Thu,  4 Jun 2026 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780603906;
	bh=+rtWvq+W9pQGpnq8lH+dygwF8usaybX8YWuerV5k8R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wus6LPz4ZN3IptlRmV/YWqPVYVUDaBFNth+XVWLr9FFGm+iiIr9tRnhkoTL5LrkJN
	 zP2ZK/wfSGE4m2GI7eHxviwKnBN/OzPdSPOMlRAslF0wRBtbbEhIZX//cWYbk3SGcq
	 wo1sCE+WykmDcOIrOdE7dPCje+f24J/KjX5cUlRxGfJibA24X1c6ZdvUPbw00zOaBN
	 YPgfAWiVCwrPk3OfQ4aSXvgRUWtSKzXPM+ShuLPHGgQeqNkpA4Kj9/ar0lHTd7oJ/O
	 2AFSQch3hgXiI1fD++si3z/kRVepcz88HpjvctPWpVpohkAYO9C8irIGi/jFWXta5E
	 Jyl6AfZnjAZkg==
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
Date: Thu,  4 Jun 2026 17:11:16 -0300
Message-ID: <20260604201119.1702338-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604201119.1702338-1-acme@kernel.org>
References: <20260604201119.1702338-1-acme@kernel.org>
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
sysconf(_SC_NPROCESSORS_CONF) initialization of max_cpu — it was only
used for the comp_cpus allocation, and max_cpu is dynamically updated
from the recording's events during processing.

Fixes: 99623c628f54 ("perf sched: Add compact display option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 36da451447b5e59f..80e42536400a91c2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
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

