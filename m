Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEDAC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779376105A
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhHKTDX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhHKTDW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 15:03:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BB6F61077;
        Wed, 11 Aug 2021 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708578;
        bh=STUcYPXnkJiThMTmp6iJIfCxEefd9IOUulaqLIj3Dyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYocvPLSfGLglCzJSWA3cskjMhkpjD6hLZEErYf8A1IjPH32/g11+ZolGJpctCVD3
         77ask/NRROrFZc0hXstQydfngzJbHZxF0hxR47y6Ol+zOxFH9s4xd8uHR5ZJvyHLEc
         hDg+oShmRPyd2oXY4dC8yUUsMsqcnVcNI08n/wcBwmzyq21EPxkzgKf415NKsPjXlZ
         H6OLNGY6D+PlQGxXvx25w3uu1vbBLhE07Agi4t/xO9zgH1DNoBVD3yEL5T5FJO/PEg
         FaZUcC+0O+QVMzZKNna78gdc2YQA+h778Bt9PK3U/UFP08YjHsHENb80Tuo4+LNah5
         Sk3PdYoI+QkAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87F6E403F2; Wed, 11 Aug 2021 16:02:53 -0300 (-03)
Date:   Wed, 11 Aug 2021 16:02:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: make --skip work on shell tests
Message-ID: <YRQe3cIaC2AA5xQl@kernel.org>
References: <20210811180625.160944-1-rickyman7@gmail.com>
 <YRQZqOH9JLGAX6NE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRQZqOH9JLGAX6NE@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 11, 2021 at 03:40:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 11, 2021 at 08:06:26PM +0200, Riccardo Mancini escreveu:
> > perf-test has the option --skip to provide a list of tests to skip.
> > However, this option does not work with shell scripts.
> > 
> > This patch passes the skiplist to run_shell_tests, so that also shell
> > scripts could be skipped using --skip.
> 
> In such cases please provide an example of the usage you're fixing, what
> was it that you tried that didn't work and that now works?
> 
> Its obviously a fix, so I'm applying it.

So I added this to the commit log:

Committer tests:

Tests 79 onwards are shell tests:

Before:

  # perf test --skip 1,2,81,82,84,88,90
   1: vmlinux symtab matches kallsyms                                 : Skip (user override)
   2: Detect openat syscall event                                     : Skip (user override)
   3: Detect openat syscall event on all cpus                         : Ok
   4: Read samples using the mmap interface                           : Ok
   5: Test data source output                                         : Ok
  <SNIP>
  78: x86 Sample parsing                                              : Ok
  79: build id cache operations                                       : Ok
  80: daemon operations                                               : Ok
  81: perf pipe recording and injection test                          : Ok
  82: Add vfs_getname probe to get syscall args filenames             : FAILED!
  83: probe libc's inet_pton & backtrace it with ping                 : Ok
  84: Use vfs_getname probe to get syscall args filenames             : FAILED!
  85: Zstd perf.data compression/decompression                        : Ok
  86: perf stat csv summary test                                      : Ok
  87: perf stat metrics (shadow stat) test                            : Ok
  88: perf stat --bpf-counters test                                   : Ok
  89: Check Arm CoreSight trace data recording and synthesized samples: Skip
  90: Check open filename arg using perf trace + vfs_getname          : FAILED!
  #

After:

  # perf test --skip 1,2,81,82,84,88,90
   1: vmlinux symtab matches kallsyms                                 : Skip (user override)
   2: Detect openat syscall event                                     : Skip (user override)
   3: Detect openat syscall event on all cpus                         : Ok
   4: Read samples using the mmap interface                           : Ok
   5: Test data source output                                         : Ok
  <SNIP>
  78: x86 Sample parsing                                              : Ok
  79: build id cache operations                                       : Ok
  80: daemon operations                                               : Ok
  81: perf pipe recording and injection test                          : Skip (user override)
  82: Add vfs_getname probe to get syscall args filenames             : Skip (user override)
  83: probe libc's inet_pton & backtrace it with ping                 : Ok
  84: Use vfs_getname probe to get syscall args filenames             : Skip (user override)
  85: Zstd perf.data compression/decompression                        : Ok
  86: perf stat csv summary test                                      : Ok
  87: perf stat metrics (shadow stat) test                            : Ok
  88: perf stat --bpf-counters test                                   : Skip (user override)
  89: Check Arm CoreSight trace data recording and synthesized samples: Skip
  90: Check open filename arg using perf trace + vfs_getname          : Skip (user override)
  #

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
