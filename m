Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB701DF969
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182429; cv=none; b=VzWRyelT8UpKa8xreRVtNpm1ngyF0kapzxgjBxYNrgL8gvE+uu6uejKIa+4zRRM2amwBDh59J7RaYgHAN68ZThZvmmiF4/UwuRyRqsrWcd8KMtbCu7ZhjGDSIWhADwbIfZtN1bGxd++U9ZaD4F+hpwaGsRaiibK6ZgXxmrLLaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182429; c=relaxed/simple;
	bh=7RObRM0z6nR9DWrq0r5Bujm7WrPO0gXOnXZjPf3UXpk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=WPvHpNux+CLczKS4tqkAgqhxJ/kicBop/+l52dqjkobItwh/geJ7AWMdcwS+WkJkPqxqvbDl6FGPZYh0Y9XJSs/Ld6FSaogORA8L9X/7/JhJ1c0xXGz/adokJ+9TGCADEPvM98lR1X0DcTZ7T75Ojxs4Gr0nxefvUddIUJi9/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxURDOBP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxURDOBP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29bcb5591cso1896221276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729182423; x=1729787223; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4IAnzQZVBr6W615fwR+39NWeMnDjMPSHLvl/Wce2vU=;
        b=JxURDOBPAoKBzbtxxi2UmR4w4JQQoayUSWgJOcyypZEyTDcgHdsIunsg7sTTKv1qff
         Bh5mDaCkCYdmuoV4KoWEO9YLi3MF+Zll/eLKnLzb5rPeQrkiqohizE0AclI1OaXhkxcF
         5aCDm+M/iGVbet3gKv+hdHiTQJPcRTSLt7ScYDSeOonS/JeqAyKhP/R8bardIwgjCFuR
         aBiaZccROsTA5VtNDLCSRL3ulNCZS52+vUn36/Vlx4/StnrX+y0FugU8O6erKdrvdLIL
         WGWIDIANYvL7eS653V/tbQZ2MNAEIwcrNloJNVS7xVTjg2Zr0OCUEITJWkTDZLoVZyl2
         Ax4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182423; x=1729787223;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4IAnzQZVBr6W615fwR+39NWeMnDjMPSHLvl/Wce2vU=;
        b=bvi15iCj8nNhTr//fNyOyJtqCYvXsnBnQR4hCOORFnpkKgYFFyAcqAYHoDtuwG/3pd
         AgKVxQLgOnOGQEG9uTVjl2zGwyony83h06De7OkbkvIdnwq7zcPVn7XwdxMFur8BjiA+
         UbFcGKT3KVP9vdVNME3LlgHCSazs3K8gvfqwYk9mEIlWQ9TRMHI9J3TkoO4dC8lxchIm
         skOyDAsdoGU1wQJz8790hGPZX68Vv5UTLCrk7WaqhJ0nGbWEQRjSRdc4jCQcTEWuRPBG
         CHcTN5IrGXA6Szle+zA8tbBI9CHwx9SqFLDvs7EAWWT4EycjUeXifaCGc2wlgX7KoRRr
         u7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVFpVliNI7mNy6kcOndutB3pG0fJxODlKVqcFLCwK3MpedNjgk5Jcq6sKNjrasahWUC0MZGrfvSsqsX9noJt6Ro@vger.kernel.org
X-Gm-Message-State: AOJu0YwF28aH4GoGX+NDSaMxiQKbFW/VpfcG45UKh2gDjq05WD19omLC
	JrB01miyXhmrqWC603bc+J8VpQOizGQ3uJKU+QQ5qLH/MvsjpNZ4dPxTrPKfKt64KqV29rxjyCN
	TrCuo1Q==
X-Google-Smtp-Source: AGHT+IFG7sCOdONyNi5sV1QifTeVlHob7eJx347MgZjZvcxyocfpiupcKBob93e0kzghzcj2bHUGdDdpRE70
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:6902:1824:b0:e28:fba4:8b6e with SMTP
 id 3f1490d57ef6-e2979482a97mr4636276.7.1729182422876; Thu, 17 Oct 2024
 09:27:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:26:49 -0700
Message-Id: <20241017162649.724851-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v1] perf check: Add sanitizer feature and use to avoid test failure
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
 tools/perf/builtin-check.c         | 37 ++++++++++++++++++++++++++++++
 tools/perf/tests/shell/annotate.sh |  6 +++++
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..5779df5e35ec 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -9,6 +9,37 @@
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
+#define HAVE_SANITIZER_LEAK 1
+#endif
+
+#if defined(MEMORY_SANITIZER) || HAS_COMPILER_FEATURE(memory_sanitizer)
+#define HAVE_SANITIZER_MEMORY 1
+#endif
+
+#if defined(THREAD_SANITIZER) || HAS_COMPILER_FEATURE(thread_sanitizer)
+#define HAVE_SANITIZER_THREAD 1
+#endif
+
+#if defined(UNDEFINED_SANITIZER) || HAS_COMPILER_FEATURE(undefined_sanitizer)
+#define HAVE_SANITIZER_UNDEFINED 1
+#endif
+
+#if HAVE_SANITIZER_ADDRESS || HAVE_SANITIZER_LEAK || HAVE_SANITIZER_MEMORY || \
+	HAVE_SANITIZER_THREAD || HAVE_SANITIZER_UNDEFINED
+#define HAVE_SANITIZER 1
+#endif
+
 static const char * const check_subcommands[] = { "feature", NULL };
 static struct option check_options[] = {
 	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
@@ -47,6 +78,12 @@ struct feature_status supported_features[] = {
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

