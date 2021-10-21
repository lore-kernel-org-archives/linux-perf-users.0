Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9441C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 20:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E630610CF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 20:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJUUdX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhJUUdV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 16:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1483660FE8;
        Thu, 21 Oct 2021 20:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634848265;
        bh=eszrDbdkU26d521bV5MLXpdQPa7NylLuf1Bo8V1r+3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPHFQWeuj/a47468aOWrmB8fGMm07UjLOKPkMWE+C5W4VAHkRvmzThYAOFD2vhB+k
         hpyIg34lp4bI8E0dsCbGEr2s7gBuEH98TsYoJ3XF3Zq/+YZoVQDJIeebZJL3bzZo0b
         xr3oCUIYu7uTa5xcR6FPKlbi+TRp8WakQ41ebRAAleR25/y4YSWeOrfEhUSKAVNBib
         5lopI9bKkj7GfSgCzwKoaDW7vRkxduWdi8dCEsrlNu7YFq0PeQYJkD+0D4iNOMZv+Z
         iGDuKT0Bbti7MIqeES1xegrrxU/K2AD8e/mYxVt5+HZk0QcXMIMPLgG4IFTAt89GQ/
         aGDsH1HyLlBNg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 551CD410A1; Thu, 21 Oct 2021 17:31:01 -0300 (-03)
Date:   Thu, 21 Oct 2021 17:31:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mingo@redhat.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <James.Clark@arm.com>
Subject: [RFC] Support Intel-PT code build in 32-bit arches
Message-ID: <YXHOBXiIXP9b3xps@kernel.org>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
 <YXAoOgRVfkzr5vcS@kernel.org>
 <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
 <YXBRF0vM8sEwherG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXBRF0vM8sEwherG@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 20, 2021 at 02:25:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Oct 20, 2021 at 03:41:01PM +0100, John Garry escreveu:
> > I suppose the best thing now is to send a patch on top once perf/core
> > contains that commit. Let me know otherwise.
 
> You can send a v2, as:
 
>   29     8.60 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-9)
>     util/intel-pt.c: In function 'intel_pt_synth_pebs_sample':
>     util/intel-pt.c:2146:33: error: passing argument 1 of 'find_first_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      2146 |         for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
>     /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:37:38: note: in definition of macro 'for_each_set_bit'
>        37 |         for ((bit) = find_first_bit((addr), (size));            \
>           |                                      ^~~~
>     In file included from /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops.h:21,
>                      from /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:34,
>                      from /git/perf-5.15.0-rc4/tools/include/linux/bitmap.h:6,
>                      from util/header.h:10,
>                      from util/session.h:7,
>                      from util/intel-pt.c:16:
>     /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops/find.h:109:51: note: expected 'const long unsigned int *' but argument is of type 'const uint64_t *' {aka 'const long long unsigned int *'}
> 
>  Adrian, this is on:
> 
>  commit 803a3c9233990e1adac8ea2421e3759c2d380cf8
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Tue Sep 7 19:39:03 2021 +0300
> 
>     perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
> 
>     Originally, software only supported redirecting at most one PEBS event to
>     Intel PT (PEBS-via-PT) because it was not able to differentiate one event
>     from another. To overcome that, add support for the
>     PERF_RECORD_AUX_OUTPUT_HW_ID side-band event.
> 
>     Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> 
> That is still just on tmp.perf/core, so we can fix it, probably its just
> making that uint64_t into a unsigned long, will check later if you don't
> beat me to it.

Adrian,

	Probably we should just disable Intel PT support from being
built on 32-bit arches, right? I don't know if anybody is interested on
that, my tests just try to figure out if it continues to build, and if
fixing any problem isn't costly, which in this case is more than my
threshold, wdyt?

- Arnaldo
