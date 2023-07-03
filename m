Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954CEB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 07:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjGCH0b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGCH0Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 03:26:24 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12457E78
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 00:26:12 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-78f36f37e36so1213812241.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688369171; x=1690961171;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AFhL3WX439UF4ApWUsjLXGA8K76NwNV7mdB9JrDSbOs=;
        b=DHzBol8NLJ+48zey6G6sAvkl6ZLmYaukks2MSceVz9eVvrtdUcyJ7mgcYSrSO0hTwW
         2iVMxffzSLK0S2/rPMgLtNkyJjYZUKmqi8+xlyXOlLQjLrlwi/Z83AwdtiZ5b7loS6dA
         9hhK9Sl0KSPoDlNfosKy43Jfeqn3agIJyzOHO9P4eyJIHAmCkk/HpC0YsAiF7G4UnTBv
         q2nXKbdUE9jZeWnadixu10OKXl3xbJWeJZAWfW2I/1enV/ofupc3gmNxVbhB+V+Wt8xe
         aqkGFYTgm1S8qtpKLatDn5ft4qkD7eWDUourxJc5SV8rSaXP0pKTeUIJngzgXv/QvbEM
         ubNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369171; x=1690961171;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFhL3WX439UF4ApWUsjLXGA8K76NwNV7mdB9JrDSbOs=;
        b=ZfNmt3PcFRfMX0Qs5LjBvokxctTPYf2LkypIGHNl0GKgOpRUHhgqC/hWqSBn75vWA3
         A0FZ6JGANNsZUTofZqB6TP4pTgUkpwRadlRctFxd+cjVpVGqomlw16rdQNOkCVVKHOfL
         5R5WD8e2/HMcnWFR4Le4oCkbWEReFeT1tYSKKWqeJl/foP6Ahhfb4nFqsMa8ZRpSmBSR
         FmPwMlMavGONaonrxrRjEanUkgFyVNQTnJaooIVeMP0bckeDD1mtxukEd8NjZzqyMWW8
         QuiroHb4SsGqacJPLcK6EG41MVtcd5seYJjVLlyBR+82eP3F6KWnfSpjxJpxUpGCRnsi
         gn4A==
X-Gm-Message-State: ABy/qLaaru77qPeA6tu0aDH369QKc4HhoO0HnEZyWB2CDHW/5C/Eircv
        5qrXB79BggDDB+NUobIBzh8mflnBAvb8QaY6IqbbeDsMfLtb97pLRO313Q==
X-Google-Smtp-Source: APBJJlGau/9OizFSeLgMU/K7IoZbflIEWzaM5xflRF3SI1OEFTJw/gCMYBFgMESsm8IteNIYVawKBkXDI8mVc+q8tBM=
X-Received: by 2002:a67:f651:0:b0:443:51a7:b63d with SMTP id
 u17-20020a67f651000000b0044351a7b63dmr4037175vso.23.1688369171044; Mon, 03
 Jul 2023 00:26:11 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 3 Jul 2023 12:55:59 +0530
Message-ID: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
Subject: next: perf: 32-bit: bench/sched-seccomp-notify.c:139:24: error:
 format '%lu' expects argument of type 'long unsigned int', but argument 2 has
 type 'uint64_t'
To:     open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc:     Andrei Vagin <avagin@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Following build regressions noticed on Linux next-20230703.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on i386:

  - build/gcc-11-lkftconfig-perf

Regressions found on arm:

  - build/gcc-10-lkftconfig-perf
  - build/gcc-11-lkftconfig-perf

Build error:
=======
bench/sched-seccomp-notify.c: In function 'bench_sched_seccomp_notify':
bench/sched-seccomp-notify.c:139:24: error: format '%lu' expects
argument of type 'long unsigned int', but argument 2 has type
'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
  139 |   printf("# Executed %lu system calls\n\n",
      |                      ~~^
      |                        |
      |                        long unsigned int
      |                      %llu
  140 |    loops);
      |    ~~~~~
      |    |
      |    uint64_t {aka long long unsigned int}
cc1: all warnings being treated as errors
make[4]: *** [tools/build/Makefile.build:97:
/home/tuxbuild/.cache/tuxmake/builds/1/build/bench/sched-seccomp-notify.o]
Error 1

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230703/testrun/18069798/suite/build/test/gcc-10-lkftconfig-perf/history/


--
Linaro LKFT
https://lkft.linaro.org
