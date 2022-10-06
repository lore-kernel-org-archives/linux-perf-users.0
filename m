Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FFC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJFPQ1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJFPQ0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 11:16:26 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 897A5A59A6
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 08:16:25 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AD80572C97D;
        Thu,  6 Oct 2022 18:16:24 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D63EF4A472A;
        Thu,  6 Oct 2022 18:16:22 +0300 (MSK)
Date:   Thu, 6 Oct 2022 18:16:22 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h:
 No such file or directory
Message-ID: <20221006151622.i45co6lioxgheval@altlinux.org>
References: <20221006142852.mhrgi3r4fvtkircw@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20221006142852.mhrgi3r4fvtkircw@altlinux.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 06, 2022 at 05:28:53PM +0300, Vitaly Chikunov wrote:
> I noticed that perf examples do not compile anymore with v6.0 (first on ALT,
> but on Fedora is the same). Fedora example for convenience:
> 
>   # dnf install kernel libperf-devel gcc
>   # cc /usr/share/doc/libperf/examples/counting.c -lperf
>   In file included from /usr/share/doc/libperf/examples/counting.c:8:
>   /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
>       9 | #include <linux/compiler.h>
> 	|          ^~~~~~~~~~~~~~~~~~
>   compilation terminated.

This is introduced in b2f10cd4e805 ("perf cpumap: Fix alignment for
masks in event encoding") just (it seems) for `__packed'.
I am told that all uapi is using  __attribute__ ((__packed__)) for that.

Thanks,

> 
> I don't see compiler.h installed anywhere by the `make headers_install`.
> 
> Thanks,
> 
