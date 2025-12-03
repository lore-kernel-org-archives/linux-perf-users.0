Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492AA189BB6;
	Wed,  3 Dec 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796812; cv=none; b=CwstBumfNtBVIHWg4UbXhqSFN4Gxy4fCBzOJJU7mruZI3bI2xpr1ITMuNGm/k1SdQwWBctmTgz77DNDgV+TIsH6zZ2wMpjkfxt+w43OFexe/BFBLHp7xTrM/DJI5HBh32MMHs4/8bLFp+0BLBZ7+nKf16IYS1tNtWAxVo3vPNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796812; c=relaxed/simple;
	bh=H21Qc13y66hmANezpi/tOTUrSLEbJxf9oQ9S5/SkQfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EknL8rYnoEr4G0yurpgBjBkZBkQcdk4UCGoRI4UYnO3lXg4GzqpK7E40CFXwJBhrSkvdPF1TRGpxAUAZwjSnWrMpLK5SY9pdTGHTc/lNWrMKveOaeMIi8KQKQLVXyVhdRAE0GnRllskcWisSA+fY/EQiLAqcDa2JCqW7YTM/Ccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P48z83G0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P48z83G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257E6C4CEF5;
	Wed,  3 Dec 2025 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764796811;
	bh=H21Qc13y66hmANezpi/tOTUrSLEbJxf9oQ9S5/SkQfc=;
	h=Date:From:To:Cc:Subject:From;
	b=P48z83G0InkPn0g9r0P/Gwopk4k7hLSEyCH6+DsVHrwcbSBvjCgep6EkMPjxwUW67
	 p/s9qkTcAQufIwy3eqdSCVWrO+2oRROVA2aDQaUPOHoK5PAyuW5iAoOf/41w2/RrpS
	 fHxhkey+hZfj4qDywgD3mpWLij/nxNI9mpCa7MC8Rl1wzuxUo2LxGWGLzRoG1Bo/qJ
	 mtWMYbdfDWQD6kLNzjmXWhXOz+ADclabJNU9QjjIViWtKHK2042L5L7jQHrF4FOsTD
	 PZSuelYH7SpMXAGh1METAfFiW42HbkLODPGTxerTeqUoLy/cYhA8Y0H0FKAXTbRT97
	 EKFnD0liy7qxA==
Date: Wed, 3 Dec 2025 18:20:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6.19-rc1 1/1] libperf: Compile using -std=gnu17 to deal with
 visibility attribute issues
Message-ID: <aTCpiDG6WOzMv7ji@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We seem to need a more invasive patch using 'extern' on all LIBPERF_API
prefixed functions to be future proof, so use -std=gnu17 which is the
one in gcc 14, present in the distro generation before ubuntu 25.10 (gcc
15).

But to make progress and avoid this on Ubuntu 25.10/gcc 15, lets to with
the easy workaround:

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

libbpf doesn't experience this because for some other reason it already
has this line:

  override CFLAGS += -std=gnu89

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 7fbb50b74c00b3b9..5e12fd97f50c1efb 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -51,6 +51,7 @@ INCLUDES = \
 -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
+override CFLAGS += -std=gnu17
 override CFLAGS += -g -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
-- 
2.52.0

