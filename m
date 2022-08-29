Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2815C64991
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiH2M46 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiH2M4Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:25 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234C7170C
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 05:48:08 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id sg35-20020a170907a42300b007414343814bso1482203ejc.18
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=Xnrbr4NWXpH3ILMfaL+Hqy6Mh/173nAe6Rh4Ql+SwwA=;
        b=aoWdQSkdpteyXmYAo1c6eiVE2udp1iPCkTbGD3cqc5tyTEc5w9TDE5eQ2pH/aC5ONx
         wvITjNHuqGva9IIaS4Jy/kRGfM87daq+ZT24dKaI5knatHyVNPce7SKxJrvTIxK+jpRV
         T+oUK6JwmqGiqfWOw+qZfCjfKSncTUyCL/rTKrD/R/uwr1cZQDo2BiYCLIVtBSK8KpsZ
         CLE54Tvl9hptOey0GrB4CQxeXWFE0oHlZwm2u/7tiypSnfTXu/PJqf5/FBc4ceMvlGJj
         bS8z75PhngVBIBAZf6h+e4wkxi/WQq7RrV8yo3ue7h3N/zwN5y8SZVpJk5+wDM79X8yf
         2pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Xnrbr4NWXpH3ILMfaL+Hqy6Mh/173nAe6Rh4Ql+SwwA=;
        b=wA+jIHkxPG24gPPSgm2Q6/cQFejkum1/48K4XVYSbYMVkFgZZn3No2E9yeeBdgGN09
         rzPtcoTW4TV0LLLxEkhEwzeuhybuJTNnDvAi9sUNrHTHs5f1omekQi3gupO9dj8DnIaV
         g30FQ6sazSI4CHtO1RP6/ga5d0FGKzUOTaql3Ei7G/FWXdlKr6N51qZrr3meMtOmWQBo
         yyt8w6FsPvs1RIie8UJTnFxm3SY08Rt5jBPs0+JbI8UPiT3ixn6tGBpeic2fyjpDD366
         iDcUI4xqQ+sFHTxxmHThsZXRHJR0Mgf6m9BGW4ZXRLqV0tYWDvfpMZ84bJxxz+qJeajL
         wVDg==
X-Gm-Message-State: ACgBeo1+uEDZr09zPXi0ki2OJTIPJK01tZ224G19NXEVhXsNa36HcJOl
        elHkhfuYV1DBNPbF6fuCS401BCPkJw==
X-Google-Smtp-Source: AA6agR42dMVaiS+cJuLOtzyugHi3iaDb9VrUvxxRA/60qGgLveidvAmI7LaoSF8LrpwtVNgvbP26lurGuA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:aa7:c946:0:b0:43d:3038:1381 with SMTP id
 h6-20020aa7c946000000b0043d30381381mr16380942edt.354.1661777286713; Mon, 29
 Aug 2022 05:48:06 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:08 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-4-elver@google.com>
Subject: [PATCH v4 03/14] perf/hw_breakpoint: Clean up headers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Clean up headers:

 - Remove unused <linux/kallsyms.h>

 - Remove unused <linux/kprobes.h>

 - Remove unused <linux/module.h>

 - Remove unused <linux/smp.h>

 - Add <linux/export.h> for EXPORT_SYMBOL_GPL().

 - Add <linux/mutex.h> for mutex.

 - Sort alphabetically.

 - Move <linux/hw_breakpoint.h> to top to test it compiles on its own.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v2:
* Move to start of series.
---
 kernel/events/hw_breakpoint.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fd5cd1f9e7fc..6076c6346291 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -17,23 +17,22 @@
  * This file contains the arch-independent routines.
  */
 
+#include <linux/hw_breakpoint.h>
+
+#include <linux/bug.h>
+#include <linux/cpu.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/irqflags.h>
-#include <linux/kallsyms.h>
-#include <linux/notifier.h>
-#include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
-#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/bug.h>
 
-#include <linux/hw_breakpoint.h>
 /*
  * Constraints data
  */
-- 
2.37.2.672.g94769d06f0-goog

