Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64146647;
	Thu, 10 Apr 2025 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246974; cv=none; b=UzP4uFNHJrx9fB9Hy9+qkxUr++vvYqhd0fmSaqGiavtpcib7P+1bxdb3Ezr9ln2nuRE2zycowcIsw5LuOHEyP0cmdRx0eDL7C1mcpSblX2HTevRS4oiZSeRnrxniUvx7aivS0jQSOL4NAvNccxTiqnqYujcZxe9qI9ac7ubOrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246974; c=relaxed/simple;
	bh=GUHS/4Nkf7J6bc7/7YtgtSPyEUMQRZos6or8dxKDCvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JyXWvMAvizcBjgRrD41+7JSOI6dyUSf3NZbP+CuptArLzmtgiOcvrNXBvkh9MPuENd40/pKc3wo7qnOvnsl8y0hLvuJui8thXsRaxjMzQ9JCiDs45Zx8l7P7w/NBT0WxPJ76hBph/ft+YycLU4jrUULYR6MjizG1b618b7JK9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCSrbdm8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCSrbdm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDAEC4CEE2;
	Thu, 10 Apr 2025 01:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744246973;
	bh=GUHS/4Nkf7J6bc7/7YtgtSPyEUMQRZos6or8dxKDCvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rCSrbdm8YmhBLINvMRhxVXHCpPNnvfykqKlQtSIHktdCfth7lajVgWPG3zsSD9Uvo
	 ASE46zXUJeClhsnDjswyNvVEtnqEl6OkLS+FauYQb0Vb8gsiQxwdpxhjp+zo6E3NWa
	 RemXsDCBo7aSgIMABbqxgvevCecfwSV0UcACo9598cRYzEYtmlLOEeTvT52JUA8Ib7
	 QkZQFEAX+15BOjYDd7FuNkhcAW1/3KRJjxDb0IBYGUUBFGJk6TwCHSliI5nenqdvKu
	 Azl3pukIGnawwxF+8BjHivYHrVEZkYFcEW55I3A1Ys0/Kr8rHDVP8H8AjMWTeB+NlT
	 s3ldob5jriWbQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Chun-Tse Shao <ctshao@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH] perf tools: Remove evsel__handle_error_quirks()
Date: Wed,  9 Apr 2025 18:02:52 -0700
Message-ID: <20250410010252.402221-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evsel__handle_error_quirks() is to fixup invalid event attributes on
some architecture based on the error code.  Currently it's only used for
AMD to disable precise_ip not to use IBS which has more restrictions.

But the commit c33aea446bf555ab changed call evsel__precise_ip_fallback
for any errors so there's no difference with the above function.  To
make matter worse, it caused a problem with branch stack on Zen3.

The IBS doesn't support branch stack so it should use a regular core
PMU event.  The default event is set precise_max and it starts with 3.
And evsel__precise_ip_fallback() tries with it and reduces the level one
by one.  At last it tries with 0 but it also failed on Zen3 since the
branch stack is not supported for the cycles event.

At this point, evsel__precise_ip_fallback() restores the original
precise_ip value (3) in the hope that it can succeed with other modifier
(like exclude_kernel).  Then evsel__handle_error_quirks() see it has
precise_ip != 0 and make it retry with 0.  This created an infinite
loop.

Before:

  $ perf record -b -vv |& grep removing
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  removing precise_ip on AMD
  ...

After:

  $ perf record -b true
  Error:
  Failure to open event 'cycles:P' on PMU 'cpu' which will be removed.
  Invalid event (cycles:P) in per-thread mode, enable system wide with '-a'.
  Error:
  Failure to open any events for recording.

Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7da5e..3c030da2e477c707 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2566,25 +2566,6 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 	return false;
 }
 
-static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
-{
-	/*
-	 * AMD core PMU tries to forward events with precise_ip to IBS PMU
-	 * implicitly.  But IBS PMU has more restrictions so it can fail with
-	 * supported event attributes.  Let's forward it back to the core PMU
-	 * by clearing precise_ip only if it's from precise_max (:P).
-	 */
-	if ((error == -EINVAL || error == -ENOENT) && x86__is_amd_cpu() &&
-	    evsel->core.attr.precise_ip && evsel->precise_max) {
-		evsel->core.attr.precise_ip = 0;
-		pr_debug2_peo("removing precise_ip on AMD\n");
-		display_attr(&evsel->core.attr);
-		return true;
-	}
-
-	return false;
-}
-
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu_map_idx, int end_cpu_map_idx)
@@ -2730,9 +2711,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (evsel__precise_ip_fallback(evsel))
 		goto retry_open;
 
-	if (evsel__handle_error_quirks(evsel, err))
-		goto retry_open;
-
 out_close:
 	if (err)
 		threads->err_thread = thread;
-- 
2.49.0.504.g3bcea36a83-goog

