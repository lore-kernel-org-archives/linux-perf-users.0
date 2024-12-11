Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46381D9A6F;
	Wed, 11 Dec 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931944; cv=none; b=b9IyjJBRfVmWEQGT3bbD+gSu2SNLva/cjV4MnST8+pV20Xs7WjVZDi7XYsn5aZfmYieCqjD7yXz5IMURvSmQkym2tZ6nxUo6Db6jRS9ZvNMDzswDqFMD8Emg73q1wHZHokDZpzzfYuAPq2nhODFEFUs61Moe1zbiYaXRGpTMMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931944; c=relaxed/simple;
	bh=PwwMZGkK4SSHChHwBFdQwXcUukP/uWJujvZw7L2Qc0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BcZPMFC3kZsKng666tTXeEI/178sZk3wfbfWzWLDMRSMlv9km7roDFJShk1bWqGPuCl/a6ZP6s+sgEhFSDScRvOeTcq4lFTGcVkJ5QZDgdMYE9muVVoDzt6eC51s3RAvf3r/U3HGWfoell2F0G5IyKj45qtrJRQbpCeQsBZPS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k30l5vjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k30l5vjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C48DC4CED7;
	Wed, 11 Dec 2024 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931944;
	bh=PwwMZGkK4SSHChHwBFdQwXcUukP/uWJujvZw7L2Qc0Q=;
	h=Date:From:To:Cc:Subject:From;
	b=k30l5vjGrlLUjrAU92+0WXq+MxZZllGYPpBfk+uaO++Gc+x0N6claUhYx1E+JYMLI
	 XPk0o6RS+hOs48cfZnGKId3HMJPZ9YpeomGuQLZEIaDvyxdMVr8CO0kHZUW+MDtg+p
	 Z6vyYNRxmL+Xa6GR1GVdGASvrKti+tBrNIqX55bneN+4Y+mnII6Ojw5QTIDZnPBVV0
	 +e6DXiyvP/vkerTJsdX7xpCjkSY1jQWOqG50jmSm/jhIesoGcOAe1uj0hIFM4n8HWC
	 Yk7/eFb8ELuCML3M5DF5hWKEEw6pB0IadQaHZ9e6ja+ztYcqaxLCYIy1bKJYB+cBYa
	 meFWDvGDW12sA==
Date: Wed, 11 Dec 2024 12:45:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
Message-ID: <Z1mzpfAUi8zeiFOp@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We have a tools/build/feature/test-all.c that has the most common set of
features that perf uses and are expected to have its development files
available when building perf.

When we made libwunwind opt-in we forgot to remove them from the list of
features that are assumed to be available when test-all.c builds, remove
them.

Before this patch:

  $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump ; grep feature-libunwind-aarch64= /tmp/b/FEATURE-DUMP
  feature-libunwind-aarch64=1
  $

Even tho this not being test built and those header files being
available:

  $ head -5 tools/build/feature/test-libunwind-aarch64.c
  // SPDX-License-Identifier: GPL-2.0
  #include <libunwind-aarch64.h>
  #include <stdlib.h>

  extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
  $

After this patch:

  $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
  $

Now an audit on what is being enabled when test-all.c builds will be
performed.

Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel files by default")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index b2884bc23775e986..9cde51104c2d70ec 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -90,13 +90,6 @@ FEATURE_TESTS_EXTRA :=                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
-         libunwind-x86                  \
-         libunwind-x86_64               \
-         libunwind-arm                  \
-         libunwind-aarch64              \
-         libunwind-debug-frame          \
-         libunwind-debug-frame-arm      \
-         libunwind-debug-frame-aarch64  \
          cxx                            \
          llvm                           \
          clang                          \
-- 
2.47.0

