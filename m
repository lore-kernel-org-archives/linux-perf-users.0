Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7618E025;
	Fri, 13 Dec 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119465; cv=none; b=l/4F1KPBFrXIsoqi34Z5kcOW45AS42As1IaqbeN438vNNt+h9T1GMf0vjazQnSN6lSEKxi4s2bGuMhE+AKVo4H5d2MBR22pg5Z7RXCFh/oN/4ThBxqglhkf6t4UBbLtBrQIs6tDFXCK4ELCqLVDC4/BwRdZcXFipEGJVETMhHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119465; c=relaxed/simple;
	bh=DPe3h181tSfQkvLdCyws5KiQZIjhqFE+jt1Fm3+GfkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsAx5dVJ+1IqOf7EZQK5ndEWrMl1xyYe71fEJTRwy8osUOrIdRcRg0ZpYywufspEwrmZgwCeJNyvE7gmnjlp3+mJ9LuINxCLKnQnwYqiiTaiFOyaRJSGVIEnOCipIYeKQhVon79y9fkZ2a8nbuRLVHXGFxG9FgOOXeupA3yKrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS55mPuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS55mPuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D66C4CED0;
	Fri, 13 Dec 2024 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119465;
	bh=DPe3h181tSfQkvLdCyws5KiQZIjhqFE+jt1Fm3+GfkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MS55mPuYHu6dYwTgQDb4H/k3zu3otBN8X+1KGsIAqdfYTXr8tJbzhRqpymsAqO+GH
	 Kvlr4hHnq/J6yqAcdyWjIFZ/71tzYEYAWR18y2EoxiXtFU8PfyM2/uO5wKKvVUv9dW
	 w5vS9YUA0OKyyQFBWBuMcPiHUUhtXUODqu2eOP/9UQ4navAf0vueejkhbmdcRIYhUH
	 TOqUJUl8O5MRhFd7rV/iKCUWjQ93O0ch7Ss7QOFx2MdlrriTZ+sClMzlW2VQwY0Jnl
	 r36dWkZWovuM4BEf6r60Ea5h/S6auamsKLUAIB9rNPcrCaOVOvvUYqkoZbHZf0WdNe
	 nimD0kY/B7l0Q==
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
Subject: [PATCH 2/2] tools build: Test for presence of libtraceevent and libtracefs in test-all.c
Date: Fri, 13 Dec 2024 16:50:52 -0300
Message-ID: <20241213195052.914914-3-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241213195052.914914-1-acme@kernel.org>
References: <20241213195052.914914-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since these are so far considered part of the basic set of libraries to
be present when building perf, have then in
tools/build/features/test-all.c.

They were already in the FEATURE_TESTS_BASIC variable of
tools/build/Makefile.feature, meaning if test-all.c builds, those
features would be set as present, but then we were calling "again"
(well, they were not in test-all.c, so were not really being tested) for
it to be detected, fix this all up by not calling feature_check for
those features but instead have them in test-all.c to be tested together
with the the set of basic expected libraries.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 10 ++++++++++
 tools/perf/Makefile.config     |  2 --
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 80ac297f81967171..691829bc32eb0655 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -166,6 +166,14 @@
 # include "test-libzstd.c"
 #undef main
 
+#define main main_test_libtraceevent
+# include "test-libtraceevent.c"
+#undef main
+
+#define main main_test_libtracefs
+# include "test-libtracefs.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -203,6 +211,8 @@ int main(int argc, char *argv[])
 	main_test_reallocarray();
 	main_test_disassembler_four_args();
 	main_test_libzstd();
+	main_test_liblibtraceevent();
+	main_test_liblibtracefs();
 
 	return 0;
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0e4f6a860ae25339..37b793b299faae42 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1187,7 +1187,6 @@ endif
 
 # libtraceevent is a recommended dependency picked up from the system.
 ifneq ($(NO_LIBTRACEEVENT),1)
-  $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
     CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)
     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
@@ -1203,7 +1202,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
 
-  $(call feature_check,libtracefs)
   ifeq ($(feature-libtracefs), 1)
     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
-- 
2.47.0

