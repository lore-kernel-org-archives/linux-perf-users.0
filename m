Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F818DB1D;
	Thu, 22 May 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933849; cv=none; b=XhQX39JpvkR5DmihlrkmNrCGtnuuIvQimOrh18CX3V1VMXE1fZWxkjjT0hD9G0ZbvJG0EePi0mOfDmiWGiyEgSuShcMI5YXABPXExjJQuftsw7Li54V41TdP8YSqN215VsUZLst5HV/lg1bH+5NYYQJ01IdjaZWfP/YAGgaqJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933849; c=relaxed/simple;
	bh=Ht+LO9+g8KB7Zpdp8D0tOxLZ+PkCFFtL9lbD5QgltSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsLs9Kj4W6650G/hm7SnggcGavzNALo6tsDqZflR1gsjbkFlR4LlXxfSHBhvSE5et29YzGNI5MQjZ9jWHwIHu5oa+w8gHWgEmMDTigF7TxYBV+F2WWTjdQzcvRnKYaMzhzC2iWlYQrN3owZbVyPnH5p4VZ21bLNv2WDSl++x6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNBq/BG0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNBq/BG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17019C4CEF0;
	Thu, 22 May 2025 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933848;
	bh=Ht+LO9+g8KB7Zpdp8D0tOxLZ+PkCFFtL9lbD5QgltSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNBq/BG0St9bkhagLcNcw6KyiJ0ZqkggHs/mscNmHce/iphVbgvZ5E+6wu5JL8Qpx
	 YhMQdRlUGC/T+QUpLE/cgzWbVMaA6DJggoiiY4RZ3vlQszuSi/mqU58BQZQpyraz2r
	 23UNPr49sp5Qii/griD8s6/8cr4divsBAH/AuUtuvGr8i8HnayKqYJhkobssdYYeyr
	 /7saOStqScm0nrUZAFPQRSYVFBxYxBxzE1FbEGeJlHKNjpCxAwd1f+c9E1N71gkjRX
	 YQbkpnKK+W1rl4z4uS2CPXEMMgk6nHjbeb2534GGGln5VX0Yb3dsuGAUacnQF/idSQ
	 Mso127+dGY0qg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 2/3] perf test: Move some ARM tests to arch/arm64/tests/shell
Date: Thu, 22 May 2025 10:10:43 -0700
Message-ID: <20250522171044.1075583-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
In-Reply-To: <20250522171044.1075583-1-namhyung@kernel.org>
References: <20250522171044.1075583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test_arm_callgraph_fp.sh checks with aarch64 so it should belong to
there.  And IIRC ARM SPE is supported on 64-bit platforms so move the
tests too.  But I'm not sure about coresight so left them.

Also please test it with shellcheck as I couldn't run it actually.

Cc: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/arm64/tests/Build                  | 14 ++++++++++++++
 .../arm64}/tests/shell/test_arm_callgraph_fp.sh    |  4 ++--
 .../{ => arch/arm64}/tests/shell/test_arm_spe.sh   |  0
 .../arm64}/tests/shell/test_arm_spe_fork.sh        |  0
 4 files changed, 16 insertions(+), 2 deletions(-)
 rename tools/perf/{ => arch/arm64}/tests/shell/test_arm_callgraph_fp.sh (89%)
 rename tools/perf/{ => arch/arm64}/tests/shell/test_arm_spe.sh (100%)
 rename tools/perf/{ => arch/arm64}/tests/shell/test_arm_spe_fork.sh (100%)

diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index d44c9de92d425c62..6c73720cb0ffa99d 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -3,3 +3,17 @@ perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-test-y += arch-tests.o
 perf-test-y += cpuid-match.o
+
+ifdef SHELLCHECK
+  SHELL_TESTS := $(shell find shell -executable -type f -name '*.sh')
+  SHELL_TEST_LOGS := $(SHELL_TESTS:tests/shell/%=shell/%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  SHELL_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/arch/arm64/tests/shell/test_arm_callgraph_fp.sh
similarity index 89%
rename from tools/perf/tests/shell/test_arm_callgraph_fp.sh
rename to tools/perf/arch/arm64/tests/shell/test_arm_callgraph_fp.sh
index 9caa36130175964e..f59ab293d67b9f9c 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/arch/arm64/tests/shell/test_arm_callgraph_fp.sh
@@ -3,8 +3,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/perf_has_symbol.sh
-. "${shelldir}"/lib/perf_has_symbol.sh
+# shellcheck source=../../../../tests/shell/lib/perf_has_symbol.sh
+. "${shelldir}"/../../../../tests/shell/lib/perf_has_symbol.sh
 
 if [ "$(uname -m)" != "aarch64" ]; then
 	exit 2
diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/arch/arm64/tests/shell/test_arm_spe.sh
similarity index 100%
rename from tools/perf/tests/shell/test_arm_spe.sh
rename to tools/perf/arch/arm64/tests/shell/test_arm_spe.sh
diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/arch/arm64/tests/shell/test_arm_spe_fork.sh
similarity index 100%
rename from tools/perf/tests/shell/test_arm_spe_fork.sh
rename to tools/perf/arch/arm64/tests/shell/test_arm_spe_fork.sh
-- 
2.49.0.1164.gab81da1b16-goog

