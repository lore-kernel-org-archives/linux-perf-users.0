Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D806C54EBD
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjAIUem (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjAIUek (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 15:34:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A86086B
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 12:34:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w9-20020a05690210c900b007b20e8d0c99so10208715ybu.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9ogL9fBGTlSiBOaxHLGDQsLf+6hnlNrkyQf9wzS9SY=;
        b=eEkzzVs5l+fuL/ZtoLR38Eh9shkZTUb1u9waCyY7/UaKpmIh1ELVebXzD0+s1raGtu
         oquWZsAlt6BGf7J2m/rbCpxuQTIIOWLvyzlBAZQZ84+rYumGBpmCpvjjyq7MLoWSFRBc
         Md56UfNxdasYFiwlazLBzJ4ZpGzHMMHruv6E3dmi+RLvyCklp12meVmoMJ/dloJy25j6
         Htp0ssLwbCyX00gYBGX5JfCyQukcmJvMwHszcf6QQ2if64eREnjEDgcuvwbGsGXXa+eN
         XC3ti0Ly9nIDGDXhi2VvdNr/2iLzRU1VEL1lFmS0lW18MpdF92qEhGIFwt3NBC9diSyW
         sUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9ogL9fBGTlSiBOaxHLGDQsLf+6hnlNrkyQf9wzS9SY=;
        b=cF7lGZ8G0gJzDNjelCB1hNuPdIfO0FCC+K3T5YR6ovC3B+w7VW2FKoUaUSAdHgT7Le
         fnIPun8bTivunykHinUuPttDIx5wvjWSUHCLyOgKEGJEhnpgbwtTfSuRwjkT8/AR8vDG
         +y0/etQt8glamlyxUlShZu5dsvidakqvECma2KupmPLdBFfEpqdRO09UA5OePdGDlW1y
         JQlZSoBflMArF7UFNZgYW9pmmyhpP24K9STx/0LJtxc8SB2speRwEsrr6JqklS5VTyGp
         kiqcUnJZHB9e75p+dTpo5fO4D+ZTTuV8QMkSeMqJWuRN5EBb34J904rXJTHIEiuLbrNH
         OpjA==
X-Gm-Message-State: AFqh2krwBXXY58jOBi9efuQAoZ0Lrh4IcXAyzgXFynv1JfPtPCf4Rylt
        nO0mvZX2p7AEZEMAfO/uwJ5JSfkzR/mg
X-Google-Smtp-Source: AMrXdXtsVMhlvmlCs0y5swSgfwYhYMXnszwXJB/jKls1bekFVoIVNVsLB6ctPb8sHOk+oJVR7s+cPUzqzyHx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a81:124e:0:b0:499:f27a:28ba with SMTP id
 75-20020a81124e000000b00499f27a28bamr2056335yws.145.1673296478964; Mon, 09
 Jan 2023 12:34:38 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:34:21 -0800
Message-Id: <20230109203424.1157561-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 0/3] Assume libbpf 1.0 in build
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
 tools/perf/Makefile.config                    | 37 +----------
 tools/perf/util/bpf-event.c                   | 66 -------------------
 tools/perf/util/bpf-loader.c                  | 18 -----
 tools/perf/util/bpf_counter.c                 | 18 -----
 13 files changed, 5 insertions(+), 202 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c

-- 
2.39.0.314.g84b9a713c41-goog

