Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97334A0925
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454751; cv=none; b=PfXzInO08CiKfZ/trXQMMt8ScPE/dYKEhhp7hDBeQDmE7M58/HwP6muD+kPclIWn1BGeAw1LuWg0PEuFSs8UzTK1bTIKZ0mKOkcELkwIc4BMNzN8VyXzvbV6Uuwqf9LOSPup5UOLrIqeKOn4PEr4mATKr3ewp6IIaLMXQBUKOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454751; c=relaxed/simple;
	bh=unIWNemEeCfSGKI/5XwwHHk/O/+GzoowW5GpZW4ciAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ssJ+/J5fiuNCOW0WXVI0l6gIaTGoQjIAABd1TEayucVmyEk0rzXDcymNo2U9r5cIaIdK/wFT8u8D9Ae5ppInGYoaOtqrxZdBV/QNbdVdjBHUIamP0WiCUmRBjadoHi2T2pLuzNSk/rzqwmeq+dBnAOxSmWffgHRh85vbGyM9rgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhQAM9fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhQAM9fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B255B1F000FF;
	Sat, 26 Sep 2026 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790454750;
	bh=WiOvHkz+/5KKvcMekB1tFNSGqK14phYzIo1kxKGjBdk=;
	h=Date:From:To:Cc:Subject;
	b=fhQAM9feABPrqcyWdOI3XRiCDxYXNJTuBAdHwrI8KioV5nJnnhBYrXiQsPFDP6opu
	 Ewgn8HdMbl7AYHjTRS89b/pG0dPkS1WSSOO6MDzpUivgU8HtLqmhr3eQai2gRtG8ES
	 i/kLMeEvmvPU+m8Mr3T2QowrqNqTDsuyoGy2T+7ES4wo83d0DgnRyxG+uce3BjUeZU
	 v0cE9g6UXjLvflbPh8f7bq6j6DrO7mIXh0jYI4cBWU7GCzoFGDthlhzYzJbucDaZxI
	 QsixWA0ysIjHPQBjp168p8V2Iw4Amc4nsf+ziQuF/SPbpAcAekiLR3Eh3xbzfct4AM
	 2+Hh4k0A7ApZA==
Date: Sat, 26 Sep 2026 22:32:27 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] perf timechart: Remove the unused use_old_power_events
 variable
Message-ID: <argr21X4JoSl1O2W@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It is set once and never read: its only reader went away in
20c457b8587bee46 ("perf timechart: Adjust perf timechart to the new power
events") and nothing used it since, so the assignment was dead code for
13 years.

clang 23 extends -Wunused-but-set-variable to file-scope variables with
internal linkage, under the new -Wunused-but-set-global subgroup, and
with the -Werror that perf uses by default that turns the dead
assignment into a build error:

  builtin-timechart.c:355:12: error: variable 'use_old_power_events' set but not used
      [-Werror,-Wunused-but-set-global]

as seen building with clang 23.1.1 on Fedora 45 and rawhide, where gcc,
older clang and clang without -Werror all keep building it.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 3f9153d5ecfb79b0..3d88c90c6573bf88 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -351,10 +351,6 @@ static int process_exit_event(const struct perf_tool *tool,
 	return 0;
 }
 
-#ifdef SUPPORT_OLD_POWER_EVENTS
-static int use_old_power_events;
-#endif
-
 static void c_state_start(int cpu, u64 timestamp, int state)
 {
 	cpus_cstate_start_times[cpu] = timestamp;
@@ -1943,7 +1939,6 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 #ifdef SUPPORT_OLD_POWER_EVENTS
 	if (!is_valid_tracepoint("power:cpu_idle") &&
 	    is_valid_tracepoint("power:power_start")) {
-		use_old_power_events = 1;
 		power_args_nr = 0;
 	} else {
 		old_power_args_nr = 0;
-- 
2.53.0

