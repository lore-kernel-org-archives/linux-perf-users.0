Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103FCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CCC610CC
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 18:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhIBSUs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346984AbhIBSUr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 14:20:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E725D6109E;
        Thu,  2 Sep 2021 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630606789;
        bh=6PCP6x1TrAUpEBuJ8RnRPOpyp3DyHDAixWhFFpW21LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfDMw5mapObRoNPE2kNZW1TBYpaGkssa9TF2wSAsW3m7nqeGQDmKqbYAXTF1E3g2S
         aIX2joikA/06bM3a6ICQtFTyMvPkn1qr85VWpq6Q0PNpMnIlESgw8cqO0EHz5KPl1m
         JlmiV0KJbyMkJ57a00NM8deCtMOKWgAnqBexN/YerO6GeX/e2T7xcX6jl+y49Z6c/T
         fIhUDzxFwgCaYXlnYw1ErMmfSXaDbLlldWLRI+UHR79SLOOo6pXX9HZMqEfHL265NI
         SRXj8HAN/6ARvdkvWJ0j/1hoisoJk7MoGIaHGCY8VfDjHOHeeVQD52nAGURgieeVyK
         nPKcYyCdIqNwg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 70AB44007E; Thu,  2 Sep 2021 15:19:45 -0300 (-03)
Date:   Thu, 2 Sep 2021 15:19:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <YTEVwVCWoS8cgqql@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
 <YS+iOrcPTzQfmbqU@kernel.org>
 <20210902174851.GB1078000@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902174851.GB1078000@p14s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 02, 2021 at 11:48:51AM -0600, Mathieu Poirier escreveu:
> Hi Arnaldo,
> 
> On Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > > for a potentially user facing issue. If we add a new magic number in
> > > > the future, perf will be able to report unrecognised magic numbers.
> > > > 
> > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > 
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Applies cleanly to my tree, test building it now, holler if there is
> > something that prevents it from being merged.
> 
> Have you already merged this? 
> 
> If so than let it be.  Otherwise please hold off as I'd like to take a look,
> something I intend on doing next week.

Ok, I can remove them from my local branch, but this may make this miss
the v5.15 merge window, please advise.

- Arnaldo
