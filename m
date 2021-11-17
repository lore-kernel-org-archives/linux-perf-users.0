Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AACC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C510E61B50
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhKQR1n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhKQR1n (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 12:27:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77205617E3;
        Wed, 17 Nov 2021 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637169884;
        bh=du695jOxg2jvaQjQ9GNpG68580vqmHRYCGSwbBGthsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTAx+cLCOeIZmMpYijbk3JOZsa6UMMWFlgXInPKmRJciyFN43lz/zneSWUV7cBY4P
         L87oLIgcmc7AUfkZ/ke6JY1YLvN+t6tzhHvEZYZa+ML7FQDxE2Xeov5bA7lPFTNG7l
         7CD4brxKJ7we9S2AntKL1CvmYEgTP0E3P0tqkUjC3UnkVo2/3PDNVZwLBofxmOBOh/
         /Vm/aT6H208iCQkjpK2WSSMzeDsAUc8NIGs9yk8e8OtYD733VRFTwVDWqYxKH6F+8p
         450V28GU6XSiahMPUCwbbjYrvVhmAxq+kQuuDfZy5TMYe+LqBNqBUEjOrYFsaVweBG
         VZX0p/Jnil5Mw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49C014088E; Wed, 17 Nov 2021 14:24:41 -0300 (-03)
Date:   Wed, 17 Nov 2021 14:24:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] perf arm-spe: Inject SPE samples in perf-inject
Message-ID: <YZU62ekT9/NimdSq@kernel.org>
References: <20211105104130.28186-1-german.gomez@arm.com>
 <20211105104130.28186-2-german.gomez@arm.com>
 <5163f41f-2337-6557-ca91-fb2c66738872@arm.com>
 <YZUf5zu4aOfoIhFl@kernel.org>
 <aa79a8eb-e7fa-ad81-f4a3-a843b63020b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa79a8eb-e7fa-ad81-f4a3-a843b63020b2@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 17, 2021 at 04:27:27PM +0000, German Gomez escreveu:
> Hi Arnaldo,
> 
> On 17/11/2021 15:29, Arnaldo Carvalho de Melo wrote:
> > [...]
> > Next time please expand this explanations a bit more: why should we
> > inject such samples? Is this enabling some new mode of operation, fixing
> > something, what is an example of output before this patch and after it?
> I will keep this in mind, thanks. In this case the support was missing
> and I included the context in the cover letter but not the commit msg.

Got it, I'm adding it to the cset comment:

-------------------------------------------------------------------------------

perf-inject is currently not working for Arm SPE. When you try to run
perf-inject and perf-report with a perf.data file that contains SPE
traces, the tool reports a "Bad address" error:

  # ./perf record -e arm_spe_0/ts_enable=1,store_filter=1,branch_filter=1,load_filter=1/ -a -- sleep 1
  # ./perf inject -i perf.data -o perf.inject.data --itrace
  # ./perf report -i perf.inject.data --stdio

  0x42c00 [0x8]: failed to process type: 9 [Bad address]
  Error:
  failed to process sample

As far as I know, the issue was first spotted in [1], but perf-inject
was not yet injecting the samples. This patch does something similar to
what cs_etm does for injecting the samples [2], but for SPE.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210412091006.468557-1-leo.yan@linaro.org/#24117339
[2] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/cs-etm.c?h=perf/core&id=133fe2e617e48ca0948983329f43877064ffda3e#n1196
-------------------------------------------------------------------------------
