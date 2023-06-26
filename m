Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18850EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 23:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjFZXw4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 19:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFZXwz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 19:52:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F005E1991
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687823573; x=1719359573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rEN6cFQI00Wqq8pjvLLn1zXySB5OfEM2GnWhQ0Ek544=;
  b=Nrg5Q0aIsMqJA9TUMb5j1SBZXLQcfEKGt4Z2RQuRb3ZkcTCYxFdHwCrm
   Zfl7EDSsR6cMoEtRvszt6617p1pc4QwBnbuFMqS1uHpHkHxz4/xchuLHR
   yqTjWz2sUQRQ1nCIPembJFp/LLH6XrOpyLef3gsMaLKOFFn6kR9/2cO7G
   SM2Efpa7ZcpvRROrqjgcBcnZoeqJacWX34tk/TDs4NWz3LbUTq3Hv+YeG
   PoB4v5VaE7NqVgzdIhTk4mkU1yNBVOTHjIftgtyf70TrdTH1slvoRUC6p
   8MH+Bn/kI/94gl2FK95nMacn45og0GG7lUgMk8LN4Du1vAx0K/PgwwTMH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364874144"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="364874144"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 16:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666474751"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="666474751"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 16:52:53 -0700
Date:   Mon, 26 Jun 2023 16:52:52 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: Perf stat regression from d15480a3d67
Message-ID: <ZJok1Da3j2WzWsoN@tassilo>
References: <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
 <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo>
 <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
 <ZJXl5vdhxPnVBRze@tassilo>
 <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
 <CAM9d7cg5ZQvHGs3fh9iXxdgRY2uidgDTQ0WSQGuicub+wX8KFQ@mail.gmail.com>
 <ZJcu5XiTFWtXC7QU@tassilo>
 <CAM9d7chyic6tf0nvJVE+Mt+X0fagecxESqVj9=pLNtxbCP5NeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chyic6tf0nvJVE+Mt+X0fagecxESqVj9=pLNtxbCP5NeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> > >
> > > Right, not sure what's changed though.
> > >
> > > Andi, what's your expectation?
> >
> > The original test case passes with perf-next, but I still see failures,
> > but that might be related to PMU reordering. I'll investigate that.
> >
> > However if the original hiding is still in the code the problem could still
> > happen, right? I would still prefer to do what i suggested earlier,
> > to only do hiding on --per-thread with an option to turn off.
> 
> I think the hiding should not happen in normal conditions
> besides the --per-thread.  So I want to be clear what makes
> it disappears.  Then we can decide what to do.

Okay I'll watch it and see if it happens again for next.

However if it's broken in some stable might also need to double
check that.

-Andi
