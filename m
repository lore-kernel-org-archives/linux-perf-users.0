Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58DAC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01BE61355
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 17:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347379AbhESRCU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhESRCU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 13:02:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7667960FDA;
        Wed, 19 May 2021 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621443660;
        bh=+oMyyltNPd293RAoHCp/DTPyCnY+xzdlyUw8EWvB7yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzZlLBaSaOlNg7s7KBfQlEL2eNOeE0dCCaqEl46jiZmzOvg1kuTc/WVuWzPLW8zSi
         CfHk/+iPgwi2cqAI1U/uY92rc/m1mW4tp1XLiq+do5RGLgJ4fiOMqjuu2eM9DOt1RN
         ejnJre5GkVdGrdhEMlxOsq5TVtRAj2sM1GM16yVU3jDk3Qjy9PUf09+jdWcAbqi9Yy
         qAJCYknyxN4EKVMi2pcuCuuTbW6lZI1ErryUnNP3aj2sfCzXfbK/z8Jd/ZlcvC9wuy
         9QeLGLh6BgojPpneAzlT8KeHNBXxfBaUaHreiONFwxM4ek4P3Um9/Czt86QHeaZcf5
         nBpfZ+83sS6Kg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99A2C40DC6; Wed, 19 May 2021 14:00:56 -0300 (-03)
Date:   Wed, 19 May 2021 14:00:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     sumanth Korikkar <sumanthk@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: perf list dumps core using 5.13.0.rc2
Message-ID: <YKVESEKRjKtILhog@kernel.org>
References: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
 <YKU8L/v7BDobrzBb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKU8L/v7BDobrzBb@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 19, 2021 at 01:26:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 19, 2021 at 04:57:05PM +0200, Thomas Richter escreveu:
> > Using kernel 5.13.0.rc2 command perf list dumps core on my x86
> > virtual machine:
> > 
> > [root@f34 perf]# ./perf list
> > Segmentation fault (core dumped)
> > ^C
> > [root@f34 perf]#
> > 
> > The root case this this change in file ../include/uapi/linux/perf_event.h:
> > enum perf_sw_ids {
> >         PERF_COUNT_SW_CPU_CLOCK                 = 0,
> >         ...
> >  --->   PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
> > 
> >         PERF_COUNT_SW_MAX,                      /* non-ABI */
> > };
> > 
> > This change increases PERF_COUNT_SW_MAX to 12. However this
> > change is not reflected in file util/parse-events.c where data structure
> > 
> > struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
> >         ....
> > }
> > 
> > is defined and it misses the symbol name and alias for this new software

Please check and provide your Acked-by or Reviewed-by,

Thanks,

- Arnaldo

From f8b0fe090267a901aa30070351b40f5e8abc0286 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 19 May 2021 13:50:31 -0300
Subject: [PATCH 1/1] perf parse-events: Check if the software events array
 slots are populated

To avoid a NULL pointer dereference when the kernel supports the new
entry but the tooling still hasn't added an entry for it.

This happened with the recently added PERF_COUNT_SW_CGROUP_SWITCHES
software event.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dad14265b81dfb8..8c5df56121d85cb2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2928,9 +2928,14 @@ void print_symbol_events(const char *event_glob, unsigned type,
 	}
 
 	for (i = 0; i < max; i++, syms++) {
+		/*
+		 * New attr.config still not supported here, the latest
+		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
+		 */
+		if (syms->symbol == NULL)
+			continue;
 
-		if (event_glob != NULL && syms->symbol != NULL &&
-		    !(strglobmatch(syms->symbol, event_glob) ||
+		if (event_glob != NULL && !(strglobmatch(syms->symbol, event_glob) ||
 		      (syms->alias && strglobmatch(syms->alias, event_glob))))
 			continue;
 
-- 
2.31.1

