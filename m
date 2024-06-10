Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421379DDB;
	Mon, 10 Jun 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013318; cv=none; b=Mx6EWotU1a3cX7CmauiMvI/MuV1GtCpoo06HrTBvkwrNP+Zx0OwXYwDro3Vjev+4Zck0Y5Qj5pOK2/JMpwXNi8/sZDgNcBzTJaGvuyLotjYxbG3c9RG9B5XgJcDfiOr9k4UU+YsOvYJFjwH7lX3Re/XUhbgfl4EFK0Qd+OtPVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013318; c=relaxed/simple;
	bh=TAI5MVvJ3quT5ll1LWwaXnbXGxwg9ZEetfoGD6HWeHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gxj1HoamVuMsxXwt9iTuyi5jj2rHQ6HZEVLq1IxRBY5pOLS7Ozs0N5qwM4uHlR+RB/GC6FJlyaZM7XwXmX1dwk8qypMh+/v44AmH2zKw+19u56vvCrnadr0+sOHcSDnQFRb3zi6lR76mcYGuaq85EgIrEX8DkMlK2oQ8kYT4O0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D4E1688;
	Mon, 10 Jun 2024 02:55:41 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9EEC3F73B;
	Mon, 10 Jun 2024 02:55:14 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 5/6] perf: build: Link lib 'zstd' for static build
Date: Mon, 10 Jun 2024 10:54:32 +0100
Message-Id: <20240610095433.336295-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610095433.336295-1-leo.yan@arm.com>
References: <20240610095433.336295-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When build static perf, Makefile reports the error:

  Makefile.config:480: No libdw DWARF unwind found, Please install
  elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR

The libdw has been installed on the system, but the build system fails
to build the feature detecting binary 'test-libdw-dwarf-unwind'. The
failure is caused by missing to link the lib 'zstd'.

Link lib 'zstd' for the static build, in the end, the dwarf feature can
be enabled in the static perf.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 9e5663eefc01..991bb4fed774 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -171,7 +171,7 @@ $(OUTPUT)test-libopencsd.bin:
 
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lz -llzma -lbz2
+  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index db3bc460d4c2..0f918475d7b6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -152,7 +152,7 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2
+  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
-- 
2.34.1

