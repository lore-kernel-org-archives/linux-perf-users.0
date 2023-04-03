Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740EC76188
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDCVKj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjDCVKi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 17:10:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D330F6
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 14:10:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54196bfcd5fso298172687b3.4
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680556233;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=//UNXaJkupvybnqihLH4tdqWJ1GBF5jwORbNrJVaSe0=;
        b=DRJF5cXOTsS/LZ3KebaxwMU0lc+/Jej3UYvboCeBtV0/WfX5QeUiusCTJoc0zC5Jcg
         plMqOo2BQ1DA2CiYL85EH72m8Z9j399rXmblNDptRZ6wZg88Xufy2+xgJ69IS5gvNH6f
         c85XRj8egUNY+GDJqpn93HrPEL1UvZKZ9IssnAbFg4QX+e5CWiaD9X2JCFGkpbOnngHm
         Fmojfh0UYAw/hTEjQ27CLKzeQgxXPVpYaxb6m93X/4TcnfeVj9wjfFqZWwmhinm57aID
         XyhQuJah8J81c8Fx6SUf9bbbQGOl42FPpbagJBqB4Znerfv0vT+pUUxP+wD0hCICjoY5
         Vckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556233;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//UNXaJkupvybnqihLH4tdqWJ1GBF5jwORbNrJVaSe0=;
        b=fvjLThvQ7jcHEM/AReA+STtcu2OAm8loYDZaCPXVchnz+rd67nRi0IqlMqtXEJ6yJT
         8m7B91nWtcA+wwDBChTCYYCWtxM57xzrc2Hw/PA/J0RlU6dCX3W3bzSL8EYio8ut6Zlb
         uTHiv2JlFwO+GWVL2rvb/GkwHxi2JynuoOZ2/B+yliwEYLSAcOCRU8W/QdWZJL7/OUy8
         MMnzEYLv3FEkg+nHIJSBhiG6/o3cT0WyuRqg8++htL5hmB+72m/CBuDkhyoJjr6wMu67
         jiTbFO9z39CFlk3iTymWQ1pMEhsVsmuOqYUfLURSChy6faO7Nw2L86W+gGqy7ariNFEO
         DvgQ==
X-Gm-Message-State: AAQBX9fBw77f9Xbh2ApIMx8UlkXtSBIeORzJV6zz7XEHM/8jIVkMqWvE
        jrbipT8BwoAsMyhPYAMePgDw79vCi5IY
X-Google-Smtp-Source: AKy350ZMp6ACZsErvCTEuiH+Z2OfEa4+QAIsUPiMcyrTzl+g73Co0rLafAmmVelLlQrhJVZfeRkJmPAJhVGP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a25:778a:0:b0:b82:410e:daae with SMTP id
 s132-20020a25778a000000b00b82410edaaemr333778ybc.9.1680556233240; Mon, 03 Apr
 2023 14:10:33 -0700 (PDT)
Date:   Mon,  3 Apr 2023 14:10:20 -0700
Message-Id: <20230403211021.1892231-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 1/2] perf build: Allow C++ demangle without libelf
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The cxa demangle support isn't dependent on libelf and so we no longer
need to disable demangling if libelf isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 236d763181c5..dd203f0a2b7e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -412,7 +412,6 @@ endif
 
 ifdef NO_LIBELF
   NO_DWARF := 1
-  NO_DEMANGLE := 1
   NO_LIBUNWIND := 1
   NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
-- 
2.40.0.348.gf938b09366-goog

