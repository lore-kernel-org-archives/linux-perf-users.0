Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746CC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiBWKDP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 05:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiBWKDO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 05:03:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29A8A322;
        Wed, 23 Feb 2022 02:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D82FB81E8F;
        Wed, 23 Feb 2022 10:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B37AC340E7;
        Wed, 23 Feb 2022 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645610564;
        bh=cks2kgUvdKn9yDgezou3U+aY6IvjpnR2cUfofxlMj+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRHmOuU36eoGAr9V14rHJUhbunESuk0OXwMyAt4xUf0FKKEmfVlXGX3/aiqaCwz/f
         ONKt4CtIO2AlG9DhygHFT7O7TldGYkqsaYfXdeQat+huiQrLPsAasCuFdhAPKsYj6q
         QW2QD4ssaN1ul98IzUEFTsZ4fydKBYN+2uOrVOS/5sfo1PD+n6yM0g6Mdjkb5k3RtK
         hgB45kMZ/sJ5CUJ6lStizDKbW0n7Pnmzp7SJ2jP2UWVao0S+5c9wQfcPIzucLYseIX
         ZDbA0Wd+1ORRBRLtNZyeA/tYuh0vm8YmTruqNvQpDKChiqkKxGxXFyASsloLUtyJOH
         zkmqapedNuJ5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2C0B400FE; Wed, 23 Feb 2022 07:02:40 -0300 (-03)
Date:   Wed, 23 Feb 2022 07:02:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf arm-spe: Use advertised caps/min_interval as
 default sample_period
Message-ID: <YhYGQO+DPwcWyT8i@kernel.org>
References: <20220221171042.58460-1-german.gomez@arm.com>
 <20220223011436.GA414932@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223011436.GA414932@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 23, 2022 at 09:14:36AM +0800, Leo Yan escreveu:
> On Mon, Feb 21, 2022 at 05:10:42PM +0000, German Gomez wrote:
> > When recording SPE traces, the default sample_period is currently being
> > set to 1 in the perf_event_attr fields, instead of the value advertised
> > in '/sys/devices/arm_spe_0/caps/min_interval':
> > 
> > Before:
> > 
> > $ perf record -e arm_spe// -vv -- sleep 1
> > [...]
> >   { sample_period, sample_freq }   1
> > [...]
> > 
> > Use the value from the above sysfs location as a more sensible default
> > (it was already being read, but the value not being used)
> > 
> > After:
> > 
> > $ perf record -e arm_spe// -vv -- sleep 1
> > [...]
> >   { sample_period, sample_freq }   1024
> > [...]
> > 
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> The change looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

