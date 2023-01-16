Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66EC46467
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 01:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAPBBc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Jan 2023 20:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAPBB2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Jan 2023 20:01:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC28A25C
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 17:01:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c2d68b6969so272990547b3.7
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 17:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8pQIe3b3eDqKtcKxZCuszKwm9/MxIa48mrJzbJLsxM=;
        b=CtusI77hVYkkSpzCIWPeF+5W3whQRlq36FI4PV11OBIlbXcN+zCYP3yaWmsk7Vd1nu
         b+ML0FY6BsokaJuKNlmYiyXq4NV8XuKYSukBibTNcz6C6JUEnfg+Y3P//VQOixX9oICk
         jlqyXPcAodOswE8wE4Emco5exeD3Ty2q/8x8oFS1zS7OkEIAGrgxfg4QRW3vJ2DnIh7P
         DRMnFXtt8XdFejSm7KgaloK3hEX4FNwXVynqnEIE6rwtR51hoErq0b/Ia3xyEv0Z9VJJ
         nr5LIzQKEk7QfCEQJq2K2IYTMh/5jqks3aHIZlB2qccA54ells4wK0NTvWguNUDhWnlH
         rcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8pQIe3b3eDqKtcKxZCuszKwm9/MxIa48mrJzbJLsxM=;
        b=4qfWZJwVXIM4Q8FBCorUMpYV+3hBwrKre8Dsb44+rSexhAMimrtNTM/CgdqLjiopP/
         gmwgVmpJmQApAUpOdt1AGWFJ9dTMnbRVUGF32qbO+1LXJbkGOwblJrUtJsI18oIovXDp
         9hg65WoK7SmoDPvCI2c+dbkBZI0wlfcaXYhBDNTNznR7shXg5CkvnJiInXDDduiF2do5
         1O8T/IA/EkIlAQTAqhzr0a8EBwcmf7w78xLvZxHNE7lA8EcWklbLR6/2X2zNyNm/2HfE
         9Mc84aEeSNtH3RQuIcZEq9Pnwxhy9bFOi5GCP9XZhqGihN0D/gFv6rXaX3ZWRAvlXcP2
         Fmvg==
X-Gm-Message-State: AFqh2kqBmDYkvSPo2daqBhjUPIPZsq6+EzYk00Xht1Ba6hsbdT6VGe4t
        a44Ny8Dy/iDZSyVTNCrPJ29xrRVqtBj3
X-Google-Smtp-Source: AMrXdXujkx7N4RtyNWtiCeKOl5a/F0OWSBlmlkj8qlxnt3ts2/0if1/DCzxf7WApBksRDBZKcdHp8F/5Miid
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:79e:5e8e:382c:e7ce])
 (user=irogers job=sendgmr) by 2002:a81:a513:0:b0:4b5:55fb:6cbc with SMTP id
 u19-20020a81a513000000b004b555fb6cbcmr4181643ywg.10.1673830886744; Sun, 15
 Jan 2023 17:01:26 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:01:12 -0800
Message-Id: <20230116010115.490713-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 0/3]  Assume libbpf 1.0+
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libbpf 1.0 was a major change in API. Perf has partially supported
older libbpf's but an implementation may be:
..
       pr_err("%s: not support, update libbpf\n", __func__);
       return -ENOTSUP;
..

Rather than build a binary that would fail at runtime it is
preferrential just to build libbpf statically and link against
that. The static version is in the kernel tools tree and newer than
1.0.

These patches change the libbpf test to only pass when at least
version 1.0 is installed, then remove the conditional build and
feature logic.

The issue is discussed here:
https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
perf bpf:

A variant of this fix was added to Linux 6.2 in:
"perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1"
https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
This change goes further in removing logic that is now no longer
necessary.

v2. Rebase now that breakage fix patch is in linus/master.

Ian Rogers (3):
  tools build: Pass libbpf feature only if libbpf 1.0+
  perf build: Remove libbpf pre-1.0 feature tests
  perf bpf: Remove pre libbpf 1.0 conditional logic

 tools/build/feature/Makefile                  |  7 --
 .../feature/test-libbpf-bpf_map_create.c      |  8 ---
 .../test-libbpf-bpf_object__next_map.c        |  8 ---
 .../test-libbpf-bpf_object__next_program.c    |  8 ---
 .../build/feature/test-libbpf-bpf_prog_load.c |  9 ---
 .../test-libbpf-bpf_program__set_insns.c      |  8 ---
 .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ---
 .../build/feature/test-libbpf-btf__raw_data.c |  8 ---
 tools/build/feature/test-libbpf.c             |  4 ++
 tools/perf/Makefile.config                    | 39 +----------
 tools/perf/util/bpf-event.c                   | 66 -------------------
 tools/perf/util/bpf-loader.c                  | 18 -----
 tools/perf/util/bpf_counter.c                 | 18 -----
 13 files changed, 5 insertions(+), 204 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c

-- 
2.39.0.314.g84b9a713c41-goog

