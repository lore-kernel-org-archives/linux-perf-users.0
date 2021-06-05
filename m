Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849CC47082
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FC7613F7
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFEQAE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 12:00:04 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43873 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFEQAE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 5 Jun 2021 12:00:04 -0400
Received: by mail-lf1-f46.google.com with SMTP id n12so11666476lft.10;
        Sat, 05 Jun 2021 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ehYbXWei0OImMWrxYorzLQTXZn+uRgvWSHld7JUNEk=;
        b=MVOVJYYk3yBMMByuUIpGdsXaoZu4o8RFl8VP73j3JeLPnv2fNxAap8GHnQYEC+SVZq
         4QdoWpU+QWd0LodpSUdohRWVc+J5aM+buiWOFlLma19VIlxtkcNuwdLcJhsWS/rRejpy
         u9ZK1PGYTTjaruJChW8KnYjvL/LKaOBEg0NHsY7mgg5G5C2gYCPdopireSddo/+IiBEB
         cPhSo1EfrOsO5wckdj86iZ1AqYOjR8HaEeQJJs2FZN904a2d8CK4X2OMF80MCniCqCOA
         tOI8ZbgZL9gLBCO2wBpovmFHbOyJSrDFdyV/QAwUJOISBUpLpxXUVl/ULzoA32ZUrNus
         Ft4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ehYbXWei0OImMWrxYorzLQTXZn+uRgvWSHld7JUNEk=;
        b=cIATnuUVR9Qk64ggoRHbr03pu53DFx2xPw85o4qHkNriTB5I0tDVoZmkePu7tcpC4m
         7r4jxA7MHZML87fwy1CsKMkbZGXvFAjIIsHbu/ZTGchq/9V+whpwtnjOtFd3TJ8kgDeQ
         1vgoYVwP+0f83wWwJi0U99ZBjHzBjnvK6b8F8yI+RrxUCN+4VOxp2nUU9o+7wEnftclN
         DZ7hnMIHiQkGWxOpaUc0dIg0T+1oaoHJLFJMnhhYBEIlvxZj/+VLYSJXWIY4ntYikqk3
         a+GD/sv3WPu+xVmqtZDxLpNk54OnbEtm/uiGX0UTEjBSGI5tkq8LvvQ+N18Dh5C741Ea
         JFdg==
X-Gm-Message-State: AOAM531tG3Dntb9mt5rvDh2MCrb7Bu3O1Yf9Sv1rROlyX5Vl0kF15j+O
        iGsoSzUdgBHgBBx3jPfQAbM=
X-Google-Smtp-Source: ABdhPJwTxI/s4rqvDXgl+n9Sq+xNifvGJuS21NJiBOyQynsLUx9DBSj5OYAVs9/pGtHJS8vmGjDR7g==
X-Received: by 2002:a19:da12:: with SMTP id r18mr6185125lfg.549.1622908625360;
        Sat, 05 Jun 2021 08:57:05 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id w15sm146264lfq.94.2021.06.05.08.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 08:57:04 -0700 (PDT)
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
Subject: [PATCH 0/4] perf/x86/intel: Constify static structs
Date:   Sat,  5 Jun 2021 17:56:49 +0200
Message-Id: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Constify a number of static structs which are not modified to allow the
compiler to place them in read-only memory. All in all, it moves ~25kB
to read-only memory (if looking at o-files).

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
 arch/x86/events/intel/uncore_snb.c       |  20 ++---
 arch/x86/events/intel/uncore_snbep.c     | 102 +++++++++++------------
 8 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.31.1

