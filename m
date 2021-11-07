Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB953C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F61C61352
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhKGSYa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 13:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhKGSYa (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 13:24:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE9596128B;
        Sun,  7 Nov 2021 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636309307;
        bh=KkIwjv5qUUVNyc0a2ElPMStqhjbVg1uTJNWNIyNRCLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrZ4SBJqMAxkMvMWZCJsgLG42AXTRGyruAxT31fgOgAq6/ERWp6PdiLLqWzM+s0Rl
         8jV4w0kLcROF/Yv7NojRNtP5nuN31/j2Vu136UOLsyZyS9tmBD1QsvHXDrrySH6kzt
         0W+v+RwhOmQcwfN0UdNNECVML2uhyTbLLSSjsLnxXtglTPZEq9LBF/F++gJp0BLYj5
         lyJM9nY6zg9ULYHkCOJWjQJSTBjC5/drJZ88E0bHRPaNmVN0XqxgJHT8rHoYbNRpiy
         4HnBjI+9RDMl48ny6c9MVXxDtKD+yEhu7zwd9rMHmKjPp1X/s1IeL7uqvJsIibDBhN
         m+7i5rRqWgyTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16317410A1; Sun,  7 Nov 2021 15:21:43 -0300 (-03)
Date:   Sun, 7 Nov 2021 15:21:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 1/3] perf parse-events: Rename parse_events_error
 functions
Message-ID: <YYgZN9g2bytfsupH@kernel.org>
References: <20211107090002.3784612-1-irogers@google.com>
 <YYfyEcPfj5ct7w7Q@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYfyEcPfj5ct7w7Q@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 07, 2021 at 12:34:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Nov 07, 2021 at 01:00:00AM -0800, Ian Rogers escreveu:
> > Group error functions and name after the data type they manipulate.
> 
> Sensible, applied.

I'll fix these:

  62     6.89 ubuntu:16.04-x-powerpc        : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error' [-Werror=implicit-function-declaration]
       parse_events_print_error(&err, "tracepoint");
       ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  63     7.19 ubuntu:16.04-x-powerpc64      : FAIL gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error' [-Werror=implicit-function-declaration]
       parse_events_print_error(&err, "tracepoint");
       ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  64     7.00 ubuntu:16.04-x-powerpc64el    : FAIL gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error' [-Werror=implicit-function-declaration]
       parse_events_print_error(&err, "tracepoint");
       ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  65    18.84 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66    75.33 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  67    20.15 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  68    20.15 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  69    16.63 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  70     7.39 ubuntu:18.04-x-powerpc        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error'; did you mean 'parse_events_evlist_error'? [-Werror=implicit-function-declaration]
       parse_events_print_error(&err, "tracepoint");
       ^~~~~~~~~~~~~~~~~~~~~~~~
       parse_events_evlist_error
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  71     7.90 ubuntu:18.04-x-powerpc64      : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error'; did you mean 'parse_events_evlist_error'? [-Werror=implicit-function-declaration]
       parse_events_print_error(&err, "tracepoint");
       ^~~~~~~~~~~~~~~~~~~~~~~~
       parse_events_evlist_error
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  72     7.99 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error'; did you mean 'parse_events_evlist_error'? [-Werror=implicit-function-declaration]
       parse_events_print_error(&err, "tracepoint");
       ^~~~~~~~~~~~~~~~~~~~~~~~
       parse_events_evlist_error
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  73    94.41 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  74    18.24 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  75    19.55 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  76    18.36 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  77    67.70 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1

  78     8.29 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
    arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
    arch/powerpc/util/kvm-stat.c:119:3: error: implicit declaration of function 'parse_events_print_error'; did you mean 'parse_events_evlist_error'? [-Werror=implicit-function-declaration]
      119 |   parse_events_print_error(&err, "tracepoint");
          |   ^~~~~~~~~~~~~~~~~~~~~~~~
          |   parse_events_evlist_error
    cc1: all warnings being treated as errors
    make[5]: *** [/git/perf-5.15.0/tools/build/Makefile.build:139: util] Error 2
    make[4]: *** [/git/perf-5.15.0/tools/build/Makefile.build:139: powerpc] Error 2
    make[3]: *** [/git/perf-5.15.0/tools/build/Makefile.build:139: arch] Error 2

