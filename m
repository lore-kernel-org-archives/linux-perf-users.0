Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBFDC43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jul 2022 05:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiGMFYK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 01:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiGMFYH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jul 2022 01:24:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFF599E7
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Jul 2022 22:24:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s206so9495119pgs.3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Jul 2022 22:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ut+uaIBNWmPiRpGqEhRFI1vh60vpzjIhzJJbDXdJFqA=;
        b=HMXfCuTvx4TnBNFFgpcFsDLFe1hlKIJA7x8c8dqAe2c/E9vTXPWHQ8JUQi91nRQdXy
         9vp4LhwOvxd9fuxgBHfT2NNQE+mUbzJp4CHHD+YYsgyBiDgzJSEoRCLhysuARQ14LSrB
         yt+QmoWnMWFaLYTALTLgHsOzAVp6pi3ow5vmkJYuOpoRPEdwvzEB4ReaJS/jmh/AKzzB
         PpPlbJEzeeAWR6Up4a3iQM+QsHhFIqzwaTbHvLphECmYdKkApEnSTkkxpfnNaKdEnc8X
         PBoP/7QYKfvJbjNZIO4PTKOCGQk1L48sbi7SN2KXoFOAUbYgoLTPWfvJ8smAFu5zlLcF
         h9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ut+uaIBNWmPiRpGqEhRFI1vh60vpzjIhzJJbDXdJFqA=;
        b=VEJEkffGT6Lvu035thtvCEZ+Bth+K+7fCGDF7AqIoyxnVVcvNNQvw5l/TbcSr24LEk
         6pBe1PTHtRfD8gEM5ePdmQFTmThr/m5UcaFC+vHAVPEqfwluzivWrPG6IVXnNPBVhCAb
         2vYlex2I0tDhMxqTud8TuQNLKlQcI9PTxEk4qE+PfB9Kf90GKLgkyiN094oAE3RTvbOT
         kDXWAscUZVOVrdOubQLleSm9M1NCSILKjl1IGZHTJzT42omPbltPCnJElLo6AlNVhtvx
         7TFY+5teP+/HPjFyPVATEGlnlUk8TtfMbpxIy3PgQfoOP9jolGf3gXkJBJb3L/CAL7Or
         qTHA==
X-Gm-Message-State: AJIora9dNQvaKu6cYeVCNLRZej0ti+PSVSZwaqs81mViQycgdlqH2coE
        XfXKJNtZ/EkcExhxqQWS97qEow==
X-Google-Smtp-Source: AGRyM1tS8AknxcV8aZ7Iz2A8hueX4OaTh7+j7rWcVd0S1GN+RwwiWPPrquyEoWoa+nrMVRTpzesPEQ==
X-Received: by 2002:a63:f355:0:b0:419:8dfd:45d0 with SMTP id t21-20020a63f355000000b004198dfd45d0mr1531053pgj.226.1657689844535;
        Tue, 12 Jul 2022 22:24:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h14-20020a056a00000e00b0051bbe085f16sm7792615pfk.104.2022.07.12.22.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:24:03 -0700 (PDT)
Date:   Wed, 13 Jul 2022 13:23:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: A patch series improving data quality of perf test for CoreSight
Message-ID: <20220713052359.GA1354743@leoy-ThinkPad-X240s>
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 12, 2022 at 02:57:36PM +0100, carsten.haitzler@foss.arm.com wrote:
> This is a prelude to adding more tests to shell tests and in order to
> support putting those tests into subdirectories, I need to change the
> test code that scans/finds and runs them.
> 
> To support subdirs I have to recurse so it's time to refactor the code to
> allow this and centralize the shell script finding into one location and
> only one single scan that builds a list of all the found tests in memory
> instead of it being duplicated in 3 places.
> 
> This code also optimizes things like knowing the max width of desciption
> strings (as we can do that while we scan instead of a whole new pass
> of opening files). It also more cleanly filters scripts to see only
> *.sh files thus skipping random other files in directories like *~
> backup files, other random junk/data files that may appear and the
> scripts must be executable to make the cut (this ensures the script
> lib dir is not seen as scripts to run). This avoids perf test running
> previous older versions of test scripts that are editor backup files
> as well as skipping perf.data files that may appear and so on.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Just remind, you could use the command like below to generate patch
set with cover letter, version number, etc:

  $ git format-patch -v6 --cover-letter COMMIT_HASH -o patches/

Don't need to resend patch set for only this purpose, but it's good
later to use cover letter for description for big patch set, and
version number is important for maintainers to easily know which is
the latest version for merging your patches.

Thanks,
Leo
> 
> 
