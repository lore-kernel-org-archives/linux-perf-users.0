Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7263B774B;
	Wed,  1 Apr 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077349; cv=none; b=QDcpIoxcMeG89G/uVlNElRRM+QjUrCfXxRQh8Vnh8tsJRO0KtaW3pz9UddkAbQtKoQdcK6fsEAEkVOQMJR4iFKboBe9xgap0vBTBM3Fy0VvTVbwngtpVfdqdPKvFr2RHSzf+6dgQrZOStR6KDjL8vm+XB0of+7JrTejwqBa7fRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077349; c=relaxed/simple;
	bh=0VgDT/m13pM4gzV29+Nx0vRnBtaPc+jQECY4GfK04u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbmrfAPVVfFjIPhvRZv78XOEOFn7Y0ReA5vL0YX+xxqRzEpMSX9UtIDUGqsa31VMMazjCKPEcyvECy/az3gIn8me27dGDJF2D34flpGG9q6EXTgmiOAcvdGAH0lsa+BIvhxLcD/3bdjUhB+8EusP9dJHUwOCqqOhB4qKvQKQzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0cDrEPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0cDrEPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AEDC2BCAF;
	Wed,  1 Apr 2026 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077348;
	bh=0VgDT/m13pM4gzV29+Nx0vRnBtaPc+jQECY4GfK04u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0cDrEPap0Xqy7KBB27VWswf6r7rqkvqpf5Jz41bNL4oCECPn8RHfdd2wR3IilRlJ
	 a3vY5JtnlC2lyPveXtVz1Zdv3/qH0T2nZw7xybZrEWEXLOinYE0c+aQTMiG+ZzvgES
	 X+T0pDNQ53YqEUgDA5yulAFfuxeReI3aRsysMKxwph80KKFcDecTtPjYX+aSy35Ev2
	 BTx78KQWVw0/oBZQwZbCFCWjvJdrXc97+2m1XyFgvYBc0NdcYu7cgq5KFJzHAZxt91
	 +7hnONhf0VvyatXY2+in/CTcZYWdbeDyzCXlUkBwtTPtJig6oSQO9qvVrUKrkJcX5c
	 da/sWNHtMB9EA==
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
Subject: [PATCH 1/2] tools: Move tools/include/uapi/drm to tools/perf/trace/beauty/include/uapi
Date: Wed,  1 Apr 2026 18:01:59 -0300
Message-ID: <20260401210203.2150651-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401210203.2150651-1-acme@kernel.org>
References: <20260401210203.2150651-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is used only to parse ioctl numbers, not to build perf and so far
no other tools/ living tool uses it, so to clean up tools/include/ to be
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
index f7b936deeaa2cd7c..a560fbc847934fad 100644
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
index 31826621eebdb003..c6b136fe8d13053d 100755
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

