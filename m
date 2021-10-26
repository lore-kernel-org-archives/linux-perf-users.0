Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DC5C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5F760E8F
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 14:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhJZOVL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232907AbhJZOVK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 10:21:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB01460F46;
        Tue, 26 Oct 2021 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635257927;
        bh=8vuq+zVP4l7dlArP45JdQcFl63f+wi5cgcGPnMKLqJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ap+Cic2BZGJkK3P4tvrWUUHsOmER82ZejyaALJfJpDyT0igJiL5ja93n16N4EV3iE
         o8WS4F43HVI5lZgv58wR8zRmMyxUK6MtPViMDW8GfXaX0pOxcM8f7ScnnOzdo5Nm93
         mpcnAqWQo5GsGaVY5BeeYi0atD88xGsXgHVxF0Koxcb1BsCoaJKV4KFGxiB4skk7gq
         d3fuhrbws9yO1KnyI/Qs/ZEgylpz49xeDcxj57dmH0V62VTgXql4ICdONQRTy4uV+p
         bCNOp3+TvyDAtjjeg4IXvslnMneI5giyOX7eAgwWjH97fNgjwGZM11AryrCiTkONUs
         j9SGTcMk9rWtQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82ECF410A1; Tue, 26 Oct 2021 11:18:43 -0300 (-03)
Date:   Tue, 26 Oct 2021 11:18:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf tests: Fix record+script_probe_vfs_getname.sh
 /tmp cleanup
Message-ID: <YXgOQ+4UuHoeLOv8@kernel.org>
References: <20210921131009.390810-1-james.clark@arm.com>
 <CAP-5=fU_CSPv2Kry6ObbfYG4rNJpprhBrFUOJsNugM-AqQ3xoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU_CSPv2Kry6ObbfYG4rNJpprhBrFUOJsNugM-AqQ3xoA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 21, 2021 at 11:07:50PM -0700, Ian Rogers escreveu:
> On Tue, Sep 21, 2021 at 6:10 AM James Clark <james.clark@arm.com> wrote:
> 
> > The temp files are only cleaned up if the test is not skipped, so delay
> > making them until after the skip so they don't get left behind in /tmp.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> >
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied the three patches in this series.

- Arnaldo

