Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39364A99C9
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364154; cv=none; b=s87w6Jjptdsqcy96KZ4O9VhYY7K+tAYqFRv7oO1739CZKrDTycZ5/bEi5T3Qsy/IgjDHWTa7DicFngI7c17o8V2U6CwEmohN1WUBd9tyPbEKUl2kKVy/G5E2zN4l+8zoMnEgkTvTRZdrXHyHdHlmwAIbRk8yqO39WYLX02/OT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364154; c=relaxed/simple;
	bh=hcb+YsYktGD5DAT9O/TDu5c3+MGTfAHeFGUSy/g2LNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cvVwrZxxuYNsY0vWisAC6cd001V6hHYKkRNTlBX73bgR7lCoRHXads5lUcirVd0AI+rMptUalljyDV2JXLv7DOUHKiKeopuHzSR01lGMVgsHeX5nAPIHMbIBjTcwWx/L+qOqPzUhXtSb6bPKfTFgeTgXWFHh5Pqmtp59Lz9wh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9Ab7Jex; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9Ab7Jex"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2824684a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364152; x=1788968952; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDA7hQcC28A9PrfAF9PzfBXNfTQslOisMIggbz4Lwoc=;
        b=D9Ab7JexvAClT5ihXA1mVbn/UnLd7YLVsrc3SpA+iING8+FHs6atajArs86+SEGrJM
         nT7tFh6s600aCcOmHVe4Tv7R/xk86+Nmlz+rEAeM3MY6r6kfcqzaETz/089pmqhci0kh
         Calh9RRcMHDnAQrr7qp64Aba0qkmS4wFcfSHVOQ/m0bq+y1G2EtKC2qZPKwKVHxv2sad
         dwmuMwe78YcMfZlIeS4r1pL35WVyD+NmTGDlFzW8Gj39iczcWi9FCxxRT5BDeo5ghHsO
         20eQIo4rx6Ja1SvOBp8cTKtlC2vou9wr8xzLqcbHPIsF/MdTBxdeNdnny807SMcFrqBj
         Fkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364152; x=1788968952;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDA7hQcC28A9PrfAF9PzfBXNfTQslOisMIggbz4Lwoc=;
        b=j26SL+s248zExdehQdrVKbwjL155Nqia5jUQzpnkh6C1Byk4WlrxbVW5svYWq7p42u
         DSQW3clNTZhdkdtW3gs5VSofGZwqipoEUyHtLHul+OtrJPg3CPCUpvAIa2aqytwHa+6Q
         dxURktFlThc9B+kdZS5+xNXE9CTdIQpUBIWDk2NU7PN8CBnKqUW6E15IPXFGPaszLCVx
         /2CjAURgVHXo6FoZ4+gHJE3oFWQqahC6/tvVxHRMEuGOXhfZSrnDjeodD6RHdHR3rzpF
         E5iJUE2u/pnVfGwlTy8/IPdIuv/6UG26xmlhGXheADNPly5DIL+jeVEyMIhknU+Vg2mb
         sPgw==
X-Forwarded-Encrypted: i=1; AKwUvBynDmyAA2RoX3g9LEyhb+G73UYmix8CzO4spCYrMVCkNCKZ8V9YxSv6JYBbqSyHgKKDg+Ym03QetT39rUJ2oP5b@vger.kernel.org
X-Gm-Message-State: AFuF++lM39zp8r6MKetb6q4zvQNcXryC+i4DupeF8A7eMr7vZ+Aw1+t7
	lV7NH8ws8+PSsZ2Sbh2ItVBJciS4yl+E84nKoVd4tnvLGetLQGu9i7SLbY6bmennr3C3XCBLHBt
	GzRWF6bbH4w==
X-Received: from dlag8.prod.google.com ([2002:a05:701b:2508:b0:141:4a59:5b22])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2785:b0:398:9be5:b41e
 with SMTP id 98e67ed59e1d1-39aee285570mr9664000a91.25.1788364151428; Wed, 02
 Sep 2026 08:49:11 -0700 (PDT)
Date: Wed,  2 Sep 2026 08:48:57 -0700
In-Reply-To: <20260902154858.2078885-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902154858.2078885-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902154858.2078885-6-irogers@google.com>
Subject: [PATCH v3 5/6] perf tool: Add fallback stubs for missing dependencies
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

Declare stubs directly inside perf.c for commands that have library
dependencies sometimes omitted at build time, such as libtraceevent
(timechart, sched, kmem, lock, trace, kwork) and libelf (probe).

By unconditionally including these commands in the commands[] array,
users will receive a clear, unified warning indicating the missing
dependency instead of the command silently being absent.

Running `perf trace` with libtraceevent missing. Before:
```
perf: 'trace' is not a perf-command. See 'perf --help'.

Did you mean this?
        ftrace
```

After:
```
'trace' command not available: missing libtraceevent devel package at build time.
```

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/perf.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 65bdfd71f626..6c5baa285b13 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -7,6 +7,7 @@
  * perf top, perf record, perf report, etc.) are started.
  */
 
+#include <linux/compiler.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -53,6 +54,38 @@ static void __noreturn usage(const char *err)
 static int use_pager = -1;
 static FILE *debug_fp = NULL;
 
+
+#ifndef HAVE_LIBTRACEEVENT
+#define DECLARE_LIBTRACEEVENT_STUB(_cmd) \
+	int cmd_##_cmd(int argc __always_unused, const char **argv __always_unused) \
+	{ \
+		fprintf(stderr, \
+			"'" #_cmd "' command not available: missing libtraceevent " \
+			"devel package at build time.\n"); \
+		return -1; \
+	}
+
+DECLARE_LIBTRACEEVENT_STUB(timechart)
+DECLARE_LIBTRACEEVENT_STUB(sched)
+DECLARE_LIBTRACEEVENT_STUB(kmem)
+DECLARE_LIBTRACEEVENT_STUB(lock)
+DECLARE_LIBTRACEEVENT_STUB(trace)
+DECLARE_LIBTRACEEVENT_STUB(kwork)
+#endif
+
+#ifndef HAVE_LIBELF_SUPPORT
+#define DECLARE_LIBELF_SUPPORT_STUB(_cmd) \
+	int cmd_##_cmd(int argc __always_unused, const char **argv __always_unused) \
+	{ \
+		fprintf(stderr, \
+			"'" #_cmd "' command not available: missing libelf " \
+			"devel package at build time.\n"); \
+		return -1; \
+	}
+
+DECLARE_LIBELF_SUPPORT_STUB(probe)
+#endif
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **);
@@ -76,36 +109,24 @@ static const struct cmd_struct commands[] = {
 	{ "report",	cmd_report,	0 },
 	{ "bench",	cmd_bench,	0 },
 	{ "stat",	cmd_stat,	0 },
-#ifdef HAVE_LIBTRACEEVENT
 	{ "timechart",	cmd_timechart,	0 },
-#endif
 	{ "top",	cmd_top,	0 },
 	{ "annotate",	cmd_annotate,	0 },
 	{ "version",	cmd_version,	0 },
 	{ "script",	cmd_script,	0 },
-#ifdef HAVE_LIBTRACEEVENT
 	{ "sched",	cmd_sched,	0 },
-#endif
-#ifdef HAVE_LIBELF_SUPPORT
 	{ "probe",	cmd_probe,	0 },
-#endif
-#ifdef HAVE_LIBTRACEEVENT
 	{ "kmem",	cmd_kmem,	0 },
 	{ "lock",	cmd_lock,	0 },
-#endif
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#if defined(HAVE_LIBTRACEEVENT)
 	{ "trace",	cmd_trace,	0 },
-#endif
 	{ "inject",	cmd_inject,	0 },
 	{ "mem",	cmd_mem,	0 },
 	{ "data",	cmd_data,	0 },
 	{ "ftrace",	cmd_ftrace,	0 },
 	{ "daemon",	cmd_daemon,	0 },
-#ifdef HAVE_LIBTRACEEVENT
 	{ "kwork",	cmd_kwork,	0 },
-#endif
 };
 
 struct pager_config {
@@ -514,15 +535,9 @@ int main(int argc, const char **argv)
 		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
-#ifndef HAVE_LIBTRACEEVENT
-		fprintf(stderr,
-			"trace command not available: missing libtraceevent devel package at build time.\n");
-		goto out;
-#else
 		setup_path();
 		argv[0] = "trace";
 		return cmd_trace(argc, argv);
-#endif
 	}
 	/* Look for flags.. */
 	argv++;
-- 
2.55.0.966.g6673acef38-goog

