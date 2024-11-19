Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADE53363;
	Tue, 19 Nov 2024 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044876; cv=none; b=Aq5vLx/kPSYwORZOgaOnr+G+ezbx46poJa4+/W9vcwn1Om/sThs6fxC0kgUA49OI2dDC0TSv0o/ZRYNlUcOCFnQ+mrCMvoyFTS+LGUXLltW+2xw7vyyiB9sVcw1WKx1sj9p3ll5bMFp4gNzWV6OwySZDU1QiBp6Fyk8key95b9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044876; c=relaxed/simple;
	bh=ybYWFQ+nVQHzZds37gKALu6cm9L0YbObppd6u/lXX74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gfzlE0pYoqvUHsF05m0ofBc248/PxSV7/Oq92MoQbdcfOKsFTz9+RbZ1YCVlXsFpCa4ZejauHC0Fvb/Hf9IfRSU3GgKDvPfz6mus5LNDi49uJnT1uQYonccOaULy0y9lsfHI3aqIW7LvzGf2k8eBGb2rZ6GVV3eQ5FI6WKRBV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUF9Lsv/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUF9Lsv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5A3C4CECF;
	Tue, 19 Nov 2024 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732044876;
	bh=ybYWFQ+nVQHzZds37gKALu6cm9L0YbObppd6u/lXX74=;
	h=Date:From:To:Cc:Subject:From;
	b=LUF9Lsv/J0duh5c3QvJ5O5wjIdWBpcJOo0//f7N/gJ4VrEKEbaYskmOxnx9lf/LTF
	 C7UM/HXcHE3oTxwp8UXwUBqI5Gf9SIzaMrjDsmJjNpAlaKJf44OXtvw8zzPSUbw36B
	 nxuOSvDkAoUzuSOKQAHu8zcN3kgnYgMZK2qRo8bxd699MS5fZ+R9pAt/WjUoDmCQuj
	 Qrty5ZV0VEBrYbggPwZ2UAM3X4NYasnhmTr56BG1BSxXtL4oFyGDlp4VQ1IBdi5P2J
	 n8XlMgZ7T5ETRV18wrOE+UU1opl/qZD1tDGv+HPS8eoSZnR4GH9/Np425cFr02iIsU
	 qzp7lNUeZZQxg==
Date: Tue, 19 Nov 2024 16:34:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tests hwmon_pmu: Remove double evlist__delete()
Message-ID: <ZzzoJNNcJJVnPCCe@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In the error path when failing to parse events the evlist is being
deleted twice, keep the one after the out label.

Fixes: 531ee0fd4836994f ("perf test: Add hwmon "PMU" test")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/hwmon_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 1e5f93aaaf5f9210..d8ed00d45dd7249e 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -155,8 +155,6 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
 	if (ret) {
-		evlist__delete(evlist);
-
 		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
 			 __FILE__, __LINE__, str, ret);
 		parse_events_error__print(&err, str);
-- 
2.47.0


----- End forwarded message -----
