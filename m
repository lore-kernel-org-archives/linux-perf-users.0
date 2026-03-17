Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40373F7863
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773893; cv=none; b=kwDcmd4VgUladhWQthCN6jE+ik/4vXZwKCHHgWd8XLbfoAPZPqa7ANkmqCYEt6bo2lieZYwOXIIhT7RbVU/1bvI+jLX/CZ7FrXJGSB964Rj67WAQ5HQ2vI7E9SgCvM/IIqDqhT/C+lU41uu9o1O5rgbNMMzmJI71iG5zOP8SoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773893; c=relaxed/simple;
	bh=dvEQ84EZOFi0ZVeX5TM+PD21NNXmeL3RHXpP3i/6r/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YvXdEHxNFU7QVnFLEmpA+Uo0UhgKjMqhldikxn/wmK69LXIRDh/boPTJZ/p452p85msaVgHfNB7F32CjAaQwcOuBLaUeVHmu+dpCYPfr+eduOusflbUl9hCWB3oMAiZQJnQcjyNChkH140BagPJsUniupNvQYUDx94oUlthTPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B601477;
	Tue, 17 Mar 2026 11:58:05 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E023F7BD;
	Tue, 17 Mar 2026 11:58:10 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 17 Mar 2026 18:58:00 +0000
Subject: [PATCH v3] tools build: Correct link flags for libopenssl
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tools_fix_build_libopenssl-v3-1-7878c8342c51@arm.com>
X-B4-Tracking: v=1; b=H4sIADekuWkC/42NQQqDMBBFryKzbkpMxGpX3qOImDjWgWgkY6VFc
 vemnqDL9/i8fwBjIGS4ZwcE3InJLwn0JQM79csTBQ2JQUlVSp3fxOa9426kd2de5IbOkfErLsx
 OVKqWZkQz9NpCCqwB0+6MP9rEE/Hmw+f82tXP/pXdlchFrUtl82KUhamaPsxX62doY4xfX6G+x
 sIAAAA=
X-Change-ID: 20260317-tools_fix_build_libopenssl-8290bfebda3c
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773773890; l=2271;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=dvEQ84EZOFi0ZVeX5TM+PD21NNXmeL3RHXpP3i/6r/I=;
 b=JeeSSttGASsyKYkTCU+1h+QSMOMdHsUITKFt/I3p30F8yDLzSmhD/b47bco4c27dHbL6UPrb3
 rf6WjjHzWEbDgl5C4T/cft6uc2zgu1cGQvwsXPjqxbs4/y7TLx4V+0+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The perf static build reports that the BPF skeleton is disabled due to
the missing libopenssl feature.

Use PKG_CONFIG to determine the link flags for libopenssl.  Add
"--static" to the PKG_CONFIG command for static linking.

Fixes: 7678523109d1 ("tools/build: Add a feature test for libopenssl")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v3:
- Used PKG_CONFIG to explore ssl link flags (Ian).
- Link to v2: https://lore.kernel.org/r/20260317-tools_fix_build_libopenssl-v2-1-9362c14f04b8@arm.com
---
 tools/build/feature/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..f163a245837a63f13f5e6526be097fe9a0e8245d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -103,12 +103,18 @@ else
   endif
 endif
 
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  PKG_CONFIG += --static
+endif
+
 all: $(FILES)
 
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd -lssl
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang \
+	      $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd \
+	      $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -384,7 +390,7 @@ $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
 $(OUTPUT)test-libopenssl.bin:
-	$(BUILD) -lssl
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
 
 $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \

---
base-commit: bb551508e78c886e6d3bcca6c744d3bc3fd8ad59
change-id: 20260317-tools_fix_build_libopenssl-8290bfebda3c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

