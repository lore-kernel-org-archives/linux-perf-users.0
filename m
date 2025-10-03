Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5A2DC357
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514180; cv=none; b=tp0KnR48I4p1Y5f4lHa+YFHCqIT4EauJjd2SG9u+0Ua8sc15wnxNA3yCn+f6N52N0MEXT8T8k7mQlRJnKvRSfHK6X0/t1coI2nLcakiwzMLcfA3sAgyMyJn98YX6WEXUKNTve83nB9po8wO4aHIhv0xXte2Q9bS3kd2XTVBVhdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514180; c=relaxed/simple;
	bh=OpUdHXUA0W+Q6HfIdjC5/Eo2qQS6nQyXRDaLDwwWGXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TWbV11cCubEij0OY66PIB5Xcl2LqilrdzXCCEn6UC2/KaeknuU/JMR49736UKd8grXrh9S3FpW7k1zxyhcuW0vphV4ZuXWsPJV1gJD91KQUuv2YdmhQMB6w3MTzVTp0XlHkPa3SUkMdp+2dC0FmvXtH5kLtObb1R4EW9nluEG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0IMBpAK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0IMBpAK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26983c4d708so22352765ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Oct 2025 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759514179; x=1760118979; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCzKIcxSwtwSrniu1/P7nPNHr6oMGAp8BGuB6qmiLI4=;
        b=s0IMBpAKz/JVPm1vKae+sOXUR0QBPH9XFsxcSLKJ3ujbJi45AJs84rV8LHNE9YrIO/
         xPM0zCwgqkPty/8XYPgJwy5OK4KWI65Ii4rcrZquLT3PiTQIuNkCY+SRjVoA3koyl4sR
         Pk8hH1EsycPXWwZajy6QMI/HOmpiANd37h77dQvK5+0OtfaKHZargv3Yt3CvrpKH0BZw
         32xYH6x3sqGcSP7Mw3/wIaRD4xMxeKX/pyusTGn9UltXdR8o5TPJKuWSSHw0hw+1XWOJ
         MVGdWWgVGVgrycy1kNNeHPB5OMhUHox0Pcm96nUQtOzlaCy9U9ybZoy1BAG3z35kdn/c
         OOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759514179; x=1760118979;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCzKIcxSwtwSrniu1/P7nPNHr6oMGAp8BGuB6qmiLI4=;
        b=ftHfwSckuLyhQDo7a/cbTkDJ2kj3u+RIJXKQh7mFOzzFb5IRsleWvigTqGSWZE1caA
         zWb2wBuQpUZFemQO/gTzIWs1ExiadqYGEfct0zJdLKy4TmBmkuoyBEO7vTzgb8/SMGlx
         dPuJILblDbXB7m9de1/uOOYFfOff8FAMQQtZP4GydUxVjWccBoeS2jqSSorKtqwBxn/N
         y/V2cd5JjQ4p+GLsM+RNdVGn/UQ/+i3ZwAX+h3POsw5HvTRdlxgF1MDEXFtGXyl/sdi0
         hho21iOyiKeslEk0OYTAVCnN6Ldtz96ffaOIz7GFDilY32QlVIiSJ8mADrB8CWINwJxd
         kn6g==
X-Forwarded-Encrypted: i=1; AJvYcCWB8zcpELGzzMaQSfyiKizyJXX6CNAlzFP2ZOaMfPEqS8oXxAgFbEz3Hp9Zi21bb/G4HiHrhnbAM8ghmPz0mHX8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2CQW23wlQUJn88C8X/Zg+b/gz+hc1reY4hNkbmu11Yn6WZXG
	8aCloDDKL8i3fD5DJ4Bz/YfRySwmlARyMhnr9pn870Y9lZ6mWrjJKdcx3LtST5O8JvQCEO6qS1U
	/zLfIKMHIQw==
X-Google-Smtp-Source: AGHT+IHKDcdAUZyq92R8ZR4IijMnwzdyQA5mSI8EW4fYoNjLYVkiyYERcuKa/NQHiAhzl51yVbn5SUEahEmU
X-Received: from plsm6.prod.google.com ([2002:a17:902:bb86:b0:267:dbc3:f98d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:269:96ee:17d3
 with SMTP id d9443c01a7336-28e9a6fd7c4mr42004505ad.51.1759514178808; Fri, 03
 Oct 2025 10:56:18 -0700 (PDT)
Date: Fri,  3 Oct 2025 10:56:13 -0700
In-Reply-To: <20251003175613.2512296-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003175613.2512296-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003175613.2512296-2-irogers@google.com>
Subject: [PATCH v2 2/2] tools build: Remove get_current_dir_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As perf no longer tests for this feature, and it was the only user,
remove the feature test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                    |  1 -
 tools/build/feature/Makefile                    |  4 ----
 tools/build/feature/test-all.c                  |  4 ----
 tools/build/feature/test-get_current_dir_name.c | 11 -----------
 4 files changed, 20 deletions(-)
 delete mode 100644 tools/build/feature/test-get_current_dir_name.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9c1a69d26f51..9399f591bd69 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -68,7 +68,6 @@ FEATURE_TESTS_BASIC :=                  \
         libdw                           \
         eventfd                         \
         fortify-source                  \
-        get_current_dir_name            \
         gettid				\
         glibc                           \
         libbfd                          \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b41a42818d8a..d13d2a1f44fe 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -8,7 +8,6 @@ FILES=                                          \
          test-libdw.bin                         \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
-         test-get_current_dir_name.bin          \
          test-glibc.bin                         \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
@@ -147,9 +146,6 @@ $(OUTPUT)test-libelf.bin:
 $(OUTPUT)test-eventfd.bin:
 	$(BUILD)
 
-$(OUTPUT)test-get_current_dir_name.bin:
-	$(BUILD)
-
 $(OUTPUT)test-glibc.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e1847db6f8e6..778883a32afb 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -22,10 +22,6 @@
 # include "test-libelf.c"
 #undef main
 
-#define main main_test_get_current_dir_name
-# include "test-get_current_dir_name.c"
-#undef main
-
 #define main main_test_gettid
 # include "test-gettid.c"
 #undef main
diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
deleted file mode 100644
index c3c201691b4f..000000000000
--- a/tools/build/feature/test-get_current_dir_name.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <unistd.h>
-#include <stdlib.h>
-
-int main(void)
-{
-	free(get_current_dir_name());
-	return 0;
-}
-#undef _GNU_SOURCE
-- 
2.51.0.618.g983fd99d29-goog

