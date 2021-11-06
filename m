Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1502EC4332F
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86D7611EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhKFTut (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhKFTut (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 15:50:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6706F6112D;
        Sat,  6 Nov 2021 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636228087;
        bh=IdVT7GtyCMR4mfmk12mO3uhHDYgE7JCCf6WE6qE97KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QU+ZsP3x1VWA/TJJOQVHOmLnqzlskhiVnOU5TAvZL2bMiw3zOFSCv4PJQdsP1YTeL
         CIJw43JESnanhHIlACmIrF4mixxlffx88fjrJ4Fadi6kRlzD909CjyDCGSzUUbTruH
         sbiOodFllwwQhGm1lxHaOqJ1FGbx71E4SuaDC3Kbg60RYNtwnZipFubUYapqj8/8H7
         aEJghCM9MQvcpAlyUoGDA+n6x1bLFl3gplLKO0wHXPfPLBv2af6kCn4Km0BE9RXKFH
         YACiCyzw9D7DAmQr28q4mMnWDxTm/SQDRnNAc8EYgZRIqlrBFsLTj7GIiTXUeGL3rT
         diyeoDK4iisoA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 549E4410A1; Sat,  6 Nov 2021 16:48:04 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:48:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Lexi Shao <shaolexi@huawei.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, qiuxi1@huawei.com, nixiaoming@huawei.com,
        wangbing6@huawei.com
Subject: Re: [PATCH] perf symbol: ignore $a/$d symbols for ARM modules
Message-ID: <YYbb9Iz5Iix3JC/Q@kernel.org>
References: <20211027095235.123358-1-shaolexi@huawei.com>
 <0631949b-6cde-dee6-6a77-5b826938ce79@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0631949b-6cde-dee6-6a77-5b826938ce79@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 28, 2021 at 09:44:26AM +0100, James Clark escreveu:
> 
> 
> On 27/10/2021 10:52, Lexi Shao wrote:
> > On ARM machine, kernel symbols from modules can be resolved to $a
> > instead of printing the actual symbol name. Ignore symbols starting with
> > "$" when building kallsyms rbtree.
> > 
> > A sample stacktrace is shown as follows:
> > 
> > c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
> > bf4a66d8 $a+0x78 ([test_module])
> > c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
> > c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
> > 
> > On ARM machine, $a/$d symbols are used by the compiler to mark the
> > beginning of code/data part in code section. These symbols are filtered
> > out when linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but
> > are left on modules. So there are $a symbols in /proc/kallsyms which
> > share the same addresses with the actual module symbols and confuses perf
> > when resolving symbols.
> > 
> > After this patch, the module symbol name is printed:
> > 
> > c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
> > bf4a66d8 test_func+0x78 ([test_module])
> > c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
> > c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
> > 
> > Signed-off-by: Lexi Shao <shaolexi@huawei.com>
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

