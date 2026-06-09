Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C174A2E13
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024256; cv=none; b=lryRAIXaGp5G7n6tIfYVOiSjx5gSRnTDiuHnlmKLOvtDsu4mI4yEQJLkYdtoKGZBsqnJzAxF+7yYUT8PpG/wyZy3xuyS3IPco+C7wDKcxnvmFK3i4PSS3q8/xLo46HWE7YT5Yx0XEx4qdugYewN4aZVs6Ih2XFlFBOovfg+yAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024256; c=relaxed/simple;
	bh=OQF4F9a+rsmk+xc0G0FOtWI3YX3Mr7AvnAEUFnLylmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HoD+bmqMghzC+4y+ZzLJ5FZub3pianlQb/yjW4jHeY8B90Is8bHgRj2Vn539glx+2/GDPGLC25E9GsJfvO1lHDrdXpFFhJFA39WEPC4Q28TP6WxqRd8gb3DXafTCnCLtO15F1+HIRsEIllimrcchv9GEzL7NmOQM9INRm0vYZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYDQ6aOM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYDQ6aOM"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ea1eea05so725787eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024255; x=1781629055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LaWkWhrJUw9a/giq+cHZdt0Sg1l4kluVtd55JMhqgE=;
        b=CYDQ6aOMBTnxBlg2K5r/6iaPx1zy4WqElGnsSoZ3kH5q9Zekf8fGWXaFhkbvmKYzad
         mXytRCQMa0w+hdmAg4YwGzlhm/zMPYzf5CD7inVPrsSTmRW1N/UbQYbN5TDVA9HZ9sLw
         lHBMm0NdGCkl598YrqJ+Q2/GXUfQJoglxgG9MmLdgBYVrEXt4CwR6Su5lW6fNBaIb3D6
         WPDKskqQx5uWsR89rdGwvcYvy/LfHOZJMFdTXmYy0v0sSKI2I7LBLfrb56AS6p7QR6XY
         APsJDZsHWeMuHThbSzS1muk3fyXx5nU54nW1vs2KrW/BAas/uT24sOPCwoSuiJFoaCz7
         ml/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024255; x=1781629055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LaWkWhrJUw9a/giq+cHZdt0Sg1l4kluVtd55JMhqgE=;
        b=UFADwIeyAYQYnVkAt8N9z6n/w5JuAS/V+Tq7AV5PqZpNOFU+nbNDv0NrdIDUL07OZ8
         I6MQWBfA7nU40FULCdCKmiDBGdDPM00VuNgc2i+CP4mppAeC/pWsnqgVWDiTj85r6wNs
         elYsehkKePW7sPi2YoOWfPp89XzK6QN89HQWXtdJe3ABZK622yJrmlxBxKe6/cPxNzul
         KmjUU5V3JRGopvmPeVOcpXDziGpOn6KRjAwSJlgpEDobSMV10E89l5M++t15buBFfJsT
         QYBk/byKsbewQze0/wGH6XvC/gfHiNQ2VCYJSnHqFzoi2AGTThIOXheoNErS3028UnTz
         VdJA==
X-Forwarded-Encrypted: i=1; AFNElJ/PiCn/ft3/K3O3hoBzQPuHJEHxuDh+xRma8q3xVmv9mpMQMU8pX6oudaDkPj5esIwQxg3M0+VGackzvoAAEgmf@vger.kernel.org
X-Gm-Message-State: AOJu0YxCr1nOKWHflS3e+0dxQUp+2Bj5AS1aF/D8vCbTqMT9KzH+86H8
	yRwI0KRwEKa/assTgJ8QJMfbl2rS9vOLhY9gwmXxowZQOo7C73IAteCzFqgH6WxjsW3JTjrq62+
	5597XO3L0nw==
X-Received: from dyeg12.prod.google.com ([2002:a05:7300:538c:b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72c9:b0:2ea:5057:a304
 with SMTP id 5a478bee46e88-3077aeed2fbmr12622888eec.2.1781024254393; Tue, 09
 Jun 2026 09:57:34 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:57:24 -0700
In-Reply-To: <20260609165726.786694-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com> <20260609165726.786694-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609165726.786694-2-irogers@google.com>
Subject: [PATCH v2 1/3] perf build: Add libnvme feature detection
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, yuzhuo@google.com
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, ashelat@redhat.com, german.gomez@arm.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, mjeanson@efficios.com, 
	namhyung@kernel.org, peterz@infradead.org, tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"

Introduce a feature check for libnvme so that we can conditionally
compile the NVMe PMU driver. This checks for the availability of the
libnvme headers and library using pkg-config.

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/build/Makefile.feature       |  5 ++++-
 tools/build/feature/Makefile       |  3 +++
 tools/build/feature/test-all.c     |  5 +++++
 tools/build/feature/test-libnvme.c | 11 +++++++++++
 tools/perf/Makefile.config         | 12 ++++++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libnvme.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c1..3bc9a305256b 100644
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
@@ -171,7 +173,8 @@ FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
 FEATURE_PKG_CONFIG ?=           \
 	 babeltrace2-ctf-writer \
          libtraceevent          \
-         libtracefs
+         libtracefs             \
+         libnvme
 
 feature_pkg_config = $(eval $(feature_pkg_config_code))
 define feature_pkg_config_code
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
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 544563d62950..875eb9185e23 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -146,6 +146,10 @@
 # include "test-libopenssl.c"
 #undef main
 
+#define main main_test_libnvme
+# include "test-libnvme.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -178,6 +182,7 @@ int main(int argc, char *argv[])
 	main_test_libzstd();
 	main_test_libtraceevent();
 	main_test_libopenssl();
+	main_test_libnvme();
 
 	return 0;
 }
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
2.54.0.1099.g489fc7bff1-goog

