Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A78305967
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Sep 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098063; cv=none; b=O7jO4pUKlmpOBj85sljUdpZChY/gMlTXnZNe/hfNgrF+9APnD623Tbdqaf35xvnDe0jypXkDVTmpAX99IZpU7/zdahsvrjMFRJu0ciJ87MhZEVWon55FUUFeO7xu+3Zn1ZjUUXWlNOvURDbm3URzMeGX6BrEcC4iTdn4tkXLbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098063; c=relaxed/simple;
	bh=TqCFIlY5Q1qK1gIyHMP0eyN2kAryd7TD2zvOKn/ItfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6Z3Pm8ZTW0yLz+Gt6Eb6dZgZoPtRjZhdibO0Um9jFunIEsEW6ud2is0MdKWUJR9C2KNuyQ4nglvIyBOPgdVgdOJ+CctFAIx8CNoKUQUdrjUohtp6T+8wOTDgQMmWF4onerdkrygCAtdnb4wbHKkQ7grcziQBXuHY5MlWdGgTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=xlTkJDcH; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="xlTkJDcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1757097521;
	bh=TqCFIlY5Q1qK1gIyHMP0eyN2kAryd7TD2zvOKn/ItfE=;
	h=From:To:Cc:Subject:Date:From;
	b=xlTkJDcH517dPR5+ZVUfXH3bf0n+LpqrpiWoQFEDCTGow0hYUTJp/DiwvLoAAs9/z
	 umv+eHTtojBwTNY1eHG5rcC5akU5bCU4074gGZqdL5c/gVjAjPfb3oPoG1gGSh6iaN
	 04y3NE6VeJ4SH2+wJSx6KX6Sv2yPf4in0kgGuXvE=
Received: from firstfloor.org (c-24-20-246-137.hsd1.or.comcast.net [24.20.246.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 76C9E5D9E6;
	Fri,  5 Sep 2025 20:38:41 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 5CE961622A9; Fri, 05 Sep 2025 11:38:38 -0700 (PDT)
From: Andi Kleen <andi@firstfloor.org>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] tools perf build: Support BUILD_NONDISTRO on OpenSUSE Tumbleweed
Date: Fri,  5 Sep 2025 11:38:32 -0700
Message-ID: <20250905183832.3011694-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My Tumbleweed system needs -lzstd -lsframe to build -lbfd
for BUILD_NONDISTRO to get a sane BFD based setup.
Add probing for that case.

The previously posted build fixes are also needed.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/build/Makefile.feature |  4 +++-
 tools/build/feature/Makefile | 24 ++++++++++++++++++------
 tools/perf/Makefile.config   | 22 +++++++++++++++-------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 649c5ab8e8f2..46bdb9f8ba7f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -120,6 +120,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libcapstone                    \
          libbfd-liberty                 \
          libbfd-liberty-z               \
+         libbfd-liberty-z-zstd-sframe   \
          libopencsd                     \
          cxx                            \
          llvm                           \
@@ -159,7 +160,8 @@ FEATURE_DISPLAY ?=              \
 # Declare group members of a feature to display the logical OR of the detection
 # result instead of each member result.
 #
-FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
+FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z \
+			       libbfd-liberty-z-zstd-sframe
 
 #
 # Declare list of feature dependency packages that provide pkg-config files.
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b41a42818d8a..7fd30cbeefb0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -20,6 +20,7 @@ FILES=                                          \
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
+         test-libbfd-liberty-z-zstd-sframe.bin  \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
          test-libcap.bin			\
@@ -118,7 +119,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty
+	$(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty || $(BUILD_ALL) -lopcodes -liberty -lz -lzstd -lsframe
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
@@ -278,15 +279,22 @@ $(OUTPUT)test-libbfd.bin:
 	$(BUILD_BFD)
 
 $(OUTPUT)test-libbfd-buildid.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
+	$(BUILD_BFD) || \
+	$(BUILD_BFD) -liberty || \
+	$(BUILD_BFD) -liberty -lz || \
+	$(BUILD_BFD) -liberty -lz -lzstd -sframe
 
 $(OUTPUT)test-disassembler-four-args.bin:
-	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes || \
+	$(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd -lsframe
 
 $(OUTPUT)test-disassembler-init-styled.bin:
-	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes || \
+	$(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd -lsframe
 
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
@@ -297,6 +305,10 @@ $(OUTPUT)test-libbfd-liberty.bin:
 $(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
+$(OUTPUT)test-libbfd-liberty-z-zstd-sframe.bin:
+	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz \
+		-lzstd -lsframe
+
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..53864a505cfa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -923,23 +923,31 @@ ifdef BUILD_NONDISTRO
     EXTLIBS += -lbfd -lopcodes
   else
     # we are on a system that requires -liberty and (maybe) -lz
+    # and possibly sframe and zstd
     # to link against -lbfd; test each case individually here
 
     # call all detections now so we get correct
     # status in VF output
     $(call feature_check,libbfd-liberty)
     $(call feature_check,libbfd-liberty-z)
+    $(call feature_check,libbfd-liberty-z-zstd-sframe)
 
-    ifeq ($(feature-libbfd-liberty), 1)
+    ifeq ($(feature-libbfd-liberty),$(feature-libbfd-liberty-z),1)
       EXTLIBS += -lbfd -lopcodes -liberty
       FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
       FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
-    else
-      ifeq ($(feature-libbfd-liberty-z), 1)
-        EXTLIBS += -lbfd -lopcodes -liberty -lz
-        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
-        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
-      endif
+    endif
+    ifeq ($(feature-libbfd-liberty-z),1)
+      EXTLIBS += -lbfd -lopcodes -liberty -lz
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
+    endif
+    ifeq ($(feature-libbfd-liberty-z-zstd-sframe),1)
+      EXTLIBS += -lbfd -lopcodes -liberty -lz -lzstd -lsframe
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += \
+	      -liberty -lz -lzstd -lsframe -ldl
+      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += \
+	      -liberty -lz -lzstd -lsframe -ldl
     endif
     $(call feature_check,disassembler-four-args)
     $(call feature_check,disassembler-init-styled)
-- 
2.51.0

