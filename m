Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CA3C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FC461268
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 14:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKKO52 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKO51 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 09:57:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31CEF60F51;
        Thu, 11 Nov 2021 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636642478;
        bh=6Dgw8HyF1/nOtZxLMcnB3+PnISjW7N0dRiQF9PMuKNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcceayDV7PmmjRw5NKwDyYdx9BD75thwhBNMvUFOJLQBm1ipvyNxgstwQy3rqaeum
         GHUpT7x9tFTNh5rPE1h1uOlY0uSnHDUGkoAmOJXMLCF8spOE5w+M0QpYMu1T72dht4
         SuHf1d5jgYuFSLvDKuYFBMuv6ihe+Baw/Tfw34oh8PvqVAQ9B7y3rIRFXA9njmLPb7
         SUys5sZsGhqsNuBomQUrX5SoabwGB+FtxeRWlpwC8X9UznUEYsrq2UPgqpVw/lNQ7C
         6GCBd2fxdE4hGWSdai7PgA1+gS1hPOheZoPLaNh8DgvYM4SZuvkeVFWvC5PUPUMqIv
         WQn8B+htk2pAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A804F410A1; Thu, 11 Nov 2021 11:54:35 -0300 (-03)
Date:   Thu, 11 Nov 2021 11:54:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] perf arm-spe: Add snapshot mode support
Message-ID: <YY0uq/dVOLmkR5Iv@kernel.org>
References: <20211109163009.92072-1-german.gomez@arm.com>
 <20211111084621.GC106401@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111084621.GC106401@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 11, 2021 at 04:46:21PM +0800, Leo Yan escreveu:
> Hi Arnaldo,
> 
> On Tue, Nov 09, 2021 at 04:30:06PM +0000, German Gomez wrote:
> > This patchset adds snapshot mode support for arm-spe.
> > 
> >   - [PATCH 1/3] implements the minimal callbacks to support recording in
> >     snapshot mode.
> >   - [PATCH 2/3] implements the find_snapshot callback in order to handle
> >     wrap-arounds in the AUX buffer.
> >   - [PATCH 3/3] adds a test for spe snapshot mode.
> 
> I have verified this patch set on Hisilicon D06 board, please consider
> to pick up:
> 
> root@ubuntu:/home/leoy/linux/tools/perf# ./perf test -v 85
> 85: Check Arm SPE trace data recording and synthesized samples      :
> --- start ---
> test child forked, pid 17083
> Recording trace with snapshot mode /tmp/__perf_test.perf.data.MI2iX
> Looking at perf.data file for dumping samples:
> Looking at perf.data file for reporting samples:
> SPE snapshot testing: PASS
> test child finished with 0
> ---- end ----
> Check Arm SPE trace data recording and synthesized samples: Ok
> 
> BTW, you could see German has another patch set for enabling pid/tid
> for Arm SPE tracing [1].  I confirmed that the pid/tid patch set and
> current patch set have no conflit, and don't need worry the dependency
> between these two patch sets (so you could apply two patch sets in any
> ordering).

Thanks for the clarifications, applied, its out in my tmp.perf/core
branch, that still needs some fixes for buiding on arm related to a
recent patchset for 'perf test' from Ian Rogers, as soon as that is
fixed it will be set in stone in perf/core.

- Arnaldo
