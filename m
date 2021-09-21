Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB59C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 19:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F8660FDA
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhIUT1a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234468AbhIUT1a (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 15:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 398CE60F4C;
        Tue, 21 Sep 2021 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632252361;
        bh=gGIhMAmCiHVg6l+Obun1FAFw2n73LYtkgb74XwI5GXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS4FFbo85tBSxnEJaAxSWAGOzpOY0OQ6V97nR3oXqpfS54h1kcqXpr9zzxnsSlv/X
         w8Nx+nwQo8cEPVccCXqmdo7MNb+fDxCRBpVZ99a0PG9hUKE2+uvW+0vxu/fXlMFM4A
         bIv3PXyl0wpe3Q0np0ZhFjvmYLcXsO1mfjkU0nAH0rqGyyqegCGctJf5rP14hi3QwC
         Ij4ba/O4atXloVfruSoMV8EZ2NcHhLOkCpz/Wb8TNgXdS9XruzglKvm8GxVsgP3TI9
         xXdTWx9+Om+mNfrZ4eloRvFHZYUk58ZRW7ic9J1kTjr7oIBRX10SD2EuIZoEeI1OEj
         VuvWhbXu+APeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5E25410A1; Tue, 21 Sep 2021 16:25:58 -0300 (-03)
Date:   Tue, 21 Sep 2021 16:25:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf daemon: Avoid msan warnings on send_cmd
Message-ID: <YUoxxkBQvMHNqHXo@kernel.org>
References: <20210617055554.1917997-1-irogers@google.com>
 <CAP-5=fUzNak==X63zWDkMTsU8UYBACOtevED3ZR4Thruc0cWWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUzNak==X63zWDkMTsU8UYBACOtevED3ZR4Thruc0cWWg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 21, 2021 at 10:45:45AM -0700, Ian Rogers escreveu:
> On Wed, Jun 16, 2021 at 10:55 PM Ian Rogers <irogers@google.com> wrote:
> 
> > As a full union is always sent, ensure all bytes of the union are
> > initialized with memset to avoid msan warnings of use of uninitialized
> > memory.
> >
> > An example warning from the daemon test:
> >
> > Uninitialized bytes in __interceptor_write at offset 71 inside
> > [0x7ffd98da6280, 72)
> > ==11602==WARNING: MemorySanitizer: use-of-uninitialized-value
> >     #0 0x5597edccdbe4 in ion tools/lib/perf/lib.c:18:6
> >     #1 0x5597edccdbe4 in writen tools/lib/perf/lib.c:47:9
> >     #2 0x5597ed221d30 in send_cmd tools/perf/builtin-daemon.c:1376:22
> >     #3 0x5597ed21b48c in cmd_daemon tools/perf/builtin-daemon.c
> >     #4 0x5597ed1d6b67 in run_builtin tools/perf/perf.c:313:11
> >     #5 0x5597ed1d6036 in handle_internal_command tools/perf/perf.c:365:8
> >     #6 0x5597ed1d6036 in run_argv tools/perf/perf.c:409:2
> >     #7 0x5597ed1d6036 in main tools/perf/perf.c:539:3
> >
> > SUMMARY: MemorySanitizer: use-of-uninitialized-value
> > tools/lib/perf/lib.c:18:6 in ion
> > Exiting
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> 
> This one appears to still be outstanding. Ping.

Thanks, applied.

- Arnaldo

