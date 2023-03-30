Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02DC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Mar 2023 18:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjC3SjS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjC3SjN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Mar 2023 14:39:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9DEC7C
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 11:39:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so19535465yba.11
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2U8QUctphzNcHKFtorNgxLmK4+8NLFcRnbJiYAJzuAk=;
        b=Hj8wOroWD45sTFPIEx4Y9GnOts8Xb7rDnQaK+4CqIK/M+8apuoZ2Gc91cudxa03uhu
         /G8XELSG30NWcBb1GBwrTjCWyOr+ENgsdxshP4Q2yb+Y0fpCqA951mAggXzsIVgZpsze
         HsQ7DaToRGm8XSX1uvFkt2g83kIul6rR5ZXQkbG7FOYZpwQwwnEQAkutIdxuufoBylGo
         P+fxsYlSkX46x4/uWbp1TE4/Q3yia1/fcagSU3zqkzJD9Qa2l/yVqOrGUuRmRMBK/DFm
         pSr1TpxMrfg8/MyDiOO4JWZ4LMzKpsU0d70smMmapiE6Pif245xAU6z0KEvSKL1rY0Yq
         ugmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U8QUctphzNcHKFtorNgxLmK4+8NLFcRnbJiYAJzuAk=;
        b=P3DdZczumjDqqgtK1ld12H7MHQ+NNtomoiYxag9kcxYsXnLXIENT+FHx5zeOjl9R3g
         EH4hEdoX+lhF4bVR3IFJeXdew1Yh0jPBPupVE9sN7q3ULzdCB98RoqNl26SXg2s6yKZe
         94kxPmGQ6sBMBEYAZSgsPXU44toPu85vR5f4P5Ke7Nz1lCRybEnUMRUmAYw2kylgPPX8
         gQ8ztQLbWv7e3Zima339cydRzwxBxpREoqeko4BVuZF88nXngvte1q5itVqVEtSfOICF
         YQYa6BmuBrlUf0yrj043edkcTpEWVbTULm0oWHHjgN01UwPvLW6cQBEJ8yPhCN4t7M8B
         g/7w==
X-Gm-Message-State: AAQBX9fCLc8gdxCs+kKMjFI+ZniDi1HcKTc/AwUnuyvDagjCC8cj9S2A
        B54N32yKAcjb76chlCc3iqdfuRS+drkE
X-Google-Smtp-Source: AKy350aITBhRw3nhzJl5DrlBG23PbTNNFKSYGz4YYA9/uEHzMD1izDLfkL69SpiqNTkyLh5m6vvE5zAK5VUG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr16637242ybt.6.1680201540592; Thu, 30
 Mar 2023 11:39:00 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:38:27 -0700
In-Reply-To: <20230330183827.1412303-1-irogers@google.com>
Message-Id: <20230330183827.1412303-3-irogers@google.com>
Mime-Version: 1.0
References: <20230330183827.1412303-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/3] perf build: Conditionally define NDEBUG
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
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When a build is done without DEBUG=1 then define NDEBUG. This will
compile out asserts and other debug code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3066d0c318c3..236d763181c5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -228,6 +228,7 @@ ifndef DEBUG
 endif
 
 ifeq ($(DEBUG),0)
+CORE_CFLAGS += -DNDEBUG=1
 ifeq ($(CC_NO_CLANG), 0)
   CORE_CFLAGS += -O3
 else
-- 
2.40.0.348.gf938b09366-goog

