Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 17:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF54A6138B
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 17:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJTR2B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhJTR2A (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 13:28:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27322610EA;
        Wed, 20 Oct 2021 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634750746;
        bh=Tp2E/SX36NEBnGlGkwTmUzxzFZ6Uw/WEGsaN9+HAuBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plPO8L2LITVZQkN/oAUYv25QG0Hm30zDbRNUnPDNuOhdNG4JcRVssV3VkyZSJcHK5
         FQdJlW+BB5k0v+fArmAbvIUchSjcQXk4tGqbY5fh/e1hC0MXXAoCDWBlUNoZ9KtjbS
         zKcFffIlqyPEXt058iTZSJVvu57feSj97cq+oDTvZwoexundV3A6GMogD8wRGIJ8VT
         T0t6aNUCwq2HjYm8Xqyany40G0XhoVS0bHi03k04iI28empwS0eqnnIAVRR3c86wFS
         TbriS98/uOySj6bQzQccf/j1y8PHr007uPT7PJpV0yBBEzeUDV7K5D2mA4ugpdJdIJ
         jxP7MO67pYukA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08EFF410A1; Wed, 20 Oct 2021 14:25:44 -0300 (-03)
Date:   Wed, 20 Oct 2021 14:25:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 0/2] perf jevents: Enable build warnings
Message-ID: <YXBRF0vM8sEwherG@kernel.org>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
 <YXAoOgRVfkzr5vcS@kernel.org>
 <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 20, 2021 at 03:41:01PM +0100, John Garry escreveu:
> On 20/10/2021 15:31, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Oct 16, 2021 at 12:48:25AM +0800, John Garry escreveu:
> > > Currently jevents builds without any complier warning flags enabled. So
> > > use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS. I am not
> > > 100% confident that this is the best way, but sending out for review.
> > > 
> > > Baseline is be8ecc57f180 (HEAD, acme/perf/core) perf srcline: Use
> > > long-running addr2line per DSO
> > 
> > Thanks, applied.
 
> I was going to send a v2, with changes according to James Clark's review  -
> that was to add -Wall & -Werror, but they caused a problem on your perf/core
> branch as they triggered the warn fixed in commit b94729919db2.
 
> I suppose the best thing now is to send a patch on top once perf/core
> contains that commit. Let me know otherwise.

You can send a v2, as:

  29     8.60 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-9)
    util/intel-pt.c: In function 'intel_pt_synth_pebs_sample':
    util/intel-pt.c:2146:33: error: passing argument 1 of 'find_first_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
     2146 |         for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
    /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:37:38: note: in definition of macro 'for_each_set_bit'
       37 |         for ((bit) = find_first_bit((addr), (size));            \
          |                                      ^~~~
    In file included from /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops.h:21,
                     from /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:34,
                     from /git/perf-5.15.0-rc4/tools/include/linux/bitmap.h:6,
                     from util/header.h:10,
                     from util/session.h:7,
                     from util/intel-pt.c:16:
    /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops/find.h:109:51: note: expected 'const long unsigned int *' but argument is of type 'const uint64_t *' {aka 'const long long unsigned int *'}

 Adrian, this is on:

 commit 803a3c9233990e1adac8ea2421e3759c2d380cf8
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Tue Sep 7 19:39:03 2021 +0300

    perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID

    Originally, software only supported redirecting at most one PEBS event to
    Intel PT (PEBS-via-PT) because it was not able to differentiate one event
    from another. To overcome that, add support for the
    PERF_RECORD_AUX_OUTPUT_HW_ID side-band event.

    Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Reviewed-by: Andi Kleen <ak@linux.intel.com>


That is still just on tmp.perf/core, so we can fix it, probably its just
making that uint64_t into a unsigned long, will check later if you don't
beat me to it.

- Arnaldo
