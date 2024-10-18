Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B78181334
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230992; cv=none; b=Law2D1Q5TLY6oZiUZ8g+DXwHrRTBlmHj884nxLwcFIMMMjdOKmHh2TQrWrZWQwcyoZDANzukpKHFhxHYcUKwxrukiE+LaztI4xdMIZWw0P5XD9OOjbOPfcP7qTtQpDTPoWJTOjU0KPZpiImytR9EqdQduqHHu2Iay66zA1xZhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230992; c=relaxed/simple;
	bh=jHAgmITfHUVoA16dxa39wOe7wHkkmP8ECxCjG/LaVDw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=r3AhHJtrHy6/G6OymhwZ+eEMbsfEhD3l8JDOBie/rl8YyTdoYho3fFINeBzENVAtumMrwDdkGydUQMlXG1YQ4DC2n6QK8hfOhnwk6Kb/ceFryoaRR32+hnrrwCzyYDJRQxHLgaq/3EYMFZX+++QfCHWWjK7PRd0zSJ7LaKQeZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDW5bPM3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDW5bPM3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e321d26b38so33869687b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230990; x=1729835790; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vs/xnFgki8yyfVih2AGhbV+EZVdwg1h1oKFTNaagDiI=;
        b=jDW5bPM3lH9RThYB0R7+GGPJ8hLi4u9Jco/3GwxEMSp64TUF541xKtPh0FkG/xmmnt
         lU9YGK5XvGw/FFEcYCrw+Rsz80KRMT2aK+uKdErP0RFmZiSUttR0d8towcQTFBhIpxR6
         a79h4WEFwl4qEQpNc5/c7eF23jXNVSVpXIwT9zO2ywSVK5m7vVdE9dBf0SgWALcD+hjf
         PZpCDdXK2M0qpaTZq5PfuRy33eWY0uXX9o+mdExekbP/JPiJmgjbisc4HsSrJori89WU
         YDELAnSY1l5405lPvC4L9SDlMt1mQVembIP38nohUG0n4x5lJOXW95VOJHsw6+jkhXc5
         TGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230990; x=1729835790;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vs/xnFgki8yyfVih2AGhbV+EZVdwg1h1oKFTNaagDiI=;
        b=JcJGLF429KRwHdF//W6vWpOpeNdJh4vRYguZx8Y+svzTuLla4sghVJYmEDR1NL/b30
         fzxdf2NW9ug3hZbduYQ7YoLBeDPn18pYF/CZnhwNIfPnJuqZj9V3r+eIECN+gP3IKA/q
         dAa1kAzJt9AKzgzcbDCogrqQB9pJ8u1TYjYZkfcp3sR7xfq73NamSKiEi1akoO03kqWH
         4YptOdnsGEbX774tHI0qt1+qv0UAT2NlPaogavsy4hjdKKHtMef2YtY3w5CTBAhYyDIP
         WmxFPKUYM08OZKPA4kY6vTgDFrdxNNSVqC0kFsQR8+n3cnoAp688wdfsPEWh9Eqp4cWJ
         4vKw==
X-Forwarded-Encrypted: i=1; AJvYcCXr281bbldcpNGlizYDj8gLAxzrpVC0qs4G+33FngzMCSDVrTqdZG/Oq9hEdIegda4Rygr9Xj2E4j7MQPAc2TfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpR0osPTtRvKo/KuTTa8ZCGre3+jBap66bjbxr1Z52SzL5dyq
	YFbAPX9BD4OPeeezhrXilPFRFjg0vuqwCVNL8wIv7Y6S8fstcxuiYRK/unFqzY/yuGv/gGUwF65
	FnmL5nw==
X-Google-Smtp-Source: AGHT+IHN9uSmXknRH9uODr3YKIwoopRaXRXlxF73f4RN0m2yTZqPZ4DZGG7amvJ9japZmRNdf9oOZhfmJ56H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f11:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e5bfd596d2mr160147b3.5.1729230990269; Thu, 17 Oct 2024
 22:56:30 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:56:27 -0700
Message-Id: <20241018055627.1005723-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v2] perf check: Add sanitizer feature and use to avoid test failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sanitizer builds can break expectations for test disassembly,
particularly in the annotate test. Add features for the different
sanitizer options seen in the source tree. Use the added sanitizer
feature to skip the annotate test when sanitizers are in use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2 build fix.
---
 tools/perf/builtin-check.c         | 49 ++++++++++++++++++++++++++++++
 tools/perf/tests/shell/annotate.sh |  6 ++++
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..c44444008d64 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -9,6 +9,49 @@
 #include <string.h>
 #include <subcmd/parse-options.h>
 
+#if defined(__has_feature)
+#define HAS_COMPILER_FEATURE(feature) __has_feature(feature)
+#else
+#define HAS_COMPILER_FEATURE(feature) 0
+#endif
+
+#if defined(__SANITIZE_ADDRESS__) || defined(ADDRESS_SANITIZER) || \
+	HAS_COMPILER_FEATURE(address_sanitizer)
+#define HAVE_SANITIZER_ADDRESS 1
+#define HAVE_SANITIZER_LEAK 1
+#elif defined(LEAK_SANITIZER) || HAS_COMPILER_FEATURE(leak_sanitizer)
+#define HAVE_SANITIZER_ADDRESS 0
+#define HAVE_SANITIZER_LEAK 1
+#else
+#define HAVE_SANITIZER_ADDRESS 0
+#define HAVE_SANITIZER_LEAK 0
+#endif
+
+#if defined(MEMORY_SANITIZER) || HAS_COMPILER_FEATURE(memory_sanitizer)
+#define HAVE_SANITIZER_MEMORY 1
+#else
+#define HAVE_SANITIZER_MEMORY 0
+#endif
+
+#if defined(THREAD_SANITIZER) || HAS_COMPILER_FEATURE(thread_sanitizer)
+#define HAVE_SANITIZER_THREAD 1
+#else
+#define HAVE_SANITIZER_THREAD 0
+#endif
+
+#if defined(UNDEFINED_SANITIZER) || HAS_COMPILER_FEATURE(undefined_sanitizer)
+#define HAVE_SANITIZER_UNDEFINED 1
+#else
+#define HAVE_SANITIZER_UNDEFINED 0
+#endif
+
+#if HAVE_SANITIZER_ADDRESS || HAVE_SANITIZER_LEAK || HAVE_SANITIZER_MEMORY || \
+	HAVE_SANITIZER_THREAD || HAVE_SANITIZER_UNDEFINED
+#define HAVE_SANITIZER 1
+#else
+#define HAVE_SANITIZER 0
+#endif
+
 static const char * const check_subcommands[] = { "feature", NULL };
 static struct option check_options[] = {
 	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
@@ -47,6 +90,12 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_STATUS("sanitizer", HAVE_SANITIZER),
+	FEATURE_STATUS("sanitizer_address", HAVE_SANITIZER_ADDRESS),
+	FEATURE_STATUS("sanitizer_leak", HAVE_SANITIZER_LEAK),
+	FEATURE_STATUS("sanitizer_memory", HAVE_SANITIZER_MEMORY),
+	FEATURE_STATUS("sanitizer_thread", HAVE_SANITIZER_THREAD),
+	FEATURE_STATUS("sanitizer_undefined", HAVE_SANITIZER_UNDEFINED),
 	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 1590a37363de..199f547e656d 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -4,6 +4,12 @@
 
 set -e
 
+if perf check feature -q sanitizer
+then
+  echo "Skip test with sanitizers due to differing assembly code"
+  exit 2
+fi
+
 shelldir=$(dirname "$0")
 
 # shellcheck source=lib/perf_has_symbol.sh
-- 
2.47.0.105.g07ac214952-goog

