Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5038CC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8A36101B
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhG1XCj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:02:39 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39747 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhG1XCi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Jul 2021 19:02:38 -0400
Received: by mail-io1-f45.google.com with SMTP id j21so4646951ioo.6;
        Wed, 28 Jul 2021 16:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zcT0CaB9kN2T3PMOS6JNuQI+lMgOqz4mktM1Kdoh2lA=;
        b=LeO+wWmsE/LKNyxty0n8/u6ysjPDPu0VhRDoWl8WWdsEw2T9hpLkpPATfRzXi1ZDKc
         eCYTocxAav7oKx9C385+Zti2cPLriF2DZ7tf2jPuDufDA1pPTf/iguCAygsrjkHzOrNz
         XiQfWZbcTwcQfxx/f8PCv4Bcb+sYtvPRrZzTHcXzcfielnjNFwFW9blaGPu/+P7525mi
         OPl0yR0HN3VqJEEvvMp+KltwFGaolrrD/sLgu7BNd1NihtAWjdP4gOwD7lgdqZQUsPeA
         zRNKewWlH2Gj4WUVVYVnUhYllUKpNgFYzjkvfZPUPKQeJ6KN678igNCaAOpN67UwXAoA
         VtWg==
X-Gm-Message-State: AOAM531ZZEN/7ZLcNqvBDJm1SVZLBCL9U31mkN61EVfvtne1WMazMv23
        86I5eI5s72PMd2n45Mpt+Q==
X-Google-Smtp-Source: ABdhPJxdSkqY3tEIRhGrhjM5Xphb7LnOBoDAgo8/cHwZSqsaUtz//z4pW+rTG1kG7NYgvkhWikMI6A==
X-Received: by 2002:a6b:e016:: with SMTP id z22mr1430367iog.187.1627513355565;
        Wed, 28 Jul 2021 16:02:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j20sm974821ile.17.2021.07.28.16.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:02:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [RFC 0/3] perf/x86: Rework RDPMC access handling
Date:   Wed, 28 Jul 2021 17:02:27 -0600
Message-Id: <20210728230230.1911468-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series is preparation for supporting perf user counter access on arm64.

Originally, the arm64 implementation was just a copy of the x86 version, but
Will did not like the mm_context state tracking nor the IPIs (mm_cpumask
doesn't work for arm64). The hook into switch_mm and the IPIs feel like
working around limitations in the perf core (aka the platform problem).
So this series aims to solve that such that all the state for RDPMC is
tracked and controlled via the perf core.

Alternatively, I could avoid all the x86 changes here with a new PMU
callback (.set_user_access()?) and plumb that into the perf core context
and mmap code. However, it's better in the long run if there's a common
implementation.

So far, I've only tested the perf core changes with the arm64 version of
the code which is similar to the x86 version here. I'm hoping for some
quick feedback on the direction here and whether I've missed some usecase
that isn't handled.

Rob


Rob Herring (3):
  x86: perf: Move RDPMC event flag to a common definition
  perf/x86: Control RDPMC access from .enable() hook
  perf/x86: Call mmap event callbacks on event's CPU

 arch/x86/events/core.c             | 113 +++++++++++++++--------------
 arch/x86/events/perf_event.h       |   2 +-
 arch/x86/include/asm/mmu.h         |   1 -
 arch/x86/include/asm/mmu_context.h |   6 --
 arch/x86/include/asm/perf_event.h  |   1 -
 arch/x86/mm/tlb.c                  |  29 +-------
 include/linux/perf_event.h         |   9 ++-
 kernel/events/core.c               |  56 +++++++++++---
 8 files changed, 113 insertions(+), 104 deletions(-)

--
2.27.0
