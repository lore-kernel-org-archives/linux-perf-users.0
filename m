Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D632C6FA8F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 02:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHYCkq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 22:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjHYCka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E161BDB
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e49935630so13046317b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931227; x=1693536027;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9y0R0T/KYoRSkCgPsetHA/E7ag4fZJml6jv6nZDJg9Q=;
        b=lgMPZ9u2Li+a94DkzByZ+jgOm9cM0gX+J1LFEJnVHnhMY8aW+ZctJVGNUG54bt1wrO
         LvHQf308xkPh+3/sj9S0wUsaFrisxoUbNwCKcmEC4hD1pY1NV0+L0GmfzZxZAjkijRY9
         MAgkqwS7Ds3rfex5SPDQShFaTqHiMrngfMoU+Z3ZM9+VTlmnWKVXQ44+NzSwrgDwChNs
         zLz3hiZ280SVTpqXyMA2qrEQ3xOtA+eS6YvbXOjE7WqNe/op3qVmxwWbZ74VRJ054Nzn
         Y8TY1O4rEqdUN6vjqPFYC/bnAIcGYF2T8bR9kGMrZl92slRrctI3dMiCVoHzuSfMz4OZ
         BK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931227; x=1693536027;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9y0R0T/KYoRSkCgPsetHA/E7ag4fZJml6jv6nZDJg9Q=;
        b=AJzKDTvC4yApvh19Mq6dsDUK35v06ULnoDb0HzdJ27RwHJZJkLG7m/9wWtrsorQYZO
         MkIvXYRimXcbYjnXzmuNkryIspZyhfBXLSWlaKIyWl5WPI8pr2APcO3hvhdNtu4vvuto
         +fwKl9BqcBRe/pLwU+LvfRBQkWVFS+CTNWbOm50faZrH65Y0fsKg9UjeDj9FvNwWe2vl
         n4CJ39ty3DYG7giweVCjRXLqbu8TXD4auYwH0qLB5VMcLeo1yetZNhVaXpy6zr6uvP/x
         ZB2kVLOIVhxqD4i1FZI84VVrenpXHh1YdnA+41Ioq0B3gaIMe7/TzgHXcy0uTxBbURt5
         44Uw==
X-Gm-Message-State: AOJu0Yzg8kz7DX6Tt2CngoEZBdGQ9CaGDAcunmj08UP1ONpd46CcZvVy
        Sqh7aVvrY4ae7ABlY2kSK0Qy+AQtV2yz
X-Google-Smtp-Source: AGHT+IEB53pqv6HCic/xx2KLuoXmwH5iUnq0oTL0ZppgE2SwkTZgpvnxmDyHuX/w5KJ70BlN5o0QKPx9YKY0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2fc2:b0:589:a533:405b with SMTP
 id ex2-20020a05690c2fc200b00589a533405bmr379315ywb.3.1692931227754; Thu, 24
 Aug 2023 19:40:27 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:39:56 -0700
Message-Id: <20230825024002.801955-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 0/6] Fix missing caps, fix unnecessary casting/checking
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wei Li <liwei391@huawei.com> reported an issue where writing PMU caps
for ARM was broken. Patch 1 addresses this issue.

Patch 2 removes unnecessary checks on a PMU's name by ensuring the
fake PMU has a name. Types are updated to have a const as a
consequence and a cleanup of the use of types is done for struct pmu's
variable name. This was motivated by the discussion:
https://lore.kernel.org/lkml/20230818171952.3719251-1-irogers@google.com/

Patches 3-5 repeat the const cleanup on struct pmu's name with the
variables id and config in struct pmu and struct parse_events_term
respectively. This is done for consistency with patch 2.

Patch 6 tidies casts around libslang and removes workarounds for
libslang support needed for a libslang older than 15 years - let's say
nobody cares about a libslang that is this old.

Ian Rogers (6):
  perf header: Fix missing PMU caps
  perf pmu: Remove logic for PMU name being NULL
  perf parse-events: Make term's config const
  perf pmu: Make id const and add missing free
  perf build-id: Simplify build_id_cache__cachedir
  perf tui slang: Tidy casts

 tools/perf/arch/arm64/util/mem-events.c   |  2 +-
 tools/perf/arch/powerpc/util/mem-events.c |  6 ++--
 tools/perf/arch/x86/util/mem-events.c     |  8 ++---
 tools/perf/arch/x86/util/pmu.c            | 10 +++---
 tools/perf/builtin-list.c                 |  2 +-
 tools/perf/tests/pmu-events.c             | 20 ++++++------
 tools/perf/tests/pmu.c                    | 18 +++++------
 tools/perf/ui/Build                       |  2 --
 tools/perf/ui/browser.c                   |  6 ++--
 tools/perf/ui/browsers/Build              |  5 ---
 tools/perf/ui/libslang.h                  | 20 +++---------
 tools/perf/ui/tui/helpline.c              |  2 +-
 tools/perf/ui/tui/setup.c                 |  2 +-
 tools/perf/ui/tui/util.c                  | 12 +++----
 tools/perf/util/build-id.c                |  6 ++--
 tools/perf/util/env.c                     |  8 ++---
 tools/perf/util/header.c                  | 39 ++++++++++-------------
 tools/perf/util/mem-events.c              | 16 +++++-----
 tools/perf/util/mem-events.h              |  2 +-
 tools/perf/util/parse-events.c            | 17 ++++------
 tools/perf/util/parse-events.h            |  6 ++--
 tools/perf/util/parse-events.y            |  2 +-
 tools/perf/util/pmu.c                     | 19 ++++++-----
 tools/perf/util/pmu.h                     | 10 +++---
 24 files changed, 105 insertions(+), 135 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

