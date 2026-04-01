Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15F3B7B80;
	Wed,  1 Apr 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077354; cv=none; b=lI/bLvZHz3TfYDDvXbfA1Qu1xHGEcinLyW1kj+oQvchxmFHWBVdahQHV5gkKjZRPZhavL6tlyx1GBrVbwwLbrqPQI+7NpS5vdJg2ogQv+D8/C5NFxVbFl4/ZOR7UrRdPjN/u1VMt+JJ3wVMkD9xLkNnPUViolpnm/dF7elsFax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077354; c=relaxed/simple;
	bh=0m4yzpu64MSF3uadEQv4UlSUQ3sULu0Q2sh802UhRos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSNux+rtO/o7XoKeNqoPeZnbTs0aLEzX2l+5XO6MYMRWAnLbae7JLItFneJ/5rxpjqvuXGbFbpezWl8qg9WO3JE3Wtw4kw2Q/aV4CGQwzWE/ZV9Ve3N/gFQIlBfUq63l/bs94wGd6eQOHtn7uUPeLvM4f5BR/LX9XSlUoRVjxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kol8nd9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kol8nd9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDA1C4CEF7;
	Wed,  1 Apr 2026 21:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077354;
	bh=0m4yzpu64MSF3uadEQv4UlSUQ3sULu0Q2sh802UhRos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kol8nd9gR06P5KOmtZz0JN7OKW93pl/gdn8MiNwzd26O4zUQIS4TM6XGhGBRuBd+i
	 BNttIQ/ekM6LZMQuLRcI89FOyunIJQGys1GhQTyR+KLFtEqDGHVrsDYGLa8QjlndVJ
	 JfcXgO3ysjN+6hoWzLgF2vFawaKQOE8DzGUalie5yAKa6LMaob3jgOZq376ubbVaFM
	 aj6O/MyA/swG/OKpl55m2jReuIoLEA8X8AUCCu1zXUCiMgA4INFqqWfsDwX1IoF8Gd
	 uPB8CuaII+tcpPPscSiKBEfcMBTMkKex1yvuxe0clxEY6/ZxtatSyXhk4Zh2XCGSZi
	 4IXbXOS7QxDwg==
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
Date: Wed,  1 Apr 2026 18:02:00 -0300
Message-ID: <20260401210203.2150651-4-acme@kernel.org>
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

