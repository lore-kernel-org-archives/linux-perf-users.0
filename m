Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB416DED9
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981980; cv=none; b=O3KXrnaJsyFj4cEyOBaX0hTuRweuZwFFspnQZfaMOrUH8svSfqdNQT5s2GFIJu7peFDBnTVvulpHQbx0sLIoBX7HGeF9Ehvdzy2yRtV3zbkjsygVhF11jZuesTZUXi2ZLiBEy9jeHgzu0s54CbmGZ+QKPmXA9M95Pl6nQAIGrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981980; c=relaxed/simple;
	bh=rA+r7lJ8LbdIj6tMOCWUMchxtDlpTxoliY+5LSiS/WQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=IHf9GernEgaDretpwXInMtLJnkZPwbLFn0gkxXmbKYqp/c51VDSnnrRA0dXHvQ+vueBjfFggv4ivF5suiEvZzS2S4juaRoAQ5e8bW49tzjC2pq6w3xlWvBuMZ3LSauTt0FTWnwsuM4J+0WB3AQK+9sJaHk9FG01U2ohI18gOatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaNcDXY+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaNcDXY+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68d1d966c06so22401667b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722981978; x=1723586778; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V39mAmwJkb6dz8x4m48bmhwCQqndyH/T9UF2oWOcG2M=;
        b=PaNcDXY+/pbL7gTuq+OZspSy8MrFyJQb3dS+Uq6yrnTlWxSuJOF3ncNYwG70bN/uai
         skudneiDm7lXSMAAipuxEF8CQHVcbfuQVNlSeZ+T6czxi2YOS6KjpSbs0a+wgID2Lxsk
         I8vfvz8F1Wsjuw0uvBrUEqaJTFtSDfdPqQhXfLaeWIOqOKGDVqaApacPGYP96p81FU7a
         sAd4I7tD6zhiM1hWBo0Nyq35wGBRT2tPG4kQdJBhU8aWO15fSfk51Y1V5+gBY2Ss9g5S
         V8JVwQfvVQl7sPm9DKRfIdR8GM5TCftSsQkYmh6HtPfUPmRn6gNdBH5IJzA7naDd1evR
         lP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981978; x=1723586778;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V39mAmwJkb6dz8x4m48bmhwCQqndyH/T9UF2oWOcG2M=;
        b=aMNy3oW2wEAub7T6K7Fi/1bE6JEUrSOJwPxnKn9Tx/DVFlM1mc7CcIOeklOLyGGezB
         GgWbFpcBE92ZJrr3Orgvd6hnjapK1wzh4e7c4erWhg3LXb2tq9rwccI18XlVz2qzP2wI
         Z32ZgM5PConDawyvIq5Hz7EyA/G2zC2EwwYN8+DlkO7IgbFaZx16L6f21VdTjDRL+Ezl
         /lQoXZtI8h2lObcbfnqKrNgT+qTKTn1niPFET69QDhIfu4Z1bI2Y0fndFyYJeyuflGyM
         kIQy/rrx068WQO2a/oIH8M0Xm/yCSrY9bmEDQu7mmWd3IEyu47twNufp5YZ5ojg8AWCN
         gpXw==
X-Forwarded-Encrypted: i=1; AJvYcCVhpoAGw1jBX/ok2tEJeyK+EJuSC6JVnBmGbKsD3b38R+Evcg8oI5XkTsgVRKFyVVit7yp+Yo3xd3mR+dyt3i7b595JXpuptqwfvgaHplRHTg==
X-Gm-Message-State: AOJu0YxW50RpgxlzqyZ3XpFmSVqiAbFWNbx2MXbna0RFVtvuWDUwS3T7
	T6iUmupncDw5FDWfb1kZMtpkLF7re2FBfBlvnV1cSBXUFAYxxcgWZXSLbcpWKPcCIhGqFCAFwU5
	dC5+cfQ==
X-Google-Smtp-Source: AGHT+IFwZjUPzLCJFy9PgwjiP4MVgveFf+XD+mhfAuEWKxUAtZZGAG4Y2gs7YyMkbvyfZ3iEA2Ink/iXmZLJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:283a:ce18:dc85:107e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1205:b0:e0b:fa71:c371 with SMTP
 id 3f1490d57ef6-e0bfa71c58fmr116549276.12.1722981977890; Tue, 06 Aug 2024
 15:06:17 -0700 (PDT)
Date: Tue,  6 Aug 2024 15:06:14 -0700
Message-Id: <20240806220614.831914-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v3] perf cap: Tidy up and improve capability testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Leo Yan <leo.yan@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove dependence on libcap. libcap is only used to query whether a
capability is supported, which is just 1 capget system call.

If the capget system call fails, fall back on root permission
checking. Previously if libcap fails then the permission is assumed
not present which may be pessimistic/wrong.

Add a used_root out argument to perf_cap__capable to say whether the
fall back root check was used. This allows the correct error message,
"root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
be selected.

Tidy uses of perf_cap__capable so that tests aren't repeated if capget
isn't supported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: rebase resolving builtin-ftrace.c conflicts and incorporating
    change in:
https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.org/
v2: fix syscall number and '>' should have been '>='.
---
 tools/perf/Makefile.config  | 11 -------
 tools/perf/builtin-ftrace.c | 28 ++++++++---------
 tools/perf/util/Build       |  2 +-
 tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
 tools/perf/util/cap.h       | 23 ++------------
 tools/perf/util/symbol.c    |  8 ++---
 tools/perf/util/util.c      | 12 +++++--
 7 files changed, 75 insertions(+), 72 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fa679db61f62..4eb1fc897baf 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1031,17 +1031,6 @@ ifndef NO_LIBZSTD
   endif
 endif
 
-ifndef NO_LIBCAP
-  ifeq ($(feature-libcap), 1)
-    CFLAGS += -DHAVE_LIBCAP_SUPPORT
-    EXTLIBS += -lcap
-    $(call detected,CONFIG_LIBCAP)
-  else
-    $(warning No libcap found, disables capability support, please install libcap-devel/libcap-dev)
-    NO_LIBCAP := 1
-  endif
-endif
-
 ifndef NO_BACKTRACE
   ifeq ($(feature-backtrace), 1)
     CFLAGS += -DHAVE_BACKTRACE_SUPPORT
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a615c405d98f..88a87bf387d2 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -63,20 +63,21 @@ static void ftrace__workload_exec_failed_signal(int signo __maybe_unused,
 	done = true;
 }
 
-static int check_ftrace_capable(void)
+static bool check_ftrace_capable(void)
 {
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
+	bool used_root;
+
+	if (perf_cap__capable(CAP_PERFMON, &used_root))
+		return true;
+
+	if (!used_root && perf_cap__capable(CAP_SYS_ADMIN, &used_root))
+		return true;
+
+	pr_err("ftrace only works for %s!\n",
+		used_root ? "root"
+			  : "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
 		);
-		return -1;
-	}
-	return 0;
+	return false;
 }
 
 static int __write_tracing_file(const char *name, const char *val, bool append)
@@ -1579,8 +1580,7 @@ int cmd_ftrace(int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
-	ret = check_ftrace_capable();
-	if (ret < 0)
+	if (!check_ftrace_capable())
 		return -1;
 
 	ret = perf_config(perf_ftrace_config, &ftrace);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b24360c04aae..adbaf7748019 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -221,7 +221,7 @@ perf-util-$(CONFIG_ZLIB) += zlib.o
 perf-util-$(CONFIG_LZMA) += lzma.o
 perf-util-$(CONFIG_ZSTD) += zstd.o
 
-perf-util-$(CONFIG_LIBCAP) += cap.o
+perf-util-y += cap.o
 
 perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-util-y += demangle-ocaml.o
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index c3ba841bbf37..7574a67651bc 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -3,27 +3,52 @@
  * Capability utilities
  */
 
-#ifdef HAVE_LIBCAP_SUPPORT
-
 #include "cap.h"
-#include <stdbool.h>
-#include <sys/capability.h>
-
-bool perf_cap__capable(cap_value_t cap)
-{
-	cap_flag_value_t val;
-	cap_t caps = cap_get_proc();
+#include "debug.h"
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/capability.h>
+#include <sys/syscall.h>
 
-	if (!caps)
-		return false;
+#ifndef SYS_capget
+#define SYS_capget 90
+#endif
 
-	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)
-		val = CAP_CLEAR;
+#define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
 
-	if (cap_free(caps) != 0)
-		return false;
-
-	return val == CAP_SET;
+bool perf_cap__capable(int cap, bool *used_root)
+{
+	struct __user_cap_header_struct header = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+		.pid = getpid(),
+	};
+	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
+	__u32 cap_val;
+
+	*used_root = false;
+	while (syscall(SYS_capget, &header, &data[0]) == -1) {
+		/* Retry, first attempt has set the header.version correctly. */
+		if (errno == EINVAL && header.version != _LINUX_CAPABILITY_VERSION_3 &&
+		    header.version == _LINUX_CAPABILITY_VERSION_1)
+			continue;
+
+		pr_debug2("capget syscall failed (%s - %d) fall back on root check\n",
+			  strerror(errno), errno);
+		*used_root = true;
+		return geteuid() == 0;
+	}
+
+	/* Extract the relevant capability bit. */
+	if (cap >= 32) {
+		if (header.version == _LINUX_CAPABILITY_VERSION_3) {
+			cap_val = data[1].effective;
+		} else {
+			/* Capability beyond 32 is requested but only 32 are supported. */
+			return false;
+		}
+	} else {
+		cap_val = data[0].effective;
+	}
+	return (cap_val & (1 << (cap & 0x1f))) != 0;
 }
-
-#endif  /* HAVE_LIBCAP_SUPPORT */
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index ae52878c0b2e..0c6a1ff55f07 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -3,26 +3,6 @@
 #define __PERF_CAP_H
 
 #include <stdbool.h>
-#include <linux/capability.h>
-#include <linux/compiler.h>
-
-#ifdef HAVE_LIBCAP_SUPPORT
-
-#include <sys/capability.h>
-
-bool perf_cap__capable(cap_value_t cap);
-
-#else
-
-#include <unistd.h>
-#include <sys/types.h>
-
-static inline bool perf_cap__capable(int cap __maybe_unused)
-{
-	return geteuid() == 0;
-}
-
-#endif /* HAVE_LIBCAP_SUPPORT */
 
 /* For older systems */
 #ifndef CAP_SYSLOG
@@ -33,4 +13,7 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
 #define CAP_PERFMON	38
 #endif
 
+/* Query if a capability is supported, used_root is set if the fallback root check was used. */
+bool perf_cap__capable(int cap, bool *used_root);
+
 #endif /* __PERF_CAP_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 19eb623e0826..a18927d792af 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2425,14 +2425,14 @@ static bool symbol__read_kptr_restrict(void)
 {
 	bool value = false;
 	FILE *fp = fopen("/proc/sys/kernel/kptr_restrict", "r");
+	bool used_root;
+	bool cap_syslog = perf_cap__capable(CAP_SYSLOG, &used_root);
 
 	if (fp != NULL) {
 		char line[8];
 
 		if (fgets(line, sizeof(line), fp) != NULL)
-			value = perf_cap__capable(CAP_SYSLOG) ?
-					(atoi(line) >= 2) :
-					(atoi(line) != 0);
+			value = cap_syslog ? (atoi(line) >= 2) : (atoi(line) != 0);
 
 		fclose(fp);
 	}
@@ -2440,7 +2440,7 @@ static bool symbol__read_kptr_restrict(void)
 	/* Per kernel/kallsyms.c:
 	 * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
 	 */
-	if (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))
+	if (perf_event_paranoid() > 1 && !cap_syslog)
 		value = true;
 
 	return value;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 4f561e5e4162..9d55a13787ce 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -325,9 +325,15 @@ int perf_event_paranoid(void)
 
 bool perf_event_paranoid_check(int max_level)
 {
-	return perf_cap__capable(CAP_SYS_ADMIN) ||
-			perf_cap__capable(CAP_PERFMON) ||
-			perf_event_paranoid() <= max_level;
+	bool used_root;
+
+	if (perf_cap__capable(CAP_SYS_ADMIN, &used_root))
+		return true;
+
+	if (!used_root && perf_cap__capable(CAP_PERFMON, &used_root))
+		return true;
+
+	return perf_event_paranoid() <= max_level;
 }
 
 static int
-- 
2.46.0.rc2.264.g509ed76dc8-goog

