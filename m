Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B1BC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF2F60FD8
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 17:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhJESAP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 14:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJESAO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 14:00:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECBF560F38;
        Tue,  5 Oct 2021 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633456704;
        bh=fGEQ/Kh6I+hpl2vaInO9ive8KNBkj7H+QlaS2vgQWPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfuUWu2adxlvevelEwEloBqVcapbe/s/56NvMxmycuIlkxafkigYvnTTK2Su0V/G0
         fa7x20DnYpSBV7ZNu8wv84fC5sMUBRkwo+ZbprilphJwccj8Cf9RQkTnCvtxDaTy/J
         gOV3AcZA/+W6aCY1LeW3nkt+dg+28MkSTyQr7uUk7tosvVEQfxuA9WDEmL6pom6MgI
         IFsVKnec/CejMGWZm802zvBktm4h6A/sbNrKqSXcMJVbJGFphg0e6nK7TQaiXwmdII
         h13ppKMJ7WD4Tl1M16OCUBQFaIDOHBsqRXFpwV1GylUkjDKgc5jAWWiaV26xPQD+dM
         8Y7vhYDWi7n8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 962B6410A1; Tue,  5 Oct 2021 14:58:21 -0300 (-03)
Date:   Tue, 5 Oct 2021 14:58:21 -0300
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
Subject: Re: [PATCH 4/4] perf vendor events: Add the Neoverse V1 to arm64
 mapfile
Message-ID: <YVySPe1LRz4bGZFy@kernel.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <20211004160008.21645-4-andrew.kilroy@arm.com>
 <424d066b-30d5-4512-bd8c-15b700af2864@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424d066b-30d5-4512-bd8c-15b700af2864@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 05, 2021 at 10:33:49AM +0100, John Garry escreveu:
> On 04/10/2021 17:00, Andrew Kilroy wrote:
> > This is so that performance counters for the Neoverse V1 appear
> > categorised upon running 'perf list' on the CPU.
> > 
> 
> this really belongs with the previous patch

Waiting for a resolution on this one.

- Arnaldo
 
> Thanks,
> John
> 
> > Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
> > ---
> >   tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > index c43591d831b8..31d8b57ca9bb 100644
> > --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > @@ -18,6 +18,7 @@
> >   0x00000000410fd080,v1,arm/cortex-a57-a72,core
> >   0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
> >   0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
> > +0x00000000410fd400,v1,arm/neoverse-v1,core
> >   0x00000000420f5160,v1,cavium/thunderx2,core
> >   0x00000000430f0af0,v1,cavium/thunderx2,core
> >   0x00000000460f0010,v1,fujitsu/a64fx,core
> > 

-- 

- Arnaldo
