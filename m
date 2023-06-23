Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A0EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 17:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFWRFH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjFWRFE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 13:05:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84E26AF
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687539903; x=1719075903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+WNH4Qu/aBBi4QEMDxnOmy9qo813NM8sh7+WC0fPc4=;
  b=FYpUmTh3HvAL493Hf5AJ+R8NFBkD8y4YZdoeJWGhyLt4BZEiIui3MSeD
   4DCEduj4mVFJ88SvrSDnZQtD0x7xczjs8CUBYePnqwi3Qk1XGK97lLXPM
   WUjr5D6LrdyQWXFW6hUQSWooVzG9Mf9XMlqoxxhAaQjOjDZadBqMrcMxs
   KFdnY2SdNdRDUXrUVdAKrDK+G2GCNy4Li6+3aLBEczm1+Hf1zuTtrHxl5
   FF+zo77X6CUzuvFFVzrLg3QyZwIuw/JCLVwITF5t6rFGvbbr8K+1tYGwP
   sGLiG1cEd+50M+QxD05DzgZ9MBlyMhd8DjUTmE+9t+wDJpYHbNvN1Q/ND
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="447191208"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="447191208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="1045710418"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="1045710418"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:04:58 -0700
Date:   Fri, 23 Jun 2023 10:04:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: Perf stat regression from d15480a3d67
Message-ID: <ZJXQuWyDKbL8Psre@tassilo>
References: <ZJOmXU/41HMzanM9@tassilo>
 <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
 <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo>
 <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> > Okay so the skipping can just be removed?
> 
> The existing use case was system-wide --per-thread mode.
> It would generate too much noise without it.

Hmm I guess we could make it default for per thread mode, but add an
option to turn it on again if it's needed

(my tool currently doesn't do per thread, but I can could imagine
adding that at some point)

> > > Didn't you say you only have problems in uncore events?
> >
> > For this test case I only hit it with the uncore, but I would have a general
> > problem for any event if it was hidden.
> 
> stat-display.c::should_skip_zero_counter() specifically checks
> uncore PMU events, so I don't think core events have problems.
> 
> Also it only skips when aggregation id doesn't match, which means
> the (default) global aggregation mode should not skip any uncore
> events.
> 
> Can you please help me to find a minimal repro?

I'll run delta[1] over it later today.
But you may need a SKX.

-Andi

[1] https://github.com/dsw/delta
