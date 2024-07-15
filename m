Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9E190042;
	Mon, 15 Jul 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053786; cv=none; b=ldzxw6telHNflGsHvpL3PFUy32oMOJiUNVUqtKr2AvN4gsTIQCfSEIDA2XqCKgkGWeWV63gxDKCOUkoonT0J/3Dxkv9Mxl+VxgM/+cGn/bcZKiHhmn8gcpWsPwsL5ICPMuteJmxyarYg7y+Si8kmHDP9rs9XiPd1UnYjMCIy5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053786; c=relaxed/simple;
	bh=DoyIJN76g9VcxfuI6ysiAakjqN6ECMALbr8DTSj3FO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhgX9x7UlUE+gf5CGAePClQpbmRtiBtBvVbsjVjCuf5WL1Za9/uJly70PJelqITIKaFD4HFcK2ddN5z/8PHFgBhGJFCsGN8yUO0jsYED//6oIhifFGVf3QHGnjNocPZ1xFQiHe/q5gg6o7zuP+N7ZvuqT8KjZoHIsFi7j4mJ494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6138CFEC;
	Mon, 15 Jul 2024 07:30:10 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81EC93F766;
	Mon, 15 Jul 2024 07:29:43 -0700 (PDT)
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
Subject: [PATCH v4 5/6] perf: build: Link lib 'zstd' for static build
Date: Mon, 15 Jul 2024 15:29:20 +0100
Message-Id: <20240715142921.51881-6-leo.yan@arm.com>
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
index 2d5be5c17d65..4af6a9582f15 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -170,7 +170,7 @@ $(OUTPUT)test-libopencsd.bin:
 
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

