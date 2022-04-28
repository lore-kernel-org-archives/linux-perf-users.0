Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A05C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 13:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiD1NtQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347719AbiD1NtD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 09:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75B4833B;
        Thu, 28 Apr 2022 06:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1060B82D69;
        Thu, 28 Apr 2022 13:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBF3C385A9;
        Thu, 28 Apr 2022 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651153540;
        bh=GFf+7ataLh/akwyJEGuI1nPoHc7tcslfjzG4dS/IkSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5gxzCkaMvsGrpAVemAcjJAs++OJz3RXrkXwC+ZSMVoT5nY20fWu6I59wgMPkdpk9
         isVGfPkAHS0mCe514gliZlIPEFrCnFjYlhdJESN9XONKLGu6BzK0OmAmKIHokcc15F
         hI86Pm+ePWdF3zRD6C4BuvFPrsqy5cn4FGI2JYBLIJ1kF82ST1ofEtALkB9YP0cpF2
         tqV7bVVce3nprZ4Q9QkZMSX6KoW7tM7AUGU2dUqdsvTv8M3H8AH3APKtusRV2SMrcs
         ZU4YhDrTTbIxz4wzX09lDjJRCjgm0+r+wDKOB3V/zzGNdrUdfEW/yswKWFTs/CrKcL
         1abScLgpjb6pw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 327AD400B1; Thu, 28 Apr 2022 10:45:37 -0300 (-03)
Date:   Thu, 28 Apr 2022 10:45:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 0/8] perf: Expand perf_branch_entry
Message-ID: <YmqagfywsvGXaIVl@kernel.org>
References: <20220404045046.634522-1-anshuman.khandual@arm.com>
 <f469f253-9ccc-d55b-731d-3ecc8d685104@arm.com>
 <a304d9e4-2632-1ba9-249f-1d87c90f82de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a304d9e4-2632-1ba9-249f-1d87c90f82de@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Apr 18, 2022 at 12:17:53PM +0530, Anshuman Khandual escreveu:
> On 4/11/22 11:16, Anshuman Khandual wrote:
> > On 4/4/22 10:20, Anshuman Khandual wrote:
> >> - Rebased series on v5.18-rc1
> > 
> > Gentle ping, any updates on this series ?
> 
> Gentle ping, any updates on this series ?
> 
> I have posted BRBE RFC V2 accommodating all these new perf ABI changes being
> proposed here. I would really appreciate reviews and/or suggestions on this
> series, which is essential and also prerequisite for the BRBE driver itself.
> 
> https://lore.kernel.org/all/20220412115455.293119-1-anshuman.khandual@arm.com/

Has the kernel bits been merged? When that happens I'll cherry pick the
tools/ ones.

In future series, please, on the final patch submission, please send two
series, one for the kernel and another for tooling.

- Arnaldo
