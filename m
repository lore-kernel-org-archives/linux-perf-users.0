Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F1C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Jun 2022 22:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiFHWoL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiFHWoK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Jun 2022 18:44:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA281451C3
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 15:44:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fb7cb07885so187695517b3.23
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c71GUnbx+z6Y5oCQfLFXFuUDIswD3dH2AVqf07yimc4=;
        b=sIXoLvSdtOdydgKjNRX9fsjJLCVsEd64zX2lgGPe9WVIBkR4eR4jDY7QOAmyZp2Wk/
         5ZHxa+8AOCItYjNbLndgvKunj/BLS6BR5QctXiYETYnygk69R1oYb1M4o1OCD0S2bgSR
         sQ7fq85nLWlyf2ZocBx0xIlXhXok9a26CT0x+vrqRNHTmpI8ZKw6NNOYQEggeFT/Deh0
         vchQkvP/r8MncbWWTHAzxI2rIQ5cQ8tgtOT1w8YaIf4i31LGH/z5pO3w9/NuXtB3IRKl
         4QUbvA8X8o/pTmYbhba/QonnCVtup9IE7l1N3QuoQ0hCgE/A7iFUzzKg3BO+6I4dGdaT
         8GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c71GUnbx+z6Y5oCQfLFXFuUDIswD3dH2AVqf07yimc4=;
        b=GOwSIqlatecMHkBsZzIOKYr/k6DsaVhKQ7BHwuTTiwLNstKAtmKB23zhz/pojQMUO7
         PW5TEGZNGFQZV+p6rERjoj+yKmg6BotAZhANDky3Gqqu42TkZW/8U2/SC7dQzEcMqfYv
         iKLv5DIOHgiVYUAc3dEMmCBwMo6i/fafJQIzwK0pk04eQze8Eri0+OKrNuSdtpUBcQ15
         GqnHftTgeHrB/yyGTf4bp5Izxin6qy0PrQYAz/UGAzz7bQed5WKauQYUFkj/QTO4DM7G
         ErXRsAMafovjNs+ud1tRYP/D5iUfaXZ3ieLeB8+PfdEOS2Wbq/u4hetAV1ScF9OXhd/v
         zQSg==
X-Gm-Message-State: AOAM530iHjanb4aZfXPbgG88OgNSxrRAcxbKXljItfPhiPm0Db52UIfP
        Fqtu+N/jaG2JABH7njEE+wv3MxYX+dnd
X-Google-Smtp-Source: ABdhPJwtjq7Aa6pMRv1NxODntk17KxAxXvWtguTP8EZW9/AaerYYPdzeob19tmVRO6kSD4N39gVC1grkyHdN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de48:5efa:e4a1:2219])
 (user=irogers job=sendgmr) by 2002:a25:ac4d:0:b0:663:e6dd:ae2e with SMTP id
 r13-20020a25ac4d000000b00663e6ddae2emr9266685ybd.510.1654728247803; Wed, 08
 Jun 2022 15:44:07 -0700 (PDT)
Date:   Wed,  8 Jun 2022 15:43:49 -0700
Message-Id: <20220608224353.1176079-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 0/4] Tidy user rdpmc documentation and testing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libperf's perf_mmap__read_self and the addition of arm64 support mean
that the perf_event.h and the rdpmc perf test have become
stale. Refresh the documentation in perf_event.h, remove the x86 rdpmc
test and port the libperf test as a non-architecture specific test.

Address sanitizer testing showed libperf leaking fds when the
perf_event_open failed, add error paths to handle this.

A comment is added to perf_event.h to avoid a divide by zero when
scaling counts if the running time is 0. This was previously discussed
in this thread:
https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/

Ian Rogers (4):
  libperf evsel: Open shouldn't leak fd on failure
  perf: Align user space counter reading with code
  perf test: Remove x86 rdpmc test
  perf test: Add user space counter reading tests

 include/uapi/linux/perf_event.h        |  32 +++--
 tools/include/uapi/linux/perf_event.h  |  32 +++--
 tools/lib/perf/evsel.c                 |  17 ++-
 tools/perf/arch/x86/tests/Build        |   1 -
 tools/perf/arch/x86/tests/arch-tests.c |   2 -
 tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
 tools/perf/tests/mmap-basic.c          | 128 ++++++++++++++++-
 7 files changed, 177 insertions(+), 217 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

-- 
2.36.1.255.ge46751e96f-goog

