Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE01C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9566120D
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 17:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhI1R6O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241520AbhI1R6N (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 13:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD5C460FF2;
        Tue, 28 Sep 2021 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632851794;
        bh=YdEI7Bqrro9bDQO4y5JLhhRKWf6HiLH8T6YQwDBQ1lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlJAgl38ZCcpdRshnTlkbAZ+qTClDGjH9lbbN87z5US+q8fXuoDjX2ASHWFO8cfPh
         PJxe7bpIMNLVHRUHx/Md/NqkFraNe+Doo5f2oxx7nwQ/sxaZR/gna4Js7lLffDKS1a
         3hc5AkX5sbAhW9xtNv3zvXc0vcT2JpTuBYi/qMxjQWhtBu7+aEnx8qUAXpOPFfR/ek
         O0euJqAsyv9/ZE3Ymm/JmR1mWMkzX5icPzFzdS2br0eDfhOTc/c7KLlzDNiJ209/UG
         nGm9KFc8Mon59seYPxNtdpaMsUAF5KgVCC+HbCjd35ON0Fd1O56ZLc1ox8vpKQ3kTY
         alUBfDFM8Hxeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35318410A1; Tue, 28 Sep 2021 14:56:30 -0300 (-03)
Date:   Tue, 28 Sep 2021 14:56:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
Message-ID: <YVNXTuq1PpLpMH/R@kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
 <c547bc2d-ab7c-1e89-5d12-bd5d875f7aa5@huawei.com>
 <YVMVwDt3QHBPfT/T@kernel.org>
 <YVMXHM0F/y2ptX8C@kernel.org>
 <3949dfa2-d684-47af-ffa7-71b07141f64d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3949dfa2-d684-47af-ffa7-71b07141f64d@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 28, 2021 at 02:32:02PM +0100, John Garry escreveu:
> On 28/09/2021 14:22, Arnaldo Carvalho de Melo wrote:
> >   jevents-y      += json.o jsmn.o jevents.o
> > -HOSTCFLAGS_jevents.o   = -I$(srctree)/tools/include
> > +HOSTCFLAGS_jevents.o   = -I$(srctree)/tools/include -Wall -Wextra
> >   pmu-events-y   += pmu-events.o
> >   JDIR           =  pmu-events/arch/$(SRCARCH)
> >   JSON           =  $(shell [ -d $(JDIR) ] &&                            \
> > ⬢[acme@toolbox perf]$
> > 
> > I get this before applying Xu's patch:
> > 
> >    LINK    /tmp/build/perf/libbpf.a
> > pmu-events/jevents.c: In function ‘save_arch_std_events’:
> > pmu-events/jevents.c:473:39: warning: unused parameter ‘data’ [-Wunused-parameter]
> >    473 | static int save_arch_std_events(void *data, struct json_event *je)
> >        |                                 ~~~~~~^~~~
> > At top level:
> > pmu-events/jevents.c:93:13: warning: ‘free_sys_event_tables’ defined but not used [-Wunused-function]
> >     93 | static void free_sys_event_tables(void)
> >        |             ^~~~~~~~~~~~~~~~~~~~~
> > 
> > 
> > -------------------------------------
> > 
> > I'll add this to perf/core, as this isn't a strict fix, so can wait for
> > v5.16.
> 
> Hi Arnaldo,
> 
> OK, would you also consider reusing CFLAGS:
> 
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -9,10 +9,12 @@ JSON          =  $(shell [ -d $(JDIR) ] &&
> \
> JDIR_TEST      =  pmu-events/arch/test
> JSON_TEST      =  $(shell [ -d $(JDIR_TEST) ] &&                       \
>                        find $(JDIR_TEST) -name '*.json')
> -
> +HOSTCFLAGS_jevents += $(CFLAGS)

Humm, we have to check if CFLAGS doesn't come with cross-build options,
i.e. IIRC we have to use HOSTCFLAGS instead. Unsure if there is some
*CFLAGS variable that gets the common part, where these -Wall and
-Wextra, -Werror could go.
 
> I tried it, and there are more things to fix for jevents.o. Let me know your
> preference and if any help required to fix any errors up.

I fixed the one I found, see below, I'll test build what I have in
perf/core and push it, then you can continue from there, after checking
this HOSTCFLAGS/CFLAGS issue.

- Arnaldo

From 0e46c8307574a8e2dac8d7ba97e0f6f4bbee67a5 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 28 Sep 2021 14:15:01 -0300
Subject: [PATCH 1/1] perf jevents: Add __maybe_unused attribute to unused
 function arg

The tools/perf/pmu-events/jevents.c file isn't being compiled with
-Werror and -Wextra, which will be the case soon, so before we turn
those compiler flags on, fix what it would flag.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
To: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 6731b3cf0c2fc9b7..323e1dfe2436c049 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -45,6 +45,7 @@
 #include <sys/resource.h>		/* getrlimit */
 #include <ftw.h>
 #include <sys/stat.h>
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
@@ -470,7 +471,7 @@ static void free_arch_std_events(void)
 	}
 }
 
-static int save_arch_std_events(void *data, struct json_event *je)
+static int save_arch_std_events(void *data __maybe_unused, struct json_event *je)
 {
 	struct event_struct *es;
 
-- 
2.31.1

