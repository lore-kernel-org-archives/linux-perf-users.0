Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634237C913;
	Sat,  6 Jun 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776395; cv=none; b=VUJwNlBm+NucCbXKbCwuND3SGA8UL77z+TlE8Lag5YowBY+kzZGA2Xqz+74dJhJA7t+Qh5i0hKE2BsKicLKSxJGEK1zfr47cHSbUhHFMBlVzmo5sudadVMo7lL0qqs/RO6034Bnceic/Ow8LDhu3BO1WPaZHDD4wdETBwjhh+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776395; c=relaxed/simple;
	bh=P5hxQtzLLRCe9d9PCH2wSslvM0G7WmFGcbXq+aUnvoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgyU3FcFSyuSrE41+8DJlgYVSvMdeMQVadwZY8Ly673pfauKsqPL4jRl/yIDnHIsOy8oJnpOZ+l41L6oSifadC2JwfQ6580YJ8IrjLpS/MOpwO2c9mFcy5Fx5GPE+dQcKaklmENGWEAVsiu8phCDwCN9rSM4jDN1+qlk3R8yrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVb1Wg3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVb1Wg3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B701F00893;
	Sat,  6 Jun 2026 20:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776394;
	bh=n5Pt3mJ/skAzMgF/rZiFavZruhwhV9/q/P/HCw6wU2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZVb1Wg3JvnlgoYqwV57rs9lCs87vpoocp8znot4suapp8mCq4jZSt1OqJ8emFZ0hI
	 Krn7AS9nsRe0NhXeFqO3pvBk0q0t8cnBtGW22Io/Nb7Mol6SnAE+pwzI6dUb4FggyF
	 MXd1sjyJhAvUsDTJMFTa+GKSVQI4hqDuwqW/CJGXvTyCmBO8ZU5MOgbLOneDtD5aLv
	 QUw29n1XjHRWeP7sOjyAJBwRq6zGpSEh99J+Aq6s4VAFyZmEpI0YQBG2F1byHqi+b7
	 oeScrn07CKSJz7laUBBJYS/vrGc1B92jrwWNDmTCPB2oB6hmiCz8i9mUhcq7ae9kak
	 FcxisEBjIfVmg==
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
	Stanislav Fomichev <stfomichev@yandex-team.ru>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 4/7] perf timechart: Fix cpu2y() OOB read on untrusted CPU index
Date: Sat,  6 Jun 2026 17:05:56 -0300
Message-ID: <20260606200601.1861227-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cpu2y() indexes topology_map[cpu] without bounds checking.  The array
is allocated with nr_cpus entries (from env->nr_cpus_online), but
callers pass sample CPU values from perf.data which can exceed that
size with cross-machine recordings.

Track the topology_map allocation size and bounds-check the CPU
argument in cpu2y() before indexing.  Out-of-bounds CPUs fall back
to the identity mapping (cpu2slot(cpu)), which is the same behavior
as when no topology is available.

Fixes: c507999790438cde ("perf timechart: Add support for topology")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stanislav Fomichev <stfomichev@yandex-team.ru>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/svghelper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index e360e7736c7ba65b..826bd2577344b20f 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -47,13 +47,13 @@ static double cpu2slot(int cpu)
 }
 
 static int *topology_map;
+static int topology_map_size;
 
 static double cpu2y(int cpu)
 {
-	if (topology_map)
+	if (topology_map && cpu >= 0 && cpu < topology_map_size)
 		return cpu2slot(topology_map[cpu]) * SLOT_MULT;
-	else
-		return cpu2slot(cpu) * SLOT_MULT;
+	return cpu2slot(cpu) * SLOT_MULT;
 }
 
 static double time2pixels(u64 __time)
@@ -736,7 +736,8 @@ static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 		return -1;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, map) {
-		if (cpu.cpu >= nr_cpus) {
+		/* perf_cpu_map__new("") returns cpu.cpu == -1 */
+		if (cpu.cpu < 0 || cpu.cpu >= nr_cpus) {
 			ret = -1;
 			break;
 		}
@@ -794,6 +795,7 @@ int svg_build_topology_map(struct perf_env *env)
 		fprintf(stderr, "topology: no memory\n");
 		goto exit;
 	}
+	topology_map_size = nr_cpus;
 
 	for (i = 0; i < nr_cpus; i++)
 		topology_map[i] = -1;
-- 
2.54.0

