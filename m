Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E17C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Mar 2022 03:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiCYDza (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiCYDza (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Mar 2022 23:55:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CFB33A30
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Mar 2022 20:53:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b13so3625267pfv.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Mar 2022 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvRXa6alu94TqhKYu6X1Xgmr+rthOKW30ixcNTESHCo=;
        b=5UkMKELTIxQzOGIGTFOozNs5XUOb5JzOfrf9IF67osC3rUYWA5h9i8F7MtDfHhIjd0
         vtYuklbtm24k7jYIp8zgnewYxfK39JB38sbvdlesq/K0uCXWotx1rtxk9jguOPvwps7/
         oN/TWOqKoeQC2F2HKFQT85bt2HGQ5T+6ClsBj9niASvL+o89djEiHJjV6Z6ZwQOqU7hO
         y2a9dFoPHrrxefc6bDVQJDw8GtZBvlfKFjglCd2IJ6sF6RODFJOyogqRwZ1Fs57O5vlK
         31hNRqbkO17kJozFCYi3j4QTqa8mHa8tTv/jZhsnvWQrO99/1LBaZxbzOdgo5oJRPvCj
         2lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvRXa6alu94TqhKYu6X1Xgmr+rthOKW30ixcNTESHCo=;
        b=CJ3eoeRZN0wHfFrPDrU6dItxzGTpZkmvCv2P7AA31RduP8CwyVVgIsy9K4JCM/j0Ln
         tSbQkTlsObYbc+nPOJO1kw2R5RN3+HjtUUiEDatFQjIkMLV955VIXxAdIfPFaaTY8kW+
         fJji+PZzaZloM/epeu35nwyZHwhWsHBbw9MRvUvwSG4xllNbpcKJv05MBsfL4RIS+NiE
         eSkeUqI7f1aKNaMRrhLHCqWE/BGTpoLLL+9ROY9cMYHzFJ51JvIxMUubC7j15JjV6CnI
         KXGm/vmQPZ5JWVOR/vIG6qD91BxAUP/AXj9mNStRopInCE5vPmujNrCp2tnsPaV5tHkk
         SeCw==
X-Gm-Message-State: AOAM5330yWY/sgHAilW5VTpWN120+H6DFxIeXZhbJXWM+iaY+NCx9zmv
        21y69MqLwqMviWw31inxNjQs1w==
X-Google-Smtp-Source: ABdhPJwwzuRlN+4cwGj4yJ5TwudOy/S1v+SJWXqEX3GmDZ8kMMTEz1CZ1Hxf22pX5tLCxCI4OcR9Pw==
X-Received: by 2002:a05:6a00:2386:b0:4fa:e772:ebac with SMTP id f6-20020a056a00238600b004fae772ebacmr7915963pfc.75.1648180436500;
        Thu, 24 Mar 2022 20:53:56 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:53:55 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 0/5] perf/core: Fixes and cleanup for cgroup events
Date:   Fri, 25 Mar 2022 11:53:13 +0800
Message-Id: <20220325035318.42168-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

This patchset mainly fix a race problem between cgroup_migrate_execute()
and perf_cgroup_sched_out/in().

v3:
 - put two fix patches together in patch 4
 - delete percpu cpu_perf_cgroup, just use cpuctx->cgrp to compare
 - reorganize these patches' order

v2:
 - split into two patches to fix the race problem for easier review
 - use cpuctx->cgrp when start ctx time and delete unused task argument
 - use cpuctx->cgrp when update ctx time from cgroup perf_event
 - always set cpuctx->cgrp when the first cgroup event enabled
 - remove obselete comments

v1:
 - https://lore.kernel.org/lkml/20220308135948.55336-1-zhouchengming@bytedance.com/

Chengming Zhou (5):
  perf/core: Don't pass task around when ctx sched in
  perf/core: Use perf_cgroup_info->active to check if cgroup is active
  perf/core: Don't need event_filter_match in merge_sched_in()
  perf/core: Fix perf_cgroup_switch()
  perf/core: Always set cpuctx cgrp when enable cgroup event

 kernel/events/core.c | 212 +++++++++++--------------------------------
 1 file changed, 52 insertions(+), 160 deletions(-)

-- 
2.20.1

