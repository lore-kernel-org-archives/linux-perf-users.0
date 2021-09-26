Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED97C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 12:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D160F0F
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 12:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhIZMQ3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 08:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhIZMQ3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Sep 2021 08:16:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5A6B60EE2;
        Sun, 26 Sep 2021 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632658492;
        bh=y3/satZFfSkTdvxsNt0Fd+Altve/CYaZU+BVGarbhdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0Zbr2i4nWM7cRRrDohTa4CCrPwFzYCh22uAJC6WSfGTumn6Sw2GobEbi17hA+hnf
         HlVvNPdEeXYfIbbg1s/68uCYK1Myj3PT9aJA8wTsbxzUjk6xYQRtDW9KcpzX12lcAB
         h0YcYWtXRO712AAK8TysTOQ7vmJ5jClkeKuscENUoMErR34oaTgK7JsH0PLGekcOJX
         UEAvLhsYv+l6err5L/O3jdg2D0MX+Ab2meXsTNT8Ojd9CQrOgSuiFtaGdQzvb9maxN
         j8YlAf/+/uRdsJM8tr8oAnIK7z3iL3PpT+gaqPWmVgxAaK18ufUHaEVnzrBd3KakWp
         tLM6bS7o28z1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0BB8410A1; Sun, 26 Sep 2021 09:14:49 -0300 (-03)
Date:   Sun, 26 Sep 2021 09:14:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jinshan Xiong <jinshan.xiong@gmail.com>
Cc:     jolsa@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/lib/perf: make the static libperf complete
Message-ID: <YVBkObnrPfX6KIZM@kernel.org>
References: <20210926023028.2338342-1-jinshan.xiong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926023028.2338342-1-jinshan.xiong@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Sep 25, 2021 at 07:30:24PM -0700, Jinshan Xiong escreveu:
> This patch makes libperf.a complete. Initially it misses the symbols
> fdarray_* that makes it unusable:
>    $ nm tools/lib/perf/libperf.a | grep fdarray_
>                     U fdarray__add
>    0000000000002b3e t fdarray__available_entries
>                     U fdarray__exit
>                     U fdarray__filter
>                     U fdarray__grow
>                     U fdarray__init
>                     U fdarray__poll
> 
> After this patch is applied:
>     $ nm tools/lib/perf/libperf.a | grep fdarray_
>     00000000000063f7 T fdarray__add
>     ......
>     00000000000065d4 T fdarray__poll

Have you tried to build tools/perf/ with this?

  LINK    /tmp/build/perf/plugins/plugin_futex.so
  LINK    /tmp/build/perf/plugins/plugin_jbd2.so
  INSTALL trace_plugins
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o):/var/home/acme/git/perf/tools/lib/api/debug.c:20: multiple definition of `__pr_debug'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/debug.c:20: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `sysfs__read_bool':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:505: multiple definition of `sysfs__read_bool'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:505: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `fdarray__poll':
/var/home/acme/git/perf/tools/lib/api/fd/array.c:120: multiple definition of `fdarray__poll'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fd/array.c:120: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `tracefs__configured':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:316: multiple definition of `tracefs__configured'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:316: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `sysfs__read_int':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:479: multiple definition of `sysfs__read_int'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:479: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `fdarray__fprintf':
/var/home/acme/git/perf/tools/lib/api/fd/array.c:125: multiple definition of `fdarray__fprintf'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fd/array.c:125: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `sysfs__write_int':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:547: multiple definition of `sysfs__write_int'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:547: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `filename__read_str':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:378: multiple definition of `filename__read_str'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:378: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `hugetlbfs__mountpoint':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:317: multiple definition of `hugetlbfs__mountpoint'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:317: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `debugfs__mountpoint':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:315: multiple definition of `debugfs__mountpoint'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:315: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `fdarray__delete':
/var/home/acme/git/perf/tools/lib/api/fd/array.c:71: multiple definition of `fdarray__delete'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fd/array.c:71: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `procfs__mountpoint':
/var/home/acme/git/perf/tools/lib/api/fs/fs.c:314: multiple definition of `procfs__mountpoint'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:314: first defined here
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `get_tracing_file':
/var/home/acme/git/perf/tools/lib/api/fs/tracing_path.c:74: multiple definition of `get_tracing_file'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/tracing_path.c:74: first defined here

You probably need to include libapi.a as well.

- Arnaldo
