Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932A221FCC;
	Thu,  4 Dec 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864713; cv=none; b=JVCIOByxaG55/ICyqIGoJ+5G7sXIlMN2DAEQxS/NNTzg7DFDXoh8oEEW0NFPVpojif/1APPSV/wgt3GCux0eG0kUxkhQuRHa/ihG20LtP6rmWKAcFu++AhF92RCVz5y2kWRK1YvDOOCpMIzuCiUbModNQmSIAIYonInKOG79Bwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864713; c=relaxed/simple;
	bh=CD0Mqc2naSYjEnloMR3Ep0eSN+0Y1+5kFDWUM55ziUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SkuEQBeoBkjSwTfKjH7ijCphZ6uQFw5Yz3aWJSo8ird5u9f8EyHATyPJNVtpAMYT9C6/FfExeByYs4erIQ0CvP7GPdTJuoL0NpRUkit2MooChxbi8zVsuSPr0BvjIgngVITJlrUj0qNvXTNoW5j6i1xIqbK1YcY9YzRzKWBIaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEUbtOXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEUbtOXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31278C4CEFB;
	Thu,  4 Dec 2025 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864712;
	bh=CD0Mqc2naSYjEnloMR3Ep0eSN+0Y1+5kFDWUM55ziUo=;
	h=Date:From:To:Cc:Subject:From;
	b=rEUbtOXbS6hn/aQozzfJwMjexSeRdV4ZQsUbaWexqyT5GR6oMs9jnwy9jGJ2MEcn3
	 q3XxXwEcayyJM9X21MuPmP6uIyUUv5jTcQqR/JkAhn+XHPKhECkTIfW3NVcRsiGgRB
	 uZMgJvNra4PXEOAAp9P7mrKKfslRgwCdk7oaigZrcljAQFrYG5nq13TgS5kfMVEDoE
	 wkReZOUCG1lYsl+Tk5MbTEqhdHxBWcmYgx6SNe+V5EszHnyjhq3hhfjQgAYjOdIrOk
	 cZClIX060Br0wlOF1dVwfLNq8jL68nkCGWwekbdaOJMJQeA7EwoX1p7m3/lv5lX1HT
	 TGXRdwacWsdZg==
Date: Thu, 4 Dec 2025 13:11:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6.19-rc1 1/1] libperf: Use 'extern' in LIBPERF_API
 visibility macro
Message-ID: <aTGyxZizJtieaT1S@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use 'extern' on LIBPERF_API to address this issue that started appearing
with gcc 15, first seen in ubuntu 25.10:

  evlist.c: In function 'perf_evlist__purge':
  evlist.c:202:17: error: implicit declaration of function 'perf_evsel__delete'; did you mean 'perf_evsel__exit'? [-Wimplicit-function-declaration]
    202 |                 perf_evsel__delete(pos);
        |                 ^~~~~~~~~~~~~~~~~~
        |                 perf_evsel__exit
  evlist.c:202:17: error: nested extern declaration of 'perf_evsel__delete' [-Werror=nested-externs]
  evlist.c: In function 'perf_evlist__open':
  evlist.c:261:23: error: implicit declaration of function 'perf_evsel__open'; did you mean 'perf_evsel__exit'? [-Wimplicit-function-declaration]
    261 |                 err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
        |                       ^~~~~~~~~~~~~~~~
        |                       perf_evsel__exit
  evlist.c:261:23: error: nested extern declaration of 'perf_evsel__open' [-Werror=nested-externs]

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
[ v1 used -std=gnu17 to workaround this kinda like libbpf, use extern as suggested by Namhyung ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/include/perf/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/perf/core.h b/tools/lib/perf/include/perf/core.h
index a3f6d68edad76240..06cc132d88cf3436 100644
--- a/tools/lib/perf/include/perf/core.h
+++ b/tools/lib/perf/include/perf/core.h
@@ -5,7 +5,7 @@
 #include <stdarg.h>
 
 #ifndef LIBPERF_API
-#define LIBPERF_API __attribute__((visibility("default")))
+#define LIBPERF_API extern __attribute__((visibility("default")))
 #endif
 
 enum libperf_print_level {
-- 
2.52.0

