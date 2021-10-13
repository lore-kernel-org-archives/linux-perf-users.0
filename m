Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B63C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18060F94
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbhJMHxg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238660AbhJMHxe (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 03:53:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E6A860E97;
        Wed, 13 Oct 2021 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634111491;
        bh=jxBe3EdmOkp/uf/o/Y4dxlDbjXr7z5Jy5FzRlJAf0iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vILv/kn38IFQtIG005rvJ82OGKrmrcTLR2kW4PIyv1aDZi0QVHFfftbMghZ3/V/cU
         sytZdYnQDpJkIr22aL4i2CKSyiWhy5IDVN1TTGBxh8lNlWHLtsK3RFeCrGrLchauNB
         bpezcsIyMd3Zd0w4jN/dscn89MfWjHYKsX80lR3njxJ+PlA9SzZJegZWwmlR6BsVGF
         Y0L2n4/Y/3NFjhsVkFM2Se4siag5ymMuHvobek6QusPZEu8VJwo/+d4CVr7qWFBDpv
         yl87VkqK+MMHWfJ2AG1ueH+v7bbZfWHjTqM+z4X84L3w9D5LqOtDSh3NwjwMyYDlZu
         rlhqmGpEfatFQ==
Date:   Wed, 13 Oct 2021 08:51:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211013075125.GA6701@willie-the-truck>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013003916.GA130842@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 13, 2021 at 08:39:16AM +0800, Leo Yan wrote:
> On Mon, Oct 11, 2021 at 04:55:37PM +0100, German Gomez wrote:
> > On 06/10/2021 10:51, Leo Yan wrote:
> > > On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:
> > >
> > > [...]
> > >
> > >>> So simply say, I think the head pointer monotonically increasing is
> > >>> the right thing to do in Arm SPE driver.
> > >> I will talk to James about how we can proceed on this.
> > > Thanks!
> > 
> > I took this offline with James and, though it looks possible to patch
> > the SPE driver to have a monotonically increasing head pointer in order
> > to simplify the handling in the perf tool, it could be a breaking change
> > for users of the perf_event_open syscall that currently rely on the way
> > it works now.
> 
> Here I cannot create the connection between AUX head pointer and the
> breakage of calling perf_event_open().
> 
> Could you elaborate what's the reason the monotonical increasing head
> pointer will lead to the breakage for perf_event_open()?

It's a user-visible change in behaviour, isn't it? Therefore we risk
breaking applications that rely on the current behaviour if we change it
unconditionally.

Given that the driver has always worked like this and it doesn't sound like
it's the end of the world to deal with it in userspace (after all, it's
aligned with intel-pt), then I don't think we should change it.

Will
