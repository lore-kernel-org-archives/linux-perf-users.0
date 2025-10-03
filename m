Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F2242D91
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458464; cv=none; b=imKsq7CIqE1sKF2AT8zquNKlFIuPvqQm6WEzeHwslIN2jjLia0iGEQB1K4FcIPNx1YPmYBE9MsUkLcjlqUH2yg6xEUJ2qlfOHyvLR0PwButP/BTGAzSe26IhmHydUiSe+WZQJZRo06O/5eQeNlbgR7tMUiv9njM0IhSYwA0KYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458464; c=relaxed/simple;
	bh=l0seT57zzbeG0N1AJB+4YPl2iTrg/uYD6evzWSRRzkk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=mv5YGMSHKYGfn3fqjYVOaWO9t4Ar6fMYUK93e9Z6hT4MSLH9AfMKKT+4yZM80oFiWpzuLicadfwlA7xHVq72CVcgf9CqYcEgRnUBuJ0GKwF1aFNe4RXOr1D69hNuHOrmnYRYbL/wSVn3JIL7lMdd4O/RyL/V1Ertoj2G7/7s8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmFYRqT1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmFYRqT1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-268149e1c28so18135685ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759458458; x=1760063258; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zo682XdUrmGdyaEa4pDcJZ6agvru+K1WJLCt4vpvids=;
        b=VmFYRqT1M00VqcPdUX0ILing+medaadAdgygbp/py/uLCbQsknR+z9PsBXQPJeJog+
         fhfw0OxGy9PVFMl3MGC4tm8ikJoQJ557gwW5jhs2jYu0E8+4BEN6C3APaRjlwG2CPrTN
         5hp7dgYThTF/rvl+pi1g0oBABtHZ8UebumBFw7ic2oJkAK5LYM5C+rNI3jmrh/XF7JLt
         TQ7N0Vb2QNfEm330FzO/L6i+U9ITZlhLZuj7kMFgpwGKaN3amO/Yp5dFqwPp9NmN5QG6
         qpTr70iM4NACvpZ7lXlucgxrPEdF/3VC7ARBnSDKLSZQTUmx1vWyWTlehVJdUXhD0nWU
         V2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759458458; x=1760063258;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zo682XdUrmGdyaEa4pDcJZ6agvru+K1WJLCt4vpvids=;
        b=OUDh42McXkpzdQFrfK98SJEjC5X6Xf6GnBcnzpY8zaUK6EJJMVgPuyDGJNYkAi4/bL
         Dh77VhKpN+vYm/2Rxp9o7/E3NCVQjegBmkX8j1QABCdRKbV1eNU4jnWhfyuPA3g9f1NM
         QQURy1c7ZifaaPAB4dbrFaYQLUwaVzB7ZABUvy1alewBb8SpxENYht1MgwMYkmgxLT6F
         cZ79z2mRBeaIRbG2wHgPtAY2a4JoGsIFi5S+Uv9bMXS2fVOvmT8QNVWcLRw+NyPDGm9X
         1LnZ2siCwTh0tzZ40lVZehuoEfpD2ibqXth52GkApIlTh2H0IaFqn8rW5IT48ya0YXpS
         v5vA==
X-Forwarded-Encrypted: i=1; AJvYcCW30waZTJvL3E6On60uolgvAjml7A5jmqVCodwSzpoZDqFB4cxhqyDO8KzIRqRLY+VO1QTf5wvDlV8cZhlzXL5F@vger.kernel.org
X-Gm-Message-State: AOJu0YwaS6FbJJ9QkJVHvOTPVnTEal2othBqC1rzicCMhoE6l5MEQMJN
	OTpDrjaNa87x980bk9vAUyYDYADHDvDP3nao5cAAQVnWX20XPNsRdROUpHR/1Ai7nM5/rgSUGH0
	kxZJYDPxywQ==
X-Google-Smtp-Source: AGHT+IGGcWPCrf38L8r3eeDdZpIfUA7Dns+Go6eicYuhv3iZLJ13mowXvTlMLbWa1lct0uGmC2IhHHRopaP1
X-Received: from plwp6.prod.google.com ([2002:a17:903:2486:b0:269:607f:f138])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:388d:b0:267:e3af:ae67
 with SMTP id d9443c01a7336-28e9a546354mr16385165ad.14.1759458458578; Thu, 02
 Oct 2025 19:27:38 -0700 (PDT)
Date: Thu,  2 Oct 2025 19:27:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003022733.2417810-1-irogers@google.com>
Subject: [PATCH v1] tools build: Remove feature-libslang-include-subdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Added in commit cbefd24f0aee ("tools build: Add test to check if
slang.h is in /usr/include/slang/") this feature was to fix build
support on now unsupported versions of RHEL 5 and 6. As 6 years has
passed let's remove the workaround.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile                       | 4 ----
 tools/build/feature/test-libslang-include-subdir.c | 7 -------
 tools/perf/Makefile.config                         | 9 ++-------
 tools/perf/ui/libslang.h                           | 4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 tools/build/feature/test-libslang-include-subdir.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index fd304dc2aafd..a4b1e11c5807 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -33,7 +33,6 @@ FILES=                                          \
          test-libperl.bin                       \
          test-libpython.bin                     \
          test-libslang.bin                      \
-         test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
          test-libcpupower.bin                   \
          test-libtracefs.bin                    \
@@ -229,9 +228,6 @@ $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
-$(OUTPUT)test-libslang-include-subdir.bin:
-	$(BUILD) -lslang
-
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
diff --git a/tools/build/feature/test-libslang-include-subdir.c b/tools/build/feature/test-libslang-include-subdir.c
deleted file mode 100644
index 3ea47ec7590e..000000000000
--- a/tools/build/feature/test-libslang-include-subdir.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <slang/slang.h>
-
-int main(void)
-{
-	return SLsmg_init_smg();
-}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b0e15721c5a5..6e7c057b8ecf 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -773,15 +773,10 @@ endif
 
 ifndef NO_SLANG
   ifneq ($(feature-libslang), 1)
-    ifneq ($(feature-libslang-include-subdir), 1)
-      $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev)
-      NO_SLANG := 1
-    else
-      CFLAGS += -DHAVE_SLANG_INCLUDE_SUBDIR
-    endif
+    $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev)
+    NO_SLANG := 1
   endif
   ifndef NO_SLANG
-    # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
     $(call detected,CONFIG_SLANG)
diff --git a/tools/perf/ui/libslang.h b/tools/perf/ui/libslang.h
index 1dff3020e9d5..6722561e0458 100644
--- a/tools/perf/ui/libslang.h
+++ b/tools/perf/ui/libslang.h
@@ -15,11 +15,7 @@
 #define ENABLE_SLFUTURE_CONST 1
 #define ENABLE_SLFUTURE_VOID 1
 
-#ifdef HAVE_SLANG_INCLUDE_SUBDIR
-#include <slang/slang.h>
-#else
 #include <slang.h>
-#endif
 
 #define SL_KEY_UNTAB 0x1000
 
-- 
2.51.0.618.g983fd99d29-goog

