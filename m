Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4A7404E;
	Fri,  5 Jun 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691628; cv=none; b=b4Ft+gxsNzhSSCgIVlDlavv3ql+u7jZayVS4U24q8Jx6WAH6xolQe/VNl33YHdliDYOalRnH98brHbfdkutWO3RIpGlX5zOXTK37dPTnZld8qH/2SVDmm3x7jicj6pFX3DsjlAT9nvmFetoFykOtIhNaKE0etO2GBNBbPw3YYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691628; c=relaxed/simple;
	bh=DtRKOLnUfmfS2epWRSorWYdhI0EMiqjGopIwKkqU0Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vkq3cu8JfAxOjvtLplc3Sed9qX6fMEm7/FT5p0vMUsumsdE7ozPdbkm7hUZDf0p8gfjlwh+4YMb11Nydp7P9GU7xb8stXncSUHBX/dRmxIndKHEgcMnhwzl+jyJ9aL+6B0k/gcjdp9finokuPQZa0DFn4WbaX+TtwEAW6V3KHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw0YnQB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw0YnQB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A91F00893;
	Fri,  5 Jun 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691626;
	bh=XQy4zT4Nms9P0xdtxPNVdKMuPS+RkQp6GJQAz9nA6c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bw0YnQB5OhXR/RIpeNiv5krGA+tBFwPb/sVOf1ZdeCJpCsAhtil86fkTBhL/JOUke
	 bXK1hoRBLPiIp4uiVERF26te1SFA3CAmECuzUH/u1B7QrxuNXN3TahsEy36zxVBllT
	 Xxt+VbyaPiox+1hIgvSj+qlfD4LwlAcKO4lx4NUOgbADLwe3BuWgJElw0SmLnNRmed
	 E0/pER/W/hvff3Du9fux3t5GFynqQoCFAVM4qBGl3KADHQu7W3XXzbQtbWCOrMuMpg
	 +7A/3vX2IfTGnIrymkamWvTPX2fJih2gH9uUzXXmdGva3W9/P9CWy70n1Xrc7KyMCB
	 XwHSzbfQsgCUA==
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
Subject: [PATCH 4/8] perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
Date: Fri,  5 Jun 2026 17:33:12 -0300
Message-ID: <20260605203316.1758661-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605203316.1758661-1-acme@kernel.org>
References: <20260605203316.1758661-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

setup_nodes() iterates CPU maps from the perf.data topology header and
uses cpu.cpu directly as an array index into cpu2node[] (allocated with
c2c.cpus_cnt = env->nr_cpus_avail entries) and __set_bit(cpu.cpu, set)
(bitmap also sized to c2c.cpus_cnt).

A crafted perf.data with topology CPU IDs exceeding nr_cpus_avail causes
out-of-bounds heap writes into both the cpu2node array and the per-node
bitmap.

Add a bounds check to skip CPU IDs that fall outside the valid range.

Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b78217d98988a75c..cbe0e993053d403c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2371,6 +2371,10 @@ static int setup_nodes(struct perf_session *session)
 		nodes[node] = set;
 
 		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
+			/* topology CPU IDs from perf.data may exceed nr_cpus_avail */
+			if (cpu.cpu < 0 || cpu.cpu >= c2c.cpus_cnt)
+				continue;
+
 			__set_bit(cpu.cpu, set);
 
 			if (WARN_ONCE(cpu2node[cpu.cpu] != -1, "node/cpu topology bug"))
-- 
2.54.0

