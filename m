Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E8C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jan 2022 22:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbiAFWUf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244435AbiAFWUf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jan 2022 17:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641507634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GyovoCuLjjHHt9QM/ZJ1ih4ScrXqH+W+bjbDOcUozq8=;
        b=Spd0XgOPY7I6nM8++0CAOU/jTrKWRRCYthP3KJ/1DEvPRaEJjVkeo9B8DHB9gMW9WLZMCl
        2011LgNm1LTw4Sq0JzIOdVHZfgULEN32U1kbYsjKi2f2tDqU3Aj1K71AulDWR/qTxQMuXe
        w7fyahvE5QZOvVySHv1AwyQ0mH89teo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-ElsucRPNOYmgbNXOcpoAcg-1; Thu, 06 Jan 2022 17:20:33 -0500
X-MC-Unique: ElsucRPNOYmgbNXOcpoAcg-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so3600088wms.7
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jan 2022 14:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyovoCuLjjHHt9QM/ZJ1ih4ScrXqH+W+bjbDOcUozq8=;
        b=2naN5Ti7rFhCLI4UUWGbCxge1La7aqH/6TWuEqBUUPdFULlUpWhLHQY1HU5A0gJ/12
         a4/71s1RIIFQ8zRzbxeeonwT7qE1JFelpy2xymp9g9prbKogXAOQogi0CMczOtx9+Bf5
         UZTacmZESs6TTCkzYkZkjfU7mEop4ygYMqLAWXSym5VKjFNzY0MYxJiVE3D8xIWhkZTP
         oo05373MBAkHKDQsL0DjIjny3QscwZKxnSifCfnzIk3zB19RaOka8ilIaWQneifdpk8d
         ErZAgROlVgghbFPUJDYaBFBqyaYn0bteWTcS7zmWY2u8LCZlmfh7yIV9g/tpWkhAJY/2
         d5kQ==
X-Gm-Message-State: AOAM533k3Q5PM3zaFFpN0GgJsAlD9SzeABPqdqvidxFchpOedqlKJlMT
        v6iIdtzVFYTAMCbFLrJDb4GySCNtQdLs++1M+e+jEKakY07A8HpSQlthlxLJdi81FCHExphCw7C
        7ORx6Nqc7SbXU1ks8EkV4Bw+5yD/PUw==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr8769269wmk.76.1641507632106;
        Thu, 06 Jan 2022 14:20:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXYxtoAPX07hgPRDdhYyGPJM8/IYHeoCGK/503A3m4aTKkHkgY4kBBl4cGOPR9eroZ8W0fPg==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr8769251wmk.76.1641507631889;
        Thu, 06 Jan 2022 14:20:31 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id n12sm3668066wrf.29.2022.01.06.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:20:31 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Christy Lee <christyc.y.lee@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf trace: Move SIGCHLD handler init to trace__run
Date:   Thu,  6 Jan 2022 23:20:30 +0100
Message-Id: <20220106222030.227499-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When running perf trace with bpf object like:
  # perf trace -e openat,/.../tools/perf/examples/bpf/hello.c

the event parsing eventually calls llvm__get_kbuild_opts function
that runs script and that ends up with SIGCHLD delivered to perf
trace handler, which assumes the workload process is done and quits
perf trace.

Moving the SIGCHLD handler setup directly to trace__run, where the
event is parsed and object already compiled.

Cc: Christy Lee <christyc.y.lee@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 94d62a92f1a1..4282ef9ec354 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3925,6 +3925,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	bool draining = false;
 
 	trace->live = true;
+	signal(SIGCHLD, sig_handler);
 
 	if (!trace->raw_augmented_syscalls) {
 		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
@@ -4876,7 +4877,6 @@ int cmd_trace(int argc, const char **argv)
 
 	signal(SIGSEGV, sighandler_dump_stack);
 	signal(SIGFPE, sighandler_dump_stack);
-	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
 
 	trace.evlist = evlist__new();
-- 
2.33.1

