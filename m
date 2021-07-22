Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33549C6377D
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B4F61279
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhGVOxr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhGVOxq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 10:53:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62710C061757;
        Thu, 22 Jul 2021 08:34:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k14-20020a05600c1c8eb02901f13dd1672aso2737873wms.0;
        Thu, 22 Jul 2021 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyJINemfwGSOATCuLd9fCZ7pa/ePCnr/XUM9FOXXsb4=;
        b=G5YyGfStsB9EVlRm3eT80MFacY56yEfeHXGU/frm0/nqvvEUBqqfmLtAM1Fyi1YjPs
         QO8mvc8H3nEy0vCLE9Rxp1d73eyrQBNv6BooPcXpJwNU8dQEniMGo0HUZch1BCkD+GwA
         nCu58wZ6QSL5oQDHmpBrUyewocN+SzbmgTasyjnti1gJdqvCRpCCy2x6Ir025v4jXK0h
         JFpaKnhq3rDDJu89WVyBB/rdAV80FulZOc9UD157aCWN0xz6e7y9a/fD1NdwhxbS30Nf
         M+Yoal/YD+McZ58wlRFhq7jF5SzRKcYr9h22EMi3IYkAYJe4QMeKrbRPMhAm3dA+W43G
         4z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyJINemfwGSOATCuLd9fCZ7pa/ePCnr/XUM9FOXXsb4=;
        b=bWNte8Z7z8LpFPsYGce/Q+mJAoJOO3D71wYxvq0W4RIwygA6MgWtQGyN1sHXaDYOil
         G7TIFnRO+9Ylr46f4clhEzOVSJsyCToIkcIIFg+hnzUmJgGk0totWEqG76DbmquEZWSV
         0cT4xEmZeVFJBXjzyPbYgiO1/Qumb379mMIsCRYTSbVJ4rdpzSFpcetkV6MM1KGSsQ18
         t5nny+dheLvkjHj42HHUCd8bgCT/rxb6lufiOTaAEbSr/SxtQzo2zY5NYrMYhS9LbKzF
         8ewfVG0yRQ0PvIRKWTTkgD2avzP5h/8RSlIjnJLTJ/ZUsgUfE67K/y3lqlD03pMU1Nlj
         tGfw==
X-Gm-Message-State: AOAM530xad3W2j8kG9FyNiG6/EUsZ55hQ3GLfeazHGeXQiZWLuvIVY4e
        8YzAhweodecUcCshMPJyZXU=
X-Google-Smtp-Source: ABdhPJwtaOoDNCk6VjMtEbgUvxoECSMJySKBc+hFIfTJdtGxA8XzU17iDUKGiuW9bQV0gvbtbMbsdA==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr9336496wmh.89.1626968058881;
        Thu, 22 Jul 2021 08:34:18 -0700 (PDT)
Received: from honeypot.. ([185.91.190.155])
        by smtp.googlemail.com with ESMTPSA id o29sm23735557wms.13.2021.07.22.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:34:18 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] tools: add gettid to libc_compat.h
Date:   Thu, 22 Jul 2021 17:34:13 +0200
Message-Id: <cover.1626966805.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

following our previous discussion on workqueue RFC patchset, I'm sending
this patchet to add gettid to tools/include/tools/libc_compat.h.
This new definition will replace existing uses and will be used by the
workqueue code.

Thanks,
Riccardo

Riccardo Mancini (3):
  tools libc_compat: add gettid
  perf jvmti: use gettid from libc_compat
  perf test: mmap-thread-lookup: use gettid

 tools/include/tools/libc_compat.h     | 7 +++++++
 tools/perf/jvmti/jvmti_agent.c        | 9 +--------
 tools/perf/tests/mmap-thread-lookup.c | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.31.1

