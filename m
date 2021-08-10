Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C093C4320A
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2112A603E7
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhHJSHO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239359AbhHJSFK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 14:05:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE67603E7;
        Tue, 10 Aug 2021 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628618337;
        bh=e8AfQnkbBJUTBN66fx3ZNZlZaWyTkgvckUWpfKYlrgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edymIbhwlGNVazPpMSqv5zJ5TjFUn0QqAddAKi+3BVwOp7gtn1uNGdciLnW1EieM6
         czjev0CYwKBrEKg35h5gTF+2EvtVOyDljxQ2pGYRnYfQ9tx3v5jiUP1IFsKMxaV0xz
         BNqMaf6wBOS4ScVvQnaJZLV4RN//o/dZ2bFx0k7eDcwvD/goqsf6L20TCvsxsafnpA
         dmbFnE6yuZg8M5syNnAtTO0U2/j1naK2h4jisns2PsP+wfH7cuPD9de63uJ6e8qggy
         aQ40Mlx8Ire9riQK3ZG6YD8bF7uoc+AmfxH7rDIwiChd0fK9UpdHglkb7RdnZKp1xD
         /3Wj/B3ntqn3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12093403F2; Tue, 10 Aug 2021 14:58:55 -0300 (-03)
Date:   Tue, 10 Aug 2021 14:58:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, linuxarm@huawei.com
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
Message-ID: <YRK+X/f44UK+btRx@kernel.org>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
 <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
 <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
 <YRKGo1AtfBn85sZ7@kernel.org>
 <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 03:23:07PM +0100, John Garry escreveu:
> On 10/08/2021 15:01, Arnaldo Carvalho de Melo wrote:
> > > Shall I send this as a formal patch?
> > The question is when should I apply this patch? After this series? After
> > the patch I commented about, before?
> > 
> 
> Hi Arnaldo,
> 
> I think that you can apply it before the series. This is a pre-existing
> issue that there was no dependency checking on the test events folder for
> rebuilding pmu-event.c .

Its all now in tmp.perf/core, will move to perf/core as soon as my test
suite finishes.

- Arnaldo
