Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BD6C001DE
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Aug 2023 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjHJSt1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjHJStO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2023 14:49:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CB2D40
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 11:49:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so15722577b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693349; x=1692298149;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SDxeH55oFHXGn+t8C3oy42Zu5jtUuaiP7KK6TFKW2c0=;
        b=Ao4oBgW8qijdoB2i5MGmmRMOSZ1CjOQAHsGwhkW76xiSIoEIDHMrR+MtJxhKdbFbqq
         joUtTTpxunlSw4nEgvvm8FhZwh8HuZzSPIqAcWoJ0SvqWrqql1lrGB4nUfJ+p4Shzfeu
         ekCdFOsgh2di5eBHj567IWMk8PVqPu0INi349CgMSZieNkm7WkY4/RYrDj7813uq6It0
         pIsV26dd+6S3sOTYLGhxtbFdLhEkueHvI3/16u+voGOiRVo9ztdzPx9deTZIXBhC/hOu
         bA2Gg+CgpUdoZJRhnhapL8WjIrlMJdFJ3eRBE5ErKFiNQAPElon9km0BeUYTidS3sKzx
         pQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693349; x=1692298149;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDxeH55oFHXGn+t8C3oy42Zu5jtUuaiP7KK6TFKW2c0=;
        b=KWiU5VFoisrwg2xOLiZ2PYtu5oQtv4AIrci6xRxVNUtxeE9z1Cfu3hp9UMHMVH8SHV
         NT1Ic3JiSuV+Lax+egvDtMx+vUAAwXVMoE+zyflq+LHkBZckvN8HksJq06tvHTMLZ2lQ
         jpnqBvGq3negOKBthdCYoOjy9EWxafCdeln4qSs2jF/inyQv11fq2T9yaSWVxcYNPmEe
         hjYdXk6KXw/fJD0t+3ZMCKv8H8qu0QeFPErvza6ZjF6rEYRoizNYF/BKF+2btCAcrcD0
         AsDhXbPCv0Dq2BXwpawZeQfTjJhMdV8pL4IeK/apLt7eot8TN+uYq0OBHGBW9vgBUTfV
         gyDA==
X-Gm-Message-State: AOJu0YzIP0XqHkUj/HIaLoEw/1hT0denvezZk4fhWzRq+gsaI5Oyl63B
        z9B8iHEvIppg3rV2Fgdv5/S+WtPDuSML
X-Google-Smtp-Source: AGHT+IHHQpB5vMizOQcqzLWjuOnZrfW0fJ/MgIu8pihhcpJiyIs5zb+mtIfH4TM53evdRRBkwVYJahwn04d0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a5b:b0c:0:b0:d3d:74b6:e082 with SMTP id
 z12-20020a5b0b0c000000b00d3d74b6e082mr56663ybp.9.1691693349464; Thu, 10 Aug
 2023 11:49:09 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:48:52 -0700
In-Reply-To: <20230810184853.2860737-1-irogers@google.com>
Message-Id: <20230810184853.2860737-4-irogers@google.com>
Mime-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1 3/4] perf bpf examples: With no BPF events remove examples
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        He Kuang <hekuang@huawei.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The examples were used to give demonstrations of BPF events but such
functionality is now subsumed by using --filter with perf record or
the direct use of BPF skeletons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf                   |  5 --
 tools/perf/examples/bpf/5sec.c             | 53 ----------------------
 tools/perf/examples/bpf/empty.c            | 12 -----
 tools/perf/examples/bpf/hello.c            | 27 -----------
 tools/perf/examples/bpf/sys_enter_openat.c | 33 --------------
 5 files changed, 130 deletions(-)
 delete mode 100644 tools/perf/examples/bpf/5sec.c
 delete mode 100644 tools/perf/examples/bpf/empty.c
 delete mode 100644 tools/perf/examples/bpf/hello.c
 delete mode 100644 tools/perf/examples/bpf/sys_enter_openat.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0e1597712b95..a76a2a8f59b7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -962,11 +962,6 @@ ifndef NO_JVMTI
 endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-ifndef NO_LIBBPF
-	$(call QUIET_INSTALL, bpf-examples) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
-		$(INSTALL) examples/bpf/*.c -m 644 -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
-endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-iostat) \
diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
deleted file mode 100644
index 3bd7fc17631f..000000000000
--- a/tools/perf/examples/bpf/5sec.c
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
-    Description:
-
-    . Disable strace like syscall tracing (--no-syscalls), or try tracing
-      just some (-e *sleep).
-
-    . Attach a filter function to a kernel function, returning when it should
-      be considered, i.e. appear on the output.
-
-    . Run it system wide, so that any sleep of >= 5 seconds and < than 6
-      seconds gets caught.
-
-    . Ask for callgraphs using DWARF info, so that userspace can be unwound
-
-    . While this is running, run something like "sleep 5s".
-
-    . If we decide to add tv_nsec as well, then it becomes:
-
-      int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
-
-      I.e. add where it comes from (rqtp->tv_nsec) and where it will be
-      accessible in the function body (nsec)
-
-    # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
-         0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
-                                           hrtimer_nanosleep ([kernel.kallsyms])
-                                           __x64_sys_nanosleep ([kernel.kallsyms])
-                                           do_syscall_64 ([kernel.kallsyms])
-                                           entry_SYSCALL_64 ([kernel.kallsyms])
-                                           __GI___nanosleep (/usr/lib64/libc-2.26.so)
-                                           rpl_nanosleep (/usr/bin/sleep)
-                                           xnanosleep (/usr/bin/sleep)
-                                           main (/usr/bin/sleep)
-                                           __libc_start_main (/usr/lib64/libc-2.26.so)
-                                           _start (/usr/bin/sleep)
-    ^C#
-
-   Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
-*/
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-#define NSEC_PER_SEC	1000000000L
-
-SEC("hrtimer_nanosleep=hrtimer_nanosleep rqtp")
-int hrtimer_nanosleep(void *ctx, int err, long long sec)
-{
-	return sec / NSEC_PER_SEC == 5ULL;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
deleted file mode 100644
index 3e296c0c53d7..000000000000
--- a/tools/perf/examples/bpf/empty.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-struct syscall_enter_args;
-
-SEC("raw_syscalls:sys_enter")
-int sys_enter(struct syscall_enter_args *args)
-{
-	return 0;
-}
-char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/examples/bpf/hello.c b/tools/perf/examples/bpf/hello.c
deleted file mode 100644
index e9080b0df158..000000000000
--- a/tools/perf/examples/bpf/hello.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-struct __bpf_stdout__ {
-	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__type(key, int);
-	__type(value, __u32);
-	__uint(max_entries, __NR_CPUS__);
-} __bpf_stdout__ SEC(".maps");
-
-#define puts(from) \
-	({ const int __len = sizeof(from); \
-	   char __from[sizeof(from)] = from;			\
-	   bpf_perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
-			  &__from, __len & (sizeof(from) - 1)); })
-
-struct syscall_enter_args;
-
-SEC("raw_syscalls:sys_enter")
-int sys_enter(struct syscall_enter_args *args)
-{
-	puts("Hello, world\n");
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
deleted file mode 100644
index c4481c390d23..000000000000
--- a/tools/perf/examples/bpf/sys_enter_openat.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Hook into 'openat' syscall entry tracepoint
- *
- * Test it with:
- *
- * perf trace -e tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
- *
- * It'll catch some openat syscalls related to the dynamic linked and
- * the last one should be the one for '/etc/passwd'.
- *
- * The syscall_enter_openat_args can be used to get the syscall fields
- * and use them for filtering calls, i.e. use in expressions for
- * the return value.
- */
-
-#include <bpf/bpf.h>
-
-struct syscall_enter_openat_args {
-	unsigned long long unused;
-	long		   syscall_nr;
-	long		   dfd;
-	char		   *filename_ptr;
-	long		   flags;
-	long		   mode;
-};
-
-int syscall_enter(openat)(struct syscall_enter_openat_args *args)
-{
-	return 1;
-}
-
-license(GPL);
-- 
2.41.0.640.ga95def55d0-goog

