Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E813DC48BE0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3BA611B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFKUx2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKUx2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 16:53:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA7C061574;
        Fri, 11 Jun 2021 13:51:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp38so10489049lfb.0;
        Fri, 11 Jun 2021 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVKIt9phA9ApReTa/x0wBG20rQLtp8aFT4UgfH6+3no=;
        b=tkmOCx3Xj6ElkjWmov5IjfgX//q+Ht+zHFGC9p8980/sXlXo6gc5a5jUnT+C9n/KjG
         jZ+DedaI3/5SldieFK5lo9b2JXkUMBwPwK8pbNNPlY9L9DOQH4Ye3p5BvyeuGOiMPtEx
         I2EVkrt1XgVdPajtnWqpP9/2x0u+gz8Ez76uR5YaOfNVon1uGf9FiyRg9BeczAUC7+VB
         jzMuIjWI1SoPZ+wpXYi3G+kdjE7Kx3WyMf/ExX5pECTc2KaB1yFEnmS7DwQdgBSYtwDf
         IJWO8O6m0M9CZ7azvsKWGggkzcm9IfK3czhHZZu5tyUMH226WPksYMiMVEIulWykx+zD
         6f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVKIt9phA9ApReTa/x0wBG20rQLtp8aFT4UgfH6+3no=;
        b=UO2E2tCQrbDKSYcFj6qIKtHru7Amp9SFAmnQLsVtu88o+JFQMBdWHGTAskURC1CXl1
         V5GouBebyJCTie9CayyJzAsCU4kYb2hEfdto0vSSp1Z+VAHGXAl0UJkFKz7ALPRaJ04+
         9FPV5vFseCSHsp9TxFkXHrXTmLRlhNEIoNZciKuH9I2um4rZZMeVcLphWjEtl1HRccS/
         yVMAr49IYY0BjU95DEG0rX+wGecyQaCv5/gxzOzDtdnOkRKwQ77yoFD4tPoMOuPWHThB
         gZVL1OdrUDch7U8ly1QiPu1F00kYFmK2jHp+BvUfJoPIP0SCKX+weXPIv8xi2O/TwbKj
         fiYA==
X-Gm-Message-State: AOAM532sI5ZGZYQwCJRDywigPK+l02XskloCziZokRFR90Q826/4Nc8F
        ZizjDqciotuSeW7dACdsecnqqXKiMiUvnQ==
X-Google-Smtp-Source: ABdhPJyzVgU1vIf7Ghk1/zKo7Unxo6q5HkpLd2H0iFOMz9WSDmf/CVCwITb8Ogyu2OEyFNzoJFRwbQ==
X-Received: by 2002:a05:6512:1303:: with SMTP id x3mr3608382lfu.276.1623444688277;
        Fri, 11 Jun 2021 13:51:28 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id r7sm687118lfr.242.2021.06.11.13.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:51:27 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH V2 0/4] perf/x86/intel: Constify static structs
Date:   Fri, 11 Jun 2021 22:51:08 +0200
Message-Id: <20210611205112.27225-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Constify a number of static structs which are not modified to allow the
compiler to place them in read-only memory. All in all, it moves ~25kB
to read-only memory (if looking at o-files).

Changes since v1:
- Introduce rkl_uncore_msr_ops to be able to constify skl_uncore_msr_ops
  (now all intel_uncore_ops are const).

Rikard Falkeborn (4):
  perf/x86/intel/uncore: Constify intel_uncore_ops
  perf/x86/intel: Constify static attribute_group structs
  perf/x86/intel/uncore: Constify freerunning_counters
  perf/x86/intel/uncore: Constify unmodified static extra_reg structs

 arch/x86/events/intel/core.c             |   8 +-
 arch/x86/events/intel/cstate.c           |  10 +--
 arch/x86/events/intel/pt.c               |   4 +-
 arch/x86/events/intel/uncore.h           |   6 +-
 arch/x86/events/intel/uncore_discovery.c |   6 +-
 arch/x86/events/intel/uncore_nhmex.c     |  16 ++--
 arch/x86/events/intel/uncore_snb.c       |  38 +++++----
 arch/x86/events/intel/uncore_snbep.c     | 102 +++++++++++------------
 8 files changed, 99 insertions(+), 91 deletions(-)

-- 
2.32.0

