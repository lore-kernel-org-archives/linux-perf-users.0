Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC4C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 14:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6479D61026
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 14:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhIJOND (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233928AbhIJOND (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 10:13:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBAFA611BF;
        Fri, 10 Sep 2021 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631283112;
        bh=ejUip3itZwLtheb3TXxocHtkN/0auCx2Nyksa+ii378=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+HZ4bH9qWVLiTV8Fh+ic8F170bofDkPzKdAi+/lR+PkiYjXf6/Z45UjJSMNDrB92
         kYTFgaeU88+xie+OtpBFt7q7+KgSf8msQU1LwSBty1l285Lh/26UvUsxxTAt3JP0LH
         4xXxqW3iFB1MaI+MSwRwnQUTS1o+ukcVPEg+PjKaUCOdXKtagxEI8KXb1z6UZCpyFn
         x6zeFBD2Z2/nUDYMD7YKkALCSY1T3p+MKJPV49Qwag4ZzLWEU3mDfZzfgTKlybMRzx
         V7UkKaXrqxysbmGMZHkC5VgnItAEYFLHyQAkm8kQ54HSLlUbJuGHvksZqYP46npPm6
         l2faXe7RWYM3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E28E84038F; Fri, 10 Sep 2021 11:11:48 -0300 (-03)
Date:   Fri, 10 Sep 2021 11:11:48 -0300
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
Subject: Re: [PATCH 0/3] perf report: Add support to print a textual
 representation of IBS raw sample data
Message-ID: <YTtnpAcaCNYozoJF@kernel.org>
References: <20210817221509.88391-1-kim.phillips@amd.com>
 <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
 <YTth5DLWGbyAzxvQ@kernel.org>
 <YTtmwrZ6iy0TzG3l@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTtmwrZ6iy0TzG3l@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 10, 2021 at 11:08:02AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Sep 10, 2021 at 10:47:16AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Sep 09, 2021 at 04:58:12PM -0500, Kim Phillips escreveu:
> > > Hi Arnaldo,
> > > 
> > > Can you please take a look at applying this series?  Its kernel-side
> > > dependent series has already been applied and is in Linus' master.
> > 
> > Sure, I'm now trying to fix this:
> > 
> >   CC      /tmp/build/perf/util/amd-sample-raw.o
> > util/amd-sample-raw.c: In function ‘evlist__amd_sample_raw’:
> > util/amd-sample-raw.c:125:42: error: ‘ bytes’ directive output may be truncated writing 6 bytes into a region of size between 4 and 7 [-Werror=format-truncation=]
> >   125 |                          " OpMemWidth %2d bytes", 1 << (reg.op_mem_width - 1));
> >       |                                          ^~~~~~
> > In file included from /usr/include/stdio.h:866,
> >                  from util/amd-sample-raw.c:7:
> > /usr/include/bits/stdio2.h:71:10: note: ‘__builtin___snprintf_chk’ output between 21 and 24 bytes into a destination of size 21
> >    71 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    72 |                                    __glibc_objsize (__s), __fmt,
> >       |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    73 |                                    __va_arg_pack ());
> >       |                                    ~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/amd-sample-raw.o] Error 1
> 
> So, that trick with using sizeof and that string 3 times is cumbersome
> and prone to truncation, at least the compiler can't say that the number
> you're passing to %2d will have just 2 digits:
> 
> [acme@quaco c]$ cat printf.c
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main(int argc, char *argv[])
> {
> 	char bf[64];
> 	int len = snprintf(bf, sizeof(bf), "%2d", atoi(argv[1]));
> 
> 	printf("strlen(%s): %u\n", bf, len);
> 
> 	return 0;
> }
> [acme@quaco c]$ ./printf 1234567
> strlen(1234567): 7
> [acme@quaco c]$
> 
> I'm trying to rework this.

So below is the minimal fix, the other cases the compiler somehow thinks
its ok, so I'll keep as is, will just remove the sizeof(string) to
sizeof(var), as I did below for the offending case.

- Arnaldo

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index fc1f670e88562b2e..e24025022735acdc 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -106,7 +106,7 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
 static void pr_ibs_op_data3(union ibs_op_data3 reg)
 {
 	char l2_miss_str[sizeof(" L2Miss _")] = "";
-	char op_mem_width_str[sizeof(" OpMemWidth __ bytes")] = "";
+	char op_mem_width_str[sizeof(" OpMemWidth _____ bytes")] = "";
 	char op_dc_miss_open_mem_reqs_str[sizeof(" OpDcMissOpenMemReqs __")] = "";
 
 	/*
@@ -121,7 +121,7 @@ static void pr_ibs_op_data3(union ibs_op_data3 reg)
 	}
 
 	if (reg.op_mem_width)
-		snprintf(op_mem_width_str, sizeof(" OpMemWidth __ bytes"),
+		snprintf(op_mem_width_str, sizeof(op_mem_width_str),
 			 " OpMemWidth %2d bytes", 1 << (reg.op_mem_width - 1));
 
 	printf("ibs_op_data3:\t%016llx LdOp %d StOp %d DcL1TlbMiss %d DcL2TlbMiss %d "
