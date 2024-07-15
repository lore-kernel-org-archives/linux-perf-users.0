Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BA18F2F1;
	Mon, 15 Jul 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053784; cv=none; b=AxCIGhWueNRFbZ5fYD4YV6xspDz93xye3VKIoOQhwFFUf90gm+mdht4gAy1VMsrNeIKs/t2LEvxFkkUoDvQjy+7qom2zsMQVsXr1/8GOl6lrNioAmu0S0SyogWiXjEp/Z3+vccSowtc/LwFXorK3Wwu9ftx6L+70u8C0SvCHO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053784; c=relaxed/simple;
	bh=YWIe5v99t0UfaTAte/zzxMcuCF5wPTe2Vrv7++kRpco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unY2WqvvpkuhXvI3kgtH1EmdmvZHPMaJMNSmMEkJ6hy1ovLiPBlDhnp+cnWRUEgbhFYlv91iNqHIBsnbPhKVEuE8qXDRoZDBHWvQOJAUeV86bNrfcVZQDIZvv9ituqsqWvfnXBSJaUZ+DZSu/41nZOtncZrPmRwx6EjXvscmT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD0A1042;
	Mon, 15 Jul 2024 07:30:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE18D3F766;
	Mon, 15 Jul 2024 07:29:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 3/6] perf: build: Only link libebl.a for old libdw
Date: Mon, 15 Jul 2024 15:29:18 +0100
Message-Id: <20240715142921.51881-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715142921.51881-1-leo.yan@arm.com>
References: <20240715142921.51881-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since libdw version 0.177, elfutils has merged libebl.a into libdw (see
the commit "libebl: Don't install libebl.a, libebl.h and remove backends
from spec." in the elfutils repository).

As a result, libebl.a does not exist on Debian Bullseye and newer
releases, causing static perf builds to fail on these distributions.

This commit checks the libdw version and only links libebl.a if it
detects that the libdw version is older than 0.177.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 12 +++++++++++-
 tools/perf/Makefile.config   | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dff65d03d30d..08b2be257639 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -170,7 +170,17 @@ $(OUTPUT)test-libopencsd.bin:
 
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
+  DWARFLIBS += -lelf -lz -llzma -lbz2
+
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
+  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
+
+  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
+  # Link libebl.a only if libdw is older than this version.
+  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+    DWARFLIBS += -lebl
+  endif
 endif
 
 $(OUTPUT)test-dwarf.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 755fb78be76a..db3bc460d4c2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -152,7 +152,17 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lebl -ldl -lz -llzma -lbz2
+  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2
+
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
+  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
+
+  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
+  # Link libebl.a only if libdw is older than this version.
+  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+    DWARFLIBS += -lebl
+  endif
 endif
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-- 
2.34.1

