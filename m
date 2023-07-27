Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8FFC001E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Jul 2023 12:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjG0MX4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jul 2023 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjG0MXc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAEF30F3;
        Thu, 27 Jul 2023 05:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7DB61E39;
        Thu, 27 Jul 2023 12:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA5EC433C7;
        Thu, 27 Jul 2023 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460580;
        bh=YEUaN3MAYqvBNyV2BN0EfRdtbsnSlDcYdBV+Ec5bGew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al5StR1U2A5QhAkVjg9jgc8Xl+SdFwMukysvKgeAqH83RA9BmwjXj+oPuFL3gv/SQ
         +Ff3/x6ESWNEXYFWR6Rkb7LjADpheGl4rRvUdvbPAsSa9eivD5gFGEpETwmIJBUSK5
         6RQdYwmlGSS6vPAF5bHCeGcSc3gOIU0B6SswuBbZTdT0ZoH89g5MwrvlX5MFYI6OLp
         dwKx6sZpCqie0ZKmB2z1FjO4M50Or7P+DOAUvO8FnYHzp7s3ptqHaXohOJ4S6Ye+Ru
         oXxhSTKZ+ehFR+bJwXOIP3Iw+Xbu1aGnuRBNNRWbsa7gEKpuhDC4xPzL2qROn0oGvJ
         GB7MoYz1arqVg==
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org,
        James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
Date:   Thu, 27 Jul 2023 13:22:33 +0100
Message-Id: <169045902550.3247310.8131913678229023529.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 20 Jun 2023 15:12:32 +0800, Jing Zhang wrote:
> I add an identifier sysfs file for the yitian710 SoC DDR to allow
> userspace to identify the specific implementation of the device,
> so that the perf tool can match the corresponding uncore events and
> metrics through the identifier. Then added yitian710 SoC DDR
> metrics and events alias.
> 
> Change since v3:
> - Split the CMN and ali_drw patches. This patchset only contains
>   ali_drw PMU related patches. The CMN metric related patches will
>   be in another patchset.
> - Link: https://lore.kernel.org/all/1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> [...]

Applied first patch to will (for-next/perf), thanks!

[1/4] driver/perf: Add identifier sysfs file for Yitian 710 DDR
      https://git.kernel.org/will/c/cbbc6fdd85be

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
