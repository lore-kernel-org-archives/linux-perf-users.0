Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E0C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Oct 2022 18:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJESYN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJESYM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 14:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D01D0DB;
        Wed,  5 Oct 2022 11:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41532615F9;
        Wed,  5 Oct 2022 18:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1A1C433D6;
        Wed,  5 Oct 2022 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664994250;
        bh=JbdwwCgjNMpYuLISqpgFxX9LIJrUbzsmLwEthcqcwFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NH5nmJUxHQAsXbkpQeEHtE6L6MpAuBvgDsh7xriVeBGEC2pN6CVx7ug/PiimZnWQX
         09SucxMUJ1d+izuNUAZvSWduKZZgcLGilrBotMQCY4FPx5L2QprQWMnfR1GhK2jakH
         OvigDcmFHPYMH+oYSJAJC/mFWex9310O9D/Vl261vB4VENDG/u30kqhadveWIDiHFa
         e/eEe9EDBzn77dGx4IGQ+/R3gt/8mNsKAYuh4CAJrh3ixEHXprkEqvje+Ot9EFeoEw
         S3FPzgRzBCgStoyGdDzt63i5M0uEMIUS1ZmInzWNNum4nemmXB6LGEYeD0Yz6SiiPx
         iidkvwRSeMVVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 255114062C; Wed,  5 Oct 2022 15:24:08 -0300 (-03)
Date:   Wed, 5 Oct 2022 15:24:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] perf record: Save DSO build-ID for synthesizing
Message-ID: <Yz3LyPfSDPcohoXG@kernel.org>
References: <20220920222822.2171056-1-namhyung@kernel.org>
 <20220920222822.2171056-2-namhyung@kernel.org>
 <YysWn/W3+dXlZnYG@kernel.org>
 <CAM9d7cjtrVsccWUOCAtz1LbHoYxx7uV4SCaBMLdME-pdZjmjfw@mail.gmail.com>
 <CAM9d7ch1GG2xjOpPwMf0q88CWtX2DdSiRXDJX6vevTk_1g+USw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch1GG2xjOpPwMf0q88CWtX2DdSiRXDJX6vevTk_1g+USw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 05, 2022 at 10:50:01AM -0700, Namhyung Kim escreveu:
> On Wed, Sep 21, 2022 at 10:55 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Wed, Sep 21, 2022 at 6:50 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Tue, Sep 20, 2022 at 03:28:22PM -0700, Namhyung Kim escreveu:
> > > > When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> > > > it has no idea if it's done already.  Maintain a dsos to check that and skip
> > > > the file access if possible.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > > v2 change)
> > > >  * Remove perf_event__synthesize_{start,stop} and use machine->dsos  (Adrian)
> > >
> > > Will wait till I merge perf/urgent into perf/core so that this applies.
> 
> I think it's doable now :)

Sure, applied! :-)

- Arnaldo
