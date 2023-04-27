Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76829C77B73
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Apr 2023 20:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbjD0UiQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Apr 2023 16:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbjD0UiK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Apr 2023 16:38:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5059423A;
        Thu, 27 Apr 2023 13:38:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-95f4c5cb755so458248566b.0;
        Thu, 27 Apr 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682627887; x=1685219887;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=REjZ46P60cqFHRGabjrEsGAi5GtYTwnrASydrK+kdp0=;
        b=RekVHokdfbsBvWn+uuP7JVr7tESdEYeQ7bbZ8pH3UiOVMoYeH09PK97guifASfAWI4
         gFIwBAmam+sWpS+r01eE7pgbXmWkoYVToUExADA35WGndydyBEctFMx17CcpxA4uVI77
         zXY58QJriuDrQx176dlyUqSFfsv9mSyKUzBIdN78AfltReUkbp6WA4iVvScUixTo/1qM
         HVnkeXUZ5Zy5ESYGkBm5K1QRpXc7iq5b9kH/hRHvWOuQa6z9B8eC54pw+7qcvU8qJW8h
         QJe10pW9HK71g2pz7AyPqtHko05O1Lj13R2YaOkZJEjZ+HlSTwA9KpUtiohazztkPegs
         82dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627887; x=1685219887;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REjZ46P60cqFHRGabjrEsGAi5GtYTwnrASydrK+kdp0=;
        b=Net21/MF+Yb5FsAdgXeXzSx8Xrt//06KDn7sqc8/Q/QfVeUjmSXNYhw0PLDI4WRTAO
         Ip+sOpifc3AEadDsRXscLj4HAIjPJH1lsqdr/rZz95gRomOxq2DNaHywijEtkH8pMBqs
         O46glB6omkBmnLU2Hb9hhgChWPdmifkHlNre33m9lLGxJcORD+jItNxYFQguoyVv+iZQ
         2JpyJphJChUQPVPBJgpxhHEt/FgpcGHxFo7v8OZ6YBThS6N7YFogF2KSsOD2fYJLOjvc
         3A7uoKVj7/jcu3bHRTKJEgkKZg65XabHHhi/Tr5iD4OHybfL7KlCkjYPZXOExKDNlqmw
         KZIg==
X-Gm-Message-State: AC+VfDzZRSbfMg8ZBaN7HwHf1pIhBiH6HT+cBa5ZEyW/Evpmy+3+GyCR
        bya6JsAoJOpRb1eM0+kX5SE=
X-Google-Smtp-Source: ACHHUZ4K52G2eDlOMYXCveyy7GRZS982zkfIdGrva69OjHY5Xt2w2P7CViwWODH4g+lCbN1d5TfD4w==
X-Received: by 2002:a17:907:7b93:b0:958:4870:8d09 with SMTP id ne19-20020a1709077b9300b0095848708d09mr2878334ejc.37.1682627887262;
        Thu, 27 Apr 2023 13:38:07 -0700 (PDT)
Received: from gmail.com (1F2EF38A.nat.pool.telekom.hu. [31.46.243.138])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm10237726ejx.159.2023.04.27.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:38:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 27 Apr 2023 22:38:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf event updates for v6.4
Message-ID: <ZErdLD+FWUjx08ey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-04-27

   # HEAD: 743767d6f6b8f28228be181fe369657f7ecd1eb2 perf/x86/intel/uncore: Add events for Intel SPR IMC PMU

Perf changes for v6.4:

 - Add Intel Granite Rapids support

 - Add uncore events for Intel SPR IMC PMU

 - Fix perf IRQ throttling bug

 Thanks,

	Ingo

------------------>
Artem Bityutskiy (1):
      perf/x86/cstate: Add Granite Rapids support

Kan Liang (2):
      perf/x86/intel: Add Granite Rapids
      perf/x86/msr: Add Granite Rapids

Stephane Eranian (1):
      perf/x86/intel/uncore: Add events for Intel SPR IMC PMU

Yang Jihong (1):
      perf/core: Fix hardlockup failure caused by perf throttle


 arch/x86/events/intel/core.c         | 16 ++++++++++++++--
 arch/x86/events/intel/cstate.c       |  2 ++
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++++++++
 arch/x86/events/msr.c                |  2 ++
 kernel/events/core.c                 |  4 ++--
 5 files changed, 32 insertions(+), 4 deletions(-)
