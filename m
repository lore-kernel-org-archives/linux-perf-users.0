Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4EC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 22 Jan 2022 10:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiAVKS7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 22 Jan 2022 05:18:59 -0500
Received: from mout02.posteo.de ([185.67.36.66]:45051 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbiAVKS7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 22 Jan 2022 05:18:59 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id BAC86240101
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Jan 2022 11:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1642846737; bh=e+72hSmdYOo6RbSzyQceh1NFpEMaGK10Z76+LR1K/IQ=;
        h=Date:From:To:Subject:From;
        b=E5/ZT81WL5OhFbxjDmfs7XWhjyXDXjX8PCPTXuv8Ui1sSBAwkXwczYdmu5sFwObDl
         V95kkQes3fRmuUKyDuZ4v9CP3t7isdTwbp9cAsFI1rS46uIGgLyIvSXszf2rvNSMd8
         lXxtTXg2PHFEaI2UzPbf029s1/XiHsktyNMoFBIKPr2w2m58PxywHuepVXJXTuDDez
         COUopgL/OsESrBEWe+0lClnC4JA888nol7xBJKJnP9YSA4O/8X1lC5/wLwmz8lU+hP
         Xz9gieFahzCd6cGtlGxrT+IMU/5MRVculrT1kmT9TCnDZ/2RwUXMG1o1qxBUaQtvQm
         0LUdie4GdXmug==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JgsfT1lCvz9rxL
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Jan 2022 11:18:57 +0100 (CET)
Date:   Sat, 22 Jan 2022 10:19:58 +0000
From:   xaizek <xaizek@posteo.net>
To:     linux-perf-users@vger.kernel.org
Subject: [bug report] --tui should not be silently ignored
Message-ID: <YevaTkzdXmFKdGpc@zx-spectrum.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

(Mind that I'm not subscribed to the list.)

If slang isn't available during compilation time, there is a warning at
build time.  However, users won't see it and will scratch their heads
when `--tui` has no effect as I did 5 years ago and just found out that
it still behaves the same (yes, I didn't report it then).

Please print a warning that `--tui` is being ignored if perf was
compiled without slang or even make it an error (e.g., don't define the
option), but don't silently ignore the option.  I had to use strace and
then grep sources to understand why TUI doesn't work.  Documentation might
also need an update to mention that availability of `--tui` depends on
whether slang was found during build.

Regards,
xaizek
