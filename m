Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E549C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2347761040
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhESHVI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhESHVG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 03:21:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B87C061760
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso2326436pjq.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heLMK1eVMd9vz01zbjzMSRH/Wv+AZ6MgS42nN+leRL8=;
        b=XjbDchF23I2Bo56VloArkfZQPG+SkQmBadJ5nE5rEJ0YOcRju17csGqJmZ84opweJy
         c9T9sHYCTv78MMSMKQuquxH3ebgC0VhhUWb3n5z9yYBRRCaXHQslFleBbmmPDR5kfciD
         vNybNIgVuIbUptlBWJijwWURr6eiYaeQHd7kBK+l+4aRIjzlpMYbIVwSvlmS+2uTWspl
         R5iyYcvf0HXkJmMST9QjzeRnz2wKQjligSoeP1yQgzB8Gq++E6mWb8gxvJXMP+bGlQpH
         J0L+L2P3LBC69KwjRF9v2M2R8JfjpndY2JqrPIGTDt0tdgHMvMmdNycZKbL3N3jmNb+U
         zqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heLMK1eVMd9vz01zbjzMSRH/Wv+AZ6MgS42nN+leRL8=;
        b=Jiga61ss4KQ2xNMo95Wo0PghPiyG4eO5BImHsLWHuu5zwDUQMsfFbU3noQTImDRsym
         Il5QB4UizjxwvDjfzswJvqbqnTDgLNTX1svphcelSNTNbMfz8+0NxwHacVsApgV60vSi
         ABTXAbH8Cf6AJ/teIyAuajSkE26qVfHnEQtzcIqoqpEQ8d9etbKff/Xaa7b13Hqoni1C
         QEUL0BCEuQOdWiWGHyPBf1CoxWUXVrZKCfoVT95F3abG2FA1dZGe7VQa9jFWzhBZ2fnG
         oHo/JTbl1veS27m1RS7l8oUYruBSoBq3KD6YBNxe8aq+jHr8Otsw65qLjaq1ScHIzH62
         t+zA==
X-Gm-Message-State: AOAM5300LUF6ZLHR/M4eoiN0XJe5XtYZjqNUpIG9+jzspnLgxAZQLiEx
        3MBzfbzjKCqUUJ2UZMAmMUX9zw==
X-Google-Smtp-Source: ABdhPJzsnkXIAqnGpb2P78SYG5OsZrFZjbzFBEaoM5bed8mXbJBTf7ascukMOrEQKyhdRY6fM+fsuw==
X-Received: by 2002:a17:902:a70f:b029:ea:d4a8:6a84 with SMTP id w15-20020a170902a70fb02900ead4a86a84mr9345467plq.42.1621408786017;
        Wed, 19 May 2021 00:19:46 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id q9sm3435974pjm.23.2021.05.19.00.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/5] perf arm-spe: Enable timestamp
Date:   Wed, 19 May 2021 15:19:34 +0800
Message-Id: <20210519071939.1598923-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch set is to enable timestamp for Arm SPE trace.  It reads out
TSC parameters from the TIME_CONV event, the parameters are used for
conversion between timer counter and kernel time, the calculated
timestamps are assigned to Arm SPE samples.

This patch set can be clearly applied on perf/core branch with:

  commit 046b243a6afb ("perf x86 kvm-stat: Support to analyze kvm MSR")

The patches have been tested on Hisilicon D06 platform.

Changes from v4:
* Dropped the change "perf arm-spe: Remove unused enum value
  ARM_SPE_PER_CPU_MMAPS" for format compatibility (James).

Changes from v3:
* Let to be backwards-compatible for TIME_CONV event (Adrian).

Changes from v2:
* Changed to use TIME_CONV event for extracting clock parameters (Al).

Changes from v1:
* Rebased patch series on the latest perf/core branch;
* Fixed the patch for dumping TSC parameters to support both the
  older and new auxtrace info format.


Leo Yan (5):
  perf arm-spe: Save clock parameters from TIME_CONV event
  perf arm-spe: Convert event kernel time to counter value
  perf arm-spe: Assign kernel time to synthesized event
  perf arm-spe: Bail out if the trace is later than perf event
  perf arm-spe: Don't wait for PERF_RECORD_EXIT event

 tools/perf/util/arm-spe.c | 73 +++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 10 deletions(-)

-- 
2.25.1

