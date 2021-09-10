Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E3C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CC4611BF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 20:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhIJU73 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhIJU72 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 16:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96EEC611B0;
        Fri, 10 Sep 2021 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631307496;
        bh=l5Ivykoso88H+KKCpsO0QyRS8W6t/eGHvvPwWtnaN3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX+/WD5PnnbGQSDV5JYDRBXg8HcRFbghVzE2DCa4VzoVS/HKY/o4mK0+nugQjlTCU
         hOOrTImtX0M646Rw8NOHLGIMBmFZbbAJUzLu9H4Jy17itwE7Ele908tVOzElRy1Zn/
         58kbdIE2StD31dXxtc95j87MPZEAuVe84Gbd9FIAqSosqxPVD6IX3pVnlOGewMnz+K
         pZd8ku6odDeW+g93uuK1ch7Ew9w67PS427h8wO6ZByPsco6rQuRUU1EGC2jAtnTYoq
         kum5YheM4egBejhAY6UOnTf2RD+LO9yDzSyFAfLcyk+48EG+ONvdvNedctkS5apERU
         zi14m7tLn+7/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2799E4038F; Fri, 10 Sep 2021 17:58:14 -0300 (-03)
Date:   Fri, 10 Sep 2021 17:58:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Another bug: Re: [PATCH 0/3] perf report: Add support to print a
 textual representation of IBS raw sample data
Message-ID: <YTvG5ndtSQtRHte2@kernel.org>
References: <20210817221509.88391-1-kim.phillips@amd.com>
 <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
 <YTth5DLWGbyAzxvQ@kernel.org>
 <YTtmwrZ6iy0TzG3l@kernel.org>
 <YTtnpAcaCNYozoJF@kernel.org>
 <YTto5xw/XSMuiGrG@kernel.org>
 <YTu2mu6a4lkx92ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTu2mu6a4lkx92ee@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 10, 2021 at 04:48:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> All the cross builds are failing:
> 
>   28     9.20 debian:experimental-x-arm64   : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
>     util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
>        12 | #include <asm/amd-ibs.h>
>           |          ^~~~~~~~~~~~~~~
>     compilation terminated.

Trying with the same trick used by intel-pt to build on all arches:

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index fbb7d61c50489374..d19d765195c54b79 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -9,7 +9,7 @@
 #include <inttypes.h>
 
 #include <linux/string.h>
-#include <asm/amd-ibs.h>
+#include "../../arch/x86/include/asm/amd-ibs.h"
 
 #include "debug.h"
 #include "session.h"
