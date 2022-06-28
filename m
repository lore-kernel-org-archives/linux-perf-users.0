Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F887C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 09:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiF1J7I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiF1J7G (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:06 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BFC2E0A6
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:05 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id t14-20020a056402524e00b0043595a18b91so9159297edd.13
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Sjjp8jJ7/w0ICOZmYCWvjg7GfEBySyn/+1KfIaOHFY=;
        b=RQpMHh1moTKaRIBjxXnduRTRj1+XOs4vQaRansot4504YpMW6JzxCakSHA0ZB4Cbth
         8fE7QYR5gdwuuaesCuj6XqcfWzoDjKmsmgaVQUd9ciCsaFlXLjQc6VaTmcJ3HkDwTkCz
         lOzuMdxSDRGinWsvPnlsnskh/2yJjhaHqEUVX8Gz1KwncT77mu6T69CeJ3IHvSJcRCvX
         nH9J/YmoHWMI0HlmqnbB1Mr1kCY3tLb/zQaeGzLuHfAt6JljFU2hCl0oBIAG6AyvE7rU
         WE53JOuwEcSvVKQkeW0RqqwgqUTloh7LaQJOmf46hlOvJ76Ol3QtEYr4vWDHFDTWSw58
         K/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Sjjp8jJ7/w0ICOZmYCWvjg7GfEBySyn/+1KfIaOHFY=;
        b=Q5o1wVBodEDxdM7klkUb0jc+YBXtwJ6gJLmZchw9uzDkrnyuOKkh3pLMEzkZQxtz2j
         jySNOoPXTmRnaMyaztQdz47Nflu3VKGnRFKNfeEt06RETalu9mE5o4uZmC/j6pYGlCos
         YSgGZuV5VUI8X6rOLyJFYCCetopZEe6IKyEMn3ZmDuv6NsyXRxv8t7/+RAsslnFXKSuM
         zK4VNQVmfxw57D2G311SQfWRqHTT6ZvkYf3EMkgcqvq5bW1CD/9t9a+7wAyXGx+AXLJD
         aICz0j5g/I73Hb05bin62ETlrf4M79L+Wuuca2r+tEyCYxGXzbhqUEHtrmRHNyxCvPG2
         4PoQ==
X-Gm-Message-State: AJIora/G/p77g9kr8nwFYCsMDwXGVYylx1w2OlMCTEdtCeaAGR0g/QxQ
        +R8m1w81Y5R5/tVrvL7W5KQEvzw7fQ==
X-Google-Smtp-Source: AGRyM1sFuMxPEYN4PW/X/08GhQyD29MIQ2ajj7eQl0T18mWtYdHFG3Mm0EGUOshAqjgz3PRkgvonVGYROw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a05:6402:1386:b0:431:6911:a151 with SMTP id
 b6-20020a056402138600b004316911a151mr22335610edv.105.1656410343984; Tue, 28
 Jun 2022 02:59:03 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:22 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-3-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 02/13] perf/hw_breakpoint: Clean up headers
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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
---
v2:
* Move to start of series.
---
 kernel/events/hw_breakpoint.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index f32320ac02fd..1b013968b395 100644
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
2.37.0.rc0.161.g10f37bed90-goog

