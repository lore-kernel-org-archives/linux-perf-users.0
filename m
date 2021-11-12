Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A820C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B2A60EC0
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 20:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKLUPT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 15:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhKLUPS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 15:15:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E6C061766;
        Fri, 12 Nov 2021 12:12:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o29so8727380wms.2;
        Fri, 12 Nov 2021 12:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4rIIrsttUsePissnIe88gzATsf5V9UOhpR5a/3h7jI=;
        b=R6FsShsPX/TJC30uAKGfUUwFXkFAfxPJLSfqyM9vMWNT7DwYepXXeUNHxqR7dSow90
         twT58TZA4zL/UG9247mafzKcogYO/FD7tcgjmTn47SBzPWJpNZlK8dFGYQuaYG3Fs39g
         mHRM7EHNoQEKpDfgN9OoQeqXrQ4RiVmWZZY2meS+BpeRQPTGuZ8iy2WjM9DA+Hxrcyhc
         tN7AtcMQpLXsitdl+BcWwWVlcLhJ8PTVQpuQQREDHBTfNFpgvX2hEqgLEy+7YK04900s
         7BxwgVW/tskzQfrTUOINZa6vp5W0g8xD1E+idAQCR11w86a+WB5Th+3k3xixtkzLKpms
         pUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4rIIrsttUsePissnIe88gzATsf5V9UOhpR5a/3h7jI=;
        b=Mp4wT3DLmtf3Du8w3I76vhAImvzI80cgQGzAhTgorM1m26F6u0VVCeUwaD3Z6iZgOc
         NornU4e2PcI54LC1UDiLcbmLVFddHd+ZwCI0zP2Kw6GzNPdFM0cs4pK9NXAW695cVusG
         M1LvzNDQC9FRosl4V+vfq12rw3tjNROoqdRLytRrZZkXT7XvnMUVaILoimmW7V4XOPL8
         Gj2kb42aSBdPOzX7Psmz5b0NrLCb0ngylrs2QmZ/T6kc73Mzqmggpp2iMv0xCm93FR79
         yAwCU1Hhn+fGNnWWMKR9Erszk5gPeanRWdkG1HI/ajBG4l73Ls3xS1tWLwtLbjtHOPSn
         msnw==
X-Gm-Message-State: AOAM5322FD18XPQvDI0m/zuJtNVbzW/lMyqufa0aqumf+J60Oa1A9UVU
        rO/cXJCgxmBh+8saXIXAacY=
X-Google-Smtp-Source: ABdhPJz9DXyIAMh6MLbWWEBujREHpwb2hb+K59ByYhtJVcFHsEQJrMzuru+RTfTIy1CoPTAuUFbYhQ==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr36777721wmm.163.1636747945911;
        Fri, 12 Nov 2021 12:12:25 -0800 (PST)
Received: from localhost.localdomain ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id 9sm8925833wry.0.2021.11.12.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 12:12:25 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, irogers@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf bench: futex: Fix memory leak of perf_cpu_map__new
Date:   Fri, 12 Nov 2021 22:11:33 +0200
Message-Id: <20211112201134.77892-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports memory leaks while running:

$ sudo ./perf bench futex all

The leaks are caused by perf_cpu_map__new not being freed.
This patch adds the missing perf_cpu_map__put since it calls
cpu_map_delete implicitly.

Fixes: 9c3516d1b850 ("libperf: Add perf_cpu_map__new()/perf_cpu_map__read() functions")

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 tools/perf/bench/futex-lock-pi.c       | 1 +
 tools/perf/bench/futex-requeue.c       | 1 +
 tools/perf/bench/futex-wake-parallel.c | 1 +
 tools/perf/bench/futex-wake.c          | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 5d1fe9c35807..137890f78e17 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -233,6 +233,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	print_summary();

 	free(worker);
+	perf_cpu_map__put(cpu);
 	return ret;
 err:
 	usage_with_options(bench_futex_lock_pi_usage, options);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 97fe31fd3a23..f7a5ffebb940 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -294,6 +294,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	print_summary();

 	free(worker);
+	perf_cpu_map__put(cpu);
 	return ret;
 err:
 	usage_with_options(bench_futex_requeue_usage, options);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index e970e6b9ad53..0983f40b4b40 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -329,6 +329,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	print_summary();

 	free(blocked_worker);
+	perf_cpu_map__put(cpu);
 	return ret;
 }
 #endif /* HAVE_PTHREAD_BARRIER */
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 77f058a47790..2226a475e782 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -222,5 +222,6 @@ int bench_futex_wake(int argc, const char **argv)
 	print_summary();

 	free(worker);
+	perf_cpu_map__put(cpu);
 	return ret;
 }
--
2.25.1

