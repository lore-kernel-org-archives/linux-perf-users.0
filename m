Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F714E0B9E;
	Wed, 30 Sep 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773918; cv=none; b=m2KDj/GO09XBcAjEYe5v2j0rTtLyFRiv1NL5hYvK6qQ+oLLHL8jUbPyoVUrbsms5ZEJ5Oi8eC1/0sEjYpjJ0YiSGrof5fkxOJiSHLzzK/Bk0It1ejPyrbI4BMLGiCMDVtRH/mVvrDSfkcIgK1CrXr0YH8Shlu2GUsZqJiMaDC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773918; c=relaxed/simple;
	bh=yYL45a3IGyE0kwOi1+o4D9NqH7KyNV2HSrSXiSRTzbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szL9ylBOglMs32MQJDI37nff22pHKmImxCPI5qYCvtxZp4XJ55WpGWZizZnl0twLEbrGosoyYQ6SPEHjMzScnqe2DjSitkUlFgcItoZbo7nzYnRi9UIFgWConI3eIRl6m00xdmRf8AZ+7Drtmf5k76BEJK6p/6wJbWEkSW4cLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W707TjZV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W707TjZV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ECFB143D;
	Wed, 30 Sep 2026 06:11:45 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06F0D3F86F;
	Wed, 30 Sep 2026 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790773908; bh=yYL45a3IGyE0kwOi1+o4D9NqH7KyNV2HSrSXiSRTzbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W707TjZViub0U0fs7xpDWq+95dGnCasy81fQE3A+M/DjtYUIXJmCntvrdb7AZD8aS
	 t4XQgrgc+oVO7yceVm2K6aLhQsjtYEiVpKigjz0MxzPUPRYq8SzudMfM/WzoyrhN6g
	 AMfdC6iFA5aADTNc+f7soQ9XQdb9/hlGUppXuUVs=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 30 Sep 2026 14:11:36 +0100
Subject: [PATCH v2 1/4] perf build: Build the Python extension before
 pylint consumers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perf_fix_pylint_errors-v2-1-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773904; l=2908;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=yYL45a3IGyE0kwOi1+o4D9NqH7KyNV2HSrSXiSRTzbI=;
 b=yjisxiz0I3UVpGOoFilTh2q/DRJsfzZRcsemFD7n8qSMz2mR2meS8G7E1XyPHZQmZcxsTuaPs
 aH4kh06krh3D+f0ZKmj3Vpcpf9KzJjAXLkw1ZWmpPAc5gV9KcCRUCxi
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Pylint checks for tests and standalone Python scripts can run before the
perf Python extension is available. On a clean parallel build, an import
error can stop make before the extension is built.

Run the script and test pylint checks in separate sub-makes after the
language bindings are built. Keep their rules in the respective Build
files so the perf and perf-test C sub-makes can compile concurrently with
util and the Python extension. An isolated make perf does not need to
build the extension just for these checks.

Fixes: 8a54784e708b ("perf build: Add pylint build tests")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Build         |  4 +++-
 tools/perf/Makefile.perf | 15 +++++++++++++++
 tools/perf/tests/Build   |  4 +++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 8a0b5592a973384deafc5bb5cc7ed0cc91e0257e..09fd88f5aca54118a9b089e9c20124e23de77517 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -102,4 +102,6 @@ $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(PYLINT_TEST_LOGS)
+.PHONY: pylint
+pylint: $(addprefix $(OUTPUT),$(PYLINT_TEST_LOGS))
+	@:
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0102c3468a0b79fb22966d8cbd8fa8525d2ff3ae..0eb4e7c29c400021907d3da716bc4871f0df8d88 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -578,6 +578,7 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
+
 export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -633,6 +634,20 @@ $(SCRIPTS) : $(OUTPUT)% : %.sh
 $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
 
+ifdef PYLINT
+# Run Python checks after the extension is ready, independently of C builds.
+all: pylint-perf pylint-tests
+.PHONY: pylint-perf pylint-tests
+
+pylint-perf pylint-tests: | $(LANG_BINDINGS)
+
+pylint-perf:
+	$(Q)$(MAKE) $(build)=perf pylint
+
+pylint-tests:
+	$(Q)$(MAKE) $(build)=perf-test dir=tests pylint
+endif
+
 # These can record PERF_VERSION
 perf.spec $(SCRIPTS) \
 	: $(OUTPUT)PERF-VERSION-FILE
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 8fecd539012429c0f517d95f145a91137333322b..05c545aac73232a322652a6119c3178f39b83145 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -119,4 +119,6 @@ $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-test-y += $(PYLINT_TEST_LOGS)
+.PHONY: pylint
+pylint: $(addprefix $(OUTPUT)tests/,$(PYLINT_TEST_LOGS))
+	@:

-- 
2.34.1

