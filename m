Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F4317150;
	Tue, 31 Mar 2026 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991207; cv=none; b=QThwzmbMsqVPw0s2EhROBrHATjnAPp0YBLKTgBbeHpU0tiAc2TpdRIIpn151A+pYEmdnJxEGsb+NfUAzKSabF4f/eq3RsjAGdNPKsSt6EBf5g13dZJ+onVrG2tDVqMnTOOC65wwO4wJw19QDmHIAX+NBwcJYa0qZNngcrsmbdSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991207; c=relaxed/simple;
	bh=0VgDT/m13pM4gzV29+Nx0vRnBtaPc+jQECY4GfK04u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IunVWSbqoQ1BUEnJX3hoOT6L8//P+liHktAnZ5UshJOqEyIMzJ7eTLtwEmKqQS75Bua+twI5iRBze/5onIrz+oT/SS+gFmvyXGJDCisphXxI86JOy/UnJvr5IEc7riMpBVXUayNP2kVVj7sD1ATp59Hg1sswUfjRSr5mlXz8tp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQH8OjWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQH8OjWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041C0C19423;
	Tue, 31 Mar 2026 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991207;
	bh=0VgDT/m13pM4gzV29+Nx0vRnBtaPc+jQECY4GfK04u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQH8OjWK3r/nZLUXCHqLqOfAsgLbSAkUriwVhCkbzR+J/557hpyfEcwKI1olZKuPB
	 KuubTAeYrWOhaKhyR93Vl7br0z+TzGhIy7ALD+fmaYVuA6GHJdwnizV5KQSHgm9yIj
	 kL649dYJ0Vq4Yttww0H09AzXM5837ucd47LGjyR8nOKtvee1OvYzxeIOj8ztKMK4KJ
	 uUrBrJAVofdR7/m+y+Af1304wTK6Wc0+LnfRx6F44wLspjGKv6MVyZEeqGfA1Pna5N
	 pX7KztPDIj3gfCrGhSQTL/G1shCUp2p2QU0TuF4Y0WBKDWBBLXGKUIb5hPI0fpTFp8
	 gni4HX8XysUiw==
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
Date: Tue, 31 Mar 2026 18:06:33 -0300
Message-ID: <20260331210634.2126391-2-acme@kernel.org>
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

