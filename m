Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF821348;
	Thu,  2 Oct 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420077; cv=none; b=jC/2AEuRCOKgGydIjtYWSjyKYvQgdE7IoIALnS91tCoWHLr5VHBrUY+7HX+ajk8qGONwyAOXpcTNHNlUnhF8atWMIlQ81Ut90Kw3t0Kzg0CXfgTIpqVvsre/3mMKlyaD1H5RMYK6GTIHJkWuPeP5q/+YCt4hbhOMUYZw0Z9wiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420077; c=relaxed/simple;
	bh=UoRDmE2ZKRPu4BHSvN0OLW3hVDpBZhGdma8oLaU0IEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BtbJdtLWYZOnmYU9U6nweUgjXwse40VPfuPO/Ww2jidZHLh1E9dlL37BMnYP3RH/JavjcKBA41NCq955fUmPB2NBZlKlpHrH6EM3ALZTccwpUVN8NcpmedTp1GNizLTjkwHOzG0JRGgJyng7a9tC1qv6YjAELfGyFNAYSGcwtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pib/yUCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pib/yUCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61739C4CEF4;
	Thu,  2 Oct 2025 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759420076;
	bh=UoRDmE2ZKRPu4BHSvN0OLW3hVDpBZhGdma8oLaU0IEk=;
	h=Date:From:To:Cc:Subject:From;
	b=pib/yUCeAXuGkELFcX7OyoFrDvop0q00wgOJWd7Q4iBSfd1UOJkSZXRayqg3F9YcS
	 Sivk6mU5slHMUs+o8iDAK21pHXpSYsGz7qFvBnz3H3AYy0l0PGVndrwmwZCelQoQJd
	 9F/GxIxAH8tuAig0tc/uQZTwWkCTcbVgABrT874SzDphpyLbZbj1SuYcDRNQ7TSpOJ
	 NiE23QLceNW/mgs4BuHSkBe7C1Xwh4/61WJxtLCMZFsQNebnmfCcAp2xMc583sauB3
	 Xh8SQaqRL1G9eV2t3FlhEguV+K6875C3dPen1P+ohRxLxoxa1xYPxyS4HhdcpuiCrf
	 zwfiTg79O3VPw==
Date: Thu, 2 Oct 2025 12:47:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Tomas Glozar <tglozar@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v2] tools build: Don't assume libtracefs-devel is always
 available
Message-ID: <aN6eqf1nPwrfa4YU@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

perf doesn't use libtracefs and so it doesn't make sense to assume it is
always available when building test-all.bin, defeating the feature check
speedup it provides.

The other tools/build/ users such as rtla, rv, etc call $(feature_check
libtracefs) to check its availability instead of using the test-all.bin
mechanism, stopping the build and asking for libtracefs-devel to be
installed.

Remove it from FEATURE_TESTS_BASIC to not have it as available, as noted
by Ian Rogers during review.

Acked-by: Tomas Glozar <tglozar@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature   | 1 -
 tools/build/feature/test-all.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9c1a69d26f5121fd..531f8fc4f7df9943 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -83,7 +83,6 @@ FEATURE_TESTS_BASIC :=                  \
         libpython                       \
         libslang                        \
         libtraceevent                   \
-        libtracefs                      \
         libcpupower                     \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e1847db6f8e63750..2df593593b6ec15e 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -150,10 +150,6 @@
 # include "test-libtraceevent.c"
 #undef main
 
-#define main main_test_libtracefs
-# include "test-libtracefs.c"
-#undef main
-
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -187,7 +183,6 @@ int main(int argc, char *argv[])
 	main_test_reallocarray();
 	main_test_libzstd();
 	main_test_libtraceevent();
-	main_test_libtracefs();
 
 	return 0;
 }
-- 
2.49.0

