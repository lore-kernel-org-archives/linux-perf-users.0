Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F1C433DB
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 13:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56B123A56
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbhAVNwr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbhAVNwo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 08:52:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8767523A03;
        Fri, 22 Jan 2021 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611323524;
        bh=rsY0neGKErm0gSWeAP5jwwVMBa+/sA1d5id0WJlnf7M=;
        h=From:To:Cc:Subject:Date:From;
        b=sl4ggWDq4bBWBKmUA2dz8ssf+eyThAxT6LiKws7OLJRfxdKIVv/TGF/H2FRyw0Kmp
         K6t2kfWO7m6x3RxcK4FO6dSEJZTyqFxmP85xUKmSpjNTHgh5tKhxpvAigQJDsFPcV8
         nCvUIi6s1S04OqRXbJtmO7Q/GqgBfl/K2JbOexCsJD+Iav26a83BAyhBgyrn0OPg77
         SP57buZdPcT+OryC51A4hapFC4T9UiS8A/IUC1klTEenbgQJHZPrZobsUI4SoYi/AE
         NWhBHwMZPzMiIN80EPv6lxDsATTHXV0l1KGt9AeVJhcmhM0E2as3khiSQYgTEj0RTr
         QmK71GI0e1GcA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.11, 2nd batch
Date:   Fri, 22 Jan 2021 10:51:56 -0300
Message-Id: <20210122135156.608434-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 9f29bd8b2e7132b409178d1367dae1813017bd0e:

  Merge tag 'fs_for_v5.11-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2021-01-21 11:45:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-v5.11-2-2021-01-22

for you to fetch changes up to 8adc0a06d68a2e433b960377e515e7a6b19b429f:

  perf script: Fix overrun issue for dynamically-allocated PMU type number (2021-01-21 17:25:33 -0300)

----------------------------------------------------------------
perf tools fixes for 5.11, 2nd batch:

- Fix id index used in Intel PT for heterogeneous systems.

- Fix overrun issue in 'perf script' for dynamically-allocated PMU type number.

- Fix 'perf stat' metrics containing the 'duration_time' synthetic event.

- Fix system PMU 'perf stat' metrics.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-fixes-v5.11-2-2021-01-22

Adrian Hunter (1):
      perf evlist: Fix id index for heterogeneous systems

Jin Yao (1):
      perf script: Fix overrun issue for dynamically-allocated PMU type number

John Garry (2):
      perf metricgroup: Fix for metrics containing duration_time
      perf metricgroup: Fix system PMU metrics

 tools/lib/perf/evlist.c       | 17 ++++-------------
 tools/perf/builtin-script.c   | 18 +++++++++++++++++-
 tools/perf/util/metricgroup.c | 16 +++++++++++-----
 3 files changed, 32 insertions(+), 19 deletions(-)
