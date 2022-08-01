Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71851C00144
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Aug 2022 17:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiHARs0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiHARsZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 Aug 2022 13:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A57C2DAAB;
        Mon,  1 Aug 2022 10:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C2B6109E;
        Mon,  1 Aug 2022 17:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DF4C433C1;
        Mon,  1 Aug 2022 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659376103;
        bh=VH+9IJa8N2N/pZ14waAEZzza9dSZ+N1KF+5/+D85BNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeWuSZTv033aU1Z1zCAYdh5j8RfiSLieo9TtUZQMKC/acnpSq+TLAFiI6kFP7n+bl
         djMTowEDde/tsuAH/4o1Kk9hVYe0mTFU4h7bJ55+7Ru4xhVt1QH/j9AzYxXq2yIEGE
         a94h8SYgxWaBMw6/nUL7fY4yuhmBSUpeo23pHU8PjQTVKWP14gIExQ1xclH62Ouahy
         fH/yfX2UU0TwmIxUgOHIrrkbxFm70hOGSUbjd+dL9RwHfIt6MA3UKIXH5KJ/0TIEHn
         rGgNC7XZ4v7sEuYcAMey0pp3sgUju3NGImq7/kHxAhfrUBu0g8dLbPvcK26qFy2aUZ
         k4sN+XLJ0HQSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07D3540736; Mon,  1 Aug 2022 14:48:20 -0300 (-03)
Date:   Mon, 1 Aug 2022 14:48:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v3] perf test: Add ARM SPE system wide test
Message-ID: <YugR5LbHqTcweo2c@kernel.org>
References: <20220701230932.1000495-1-namhyung@kernel.org>
 <20220707031352.GB631004@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707031352.GB631004@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 07, 2022 at 11:13:52AM +0800, Leo Yan escreveu:
> On Fri, Jul 01, 2022 at 04:09:32PM -0700, Namhyung Kim wrote:
> > In the past it had a problem not setting the pid/tid on the sample
> > correctly when system-wide mode is used.  Although it's fixed now it'd
> > be nice if we have a test case for it.
> > 
> > Cc: German Gomez <german.gomez@arm.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Tested for both root user and non-privileged user, both works as
> expected:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

