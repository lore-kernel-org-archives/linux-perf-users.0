Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94416EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 05:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFWFp2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 01:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjFWFp1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 01:45:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430141FEF
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 22:45:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc9483b506fso421523276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687499125; x=1690091125;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xG7S9EdmjVVI6rCoFSNq3FA5xO2SVwNz93G04XmDDpE=;
        b=68Z680TG3vm/v6niWksrjQzjzAkc3G3TDkGOKUG0WoHhGqC0SVX7RPuBg0oh4W0yb7
         ruNpsGw1efaC8IOZv/zZjsG+odZmV5qqfWTC4ql2/Er/UraJSmAkvga43/PK4zjlQyXb
         tSvt3LUqCBpryJG57liUyDuOKaG8D+Uhv3Z6Nr5boOIqM96NRC/3C/HgjXblgkomnHLy
         hF+R8tXRjk3uMduojw203VtZx7lk9zo3aWz0GTQD4bGV6M44b24akj34EIa2YkRGTg0b
         iA+7hLoMGQ0bRwqnNF1LuWNInTPRS8bC6D6/oD5brKW73tBJxNGSD64EwCK7tl2JpyG1
         BLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687499125; x=1690091125;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG7S9EdmjVVI6rCoFSNq3FA5xO2SVwNz93G04XmDDpE=;
        b=j8VQuJTwwYzdEJT5QXr6eQJJ0f14yhiUdgQl2X4ULehfz7Xdh41lBpesVwKqRYrGPv
         j7oxu3U3SWwY80N1yij6MparwWwoT3c/Qtm82w0sQDhsr9sUUC9vkMssm+GUNEB6IYjT
         iiaqTxyyy7bBtzUjgmRx+ZD+4VvttU3QJm2MHCbtjl7KMbw21AkIDdmtmxTDURBVU/lM
         A9OlOVk0rvBsIqvGpES1z1XoX5liENhzJ58GuAOFaIYAost+hfXOefllpUMGoY7ZiRsm
         s1PObs0/Glkr7cDQIA1rPRce30c+/maVNHW9qn0kj+ej+QMnjTIWNWbKQdykUBC0vkQx
         BxAg==
X-Gm-Message-State: AC+VfDypfTPNBSbwKEtK4mrWSzYL2lp2fniV4O+Z0Zv7LGr4w9huVlVj
        1oxt5B6pH9/JmT5tN9rajethLetWkXAE
X-Google-Smtp-Source: ACHHUZ6g4NeBMT1mM78S4L8pcMUlh/TQSBMVetvWi1J1ml1BVg/J0qxr8XORzrMCJstmlNR0jN9tcog3h5X7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:ce11:0:b0:bc3:9cd9:6e0e with SMTP id
 x17-20020a25ce11000000b00bc39cd96e0emr3015289ybe.10.1687499125559; Thu, 22
 Jun 2023 22:45:25 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:45:17 -0700
Message-Id: <20230623054520.4118442-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 0/3] Remove symbol_name_rb_node
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use a sorted array of symbol pointers to avoid the potentially
unnecessary 3 pointers (rb_node) for the name sorted symbols. Saves
been 24 and 16 bytes per symbol.

v3. Move sort by name dso lock into its own patch.
v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
    doesn't need an optional parameter. Separate out
    symbol_conf.sort_by_name removal.

Ian Rogers (3):
  perf dso: Sort symbols under lock
  perf symbol: Remove symbol_name_rb_node
  perf symbol_conf: Remove now unused sort_by_name

 tools/perf/builtin-kallsyms.c    |   1 -
 tools/perf/builtin-lock.c        |   2 -
 tools/perf/builtin-report.c      |   1 -
 tools/perf/tests/builtin-test.c  |   1 -
 tools/perf/util/dso.c            |   7 +-
 tools/perf/util/dso.h            |   3 +-
 tools/perf/util/map.c            |  14 +++-
 tools/perf/util/map.h            |  12 +--
 tools/perf/util/probe-event.c    |  16 ++--
 tools/perf/util/symbol.c         | 131 ++++++++++++++++---------------
 tools/perf/util/symbol.h         |  12 +--
 tools/perf/util/symbol_conf.h    |   1 -
 tools/perf/util/symbol_fprintf.c |  10 +--
 13 files changed, 106 insertions(+), 105 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

