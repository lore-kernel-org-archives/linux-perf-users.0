Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC61C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6457661154
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 21:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhKMVN7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 16:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhKMVN6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 16:13:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CD6760EFE;
        Sat, 13 Nov 2021 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636837865;
        bh=DNAiApXHVj+drlYL00cNv7Qe2n+gbdgDqCvHvFDCwxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRWRBbKTMRvWcWeYJ/2nb/265oeUe2ykcri9ENfzyntmrA8TqswTaM3VPfbvtlpae
         I7Tu9UR5oDNb7L22DzN5i70fy6oVqMG6RsGEGFZMmYjp/CFlLLJpQ9o9c4InbULHBG
         XYHac6vZ4LBkP9Mq6GKUteZhJhYKuGu2VLW6zx0oh+FVibxOxJDBNUo59GvgKLaHnz
         kJfI/Nf2jwzcAFhEpTxOZRKLUu89nyucbuOfvKym8f37BnIHEUPGHZD2eAIQdlpsjR
         SaIsai2e4umLVXbT9W4/rlSPZtW8ip3J2HkYNl8cXKsGqRb4VU9HX+8qiYd6LLJGHh
         X91AS8XMLMPnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4EB274088E; Sat, 13 Nov 2021 18:11:02 -0300 (-03)
Date:   Sat, 13 Nov 2021 18:11:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [PATCH v2 11/22] perf test: Convert watch point tests to test
 cases.
Message-ID: <YZAp5kGiZ3gP+5Zd@kernel.org>
References: <20211013174604.747276-1-irogers@google.com>
 <20211013174604.747276-12-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013174604.747276-12-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 13, 2021 at 10:45:53AM -0700, Ian Rogers escreveu:
> Use null terminated array of test cases rather than the previous sub
> test functions.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/wp.c | 128 ++++++++++--------------------------------
>  1 file changed, 30 insertions(+), 98 deletions(-)
> 
> diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> index 904bdf2dcf81..2c0513257b15 100644
> --- a/tools/perf/tests/wp.c
> +++ b/tools/perf/tests/wp.c
> @@ -62,8 +62,12 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
>  	return fd;
>  }
>  

  65     6.29 ubuntu:16.04-x-s390           : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9)
    tests/wp.c:24:12: error: 'wp_read' defined but not used [-Werror=unused-function]
     static int wp_read(int fd, long long *count, int size)
                ^
    tests/wp.c:51:12: error: '__event' defined but not used [-Werror=unused-function]
     static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
                ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2


Trying with:


diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 2c0513257b15c041..820d942b30c390e9 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -48,6 +48,7 @@ static void get__perf_event_attr(struct perf_event_attr *attr, int wp_type,
 	attr->exclude_hv     = 1;
 }
 
+#ifndef __s390x__
 static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
 {
 	int fd;
@@ -61,6 +62,7 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
 
 	return fd;
 }
+#endif
 
 static int test__wp_ro(struct test_suite *test __maybe_unused,
 		       int subtest __maybe_unused)
