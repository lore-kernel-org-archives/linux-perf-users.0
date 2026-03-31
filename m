Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E55317150;
	Tue, 31 Mar 2026 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991213; cv=none; b=go20dyHTqIzI3rK6Ns0XYFhY17SyGelGB55qiYSlwYnlV8YQZ2YelgejjF0nyO387jEQb1evyi4b54Oew/3S+OlKfKwLqrgut59qrRqJG6YiNltgzkv8Snb4q4wqyljurY9gbUptMgW+4jh9LGvy1rzjTDGV7SqnJxEr+FConjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991213; c=relaxed/simple;
	bh=0m4yzpu64MSF3uadEQv4UlSUQ3sULu0Q2sh802UhRos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpIYaES1EcaU1UbQm+3btYeXJNtm8Q2kLCvRvtXy5mkuLstIm1rRzAXmxHE+OwRDlYSYlaXmwvUubVBHi5N5bUQipZGFd3v0FOpk6SYfcs/yJWOuPQ03kY2Vu0kxN4I8p2z4Sq5Wwpmot4GnsTSkweHhT2GYaIbEzZLzEdF3dIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvKjnvLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvKjnvLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5A5C2BC9E;
	Tue, 31 Mar 2026 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991212;
	bh=0m4yzpu64MSF3uadEQv4UlSUQ3sULu0Q2sh802UhRos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvKjnvLD8r/3ldv4ytOkskzIBBSLubsM/cI0xciRYnIeqf7z6B+XvVCmdf2k7g+RK
	 yYLdgoup/Deu8zD3451z9J0cG/irHFA7LI+9Wzbl9Zhh28JYkkW2OmfxdtG3UiY6RH
	 DD0j4iC1qQBD14yNntpYGFiXe8flJD7KIc9sg1PFPhwfq6R9AGOO/PdtNcZoEpAbfS
	 5AwZbV0NyH7UOzrqyMHy2+ZsOjLVzWonMyqQ5Ik6V7IZEgE+m5cvHu4RQ2QXSEdKcb
	 kdS8982nSExU/zUfO5CF2sJ31hXhGXdH3QEuinnU0DK+j3FW/c8buxxReOblmG0Qy0
	 zz6nPZblOxavA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/2] perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/
Date: Tue, 31 Mar 2026 18:06:34 -0300
Message-ID: <20260331210634.2126391-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331210634.2126391-1-acme@kernel.org>
References: <20260331210634.2126391-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/Makefile.perf                                   | 4 ++--
 tools/perf/check-headers.sh                                | 2 +-
 tools/perf/trace/beauty/fadvise.sh                         | 2 +-
 tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h | 0
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a560fbc847934fad..cee19c923c0607d2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -556,8 +556,8 @@ $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_t
 fadvise_advice_array := $(beauty_outdir)/fadvise_advice_array.c
 fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
 
-$(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
-	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
+$(fadvise_advice_array): $(beauty_uapi_linux_dir)/fadvise.h $(fadvise_advice_tbl)
+	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(beauty_uapi_linux_dir) > $@
 
 fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
 fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
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

