Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AECC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Dec 2022 15:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiLLPjk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiLLPje (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Dec 2022 10:39:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7847C14087
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 07:39:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1604F6112B
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 15:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB1AC433D2;
        Mon, 12 Dec 2022 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859571;
        bh=bsRSnz3UJl2WZo1q75Npf56ZTEBh+RSUlsfyNp3xyvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PutqhPvXI160Ms7WYR5j2pKKqADTVzjLRVBNtyDPdjrLC5BP+9TuFbsq/elWL445Y
         hoMwTkEITaxBCxaxpo7PaN/YfLx38WdnqSKxgsHUNwpgnClj+68oyzMd0q/67N9D7m
         MoSAMj6Ym+na0wl51KqLwFK4J8XW/LiR97wjgtQgLHRjJZQYVB6sS09a7etgtNO76l
         g5WLhPGw/zf2HPUhDorpN9fD/epnabiH1Hzd1WQ7ZwKQQbA6Fjs5imjkDI90+KbVfb
         ODt8CUuiXbtNaCmvEAJQUZJ3fB55sA7pXKg/zs0Ko7BWeUaR4VvD3z2s+8MzzB17O5
         5QgYdg+EQg6jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B302740483; Mon, 12 Dec 2022 12:39:28 -0300 (-03)
Date:   Mon, 12 Dec 2022 12:39:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>, disgoel@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf test: Update event group check for support of
 uncore event
Message-ID: <Y5dLME8rr1YIfyQe@kernel.org>
References: <20221207165815.774-1-atrajeev@linux.vnet.ibm.com>
 <9c0ade1e-1c7b-90f5-0385-a568545567db@amd.com>
 <3C59F3E6-B7DE-485B-9483-703EBDE9AC41@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C59F3E6-B7DE-485B-9483-703EBDE9AC41@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Dec 09, 2022 at 12:57:34PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 08-Dec-2022, at 9:48 AM, Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> > 
> > On 07-Dec-22 10:28 PM, Athira Rajeev wrote:
> >> Event group test checks group creation for combinations of
> >> hw, sw and uncore PMU events. Some of the uncore pmus may
> >> require additional permission to access the counters.
> >> For example, in case of hv_24x7, partition need to have
> >> permissions to access hv_24x7 pmu counters. If not, event_open
> >> will fail. Hence add a sanity check to see if event_open
> >> succeeds before proceeding with the test.
> >> 
> >> Fixes: b20d9215a35f ("perf test: Add event group test for events in multiple PMUs")
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > 
> > Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Thanks Ravi for checking the patch

Thanks, applied.

- Arnaldo

