Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E135C77B7E
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 03:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjE0Dnn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 23:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0Dnm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 23:43:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4FCE4
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb76a9831so2957699276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159021; x=1687751021;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/iIFRTutZ/Cgxehh+4C5m3fM6/hlPbbg/pKVn2e98A=;
        b=Ruqhmxe54X1phUoro1zDMJ0+jBGbZM1+IlrZINkNq/6Cx9BTzBijRnzcO28XGuu2cQ
         o+G9yZpvxYC058BUgh6gHor1KczcU66PyIvuho/fSIK9TroXU8+yRhuD+QsjUL4xY1yQ
         IT06eJNXwXcC9FQv+K+/AnafBZqiXO8M3MKRXkI6hpz0Oz3vOSJQbjHS99BUJdc2XXIh
         dh/4yF0nUorgFgPfFQxn/y5N48Ls5W8L565hroCl/7dzXRek5NLKe0EUqyD3rm39zWTd
         kfPeqpgAa248LODc9VWKF5P4zTCR3Ndt7LXx8TFPORrwCVOLdbS30M4MZ+MA3f0lE4+r
         DpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159021; x=1687751021;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/iIFRTutZ/Cgxehh+4C5m3fM6/hlPbbg/pKVn2e98A=;
        b=BKxyo74oeKmcFhK1f3WgzVKy2mTJJfR4LrAYeBO9Wq9xMrsE1qdRk8ijZnAHSejNk8
         u/vMYb6DHhP0TP6To4g5e5igSKK0tZ+xYHCDBrNDbY6TrbDOmhYna2w7BnM5RWIQGqUM
         y8uNJPENEN/b3b/3ftw+u8JNnRPPEDjAi00VgVZCDgYWKAY8fiJQ7ECWBxd6u+4M20yx
         qfqkwjBC2UGgYCKMEo6g5s1eg0dI1YpvHxHKrccG7xctLOgi+Utu9aIrBA1SfQF2exwS
         ZOjPMesq1+S7HJ9C9WxK0YppmObhHh3BDz2CRnTozgKmz1uh7R4QppO4qw7OdukAAUSV
         1uSw==
X-Gm-Message-State: AC+VfDybCvu6yUnaVYtiqXFcEYrGO0D3WGQrtUL0wbRcYJijNDNH17Rn
        Bw2zgWO65Yh/AIkAftNHn54/ZDEhutEc
X-Google-Smtp-Source: ACHHUZ5zfXF4lXNV6DS2lJajmVshOGxHU54PEh2SlR+UQgpzqJCRMF3RM0t+r5MlWeqSHbNaGvoICQ9ldyZd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:68b:0:b0:bac:828a:e147 with SMTP id
 133-20020a25068b000000b00bac828ae147mr1428986ybg.9.1685159020887; Fri, 26 May
 2023 20:43:40 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:18 -0700
Message-Id: <20230527034324.2597593-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 0/4]  Avoid some large stack allocations
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Following on cleaning up .data and .bss in:
https://lore.kernel.org/lkml/20230526183401.2326121-1-irogers@google.com/
Look for some probably too large stack allocations with -Wstack-usage=3D200=
00
and pahole.

Don't attempt to cleanup variable length arrays like in:
```
util/header.c: In function =E2=80=98write_cache=E2=80=99:
util/header.c:1269:12: warning: stack usage might be unbounded [-Wstack-usa=
ge=3D]
 1269 | static int write_cache(struct feat_fd *ff,
      |            ^~~~~~~~~~~
```

Also leave two allocations relating to session/event processing:
```
util/auxtrace.c: In function =E2=80=98auxtrace_queues__add_indexed_event=E2=
=80=99:
util/auxtrace.c:424:12: warning: stack usage is 65616 bytes [-Wstack-usage=
=3D]
  424 | static int auxtrace_queues__add_indexed_event(struct auxtrace_queue=
s *queues,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/session.c: In function =E2=80=98perf_session__peek_events=E2=80=99:
util/session.c:1822:5: warning: stack usage is 65648 bytes [-Wstack-usage=
=3D]
 1822 | int perf_session__peek_events(struct perf_session *session, u64 off=
set,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~
```

The biggest win is for perf inject where 128kb becomes lazily
allocated when aux or guest data is encountered.

Ian Rogers (4):
  perf sched: Avoid large stack allocations
  perf script: Remove some large stack allocations
  perf inject: Lazily allocate event_copy
  perf inject: Lazily allocate guest_event event_buf

 tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++------
 tools/perf/builtin-sched.c  | 26 ++++++++++++++++++++++----
 tools/perf/builtin-script.c | 17 +++++++++++++----
 3 files changed, 60 insertions(+), 14 deletions(-)

--=20
2.41.0.rc0.172.g3f132b7071-goog

