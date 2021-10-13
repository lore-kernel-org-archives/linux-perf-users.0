Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34578C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C97061139
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 15:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJMPa6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhJMPa6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 11:30:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EAE961056;
        Wed, 13 Oct 2021 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138934;
        bh=roaz9HLeh1/B7nUIrCshrTEHqO19G7n5foigwr4B66U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJ6LOzyiuHQzwpyZwQVOZit0h2VWHCjh5W8TufUqpl0DmLva0m6KMwZQwNJHnIsum
         /N7ojWZHXg9rVH19b3xAKQxkgsaJr/+ssfS/UzZ9NIp6u9k5+CzCvAdKxmsGnzAVOM
         1txmMTXNFGjm2lg8EuiXe+1iJbUjZjGnCJGFPCBkJyVSJ8zfxYNfl7Bb4DFbicTvC2
         R9Zv3sNIJG0H66IbBlZM+jXnAgZ0wglV/t90fdRETN090+LV4fa/sqZbRBpgCwWdt+
         6SVAF1C3daU4hdDb6TFHFFWyjxQlB/dHZmXZaRtG16O0ANBsWympcWEkuiD4Q+KqLN
         LQ3Bc+EWroh6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F05F6410A1; Wed, 13 Oct 2021 12:28:50 -0300 (-03)
Date:   Wed, 13 Oct 2021 12:28:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] perf vendor events: Categorise the Neoverse V1
 counters
Message-ID: <YWb7Mrh8QYSMgPjl@kernel.org>
References: <20211006081106.8649-1-andrew.kilroy@arm.com>
 <20211006081106.8649-3-andrew.kilroy@arm.com>
 <03152b9d-2ad1-7bd3-e5a7-fc899c8c567c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03152b9d-2ad1-7bd3-e5a7-fc899c8c567c@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 06, 2021 at 09:38:27AM +0100, John Garry escreveu:
> On 06/10/2021 09:11, Andrew Kilroy wrote:
> > This is so they are categorised in the perf list output.  The pmus all
> > exist in the armv8-common-and-microarch.json and arm-recommended.json
> > files, so this commit places them into each category's own file under
> > 
> >    tools/perf/pmu-events/arch/arm64/arm/neoverse-v1
> > 
> > Also add the Neoverse V1 to the arm64 mapfile
> > 
> > Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> > ---
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> Note: for the other 2x patches in the series, you should have picked up my
> reviewed-by tag for v2 (unless they have changed significantly from when the
> tag was originally granted).

Right, I'm picking it up this time, thanks!

- Arnaldo
