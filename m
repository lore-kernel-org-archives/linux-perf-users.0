Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA76EC6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Sep 2022 20:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiITUQb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiITUQ3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Sep 2022 16:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BD736844;
        Tue, 20 Sep 2022 13:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E47E62D0F;
        Tue, 20 Sep 2022 20:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F5C433C1;
        Tue, 20 Sep 2022 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704987;
        bh=+ChkXvaDMIaT28k+Efej/RqaJDrHwaiGxGqSiV6vfE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtB9ko9EVd0lVma9cOVnGhv/tw7EosatqrQRCxL6Z9YXfLxzhLgz7uqSuS9dOARLW
         StZhvNjujufILHmLzIwV68r5FZKIxEetT58Ui/vilyXV97rwmrAhfwQbxMmLWqN3/P
         uW3d4kVWyvb0pYbcQQSdGNZmZiB2+QzhPgeBZ7Jkc90r8cX7PYHinysUjvu13DGKUt
         4QXKFSEMuS5SEOnJGDBtPqzmK5/Wy3bJUQRCE2ce5PPB1ESSgKPX5ufMQm6PuAibGg
         WDQStCyfsIhQKCJ6gzr4WJisMEwNCEvPMpvvWJxHgO8aI9l8dj6/xbva1yyi3NT+iL
         FWBd6DvSROzGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4106540856; Tue, 20 Sep 2022 21:16:25 +0100 (IST)
Date:   Tue, 20 Sep 2022 21:16:25 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 0/2] perf tools: Fixes for mixing per-thread and per-cpu
 mmaps
Message-ID: <YyofmSXYtJoFb0Mg@kernel.org>
References: <20220915122612.81738-1-adrian.hunter@intel.com>
 <CAM9d7chkt13mLFfFhYZJpHHYi83-f-BxdGs1Eyw8sF9X9BX2jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chkt13mLFfFhYZJpHHYi83-f-BxdGs1Eyw8sF9X9BX2jQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 16, 2022 at 11:28:35AM -0700, Namhyung Kim escreveu:
> On Thu, Sep 15, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > Here are a couple more small fixes.
> >
> >
> > Adrian Hunter (2):
> >       perf record: Fix cpu mask bit setting for mixed mmaps
> >       libperf evlist: Fix polling of system-wide events
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> >
> >  tools/lib/perf/evlist.c     | 5 +++--
> >  tools/perf/builtin-record.c | 2 ++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> >
> > Regards
> > Adrian

-- 

- Arnaldo
