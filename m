Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC64C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 20:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJFUnX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiJFUnV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 16:43:21 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92DB025E8D;
        Thu,  6 Oct 2022 13:43:19 -0700 (PDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0F7F072C97D;
        Thu,  6 Oct 2022 23:43:18 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E45DE7CF8EC; Thu,  6 Oct 2022 23:43:17 +0300 (MSK)
Date:   Thu, 6 Oct 2022 23:43:17 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vitaly Chikunov <vt@altlinux.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] libperf: Remove reference to non-uapi header
Message-ID: <20221006204317.GB11960@altlinux.org>
References: <20221006162919.2231389-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006162919.2231389-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 06, 2022 at 07:29:19PM +0300, Vitaly Chikunov wrote:
> Fix build with libperf:
> 
>   $ gcc ./tools/lib/perf/Documentation/examples/counting.c -lperf
>   In file included from ./tools/lib/perf/Documentation/examples/counting.c:8:
>   /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
>       9 | #include <linux/compiler.h>
>         |          ^~~~~~~~~~~~~~~~~~
>   compilation terminated.
> 
> Fixes: b2f10cd4e805 ("perf cpumap: Fix alignment for masks in event encoding")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>


-- 
ldv
