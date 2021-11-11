Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C11DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139D361268
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKKOwW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:52:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232778AbhKKOwV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 09:52:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A4F6611C9;
        Thu, 11 Nov 2021 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636642172;
        bh=m63EtrPwpm6LnSWd8XhfbXeih+SRv8lwKj/IxX6ZAWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mu/MNduVlth7zaektHVNwNZkfnCQCeBmBeUSMQUle089puuPH2BHHC9Bwn7AfjXDP
         hfVYUZ7DYMzTGSwscGsvK05srH3rv6O8Ty1uHfmefN7A95hKtUDAGthDgZbJjSroyj
         Vv0Jii8yOR3Piqr/9U5Yib677Tu/qMYPNDJbfmzjANKnepcAZs/uoh5FuewDf5VBln
         lCxi0gh1CNSytxmAi18WJYxDRNBCSeAQ013FUbaOuxkSdIi5AUeE8LDoi/hRmKjx1T
         PRC8UAsumvqTEt1yMUOHCfp3VcifdCocLjfjTyWpYINx37gbVG+DFSGocBiqq6lFje
         iCVGH7PZwyVMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E620410A1; Thu, 11 Nov 2021 11:49:29 -0300 (-03)
Date:   Thu, 11 Nov 2021 11:49:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] perf arm-spe: Track pid/tid for Arm SPE samples
Message-ID: <YY0tebaDnTxx3v84@kernel.org>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211111072714.GB102075@leoy-ThinkPad-X240s>
 <20211111132647.GC106654@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111132647.GC106654@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 11, 2021 at 09:26:47PM +0800, Leo Yan escreveu:
> On Thu, Nov 11, 2021 at 03:27:14PM +0800, Leo Yan wrote:
> > Hi Arnaldo,
> > 
> > On Tue, Nov 09, 2021 at 11:50:16AM +0000, German Gomez wrote:
> > > The following patchset is an iteration on RFC [1] where pid/tid info is
> > > assigned to the Arm SPE synthesized samples. Two methods of tracking
> > > pids are considered: hardware-based (using Arm SPE CONTEXT packets), and
> > > context-switch events (from perf) as fallback.
> > > 
> > >   - Patch #1 enables pid tracking using RECORD_SWITCH* events from perf.
> > >   - Patch #2 updates perf-record documentation and arm-spe recording so
> > >     that they are consistent.
> > >   - Patch #3 saves the value of SPE CONTEXT packet to the arm_spe_record
> > >     struct.
> > >   - Patch #4 enables hardware-based pid tracking using SPE CONTEXT
> > >     packets.
> > 
> > I have tested this patch set, it works well on Hisilicon D06 board,
> > please consider to pick up.  Thanks!
> 
> Hi Arnaldo,
> 
> Please hold on this version and German will respin a new patch set for
> a found issue.

Ok

- Arnaldo
