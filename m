Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAC4A9D5F
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364152; cv=none; b=JPqyRPxlkawhcZ15C9faU0lPPIzxOl47rYd9Np3xvFQkg5ODWswE6yHIPON9jcoDTPM+PsF3709lzCM21uQBtl6nmPlr28j8bPT1sA9fviRTBannbRxIxwg3qiztsRMPAvdnew/+r5E/vLambcUXBk3uKfWKk2pxkgj0xSni8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364152; c=relaxed/simple;
	bh=LTTLra+PUz1AlKXy3o92mh9nNm1O1hcLy9+oY8eA8M8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YjKWIjFdq4xxAgIqJc0FBwwCbKUIdTOeoCSJgWeHHdw8pWWUKGlbN0OllKpmi+6LjvlrowNDBFme3cCWu317dYhKq9Bf6pJkDGZ6bWus1uvcxbBMps3ed/aG1vAhenRfYA5BF+KskgmEWjq9ZG6hHz26m9bt4y0wLd9uIyhpUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSyojTa1; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSyojTa1"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1829980a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364150; x=1788968950; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhk15Dkp6U70e7pfSeMd4e+aP7RD0YHiViMj7ADpkzQ=;
        b=sSyojTa1ktrLg2Br0nVpRSYkhl9YMmpVqb72emIr0jj8JZallUo8t5Pn47vQVly7D6
         FFzRoEoJY5mNjazKkIH9EnBrV99K1khBCEX/PM2LCcPPwilRR+7lIhRcKXkQ0u4A1v5E
         EQgRayX0jwiNXCWbFZvkd8PrvjzFaYhuldEh0+aaVMApC+SBhlQjW0hLrVVWPWdxK4th
         8oxMEExRrVLZYbhFQGRxb11Yuql/5R7WNX2vTbZ6sASt1T6CLTgFtPLFa2xmD+9d2odD
         lxv9CiwXtLRLwoLHsJL8hLkUB5B0PPZ01QFchyWqm9JZ9DfYhlhWv5WlsPBKhFUVymhH
         vcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364150; x=1788968950;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhk15Dkp6U70e7pfSeMd4e+aP7RD0YHiViMj7ADpkzQ=;
        b=mnaK5nnSVN2Fk4wTXt2noRJcW23TZwxNN83yht4PX1JyWyGFmEpqP0FpuwF5woRYn3
         mPamcAfZiDdxA+yzYWmLw70TYnw+lwawz27JMlNgBqWRHUUrKzBBjeG1VxtjbIQC7PH4
         e1JmHg30GrBAW/t6f+x5xpACNNGGpQ805va2ZT7xShQB+yBh04OCLAtLoAdkEYb4aLYk
         iLIJPAXrPaQkLfsU+uU4yidvf3ZRqy2V0R/gxYZqR/FepIcPHJaCt6M3Q0u5ncoZLtxQ
         iOEVhZx1NU/QvGlIz8t0s7IjSzcpzmFYnvOgZC+6X3mxLAGuwR8STnkOmX6Y82fPqNzs
         eELw==
X-Forwarded-Encrypted: i=1; AKwUvBx7N4OlqYhl8JSbUqr2f93RyN2bjNSjnRi2qi1J2ev8CGxTxnq+bboFqTWQ3fpiylDBCJqi0EPFkAJB5bEbaQc6@vger.kernel.org
X-Gm-Message-State: AFuF++niRJzKgWLRRmlqRAelL+6eCKz86ebZWejglUhsaC6fpXxvYqQ4
	pQ4ri/tiHQKDeSfiUrwPOeo/CTYOLujwpp44MP3tvn9WfPMQ1TIOTWaV5SEgUUz4TZe+cl7Ds6R
	DzkOChj7ZXw==
X-Received: from dycpq12.prod.google.com ([2002:a05:7301:fd0c:b0:327:7dfc:560a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53d0:b0:37d:f983:7b5
 with SMTP id 98e67ed59e1d1-39aedf779b3mr8820740a91.9.1788364149483; Wed, 02
 Sep 2026 08:49:09 -0700 (PDT)
Date: Wed,  2 Sep 2026 08:48:56 -0700
In-Reply-To: <20260902154858.2078885-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902154858.2078885-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902154858.2078885-5-irogers@google.com>
Subject: [PATCH v3 4/6] perf tool: Move usage strings and functions to perf.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tianyou Li <tianyou.li@intel.com>, 
	Jiebin Sun <jiebin.sun@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Eric Biggers <ebiggers@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The code is mostly used by perf.c with additional unused functionality
such as function pointers derived from early git code. Moving it into
perf.c directly reduces the code footprint, drops the util/util.h
dependence from perf.c, and allows us to remove util/usage.c entirely.

The string constants are exposed in builtin.h, as they are used
in builtin-help.c.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/builtin.h    |  3 +++
 tools/perf/perf.c       | 13 ++++++++++++-
 tools/perf/util/Build   |  1 -
 tools/perf/util/usage.c | 34 ----------------------------------
 tools/perf/util/util.h  |  4 ----
 5 files changed, 15 insertions(+), 40 deletions(-)
 delete mode 100644 tools/perf/util/usage.c

diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 40c4078c295f..e0b430821abc 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,6 +2,9 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
+extern const char perf_usage_string[];
+extern const char perf_more_info_string[];
+
 struct feature_status {
 	const char *name;
 	const char *macro;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 7e2e667b011f..65bdfd71f626 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -31,7 +31,18 @@
 #include "util/build-id.h"
 #include "util/config.h"
 #include "util/debug.h"
-#include "util/util.h" // usage()
+
+const char perf_usage_string[] =
+	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
+
+const char perf_more_info_string[] =
+	"See 'perf help COMMAND' for more information on a specific command.";
+
+static void __noreturn usage(const char *err)
+{
+	fprintf(stderr, "\n Usage: %s\n", err);
+	exit(129);
+}
 
 #define CMD_EXEC_PATH "--exec-path"
 #define CMD_DEBUGFS_DIR "--debugfs-dir="
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b26a0b1ddfa3..d08f2af7d970 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -54,7 +54,6 @@ perf-util-y += string.o
 perf-util-y += strlist.o
 perf-util-y += strfilter.o
 perf-util-y += top.o
-perf-util-y += usage.o
 perf-util-y += dso.o
 perf-util-y += dsos.o
 perf-util-y += symbol.o
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
deleted file mode 100644
index 4c8ffbad2323..000000000000
--- a/tools/perf/util/usage.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * usage.c
- *
- * Various reporting routines.
- * Originally copied from GIT source.
- *
- * Copyright (C) Linus Torvalds, 2005
- */
-#include "util.h"
-#include <stdio.h>
-#include <stdlib.h>
-#include <linux/compiler.h>
-
-const char perf_usage_string[] =
-	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
-
-const char perf_more_info_string[] =
-	"See 'perf help COMMAND' for more information on a specific command.";
-
-static __noreturn void usage_builtin(const char *err)
-{
-	fprintf(stderr, "\n Usage: %s\n", err);
-	exit(129);
-}
-
-/* If we are in a dlopen()ed .so write to a global variable would segfault
- * (ugh), so keep things static. */
-static void (*usage_routine)(const char *err) __noreturn = usage_builtin;
-
-void usage(const char *err)
-{
-	usage_routine(err);
-}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 87a0818a8c76..f8f1ff603c72 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -17,9 +17,6 @@
 #include <internal/cpumap.h>
 #endif
 
-extern const char perf_usage_string[];
-extern const char perf_more_info_string[];
-
 extern const char *input_name;
 
 /* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
@@ -29,7 +26,6 @@ extern bool perf_host;
 extern bool perf_guest;
 
 /* General helper functions */
-void usage(const char *err) __noreturn;
 
 struct dirent;
 struct strlist;
-- 
2.55.0.966.g6673acef38-goog

