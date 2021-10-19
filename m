Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E628FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4FA60174
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJSVQl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhJSVQk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 17:16:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE5E860F8F;
        Tue, 19 Oct 2021 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634678067;
        bh=DbU903xMbBGkZKtmLMTtL2HO/MtcYuHg5E4ozNbbhFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lnKVbqvGKqHJB9MmTwhIeCEpd4qHcBeuqUbeFTP7mYKN2qkGM33pIdCV5/YhLMMqe
         8Q4ugwO8NCi+Hha6/hDKSlUvApyoSMAxzCXXM/iBXJSHyT69A4VSVVo0eRqAuOWaKv
         3N98PdMTwK4uetL8veSSEXBG7CUhdr/d8awagRGfvBYSIebZiYJ35WJNIJwdurKwfj
         5NdBf3VHIWSk9loeRiLitBMT1dgc//xjE90VZ+TNtP5MIJYl4RW+zfEe3Z9aCUOdWd
         44Job2tGqPfpHWN8vP9wxvBcgJa09DlkW1/qC3PRyd7qVDiH9J4NOsUzcxKva61rzX
         L7xUgKfCOwK9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 747D7410A1; Tue, 19 Oct 2021 18:14:23 -0300 (-03)
Date:   Tue, 19 Oct 2021 18:14:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf list: Display hybrid pmu events with cpu type
Message-ID: <YW81L7j06Mf13QmC@kernel.org>
References: <20210903025239.22754-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903025239.22754-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 03, 2021 at 10:52:39AM +0800, Jin Yao escreveu:
> Add a new option '--cputype' to perf-list to display core-only pmu events
> or atom-only pmu events.
> 
> Each hybrid pmu event has been assigned with a pmu name, this patch
> compares the pmu name before listing the result.
> 
> For example,
> 
> perf list --cputype atom
> ...
> cache:
>   core_reject_l2q.any
>        [Counts the number of request that were not accepted into the L2Q because the L2Q is FULL. Unit: cpu_atom]
> ...
> 
> The "Unit: cpu_atom" is displayed in the brief description section
> to indicate this is an atom event.

Thanks, applied.

- Arnaldo

