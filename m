Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03C23D2B7;
	Fri, 20 Jun 2025 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454692; cv=none; b=ZuEXbxpuA9qgMV8Q9L0WFGgMk6r3yf/3w8XirzAYyQmacH0IQbGk74rgiR19vI7Ke2lZtFgDY7joppr2zyltZDeHfg1EFyxFh+CIl4PUIzFI8r3qo2ZwixZiOHz6pydPgYWLfu7INOvPpP/0Dwaun6QZebSd8d3OZtndDdJfQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454692; c=relaxed/simple;
	bh=Sqa7yFlza+E5vO9QUSHOv5OOHJZbEhVBY+11+7dXhpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTBOPRSthjoMExd6s+Jxj3yWBo8DwtGXsuaO/jUEKbKWOJlkhqq9tiZUvDa+D+Lsx8H9NS9r1DkQHdSMA3mWRazhf3TmRvo0zm3iISssPTXSPbNK06ecOH5Vs8xjxxmRVi0XCDcNKhIJLgJEMvWN8WUIIPTmtL4hjhUhmbcnn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OScFH4Fs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OScFH4Fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A2EC4CEEE;
	Fri, 20 Jun 2025 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750454691;
	bh=Sqa7yFlza+E5vO9QUSHOv5OOHJZbEhVBY+11+7dXhpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OScFH4Fs+0DABU5z8M4eOFqEDzIwgI1asIZGUYW+UHeQGNX8pcFPFKm9o3cjE9FCC
	 m7jNBmlaJej3lMCNAo+WA6xtXYEsNojXrlT/wnjjoMlZlWmVBD1IJjHSO26SqOaHgf
	 YjCZaoG3j+RFXVpDiPyPMxxLepPGKRA0Fhcov2k/W+U8/xkD9dSFR4ulezosprcEyH
	 7yf9AwduGkQXt8pxJyhWEqJioGrydIQjad6ilo/9sLPae38gDUHaZiiRkjQb5ieyCI
	 +MYJB5WwGRWuqCUX2N6MsSbxAdZiolcEkTqjifhTF48HN9tVlbdYa19xRSoo52WXjN
	 Y4zDXpkWuSAdA==
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
Subject: [PATCH 3/3] perf build: The bfd features are opt-in, stop testing for them by default
Date: Fri, 20 Jun 2025 18:24:35 -0300
Message-ID: <20250620212435.93846-4-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620212435.93846-1-acme@kernel.org>
References: <20250620212435.93846-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These are leftovers noticed while updating a build container.

We don't need those so that test-all.c can build and thus speed up the
feature detection.

Test for those features only if the user asks for BUILD_NONDISTRO=1 to
build with libbfd.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 19 -------------------
 tools/perf/Makefile.config     |  5 +++++
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 03ddaac6f4c4dfa2..1010f233d9c1ad49 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -66,14 +66,6 @@
 # include "test-libslang.c"
 #undef main
 
-#define main main_test_libbfd
-# include "test-libbfd.c"
-#undef main
-
-#define main main_test_libbfd_buildid
-# include "test-libbfd-buildid.c"
-#undef main
-
 #define main main_test_backtrace
 # include "test-backtrace.c"
 #undef main
@@ -158,14 +150,6 @@
 # include "test-reallocarray.c"
 #undef main
 
-#define main main_test_disassembler_four_args
-# include "test-disassembler-four-args.c"
-#undef main
-
-#define main main_test_disassembler_init_styled
-# include "test-disassembler-init-styled.c"
-#undef main
-
 #define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
@@ -193,8 +177,6 @@ int main(int argc, char *argv[])
 	main_test_libelf_gelf_getnote();
 	main_test_libelf_getshdrstrndx();
 	main_test_libslang();
-	main_test_libbfd();
-	main_test_libbfd_buildid();
 	main_test_backtrace();
 	main_test_libnuma();
 	main_test_numa_num_possible_cpus();
@@ -213,7 +195,6 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
-	main_test_disassembler_four_args();
 	main_test_libzstd();
 	main_test_libtraceevent();
 	main_test_libtracefs();
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fd03ba83a48ee08b..12193986effb954a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -918,6 +918,8 @@ ifneq ($(NO_JEVENTS),1)
 endif
 
 ifdef BUILD_NONDISTRO
+  $(call feature_check,libbfd)
+
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
   else
@@ -946,6 +948,9 @@ ifdef BUILD_NONDISTRO
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
   CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
+
+  $(call feature_check,libbfd-buildid)
+
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else
-- 
2.49.0

