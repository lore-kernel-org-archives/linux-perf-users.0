Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437C371CFF;
	Wed, 25 Mar 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470262; cv=none; b=ZHw7rTTiXBaYKZYy49co1oMktMaS/4VidfXV6Ke7XJ45xqyZxrYU9u5NagBovAg3X1cCLjYuzUbSnJFMX29qnLEGhQAk/BWgsz2DmFd+zmsi0TzBTpaRX2aK7aLm9tJP+fdISLDy4E33nybgITajKlJkbgcUYnC8yzkE5VZRrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470262; c=relaxed/simple;
	bh=5fd3ECdDIqqSgH53R+bITI0S5qmf4w7tCTbW5/P4uOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vm1yWfeNE4fGrmhyRmQ6P6EV2OaMnfdwTk5+8W3mVRdz29qv18QLzYrRWHiBT5HgkcSQP5gREVoaNkeTmrp2SCrUGNFh3EBe4cvXXFpw+RKU4pXpzGLVlWZNg7hM7pLoVJ6QNUZNaUh+xKMR+HXJZxs7/PhucebjKHgIk8w7TAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf6i5EZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf6i5EZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF6EC2BC9E;
	Wed, 25 Mar 2026 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470261;
	bh=5fd3ECdDIqqSgH53R+bITI0S5qmf4w7tCTbW5/P4uOQ=;
	h=Date:From:To:Cc:Subject:From;
	b=jf6i5EZ3QjKRJyi7LRKDLkJMR3deu6OftSQmgwDHN8ZNXaEd4j7Q8SSZ1ihxPvXUD
	 FLJuwM2/QFnHXnUC7yw6bQNgc6NO9QV2zW38yrNazXtPlquD7B4KIR8x1JkiepFiVN
	 wKFhTfRx6J8zMM6A9K33QlpVEZ/jNi3tO1cNkhhGMva6uq43NYVJs3P1c/S4hWgJAc
	 TyHv/Hq7d2113gm0f48jDcKF3A07r3N/WFdO1k7XLevjXTbJ35LUm2IeO49TpBr9UZ
	 ZQOSFi07rQR0rH9aNzZjaCga4+Igi0/Mo4L25fBvGh8z5+9cpQ0ZT5mlhzIV65PmUA
	 H2YVUNgfjmcsQ==
Date: Wed, 25 Mar 2026 17:24:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 next] tools: Move tools/include/uapi/drm to
 tools/perf/trace/beauty/include/uapi
Message-ID: <acREcm8rZbNcav23@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As it is used only to parse ioctl numbers, not to build perf and so far
no other tools/ living tools uses it, so to clean up tools/include/ to be
used just for building tools, to have access to things available in the
kernel and not yet in the system headers, move it to the directory where
just the tools/perf/trace/beauty/ scripts can use to generate tables
used by perf.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                                  | 2 +-
 tools/perf/check-headers.sh                               | 4 ++--
 tools/perf/trace/beauty/drm_ioctl.sh                      | 2 +-
 tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h      | 0
 tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 11b63bafdb2329a5..1a4674243cfa01e8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -547,7 +547,7 @@ $(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_tbl)
 	$(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
 
 drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
-drm_hdr_dir := $(srctree)/tools/include/uapi/drm
+drm_hdr_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/drm
 drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
 
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index da3aca87457fdc56..f220da953c6b1873 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -6,8 +6,6 @@ NC='\033[0m' # No Color
 
 declare -a FILES=(
   "include/uapi/linux/const.h"
-  "include/uapi/drm/drm.h"
-  "include/uapi/drm/i915_drm.h"
   "include/uapi/linux/bits.h"
   "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fscrypt.h"
@@ -90,6 +88,8 @@ declare -a SYNC_CHECK_FILES=(
 declare -a BEAUTY_FILES=(
   "arch/x86/include/asm/irq_vectors.h"
   "arch/x86/include/uapi/asm/prctl.h"
+  "include/uapi/drm/drm.h"
+  "include/uapi/drm/i915_drm.h"
   "include/linux/socket.h"
   "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fs.h"
diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beauty/drm_ioctl.sh
index 9aa94fd523a9c2dd..f2f1a257bac8b41e 100755
--- a/tools/perf/trace/beauty/drm_ioctl.sh
+++ b/tools/perf/trace/beauty/drm_ioctl.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/drm/
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/perf/trace/beauty/include/uapi/drm/
 
 printf "#ifndef DRM_COMMAND_BASE\n"
 grep "#define DRM_COMMAND_BASE" $header_dir/drm.h
diff --git a/tools/include/uapi/drm/drm.h b/tools/perf/trace/beauty/include/uapi/drm/drm.h
similarity index 100%
rename from tools/include/uapi/drm/drm.h
rename to tools/perf/trace/beauty/include/uapi/drm/drm.h
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/perf/trace/beauty/include/uapi/drm/i915_drm.h
similarity index 100%
rename from tools/include/uapi/drm/i915_drm.h
rename to tools/perf/trace/beauty/include/uapi/drm/i915_drm.h
-- 
2.53.0

