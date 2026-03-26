Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1E3783CE;
	Thu, 26 Mar 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537906; cv=none; b=a5t8anwPzPM31phHW1CMASNsZd3XsAk//9n5j95bZRon8e3Ki9HsYqTw93qBoAGbpWQ0fXStWMKmTQXLSbhow5eSJYCRSA9X/9QtjccLL3JMuHmr8FZbP0M2O+67gFneRHeZ1zipLHkbgUOXMcWwZYNxEnwC3tpWx+JtQUT+Jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537906; c=relaxed/simple;
	bh=yEPIyPZ8fW28LywZ08KTz1c8AaYap9W25cyAOhfVKAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YPUDcHJGlGAPnT4aNKdKC2Lfjx/RPA0NlfpzVw2l9gPf69eeBG6UON5y9QBv9zbClne1o76Gu0kz7i6YCxz8RGO72HGtbgvr1Ih/AOTjfNY5OUwWiJpmOGt/YnG3QEnvvZ/2YVJEHuEa0v/eduLOu0Z2lWh+H1++lUvBatkT+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExQJWuz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExQJWuz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA46C116C6;
	Thu, 26 Mar 2026 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774537905;
	bh=yEPIyPZ8fW28LywZ08KTz1c8AaYap9W25cyAOhfVKAI=;
	h=Date:From:To:Cc:Subject:From;
	b=ExQJWuz/UkQhTwHFMdcYtO5KdEU5Po3gwGAT4PH7fRCfl+EKNWpfkI+o2HVPkRPdS
	 33+DgLLrPrmwbfG/kzxmYWLQEAh3EgzYNht+bZ/UJLDvbl+QFyG2xU+M6BDicYa2RM
	 uwM513BnVYhaIrM1qR2CZvHW4JfguLPgBJbUNF4iiLMl8LQmYnhkGfHQXkj4Tf1IAV
	 G30l+wbhXtJS8fZZrGC2/xJzaXkSmkX0B9XbmowV4+0IwA4lvj96PyWWcwAZscGCqT
	 JyguM0jG2yXiDcVc+bWPIK7nvZG1xT9zJfdnpp/Xv/DogAEkHibZPajAx0zR9R1vbA
	 FeuQzKrdsOyOA==
Date: Thu, 26 Mar 2026 12:10:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 next] perf beauty: Move copy of fadvise.h from
 tools/include/ to tools/perf/trace/beauty/include/
Message-ID: <acVMawd0s8Jriw9h@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As it is not really used when compiling anything, just being parsed to
collect number->string tables for 'perf trace'.

  $ git grep fadvise.h tools/
  tools/perf/Makefile.perf:$(fadvise_advice_array): $(beauty_uapi_linux_dir)/fadvise.h $(fadvise_advice_tbl)
  tools/perf/check-headers.sh:  "include/uapi/linux/fadvise.h"
  tools/perf/trace/beauty/fadvise.sh:grep -E $regex ${header_dir}/fadvise.h | \
  tools/perf/trace/beauty/fadvise.sh:# tools/include/uapi/linux/fadvise.h for details.
  $

Link: https://lore.kernel.org/r/CAP-5=fVBNQVF8k3JUQjH1nkP69ZVp8BqP+uwygcx=xO0zC4xrg@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                                   | 2 +-
 tools/perf/check-headers.sh                                | 2 +-
 tools/perf/trace/beauty/fadvise.sh                         | 2 +-
 tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a560fbc847934fad..bd89d67c19e2e8e7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -556,7 +556,7 @@ $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_t
 fadvise_advice_array := $(beauty_outdir)/fadvise_advice_array.c
 fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
 
-$(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
+$(fadvise_advice_array): $(beauty_uapi_linux_dir)/fadvise.h $(fadvise_advice_tbl)
 	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
 
 fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c6b136fe8d13053d..531c0e0e84dfa101 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -7,7 +7,6 @@ NC='\033[0m' # No Color
 declare -a FILES=(
   "include/uapi/linux/const.h"
   "include/uapi/linux/bits.h"
-  "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fscrypt.h"
   "include/uapi/linux/genetlink.h"
   "include/uapi/linux/if_addr.h"
@@ -91,6 +90,7 @@ declare -a BEAUTY_FILES=(
   "include/uapi/drm/drm.h"
   "include/uapi/drm/i915_drm.h"
   "include/linux/socket.h"
+  "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
diff --git a/tools/perf/trace/beauty/fadvise.sh b/tools/perf/trace/beauty/fadvise.sh
index 4d3dd6e56dedc994..e9857112fa51e8e2 100755
--- a/tools/perf/trace/beauty/fadvise.sh
+++ b/tools/perf/trace/beauty/fadvise.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/perf/trace/beauty/include/uapi/linux/
 
 printf "static const char *fadvise_advices[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+POSIX_FADV_(\w+)[[:space:]]+([[:digit:]]+)[[:space:]]+.*'
diff --git a/tools/include/uapi/linux/fadvise.h b/tools/perf/trace/beauty/include/uapi/linux/fadvise.h
similarity index 100%
rename from tools/include/uapi/linux/fadvise.h
rename to tools/perf/trace/beauty/include/uapi/linux/fadvise.h
-- 
2.53.0

