Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6178274
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277177; cv=none; b=jmpKlHNlcJfAW/t2sO+CHscSIizzzYZtNaoHJdJgjQNDoeMRManP6jMidxA6A+dtq6xJN+xLDOr+e3+AJAD5sIWgVGJyjxEE2JXraz6Q1oR/5tcnYlOjBnTQrhcbKmVPJpJRPPLvrqLkcLaUoqEl6/8UC/4yUaXcloSDwwajPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277177; c=relaxed/simple;
	bh=48Go5WZEqhZGkBLcDojOQI4gD4oXH21Xgao7HzO4ksQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GNXDWrSKaNbPqAOnRGqsNu/mdnncH/DAajztsPQSKA3/kXktI7ByMiR2jKZjIIv+BehwssfPkSMULTaDjMxvkOQqQ4zjFVJxpgHy/f1zPi7mGDKsKPGkWaZiXXxe24LJ24g10ESujTGNL4iidBcTc7tfbWBwP0nfstpvKJX3LE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFQfrVyT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFQfrVyT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650b621f4cdso62161677b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722277175; x=1722881975; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UBx8QBhVTUb4n5W83/d6yuCCHVNeWTRoWsFaxdXjeGE=;
        b=sFQfrVyTaTs6rWpDcuzKKdK7BoFk7o8RDhbKrDw51X6sDpjym8H1Kkq2gA3Z+PPWKk
         arDNByoUhIuHXdkFKvY7TAXbGedJnPs4jU2fTJTAeH0SqWteuqMxlVhCvFlFhPcfuIr2
         wzaunUokboQlMWXthJq25Oa9ZwBtY3lWbfo+iapPILG9OK+JyWsTpf2HQSQ/qlSJk41J
         lHb6JTZxqeJa/fb3Vd/DEKELJB0o9wqZ6Ufim5nO6kXsS1S+M+3zac0+00OXoyGPFToe
         C28wy1cLIlyjXwt5U+QAEvc+xvJBOF9BOCXy0vyH84kLJ79F25bZEi+xUFyaJKkWAbh+
         MYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277175; x=1722881975;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBx8QBhVTUb4n5W83/d6yuCCHVNeWTRoWsFaxdXjeGE=;
        b=BQVoKXDrIZ/55rfZjDcRAMu+sKJe3kmPACNBofkyQAwUnBijHBycVBmqcKWU9vvYqV
         IgkhdUy1JXwIRRDh2/G4TqojkNiRxAM/R5UGTpEpclLxxbEq4Cd2NbicGhLDW0PLgWXm
         K1Zb1mVisTrpSN2pMDqhRxBZ08KcoRRrM3qRq9huVddKLTHNQ46NMBSJau5z0IpCE+zz
         2YXCAcj1w6iFYBsb00uOImxr84oPMPdKj/yWKixAAlYI0bVyY00yrtyWCpyqBrk5WP9Z
         4N6arwxNGXvyyC2JoMGN2EQENPYajWYTB0ggZd0ikNYvVI5FVP6psn4mdmjFnOh1Jf7V
         8nOA==
X-Forwarded-Encrypted: i=1; AJvYcCUe+Gl/gTsh55XtO++g/0Cv2zUE4eILdbR8IZqWiARkkZcv6lunS1YK/8wbeQMPk6vZUD3bF/dynjq+K98AjImDwXyY2KbgmylIuomLEG7Qfg==
X-Gm-Message-State: AOJu0YwkNa4RM0ugvB7TKdTDVuwZqv76zrujYuSlm7emjqeWCoyKhkfj
	9Z0A2R4Ps7+QekRqSH23J8IyQUZI0n62S4euMzYmxYvGp6cl+7B3h3uPWzvTMRfN8BgHNhSzE5I
	Vx06qkg==
X-Google-Smtp-Source: AGHT+IG1WSdS1+smV1Up5m2EVXP2AUrg+zRaNpYStAxrEFYlNxPnjIdOdwoGyFYxYPHniZO20dT94TnYI9+W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3776:680e:8cce:4b93])
 (user=irogers job=sendgmr) by 2002:a05:690c:f0f:b0:673:b39a:92ea with SMTP id
 00721157ae682-67a09d5e1damr1221107b3.7.1722277174921; Mon, 29 Jul 2024
 11:19:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:19:31 -0700
Message-Id: <20240729181931.2870851-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Subject: [PATCH v2] perf cap: Tidy up and improve capability testing
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
isn't supported, to reduce calls or refactor similar to:
https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.org/
---
v2: fix syscall number and '>' should have been '>='

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 11 -------
 tools/perf/builtin-ftrace.c | 44 ++++++++++++--------------
 tools/perf/util/Build       |  2 +-
 tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
 tools/perf/util/cap.h       | 23 ++------------
 tools/perf/util/symbol.c    |  8 ++---
 tools/perf/util/util.c      | 12 +++++--
 7 files changed, 81 insertions(+), 82 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a4829b6532d8..a9517272f80c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1018,17 +1018,6 @@ ifndef NO_LIBZSTD
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
index eb30c8eca488..435208288d24 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -560,6 +560,23 @@ static void select_tracer(struct perf_ftrace *ftrace)
 	pr_debug("%s tracer is used\n", ftrace->tracer);
 }
 
+static bool check_ftrace_capable(void)
+{
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
+		);
+	return -1;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
@@ -569,18 +586,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		.events = POLLIN,
 	};
 
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
-
 	select_tracer(ftrace);
 
 	if (reset_tracing_files(ftrace) < 0) {
@@ -885,18 +890,6 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 	};
 	int buckets[NUM_BUCKET] = { };
 
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
-
 	trace_fd = prepare_func_latency(ftrace);
 	if (trace_fd < 0)
 		goto out;
@@ -1197,6 +1190,9 @@ int cmd_ftrace(int argc, const char **argv)
 	INIT_LIST_HEAD(&ftrace.graph_funcs);
 	INIT_LIST_HEAD(&ftrace.nograph_funcs);
 
+	if (!check_ftrace_capable())
+		return -1;
+
 	signal(SIGINT, sig_handler);
 	signal(SIGUSR1, sig_handler);
 	signal(SIGCHLD, sig_handler);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0f18fe81ef0b..91ce0ab4defc 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -220,7 +220,7 @@ perf-util-$(CONFIG_ZLIB) += zlib.o
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
2.46.0.rc1.232.g9752f9e123-goog

