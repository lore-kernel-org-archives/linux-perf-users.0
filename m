Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75D3D6497
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988639; cv=none; b=oHLfSdsnVRINhknod6SA1h9gdWbaV512Ip9XmlUcsma//6SBmanL6qNa6CeI7tKYQwszP4QF2QOf33HTIOufMT4wvRXwSao++pjZxIffUPfF2CqsGtDkipqMihlCwry2hWlHO/7ZpoxQTRHPNRe20HOJRSEs8DO71QrLU7zKm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988639; c=relaxed/simple;
	bh=G/YI13U5WFN+0eILeNgDiBo8NYuCwJCGGw3/cqRhWLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AdTkcDoBd5VUaymnV9zHfNB+R6+eBPX8JDZ45v2zwozzgYxUMuPtIo6LmVvtglaFgbTi4RXLt5sBS1iwKR8pMcvI1fFQjY0Ir2USAzqD4cu8w94XTrcGUI9zCnfUDrthDJ6EwiXykMajgpFFIcZD9ypiKclGhf7pET1JZPHtJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Koa4WlEb; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Koa4WlEb"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1361d52b3a0so5906294c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988637; x=1781593437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEG6upLE0OCaQvJtXF2OY7o4khEThpYQjE5hsRLVHoQ=;
        b=Koa4WlEbfO685HUQ8uv98Im954tnc2jiWGdBioyFn0qLGpFc+xQjfyHirQFKauoOIx
         G9dN39Ytaz3QR5bYKCY8zWwPcDcOg5ITGeE637x1CvE1Vr1RS9qGc4FjsSPaSPShzVCX
         6IaBwTu1iGeNjYMW9tvUfhCvVLZJuYKFfw1qTYY7JcvXdcvmS3QSsGDACHrDQuRrBZlk
         JWJnUl+B7rGYybPGQ0sRbJkgjJV8325ICL7xkixzz7uw58cmgAveviEokqNspvmpJgPo
         e6/4Zq9SKeWWu9z1HRfIv5sLI+jxX2sKqE5Estt6Wd4Gmij1qMcL51pMmO8YwjW6ZZ/o
         9Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988637; x=1781593437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEG6upLE0OCaQvJtXF2OY7o4khEThpYQjE5hsRLVHoQ=;
        b=TsRjHeXZ/HgXwRLUSdKAsDczl216QSF7rvGO0IQIYOs2eAu0owYDzbTaOSl4Nf7Hmf
         dtdHj01LjER+D0UWIVqYbDr+yK3bhiNflqTTmNpyFJnSXOV1qPnC/uRi+jfPpdCTKpNx
         fyK+wxaL7fC0uHxCNgbE6lU33ATcf8HIaDnL4ZWgWWKOwQuRh0e762AMrbwkWMYXx6pS
         JkR9UmmiUa3QMOzZPMA4J/usCsDFcUb6aRdgNxdyLR+AgCytAMw7NZSs6/9yTauDOhtm
         MWtrC9rMM8jA+T/YFLj43BaarJHCCbXZOQuc4iAM7aHbTzPEg52iG2OLoHHp3Toed5Zd
         DUKg==
X-Forwarded-Encrypted: i=1; AFNElJ/Nn3csbnFw8Spdmryyyk+7YC8LKDOoOvxhjuLoDAnHbLOZWYxOCdKnUmxkN4FpDjBhJGf8YmB36OwTh28B54aB@vger.kernel.org
X-Gm-Message-State: AOJu0YygoWXLU60o6MsIK/APfYvVtqYmL+1USa4hs39XvsdEdWrHCEWf
	paeroyRSKvus3V6ZHuph3iy8u7354eF7Pw5HAF7CcheQbvUOYTWrQF8C4cXuxPpuMuWPRn2G1kR
	sPm8kjdBk8w==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:138:106:9053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6897:b0:136:c77a:6509
 with SMTP id a92af1059eb24-138067036e8mr8600936c88.25.1780988637161; Tue, 09
 Jun 2026 00:03:57 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:46 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf build: Add libnvme feature detection
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Introduce a feature check for libnvme so that we can conditionally
compile the NVMe PMU driver. This checks for the availability of the
libnvme headers and library using pkg-config.

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/build/Makefile.feature       |  2 ++
 tools/build/feature/Makefile       |  3 +++
 tools/build/feature/test-libnvme.c | 11 +++++++++++
 tools/perf/Makefile.config         | 12 ++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 tools/build/feature/test-libnvme.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c1..bf8503241539 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -73,6 +73,7 @@ FEATURE_TESTS_BASIC :=                  \
         libbfd                          \
 	libbfd-threadsafe		\
         libelf                          \
+        libnvme                         \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
         libelf-getshdrstrndx            \
@@ -146,6 +147,7 @@ FEATURE_DISPLAY ?=              \
          libdw                  \
          glibc                  \
          libelf                 \
+         libnvme                \
          libnuma                \
          numa_num_possible_cpus \
          libpython              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 62909a9c799d..fd00e0be6069 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -147,6 +147,9 @@ $(OUTPUT)test-libcap.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libnvme.bin:
+	$(BUILD) -lnvme
+
 $(OUTPUT)test-eventfd.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libnvme.c b/tools/build/feature/test-libnvme.c
new file mode 100644
index 000000000000..3fefad70a680
--- /dev/null
+++ b/tools/build/feature/test-libnvme.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <libnvme.h>
+
+int main(void)
+{
+	nvme_root_t r = nvme_scan(NULL);
+
+	if (r)
+		nvme_free_tree(r);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e7b15fab2ec..79c4ad10bc18 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1060,6 +1060,18 @@ ifndef NO_CAPSTONE
   endif
 endif
 
+ifndef NO_LIBNVME
+  $(call feature_check,libnvme)
+  ifeq ($(feature-libnvme), 1)
+    CFLAGS += -DHAVE_LIBNVME_SUPPORT $(shell $(PKG_CONFIG) --cflags libnvme)
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libnvme)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libnvme)
+    $(call detected,CONFIG_LIBNVME)
+  else
+    msg := $(warning No libnvme found, disables NVMe PMU support, please install libnvme-dev/libnvme-devel);
+  endif
+endif
+
 ifdef EXTRA_TESTS
     $(call detected,CONFIG_EXTRA_TESTS)
     CFLAGS += -DHAVE_EXTRA_TESTS
-- 
2.54.0.1064.gd145956f57-goog

