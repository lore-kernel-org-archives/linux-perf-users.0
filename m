Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C46AC76188
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 18:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjDCSku (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjDCSkr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 14:40:47 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725F11D
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 11:40:45 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s9-20020a634509000000b004fc1c14c9daso8827815pga.23
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680547245;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7KXY8lY6kh4yGHJrlGOwQN4b74JegDEme6RD0OCgco=;
        b=MmY3StUttrl+Dl0KtrfiUBQYX1fBd6olu28lJlPxriJAesyrYGeWv6rxB4igcoDrrS
         uCxzoybWGwVCrc4KwE7tXIatVHRsynan93kGhqKUPlW8el7kw8FlXpbKl6K13DlBtDto
         XlL9eWWTT8IqQPo+92gSOLxNTUA283A7elT3V3+K1t7iDtr/f+02Z6BM4G5/44Fp0j63
         z/eBYq3xcA8Yf4hFF1seNWEB+EXU3+BFcuSPJPk6Zu/5FCiugkgJjThlQcBlNWI0AuCv
         JuqiPg6gKulnsFOgJgblvM7b9R9mcszWjoCokybbHOgaJ1QFwMrmoVZHrAat7+GRGwVO
         UkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547245;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7KXY8lY6kh4yGHJrlGOwQN4b74JegDEme6RD0OCgco=;
        b=Qg3rveD8w7mCA8hT4HoyBAwtJEsUhqNzlV68bsZbK/2vMOFPJxIav/1nudfEtmK6wb
         iDUysJxvLAcTA5JGlpxqKkEGehGq98wmC6yfMdX6CdpDqkseVrfS5DkPju33VGRUkMQ6
         u5PSRpZ719/k0hmOhnrBYM/ShIzIQUlL04SUkgM/rmcnZAp2OdgzEo4anA8TuSTuS/SC
         sQO2b4FnObbXmQ4VfvbJlHusEkIEmRqsoSJ3GOTZXo2LCxQLmJ5SxbyKmYNJhKOzi4Jb
         gO9lURmfn59H+RfDX0eyqpdc5C0QfJxKKXoPjYdJa8gee73SvFgERYBaOuP4h7wJ9avM
         7WnQ==
X-Gm-Message-State: AAQBX9fL8mq1vUTGwRUk+Vj3BbDFQBgmQ5Wk8rE3MfySJOor75lZAi30
        qBU+YS0ULGPF5bPEEkIiurfWUjtirVBl
X-Google-Smtp-Source: AKy350ZZdr2WR9ZcTjWW1hUH12pOOyW8M+tD+hF6gzQBIwL78qeJrSAkQU0Lm7teFIKEXeaZuysvtGqqeaPZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a17:903:1358:b0:19f:3cc1:e3bd with SMTP id
 jl24-20020a170903135800b0019f3cc1e3bdmr28764plb.4.1680547244921; Mon, 03 Apr
 2023 11:40:44 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:40:29 -0700
Message-Id: <20230403184033.1836023-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 0/4] Support for llvm-addr2line
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
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The addr2line command is started and then addresses piped to it. In
order to determine the end of a addr2lines output a ',' it output with
an expectation to get '??\n??:0\n' as a reply. llvm-addr2line differs
in that ',' generates a reply of ','.

The approach detects and then caches the addr2line style. When records
are read the sentinel is detected appropriately.

Comparing the output there is a little more inline data on my machine
with llvm-addr2line:
$ sudo perf record -a -g sleep 1
$ sudo perf report --addr2line=addr2line > a.txt
$ sudo perf report --addr2line=llvm-addr2line > b.txt
$ wc -l a.txt b.txt
  12386 a.txt
  12477 b.txt

Some other small changes, switching to the api/io code to avoid file
streams wrapping the command's stdin/stdout. Ignore SIGPIPE for when
addr2line exits and writes fail.

v2. Address review comments from Arnaldo and Namhyung, fixing a
    realloc error path, argument ordering and a comment.

Ian Rogers (4):
  tools api: Add io__getline
  perf srcline: Simplify addr2line subprocess
  perf srcline: Support for llvm-addr2line
  perf srcline: Avoid addr2line SIGPIPEs

 tools/lib/api/io.h        |  45 ++++++++++
 tools/perf/tests/api-io.c |  36 ++++++++
 tools/perf/util/srcline.c | 171 +++++++++++++++++++++++---------------
 3 files changed, 184 insertions(+), 68 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

