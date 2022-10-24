Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59674C38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiJXT5o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiJXT5T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:57:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84DEF5B5
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:20:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l16-20020a170902f69000b001865f863784so6784859plg.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdPpZnwd5jRn69z8VmyRRXOs+WnLWZPFgd+7/iBzwHk=;
        b=NfrgsUTi4AApD9BZxfhAegOIzfnADBYbmqWCGsTBOOc7z6DCGVA6S5DGI56c3/0HTK
         3BuxuXx7aAY92LOmjN8o6+cd2dWG2ItvAJs2cNSk/KXbYeoUybsaEXziRA1t0YN6Io53
         Vg1GCS1dJ4xCUUxB6HolGFsWwaXlY9IllaWJonUcug574p7flVeJc9EgvgLtCaV/DXb5
         rNPH89aOcXb8wQjOZuw7PvPeSOKL3r61V8Em7fupmdz6/IberQWfB3vrQgONNxqTBR5a
         XVYq31YpR56iR0tRAxHK9QXbEYG+HLkoRNnoCIcdT4wTqMABZL528o45hcEMERtSsoqC
         iF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdPpZnwd5jRn69z8VmyRRXOs+WnLWZPFgd+7/iBzwHk=;
        b=isDz8bZCjW4dPJt/ILa34ipn1jnxV19crbCO3Dq2kOthDessWn7mfCJagY8wrVhBj7
         wYpNgGBixU0Ehu/3D4N0nwPuhdcDes+xEpo13yxENW9s/fFNqXLYjEIPuI5gG6nEkNBj
         st+njlvxf2KBo6vQiZhjgNfKKkGFskr7bbf5t6bk+uEGk3x4yO79B82c0YlmstPIpYJW
         ckBlssOFc1gwkGBmFZXC35WZaE6m7jQXeHTXVlI/UDOsQ18PJWkwSwRYZM8m644g299m
         Fv6Y474RQVMCjAxE7y/u5Pjoq7TP3gvp9pJwHgt580LYsShmoW3kAG9+9pJ3UOX92887
         E/3A==
X-Gm-Message-State: ACrzQf3QU0WK6whbTE1ep6Ol9TP8hjWmexe3Gdje0JyH0kcLhh7SZ9Re
        BWbsQvuoBDLFuXyLI0QPGcfqUR9CPGak
X-Google-Smtp-Source: AMsMyM7gOJ73zL6REh5JLPAg6wf0lT6uPprEpgZedLo1aYSYyI73sfxgXgK0r3WCA8xTVaZu8s4FZZYmNjnv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:e90:b0:213:2708:8dc3 with SMTP id
 fv16-20020a17090b0e9000b0021327088dc3mr247684pjb.2.1666635575295; Mon, 24 Oct
 2022 11:19:35 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:05 -0700
Message-Id: <20221024181913.630986-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 0/8] Update to C11, fix signal undefined behavior
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The use of C11 is mainstream in the kernel [1]. There was some
confusion on volatile and signal handlers in [2] for which atomics
(present in C11) make things clearer. Switch to using volatile
sig_atomic_t as per [3]. Thanks to Leo Yan <leo.yan@linaro.org> for
the suggestions.

[1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
[3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

v2. Remove unneeded stdatomic.h includes for sig_atomic_t as it is
    declared in signal.h.

Ian Rogers (8):
  perf build: Update to C standard to gnu11
  perf record: Use sig_atomic_t for signal handlers
  perf daemon: Use sig_atomic_t to avoid UB
  perf ftrace: Use sig_atomic_t to avoid UB
  perf session: Change type to avoid UB
  perf stat: Use sig_atomic_t to avoid UB
  perf top: Use sig_atomic_t to avoid UB
  perf trace: Use sig_atomic_t to avoid UB

 tools/perf/Makefile.config  | 2 +-
 tools/perf/builtin-daemon.c | 2 +-
 tools/perf/builtin-ftrace.c | 4 ++--
 tools/perf/builtin-record.c | 8 ++++----
 tools/perf/builtin-stat.c   | 8 ++++----
 tools/perf/builtin-top.c    | 4 ++--
 tools/perf/builtin-trace.c  | 4 ++--
 tools/perf/util/session.c   | 3 ++-
 8 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

