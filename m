Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7DC43219
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Nov 2022 12:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiKKMJt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 07:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiKKMJs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Nov 2022 07:09:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0BDF4C
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Nov 2022 04:09:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j12so4104426plj.5
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Nov 2022 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s08YO+rPBtB2uwv5IJoOR+YbywlIrwvyXquHPxbqQy4=;
        b=wasi9M2E49zmc8HflupPJNJX5BOmd2HA+06pH/USFgAM0KLcYG99l21PRZKLEgKcra
         jFNwx7+tVkwsLkBE4hN9Q3f99EDBwjEvJZN34raW4fmp4ud7gNy3iMoiLXuYMS/VR3hv
         oBSvnUauT4yeROtVjXG6dkHKH3bJh3R6ZJMhOr1odUsIhtCvEV3sJrIfS0IqGOrtGm+M
         YS86+6HFQoKkghzN1ri6Pp5vvF8SsdunwDzkhoHHN0rPYtRYliVmwXefESGRdYMh8Kfp
         hu9CTkyLFwuN3CEXVb6GHX/3yuJEgs44zZEu23KZzsDncrixneN5TMrsdnQ6tf+OJE27
         viNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s08YO+rPBtB2uwv5IJoOR+YbywlIrwvyXquHPxbqQy4=;
        b=soHc1tDJwfuB29Det0Hud5wgctCqW1tyT6qrCCYaVVsNuqK1GOVN4Y9+lAcXQ2fS6r
         07MGHCYYharZgKjTu5cp+o8oLnJIE7/gzuxvU7Im2lg6dzkhTJSAaL1T6V83f/cwKF2d
         eWncq5n8Y9qMWx9VrdL6OiOEt/v7pfxuqrVUR0VgR0f8Cy4Z57f74W5l9eHSWU4gzcAD
         cEjyjnMcfHHjuwZJqsWBiSB3vMxiiVl+m6fH450XF6fDGXQl2bV8E7I4wyPIBplPoVDM
         xuld9hTw67FCmrC13LOdl07v9lvpv+mYgp9n37ZRq85zs9HhXfF1GpMrw37Bc+ZBbA++
         znnw==
X-Gm-Message-State: ANoB5pmBcc8pmZIy8v9ZZbVNEgDGo2vpcAjlRRAvNNoDAYvdusFjqdgl
        czzM+eOORutSHFX2tLNls6tv4A==
X-Google-Smtp-Source: AA0mqf6rpQlgVdwVPyESpUxSQWjA5DMRtVgmrD4pFlVUaKBVHikeqFObg/7efwTHDzbZ/ttmPse5eg==
X-Received: by 2002:a17:902:b711:b0:186:a3a0:601c with SMTP id d17-20020a170902b71100b00186a3a0601cmr2265120pls.105.1668168586808;
        Fri, 11 Nov 2022 04:09:46 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id mp14-20020a17090b190e00b0020ae09e9724sm1453408pjb.53.2022.11.11.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 04:09:45 -0800 (PST)
Date:   Fri, 11 Nov 2022 20:09:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/7] Fix perf trace libbpf 1.0+ compatibility
Message-ID: <Y247VY99skmc1wRk@leoy-huanghe.lan>
References: <20221103045437.163510-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian, Arnaldo,

On Wed, Nov 02, 2022 at 09:54:30PM -0700, Ian Rogers wrote:
> Perf trace can augment system calls with a BPF program passed as an
> event. The BPF code for this lives in examples. This patch fixes the
> example code to not used deprecated/removed APIs in libbpf. As libbpf
> has similar header files to tools/perf/include/bpf the code is
> transitioned to use the more standard libbpf code and the perf BPF
> header files removed.

I think you missed to update the code examples/bpf/sys_enter_openat.c,
either you could remove it (since it's duplicate with
augmented_raw_syscalls.c), or we should apply below fixing:

From f30af3b43060e482c54e113cbe90223173c69abd Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@linaro.org>
Date: Fri, 11 Nov 2022 12:02:24 +0000
Subject: [PATCH] perf trace: sys_enter_openat.c fix libbpf 1.0+ compatibility

Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
headers.

With fixing:

  # ./perf trace -e examples/bpf/sys_enter_openat.c
  0.000 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
  1.596 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
  1.832 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
  1.864 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/examples/bpf/sys_enter_openat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
index c4481c390d23..8edfa7c147d1 100644
--- a/tools/perf/examples/bpf/sys_enter_openat.c
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -14,7 +14,9 @@
  * the return value.
  */
 
-#include <bpf/bpf.h>
+#include <linux/bpf.h>
+#include <linux/limits.h>
+#include <bpf/bpf_helpers.h>
 
 struct syscall_enter_openat_args {
 	unsigned long long unused;
@@ -25,9 +27,10 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+SEC("syscalls:sys_enter_openat")
+int syscall_enter_openat(struct syscall_enter_openat_args *args)
 {
 	return 1;
 }
 
-license(GPL);
+char _license[] SEC("license") = "GPL";
