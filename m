Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E9C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501961176
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhDNNRI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhDNNRH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Apr 2021 09:17:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3540600CD;
        Wed, 14 Apr 2021 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618406197;
        bh=FKsRwb7EfPFXFw8CkLf7kCymw5iXZwrFnk3qDeKlUWs=;
        h=From:To:Cc:Subject:Date:From;
        b=u3eVHZNuQlT5y7tSei77rIA05NNn/DFN9H9m5CWQa+g5bQ31BrzdM2ynrJ/Xn/7Wu
         IR2dH/uVkv1LI+q26b598SW4PNz6B6o6H8S1AORBkHPI98hIQgNaVkUPdd9GM391Yj
         gfjpVfUKnHktBjitev+Olfag7EkDzHQ9sPXhmaf31S5bsI1WHQ8cvgEwcMxUAgXxZ2
         B/PUNvNMnkaYkWN/Wf6dRNRnzGbVTAgV/PCC+yck1jW5UKrlJ5XEeRzZFN0OaGhB2W
         7keoRGC36jzlryq9kB8O9R7hbbuRy6JZQZNc0jXtx2Nstffz9oIT8sJb5juKor3Ted
         ubUSOemh+aMQg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [RFC] Improve workload error in 'perf record'
Date:   Wed, 14 Apr 2021 10:16:26 -0300
Message-Id: <20210414131628.2064862-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

	Please take a look,

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf evlist: Add a method to return the list of evsels as a string
  perf record: Improve 'Workload failed' message printing events + what
    was exec'ed

 tools/perf/builtin-record.c |  8 ++++++--
 tools/perf/util/evlist.c    | 19 +++++++++++++++++++
 tools/perf/util/evlist.h    |  2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.26.2

