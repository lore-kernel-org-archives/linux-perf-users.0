Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0317EB64DA
	for <linux-perf-users@archiver.kernel.org>; Sat, 24 Jun 2023 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFXR7F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Jun 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFXR7F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Jun 2023 13:59:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1851BE7
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Jun 2023 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687629544; x=1719165544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IsOYmJUNdjgRz2OhlzNBAtXzuNdWYxyCbIxrojU/3Uc=;
  b=mpvm38ovlyJ4mo6C60XYoI2BYaD2jST6PHhAWDEVjDqb3Sl8bxId4QIa
   85Udm1RlMvcT6j1gC2euAY57+U9urZvlk/iZO0zbesSWJItYclcQLBlDz
   BzMNUTsOhQSJSL0Bt9x+ZnFI8R8F/ppKlLUAxMPcGCF0zLnO+Y9+m7MTF
   tQSRP7hCi6XujO85kj7CZmhMy2hRyDlVR6Zsjmi2fBM11FI1xKS0xgjch
   eof6VDhJTEEYnJRgXvz1DO0HI2H4uxP+7jYLLGb5Ut3qxUIlTQgPFC4k2
   /K78hoHHmnkCi8tXXxNuwxqx5H2nRXGPToU7ywAUR43OxBK/xAHRTFAql
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="358459860"
X-IronPort-AV: E=Sophos;i="6.01,155,1684825200"; 
   d="scan'208";a="358459860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 10:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="1045983152"
X-IronPort-AV: E=Sophos;i="6.01,155,1684825200"; 
   d="scan'208";a="1045983152"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 10:59:03 -0700
Date:   Sat, 24 Jun 2023 10:59:01 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: Perf stat regression from d15480a3d67
Message-ID: <ZJcu5XiTFWtXC7QU@tassilo>
References: <ZJOmXU/41HMzanM9@tassilo>
 <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
 <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo>
 <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
 <ZJXl5vdhxPnVBRze@tassilo>
 <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
 <CAM9d7cg5ZQvHGs3fh9iXxdgRY2uidgDTQ0WSQGuicub+wX8KFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg5ZQvHGs3fh9iXxdgRY2uidgDTQ0WSQGuicub+wX8KFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> > So with perf-tools-next it appears that we're not merging the uncore
> > events, but that's different than skipping events.

Isn't that a regression too? We're supposed to merge.

> 
> Right, not sure what's changed though.
> 
> Andi, what's your expectation?

The original test case passes with perf-next, but I still see failures, 
but that might be related to PMU reordering. I'll investigate that.

However if the original hiding is still in the code the problem could still
happen, right? I would still prefer to do what i suggested earlier,
to only do hiding on --per-thread with an option to turn off.

-Andi
