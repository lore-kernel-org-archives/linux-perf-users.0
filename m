Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38017C74A5B
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Mar 2023 11:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjC2LO3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Mar 2023 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2LO2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Mar 2023 07:14:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D140C4
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 04:14:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so15282599wrd.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680088466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcF0vX8j8gqWH3Qe03F1mOXxKH3Dih4Bs0j11Tzpjbo=;
        b=CqtWfSA0HALwgFr3US5SPtV4WTVD8MrH6cLx8wHXzh3tnzeet1qd2KiWvrHn8n+GKb
         JeQiOhybZTrUMrETQIqsTgV6BXwYXaHKXuD6AjLcFnOlcpWau3a38xNF5aCj0d+Dgqal
         787y/V5xfOmzgxeU9Nzwg0fP5pskAakWQFy2Qb+mVET7X5aX3RhaZS0iF2OeQIoZv/BP
         RixWO032QlUy7U6Mn9m5Ixm7jI+DggEFAtq/n5qucER7y9nsiaq7mm0nDf0twJrPry1W
         UOfKThT8RaimVyatAY882OCvpRQs6PKPcS1PD11H7Yc70EpdpLaYigt0aUEj9+zVB8Ft
         Y4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcF0vX8j8gqWH3Qe03F1mOXxKH3Dih4Bs0j11Tzpjbo=;
        b=TByZhV/m6dsWn/DHclbvzWVElB5m7XvY6bLJ5mkhsJb8DnQ/JGG1VRP4xcJFw2W9u1
         5I2Ekl1CNmWkW80YGj+uBZmsRzx6m3x1b+QTFb1yrjIUjHVF89BJpbTAxUuhCXFPHlx1
         PJ2GiUnJh4M5E5rh6z/DS/7342dNBcphw6WImwmcDiptCy4IRtEY2H4tVmJWxRWrrCpt
         fsR5xStwWn7/cT3J/aHga0q/sTA8iaCGvziWoJKbXLgGr0/Yz+uBtJ/9rKCIOs9KzxJD
         sPNh8FEsBm5XMc8SmMqjdy5yIasjd+ldsa38B86MGvkuVmLaeccTNnzb0hr0Y422w4Nb
         Qvvg==
X-Gm-Message-State: AAQBX9eoM1yInJjmZ2pYK/tFhsG15Gylv2hPCdOB/LWn0+wsuvJ8cnDi
        vj1oAtQ4l/xKscqQZP8uAsCyP6yUyu6brvfB9ns=
X-Google-Smtp-Source: AKy350ZwYFFQU329m4ivgWvusumP663lpxpwBKfi5CMKQa2WHao1B/T4u3EW5VhN5eZvjO+v4BgLeQ==
X-Received: by 2002:adf:e242:0:b0:2cf:e15b:c1c5 with SMTP id bl2-20020adfe242000000b002cfe15bc1c5mr14341071wrb.22.1680088465952;
        Wed, 29 Mar 2023 04:14:25 -0700 (PDT)
Received: from linaro.org (host86-131-79-192.range86-131.btcentralplus.com. [86.131.79.192])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b002cde25fba30sm30067163wrx.1.2023.03.29.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:14:25 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        suzuki.poulose@arm.com
Cc:     leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v8 0/3] perf: cs-etm: Update perf to handle new Coresight Trace ID
Date:   Wed, 29 Mar 2023 12:14:19 +0100
Message-Id: <20230329111422.3693-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The original method for allocating trace source ID values to sources was
to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
The STM was allocated ID 0x1.

This mechanism is broken for systems with more than 47 cores.

The kernel related patches the provide a fixed Trace ID allocation mechanism
are now upstreamed.

This patchset updates the perf code to handle the changes to the trace ID
notification mechanism that now uses the PERF_RECORD_AUX_OUTPUT_HW_ID
packet to set Trace ID in the perf ETM decoders.

Applies to perf/core 

Changes since v7:
Split from original patchset [1] to be sent separately as kernel related
patches are now upstream.

[1] https://lore.kernel.org/linux-arm-kernel/20230116124928.5440-1-mike.leach@linaro.org/

Mike Leach (3):
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet

 tools/include/linux/coresight-pmu.h           |  47 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  21 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 326 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  14 +-
 5 files changed, 350 insertions(+), 65 deletions(-)

-- 
2.32.0

