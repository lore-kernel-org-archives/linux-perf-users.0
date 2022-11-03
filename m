Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BAC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 04:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKCEyu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKCEys (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 00:54:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003C417598
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 21:54:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m4-20020a258004000000b006cbf32f7ed8so1113790ybk.9
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 21:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jZXowGsurJE+s3+HfBZ6GT+6g7K96tSBIPyO+vNCcsA=;
        b=NxXkPe3pHcYT8iN7ya3pJumFi+pQ0vkHaIriviOdmvPthV36Y5/415d2g41J5VldXl
         WQ8ILJP0mmK8scFWbpLeRf3cPnKM0ktYsPaaIPcBU/2yYdwFDwkAEtUVtU9FutGvJ81Z
         og9FRK7xk9I9WPZsv3H/fnCJNmGcbyN1oc+FREMP61iWQKUCdwJQ7Sz1/+1eXI+oKVSv
         OoclwxiwCBCXSv+1uJDQc/IzPL7kZBvAsodPlJwaHbAuBW63OeLXfFo3/GwP6qNh5D7M
         fpWFMFamJD/hFyEDZ8iRGyDIxLrMz4ysj5Q0WwN7pmWqcbb+IMC58wX1oVfkE+L4KRz1
         po5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZXowGsurJE+s3+HfBZ6GT+6g7K96tSBIPyO+vNCcsA=;
        b=DHMeVmQOF/QqDokvhw30ZXCiaBhD84CMUQGG1v9+BUUjWW6VwfPqrOc7WI5ckBxb5x
         OUzufI0iBXjPdyXcVSS6KdBKhpTDNkbfHkzNGDGj0xQqdYKRJmmss9xr23ex9KTmqEzO
         k5vldwoK+3LoJfNIBQ+6IRi1z/X8lW3kAPKNuDxetHmUt/5v64oRDQb3SpAk1hBk1qvL
         deQzTjypk6bzYi9vuGOpbQQXufEnR42jvZnLCoaeKVXbePBh5bzofv+taxJtH7nndNzF
         aoIvTjp7YkJro8bcyclROHHNnvfS6LvmvwQ6aUhqXGnlw3UL+TnV08xCI7/7rRlpLvNj
         idAQ==
X-Gm-Message-State: ACrzQf1czgZdY9xZjpLeeOlDv/431f6gFRXq6ghQz6WbJEAt7kb5Hbf5
        r1kGrMDEng8Fr6cCiX6ALBOi8UExO597
X-Google-Smtp-Source: AMsMyM5gQLmkoq2wQlEnKPsDCXgEFk1fpShBi3BSXv4S72Lx55H99KGCQPG78W+rGnj5gX7yY6U9qKtx776d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a25:6dc4:0:b0:6c1:822b:391f with SMTP id
 i187-20020a256dc4000000b006c1822b391fmr25547855ybc.586.1667451287286; Wed, 02
 Nov 2022 21:54:47 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:30 -0700
Message-Id: <20221103045437.163510-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 0/7] Fix perf trace libbpf 1.0+ compatibility
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf trace can augment system calls with a BPF program passed as an
event. The BPF code for this lives in examples. This patch fixes the
example code to not used deprecated/removed APIs in libbpf. As libbpf
has similar header files to tools/perf/include/bpf the code is
transitioned to use the more standard libbpf code and the perf BPF
header files removed.

Ian Rogers (7):
  perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility
  perf trace: Etcsnoop fix libbpf 1.0+ compatibility
  perf trace: Augmented syscalls fix libbpf 1.0+ compatibility
  perf trace: hello fix libbpf 1.0+ compatibility
  perf trace: empty fix libbpf 1.0+ compatibility
  perf trace: 5sec fix libbpf 1.0+ compatibility
  perf bpf: Remove now unused BPF headers

 tools/perf/Makefile.perf                      |  5 --
 tools/perf/examples/bpf/5sec.c                |  8 +-
 .../examples/bpf/augmented_raw_syscalls.c     | 75 ++++++++++++++-----
 tools/perf/examples/bpf/augmented_syscalls.c  | 58 +++++++++-----
 tools/perf/examples/bpf/empty.c               | 13 +++-
 tools/perf/examples/bpf/etcsnoop.c            | 41 ++++++++--
 tools/perf/examples/bpf/hello.c               | 24 +++++-
 tools/perf/include/bpf/bpf.h                  | 70 -----------------
 tools/perf/include/bpf/linux/socket.h         | 24 ------
 tools/perf/include/bpf/pid_filter.h           | 21 ------
 tools/perf/include/bpf/stdio.h                | 16 ----
 tools/perf/include/bpf/unistd.h               | 10 ---
 12 files changed, 169 insertions(+), 196 deletions(-)
 delete mode 100644 tools/perf/include/bpf/bpf.h
 delete mode 100644 tools/perf/include/bpf/linux/socket.h
 delete mode 100644 tools/perf/include/bpf/pid_filter.h
 delete mode 100644 tools/perf/include/bpf/stdio.h
 delete mode 100644 tools/perf/include/bpf/unistd.h

-- 
2.38.1.273.g43a17bfeac-goog

