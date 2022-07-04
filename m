Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F6C43334
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiGDPGS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiGDPGH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 11:06:07 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8A101D5
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 08:06:05 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so7412484edc.15
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CJh9nArzdKDvJ+iA1QR7bBHoipxrgc/zo0qPPTGYcZY=;
        b=rSsD/r2qs6OJJi8z0M9FDZLGkHAZGRAv/2iygM2Npml6bURRT2zzlrkokzKUTzF53M
         0uNT+MmX43yhsm8WlEQTiFFVDQORwKM3SbgJjOQTugcMQ5zZxJ5+rO7jKh2Rk6Q0mE6D
         HG7FYoCv03lv6k4/UDJMxG21xceFZTCBMFa9ATDldsD26PL2tPFHXHIsAb9eiaaMtONM
         6jJHEGoFNKDNnQvdJBQYvuHv5nwivY7BfDz+f2lQzIGkZiq4Em9sBZ+2f68ExlDrs/jW
         DMVZ2udkpcF81KuJofszuEFyvAOuj4RsGW4UOY/geZxqVAPwZD/7NRDTPlCR5Krjorm+
         D0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CJh9nArzdKDvJ+iA1QR7bBHoipxrgc/zo0qPPTGYcZY=;
        b=E3k3V8qvQw0ONywJPNeDdRAm/iee2HOxMBarmMa5nGPKxXva525PNpW6E0Ju0XmX1m
         YlZLuxXrvGXTr9RmOV/xEU/wQYpZ2iDy/2OBJoL1Uz6GSWgzRn/WPdfQi9pFA7rE5LSV
         +ma0YuQ3DfNbcYgJJi0AmFayccIjHKXZ6TkjisIIlmRJkeUO+hJgP1kqo5YZi+Z8XggH
         0xl2ci6EJEz+Ri21PIDnpjEYTfs5gShXV0NLm+RciCHm+GdxRklmItXcBzniqbFS/VSM
         57FtLdSYmcAhUXqUg/PHrxl+t3vD966Drtav7Eprlym0vsDr2DjUgtJUT7eW3FtL89tA
         rf2w==
X-Gm-Message-State: AJIora+633RAPudawnAJpLouloEg9XKXPgH+8s4CoKTps2DoQ664sIgB
        s4rFKXmhM4u7tVE1jNV/vk7/L5o0Rg==
X-Google-Smtp-Source: AGRyM1svWag9OLn9yzYcELWRbfTc1Dah/9HaaTehHww+9DZEXEHQi38e6VRE1jGA8IrZ+CcRyZuqY4n6DQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a17:906:11d:b0:712:abf:3210 with SMTP id
 29-20020a170906011d00b007120abf3210mr28767207eje.292.1656947164230; Mon, 04
 Jul 2022 08:06:04 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:03 +0200
In-Reply-To: <20220704150514.48816-1-elver@google.com>
Message-Id: <20220704150514.48816-4-elver@google.com>
Mime-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 03/14] perf/hw_breakpoint: Clean up headers
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
2.37.0.rc0.161.g10f37bed90-goog

