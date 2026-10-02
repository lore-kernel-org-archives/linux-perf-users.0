Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0957263F5D;
	Fri,  2 Oct 2026 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920121; cv=none; b=S4hg/FosQ6wl/soOClsn0FYYoUfkAZQW8oUZLKsXFzn3XKAr6D3q5ZgyHpNwBVeWSC2lfsQN6/L8aDrmO1Cj1XNsU5ca+pb38gA828Llmt1GAV8r7OfGG6N4WMEjm3doOsMu9X3JCCALuq2d2K+/r0TSI2YNeKHOjE5TLmQyJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920121; c=relaxed/simple;
	bh=AcSQTHExjj/ck0XyV2GJ09CJ95tny3ob1Gwszsi46R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGyVEkaI3XboSNLNoqJswBUDdzSiZm/Bl0yDIA85GUC+NbAfh7lA5mx/me0qrniAk6VpFSrFz/aLLZDufmUYsF4nlLVgjcUdHShuWffshXJ57hsF/tKol19uBtZHGhXTbGw/OKoqriS4CHT5GzPkWfWu6b82u6ypo72zvOXrpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+Zw5cI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Zw5cI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A21F00893;
	Fri,  2 Oct 2026 05:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790920119;
	bh=++dgApjfRA1Tl0LzMZhhtP9eZSf7IsbCx9oAKsJeAN8=;
	h=From:To:Cc:Subject:Date;
	b=F+Zw5cI/5rc32I4adx3T0I/q7yj+eAFqNTo8nTo9DlSI3iuamKup8JnSb2IXsex40
	 dg3JrOfLdUQTCpnm72AsWvRjeuC73WsiYoqeixbKbhV9YDysoHKm2fGaZN0Hct8fgg
	 IPqwYPVl4rzakh9HRRE6bf2WoHM035Yowlf8c+KKbg/ijMs7ydJQeH3ae2Iz1QECmj
	 sc5rxjZonvI5Pu3rpGoD4oqeezspwYCK9fUeszRihvRFy6nqpg/imifJdwjqTXFHpA
	 puzZ3ehjX29x1F3CZjQeknZp/qjTE4kgZV1xxTzcDqMq917AZKMihP76Xa51bunm24
	 Xxv4QL7vlb6yg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Chun-Tse Shao <ctshao@google.com>
Subject: [PATCH] perf stat: Fix aggregation of cgroup events
Date: Thu,  1 Oct 2026 22:48:32 -0700
Message-ID: <20261002054832.64980-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got a report that perf stat with BPF and cgroup is broken with
aggregation like per-socket or node.  On my machine, running the
following command shows the problem.

  $ sudo perf stat -a --bpf-counters --per-socket -e cycles \
    --for-each-cgroup /user.slice,/system.slice  sleep 1

   Performance counter stats for 'system wide':

  S0       12      <not counted>      cpu_atom/cycles/                 user.slice
  S0       16      <not counted>      cpu_core/cycles/                 user.slice
  S0       12      <not counted>      cpu_atom/cycles/                 system.slice
  S0       16      <not counted>      cpu_core/cycles/                 system.slice

         1.002798147 seconds time elapsed

That's because there's a logic to make the whole event failed if result
from any CPU looks bad when aggregation is enabled.  Normally it
considers bad when an event has no enabled and running time.  But it's
possible for a cgroup event to have no chance to run on some CPU during
the window and then it will have 0 enabled and running time.  Let's not
treat them as errors.

After the fix, the same command produces:

   Performance counter stats for 'system wide':

  S0       12          5,094,112      cpu_atom/cycles/                 user.slice
  S0       16         28,075,944      cpu_core/cycles/                 user.slice
  S0       12          1,516,568      cpu_atom/cycles/                 system.slice
  S0       16          5,569,575      cpu_core/cycles/                 system.slice

         1.003231856 seconds time elapsed

Reported-by: Chun-Tse Shao <ctshao@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 25f31a17436828aa..6da3dbbde0e2ad8d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -381,6 +381,10 @@ static bool evsel__count_has_error(struct evsel *evsel,
 	if (config->aggr_mode == AGGR_GLOBAL)
 		return false;
 
+	/* cgroup events may not be scheduled on some CPUs */
+	if (evsel->cgrp)
+		return false;
+
 	/* it's considered ok when it actually ran */
 	if (count->ena != 0 && count->run != 0)
 		return false;
-- 
2.55.0

