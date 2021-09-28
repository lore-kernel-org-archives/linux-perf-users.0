Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD7CC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1C96127A
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 19:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbhI1TSe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237134AbhI1TSe (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 15:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FA4D6124B;
        Tue, 28 Sep 2021 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632856614;
        bh=FfXlaxy+LpiN2TDECZvSAwnUFrz442elIyOG2GVbO8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RS6/ltESYmaovDS0Cqh0C2Zyu5s+4KCCmu0kmt3d85oACAGbk/hXyitw3jJXwomrw
         g6LjlLL337rjkmCg9c+yx3ct7XcU+iQkAP/yWrl3apH78gKll3bmRx2WmDpqydkG0y
         k+y+vFU4PN0tdrOyT6GaXZv5V64esUVXAlsFPKYbZXm+BiQnVQffu+XJXFQaTbZ56M
         oi1B+Q5qA43khtNZvu/ukGgWM+xwrCeiR0QeHXg0S+k2lUl5TNtqi4xpoOwN/GBTtp
         Iskw4F3mYC5CmJZMGdzUSNfaMM/QgKSUIRuf2WGyfY7n/pzE3SEW5lVaKLphVaqx3T
         hRmHJ7yy4oA0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FF0B410A1; Tue, 28 Sep 2021 16:16:51 -0300 (-03)
Date:   Tue, 28 Sep 2021 16:16:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, will@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        liuqi115@huawei.com
Subject: Re: [PATCH 1/5] perf parse-events: Set numeric term config
Message-ID: <YVNqI+YFGbX+xiuk@kernel.org>
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com>
 <1631795665-240946-2-git-send-email-john.garry@huawei.com>
 <CAP-5=fVG3_p3Xf3s6FnpSRFwt3+CxitPZwRK0fMbz2t8WZaSEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVG3_p3Xf3s6FnpSRFwt3+CxitPZwRK0fMbz2t8WZaSEw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 28, 2021 at 10:59:42AM -0700, Ian Rogers escreveu:
> On Thu, Sep 16, 2021 at 5:39 AM John Garry <john.garry@huawei.com> wrote:
> >
> > For numeric terms, the config field may be NULL as it is not set from the
> > l+y parsing.
> >
> > Fix by setting the term config from the term type name.
> >
> > Also fix up the pmu-events test to set the alias strings to set the period
> > term properly, and fix up parse-events test to check the term config
> > string.
> >
> > Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Having this would be very useful with an issue I'm looking into.

Thanks, applied the series.

- Arnaldo

