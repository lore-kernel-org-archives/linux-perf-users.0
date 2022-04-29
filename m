Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6EC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Apr 2022 18:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380110AbiD2Srr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378784AbiD2Srq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Apr 2022 14:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B9DCE650;
        Fri, 29 Apr 2022 11:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0722B83775;
        Fri, 29 Apr 2022 18:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 539CFC385A7;
        Fri, 29 Apr 2022 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651257865;
        bh=/BheFzTV8YEtMZHnftdKshC1GQr6usshhH99m78+kWQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gN8jqTPdeKs1vqBo0cd2cTdAS+SCHQJ6Un8nAk0IDomdC6X0/otKlzXjmBXYmDJNt
         +jCHsIjpYGV8WjNAtZ3+tI8ABdyjoqzSzPQK20KseLrZHrsS2yfNTf3KYgPEX4KsBq
         OmvB2+Tdb6j1xPhddHc9IM+qeYpnpdpcrH+BbCaAbSVATFfj1sumCSI3LOjBfihukc
         eD1GsoCvm5q6sJw+Cp7X0BlmxIm+vYjvkfi+wNsu+vjogqvgox3XUQn/zdootcuI+1
         a/MDsmPy25B9q+tyFqUb45IjF68HTkLFOTdg8rU6nUL+KDfXkYajh2nYNBxdUzsIxQ
         BHvYRVyDEMDVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E5E8E5D087;
        Fri, 29 Apr 2022 18:44:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220429125712.527713-1-acme@kernel.org>
References: <20220429125712.527713-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220429125712.527713-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-29
X-PR-Tracked-Commit-Id: a5d20d42a2f2dc2b2f9e9361912062732414090d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e71713c9e75c34fc03f55ea86b381856ca952ee
Message-Id: <165125786524.12833.3296469943421128066.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 18:44:25 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 09:57:12 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e71713c9e75c34fc03f55ea86b381856ca952ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
