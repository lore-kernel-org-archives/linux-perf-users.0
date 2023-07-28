Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F56C001DE
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 06:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjG1Gtr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjG1Gtq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 02:49:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396883590
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc68c4e046aso1655123276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526982; x=1691131782;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JSRNyTgH2RQM+IopPYAVHpRofqMWho9ANhQe7NRcfyI=;
        b=nRXi1Z1xCu+ny9dJx+xC1ohGfwhMrbNXm3ILlxZ3d8TaGL1vQWN1Y8b119HfJeOH+L
         sYKDJmVsp9CBS2egYSkyBlP6MXSlJmcM60reg1cTMtzo3s2yoXU4YF41uTIre8F6TBak
         IV7uqTL1PElSoXiUNzEsLMQ6Vt12zexPCG/AQVo9mBnI5/+IJYT5zRffhRstt5aFptQH
         aa98iwrlnIVy5+oVyhwnEV9xk0Uv4CWqfHV05vOOSjVxW3uJfPyTFTd2hQjYpTDrkTEW
         4vf0idf827w3L+2/4kRyak9lzmfRYrBeTuZj9mxJJxnARn3FrgPJ9mNUgA+HPLxu9GCS
         4tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526982; x=1691131782;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSRNyTgH2RQM+IopPYAVHpRofqMWho9ANhQe7NRcfyI=;
        b=UKun34kv4aJ1ShWKAqv9r+GIxOIlA7ao+VGZ0StoqIDNKiqaP8M7P3Ut8b/RdK3occ
         9BVEdVHuuHPSpYjkIsXXHOplgZ4D7U7ODahflFidAgRNcs/rejlK4HkR8wR7vkqeO2uQ
         gmVyWawRH4Fl7AV5wGfyqAc8lHtCRmFH8xFceWtc0bcSgFEQ/640ZCTQkK2Nx4sK8hlJ
         1fFrkOtpg8qzEPvF/iQfLiP5nDzZGK2hLshBVg+a87buA1I42wYdgqEPVrpskkwYt60l
         xO+UpRR+jo7K6qTWzeQG65RgrZBVgD+MzbA6rcq7SuVBbvvVLrDVGbiV6kNHslFDlQiy
         DVcQ==
X-Gm-Message-State: ABy/qLaOC6qzRF/4edxeL5Xi9C7AxLY3I5CJKiHX1AaukQdAFMLdjBNT
        /iUQVod6d2wzNaIPQTIIimvOKh6hjkn6
X-Google-Smtp-Source: APBJJlH3g+5y4xz+Nx2m6TkDig3uk0UwJ/M7ao/vA9fmwc712RvGVnodtkcrYfR1OT2c4G9x/YNVMhG1rfj/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:ab47:0:b0:d08:8cf5:c5d8 with SMTP id
 u65-20020a25ab47000000b00d088cf5c5d8mr4845ybi.5.1690526982027; Thu, 27 Jul
 2023 23:49:42 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:11 -0700
Message-Id: <20230728064917.767761-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/6] Simplify C/C++ compiler flags
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some compiler flags have been brought forward in the perf build but
without any explicit need, for example -ggdb3. Some warnings were
disabled but the underlying warning could be addressed. Try to reduce
the number of compiler options used in the perf build, to enable
Wextra for C++, and to disable fewer compiler warnings.

Ian Rogers (6):
  perf bpf-loader: Remove unneeded diagnostic pragma
  perf build: Don't always set -funwind-tables and -ggdb3
  perf build: Add Wextra for C++ compilation
  perf build: Disable fewer flex warnings
  perf build: Disable fewer bison warnings
  perf build: Remove -Wno-redundant-decls in 2 cases

 tools/perf/Makefile.config     |  9 ++++-----
 tools/perf/util/Build          | 18 ++++++------------
 tools/perf/util/bpf-filter.y   |  2 ++
 tools/perf/util/bpf-loader.c   |  3 ---
 tools/perf/util/c++/Build      |  3 +++
 tools/perf/util/expr.y         |  4 +++-
 tools/perf/util/parse-events.c |  1 -
 tools/perf/util/parse-events.y |  1 +
 tools/perf/util/pmu.y          |  3 +++
 9 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

