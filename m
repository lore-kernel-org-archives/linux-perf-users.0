Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03E21ABDD
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789285; cv=none; b=KhYQtaFZaHNfXTNMLfchjfDsz3k2kOcET5sqNQhIlxXv8iI6SNRi5GnjB/q610COmJN37C5+56pUCEi9AIj15RkeXVXR4bAKJX6hxkAamb7qvwh8sFv5Fsx4pQQMKwCVUDdgXDLJeh1kJVRwhb8o71884glwvefQry8LMmFIM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789285; c=relaxed/simple;
	bh=pG5Yf72C3MqafKFRNeVo/6WJSrEMD1cF8DCDnUjCrR4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=bZD9MWLWX5tQiwj3ZAiVVwYu34bU4H+wkVHQ/l9Z2xg64pA8ht1WeryEiIjCiIhTmu5Mdq9yJpBDeKswl1cr5FGb5ytR+0ipVNH3f2pOZnSbXkseTsIdG2/3IkHYvx36B4mjDpu5BDRr5kBu7h7FxgYUz+FM4mmgwFTSOeGjEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4BUEgHJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4BUEgHJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so4935715a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759789283; x=1760394083; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQWL67VG2RJkWDD0RBurlwFfJhiEYMgxw5epo/dpmeY=;
        b=A4BUEgHJcBq+jXZ4lpzYKhXyCA889dHMqzhWYsxe2P6IWnUyLujKml44PGmX+w9q2j
         Nn9SUVy1PQMsYEfax+OJIjS5wRn6vWYGbFzhrVM4nOrIRh6uMdokwSo0PpeGeWM2rHJ7
         9YbU0uanfuZeYtpGiy8Lg9kW7y3hLRuMB3iwMvvU6tH9RG53r1EXdpsuZtA1VFbx042N
         c1iUMfz047yDrOsUbBJAsdxM4tCG/wLCOJq2Eefdkiunybr2qyliFRbglmQc3W9XFdFg
         cLdVSqXyMDyczTjnRu7CI1X35BelFCe/YxrRRfnZ8Oec7jV47mkYkZaxUn/DiIrAfJb0
         XtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789283; x=1760394083;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQWL67VG2RJkWDD0RBurlwFfJhiEYMgxw5epo/dpmeY=;
        b=kXHeWueQ9IvvEJBj7/lfkNzboaT4Q07+GWmQBZ5O/DAtYbrW23buncmqHbgn8essHC
         e/7TkY2FuoDV51p8Wr8MVNbUkxGOy7mzxLPso/hAnEQxeAfKV/jbfwlobecCPlinLpRB
         WKjvBj3uzaxFPCRRN+Ee5r5E13WM1hkx058V78qB26LITIgxC6WD5WCenh0cfsrIhz9r
         OeUgp6KgTI5t8wErMWHIyV8cdjjgPcrRsPHI04EWKJ2sz9osNircNP+C5ao84AxsdQBe
         rBUkwNb+JZWPy/rH263v17COtl3sMWyuTzgsy4nWZLhylBO7SOrg90vn9lTMFx3WxhuN
         qr7A==
X-Forwarded-Encrypted: i=1; AJvYcCVzlJyTsNUSWlibVjDWqt51agZtIdD9JEFpOjIvzCfzswfsI3X/+6nd3NFrJMIpbiUA7fmSok98F2KMr6LuwQ71@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Cd9DJmTpYMMyKt6AIWlYUJHn2suVmtq8toN/z9baSgyoYfmZ
	SNDRfnpsZRIVqMQnGS9y3vQ7cNdtyXyrVEh4xjqv+ZVdIEtAcTRUKJgo1eGeZw6JfomVqq3rUw1
	gUZuaNdc+vA==
X-Google-Smtp-Source: AGHT+IG9LGXJQP1sxyydOdHtv0ZVI9tHHJXDh68uhbhHHO6JQs+vkAbydr9aE4+5APzeHyRyAJDVj5L8NboC
X-Received: from pjbsy16.prod.google.com ([2002:a17:90b:2d10:b0:327:dc48:1406])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0e:b0:330:6d5e:f17e
 with SMTP id 98e67ed59e1d1-339c278eb63mr16671097a91.24.1759789283381; Mon, 06
 Oct 2025 15:21:23 -0700 (PDT)
Date: Mon,  6 Oct 2025 15:21:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006222116.3335193-1-irogers@google.com>
Subject: [PATCH v1] perf build: Don't leave a.out file when building with clang
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Testing clang features doesn't specify a "-o" option so an a.out file
is created and left in the make directory (not the output). Fix this
by specifying a "-o" of "/dev/null". Reorganize the code a little to
help with readability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index dd289d15acfd..6caf2126b1cd 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -22,8 +22,16 @@ assert srctree, "Environment variable srctree, for the Linux sources, not set"
 src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
-    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
-    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
+    error_substrings = (
+        b"unknown argument",
+        b"is not supported",
+        b"unknown warning option"
+    )
+    clang_command = [cc, cc_options + option,
+                     "-o", "/dev/null",
+                     path.join(src_feature_tests, "test-hello.c") ]
+    cc_output = Popen(clang_command, stderr=PIPE).stderr.readlines()
+    return not any(any(error in line for error in error_substrings) for line in cc_output)
 
 if cc_is_clang:
     from sysconfig import get_config_vars
-- 
2.51.0.618.g983fd99d29-goog

