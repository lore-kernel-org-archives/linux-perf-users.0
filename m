Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530BEB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjGXUM4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGXUMy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 16:12:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA5188
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 13:12:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584126c65d1so7736197b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229572; x=1690834372;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qd83SvYx4O+g1mfcaqYz4UeSIRNutVl7jKxeFEywY=;
        b=pjmhJI2UMVSo0ZLkueSW/j/h4CPCqUEQHkXsiBIOVsLlCz7xAxezyPdSi7tryxRfog
         +EnkGX5/jNxb4KJ87EmOK86b7C1swlhBsp6732VqlaX+RSq7zlB7iWlN2B2R6X/qaRci
         zAum1rwT6cCZ5FBNhzodpUe4nNOwLN9aKrzcJIeogtc8Va3ng2W6Yx/B4zqTWDHhyN6d
         Q4QzOqFgFRjRqGYRNOlE3XfRe4mvND2e18Z5NmqUCJGT/iZo3/Vvy02afXUbFbkk8Gth
         DRe516Jy3euJ4KsAii07QamDiuQzdU2p2dM1P52WMY66T0vaX89+Cu+NOu8yXMBow1J3
         LGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229572; x=1690834372;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++qd83SvYx4O+g1mfcaqYz4UeSIRNutVl7jKxeFEywY=;
        b=N+UolIJX+Qu8qfH5zon4pqwj4GMtdmBpUogEMNkX6HyoZpY9dwBOcsWG4xr7O9UkzD
         n+uKFxqjPwRkRn9RsMSA/egHRwCZDFVkO7R79IYyI3xu87sgpZaKuXizX/gRyF6Q/GG8
         S7jc4g8DGv/Ui0qbR37qiJDZkBK3uVLGCbRlEROu3rpsgIlP9XXf1lJGaW+YCoL+dFGL
         FbrvIDWGo3N7ac2vMHDiBh/OdY8uC6NmNF3o/kOho+51MBHafsPebObgSSCSMN3xx4nA
         05xHG1A94TQB6FvzjZC4nR62pWPT7DUol1pTUqyFF9lWcDjUqomCnQcFr/euuDkOSnVe
         wz4A==
X-Gm-Message-State: ABy/qLYDdvZn8H+mIUFDJls+xv08e7mH4tVVws1dke35XAarUJr0QGGv
        GQ6zv5kX3Gf89DM59/zwAhLg++U6bh8x
X-Google-Smtp-Source: APBJJlEwAq/rZS1ckxZoRCzDTn4+i1Vkf44RQCvwMa2Lq6CVP6f9fOQqpMnxMsHhzBYsRzrTUqd96mIv9LJv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a5b:643:0:b0:c4e:3060:41f9 with SMTP id
 o3-20020a5b0643000000b00c4e306041f9mr78575ybq.9.1690229572729; Mon, 24 Jul
 2023 13:12:52 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:12:43 -0700
Message-Id: <20230724201247.748146-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/4] Perf tool LTO support
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
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a build flag, LTO=3D1, so that perf is built with the -flto
flag. Address some build errors this configuration throws up.

For me on my Debian derived OS, "CC=3Dclang CXX=3Dclang++ LD=3Dld.lld" work=
s
fine. With GCC LTO this fails with:
```
lto-wrapper: warning: using serial compilation of 50 LTRANS jobs
lto-wrapper: note: see the =E2=80=98-flto=E2=80=99 option documentation for=
 more information
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel.ro+0x28): undefined=
 reference to `memset_orig'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel.ro+0x40): undefined=
 reference to `__memset'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel+0x28): undefined re=
ference to `memcpy_orig'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel+0x40): undefined re=
ference to `__memcpy'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans44.ltrans.o: in function `test__arch_unwin=
d_sample':
/home/irogers/kernel.org/tools/perf/arch/x86/tests/dwarf-unwind.c:72: undef=
ined reference to `perf_regs_load'
collect2: error: ld returned 1 exit status
```

The issue is that we build multiple .o files in a directory and then
link them into a .o with "ld -r" (cmd_ld_multi). This early link step
appears to trigger GCC to remove the .S file definition of the symbol
and break the later link step (the perf-in.o shows perf_regs_load, for
example, going from the text section to being undefined at the link
step which doesn't happen with clang or without LTO). It is possible
to work around this by taking the final perf link command and adding
the .o files generated from .S back into it, namely:
arch/x86/tests/regs_load.o
bench/mem-memset-x86-64-asm.o
bench/mem-memcpy-x86-64-asm.o

A quick performance check and the performance improvements from LTO
are noticeable:

Non-LTO
```
$ perf bench internals synthesize
 # Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 202.216 usec (+- 0.160 usec)
  Average num. events: 51.000 (+- 0.000)
  Average time per event 3.965 usec
  Average data synthesis took: 230.875 usec (+- 0.285 usec)
  Average num. events: 271.000 (+- 0.000)
  Average time per event 0.852 usec
```

LTO
```
$ perf bench internals synthesize
 # Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 104.530 usec (+- 0.074 usec)
  Average num. events: 51.000 (+- 0.000)
  Average time per event 2.050 usec
  Average data synthesis took: 112.660 usec (+- 0.114 usec)
  Average num. events: 273.000 (+- 0.000)
  Average time per event 0.413 usec
```

Ian Rogers (4):
  perf stat: Avoid uninitialized use of perf_stat_config
  perf parse-events: Avoid use uninitialized warning
  perf test: Avoid weak symbol for arch_tests
  perf build: Add LTO build option

 tools/perf/Makefile.config      |  5 +++++
 tools/perf/tests/builtin-test.c | 11 ++++++++++-
 tools/perf/tests/stat.c         |  2 +-
 tools/perf/util/parse-events.c  |  2 +-
 tools/perf/util/stat.c          |  2 +-
 5 files changed, 18 insertions(+), 4 deletions(-)

--=20
2.41.0.487.g6d72f3e995-goog

