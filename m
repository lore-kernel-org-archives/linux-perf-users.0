Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C65165FBB;
	Tue,  7 May 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093921; cv=none; b=AIrpFtyT4zSVXpIuVJwvLHQto7vm5WVo/AA28C/5fTJ87/TAPK3uX2Q5voJ1qjGPPFglI7IMjHjCZFmpmCCDCNlb38xtp/gIX60AVw0JWnEjN7FGzo/rqQQ/AdijCDxSwZJjg+yym1e1cJWNq/PC4yapPV4pX/S4FGIXf5+FBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093921; c=relaxed/simple;
	bh=BlgGobMZndwfwOk3KudlQAze0gy+zqr4ktG0u2cvSuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=relgHke2BsLYRoc84xMzJwcO9iISDY8btc6Y7EVz7e2XCjSwPMeBwUoszRNASiPcC2Y5r/7mW532iieKFCjb9erDbCxeqHBghhNWnWE4wA/5gqV/giBvZFGhkuuGGDVPIRY6ruXDG18ox53iOu+m327AgeQQTReLc07+lm2YfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv5hBkoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv5hBkoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE9CC2BBFC;
	Tue,  7 May 2024 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093921;
	bh=BlgGobMZndwfwOk3KudlQAze0gy+zqr4ktG0u2cvSuA=;
	h=Date:From:To:Cc:Subject:From;
	b=Dv5hBkoDatfLK0RnKlftZWS6xf5XN+VbQH8YTRBrSGSxuFNF/Fdxa0dIZIepFcXrd
	 +rBvI6X8Ta3+6p0Kq6QKvZ0UWWd+K+zZZp+Dq11yZEmecYiNYODyruzBgYQUdc5Yc1
	 ya+SDUcMIwKnmj6GjArLT4BhzusC2KPtze9Y05Uit6P9vwMIejoi8o9vl/0qPdnQ5j
	 /mMf+ZYrG7SYwfvd+3uhcvqMIWbElFXLOq8+lz8j5ZKDecBWS4r7t7c7lwbXKgJZOO
	 Yi/ry1VsWO7dco0VvOr9N/ZDp5qB0sqZAqsl2iekG0D+23YOG3fwL9HGhoqqGfZ3ka
	 OzCD+8p2ILhmw==
Date: Tue, 7 May 2024 11:58:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf probe: Use zfree() to avoid possibly accessing
 dangling pointers
Message-ID: <ZjpBnkL2wO3QJa5W@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When freeing a->b it is good practice to set a->b to NULL using
zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
pointer is kept somewhere, we can more quickly cause a segfault if some
code tries to use a->b.

Convert one such case in the 'perf probe' codebase.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 019fef8da6a8e60f..003a3bcebfdfc2d1 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -325,7 +325,7 @@ static void cleanup_params(void)
 	for (i = 0; i < params->nevents; i++)
 		clear_perf_probe_event(params->events + i);
 	line_range__clear(&params->line_range);
-	free(params->target);
+	zfree(&params->target);
 	strfilter__delete(params->filter);
 	nsinfo__put(params->nsi);
 	zfree(&params);
-- 
2.44.0

