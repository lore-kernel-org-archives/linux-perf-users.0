Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07665C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Mar 2022 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbiC2Pr3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiC2Pr2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3B3A722
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 08:45:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so17884338pjb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBWbnx9nmzpAVk+ZjuUdTpMYBLq8k4If2dmnAQXSRqs=;
        b=CAlgzMvhKAuMBP/KNFNTLpGMzTNRw/jYBSJHv9/OXpabr64KZM2xwneiShOr2va39m
         CIxaq0Wp5DRppuVj+7eStv93DZ5PDZRXJdeCrNwy6O+U9acfEg2mC8/6/9KOCEESP1F2
         2xn5DXtmr0vr1//0yuIcgFqgnd+/ldRQjqtPDcfKid+7a/er8uhKS+02120dtLnSRLuu
         yBrjtK/0p4WQciARh/7hfX/qV49payYKLzPaXPBTv6QuLSu8Wx401aFUDWIzCpohRpjx
         SmajDmBcOmDru3W6XB1xLty3R4BBBgn89IBHDNJNB9sibTsB1+x9OmvcaMMo29g/kGOR
         Vn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBWbnx9nmzpAVk+ZjuUdTpMYBLq8k4If2dmnAQXSRqs=;
        b=ZFPOlO3zt9rKoUOsbwSkRoxqoXO2ExVoc53iH6OgBBJvEED6tstJCzeUnuhkmdIVMZ
         2Lr1ybwvIcgx505a2xbZK+Xb9DZRAqBdGFUqnGwc1ClYLACQxGfmgievjzIUMXTwpmFy
         /feH5T5T6Rr4s/kUv6QLPAXBu0CXF/o5OHUFQmvlQQb+rRPoqfg+zMg+P+LQZboSGCSP
         norYD1JCEk0tMlKIRVmoOG+ZYnuMAebFYlaLvN+rZDu4wO9TCSqLSsIzdmpgiW/ngnlO
         w58gUzmaz/PVcGKp+AAlFikNJWR+xDUNhZTRh1AMpAab2nxT0HI6E+tigX7pDEe+kvD5
         /6bw==
X-Gm-Message-State: AOAM531tgDEI4+skJaRQ3QCrztRMHTUcsvQginNimL4XpchianFah1No
        V7M1bnqdxVysAx7WRTShECDCUw==
X-Google-Smtp-Source: ABdhPJzz19Rg+Su10Np5HFxc79yFW1oMkdOJLvHJr7FrwyKx+yX7c483JS7yzqqD2oF7eq7kBNbMwg==
X-Received: by 2002:a17:90b:4b89:b0:1c8:105a:2262 with SMTP id lr9-20020a17090b4b8900b001c8105a2262mr178749pjb.225.1648568744396;
        Tue, 29 Mar 2022 08:45:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:45:43 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 0/4] perf/core: Fixes for cgroup events
Date:   Tue, 29 Mar 2022 23:45:19 +0800
Message-Id: <20220329154523.86438-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

This patchset mainly fix a race problem between cgroup_migrate_execute()
and perf_cgroup_sched_out/in().

v4:
 - delete patch 3 in v3 that remove event_filter_match() in
   merge_sched_in(), which is wrong since the hybrid system
   implemented PMU specific filter_match callback. Thanks Kan.

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


Chengming Zhou (4):
  perf/core: Don't pass task around when ctx sched in
  perf/core: Use perf_cgroup_info->active to check if cgroup is active
  perf/core: Fix perf_cgroup_switch()
  perf/core: Always set cpuctx cgrp when enable cgroup event

 kernel/events/core.c | 209 +++++++++++--------------------------------
 1 file changed, 52 insertions(+), 157 deletions(-)

-- 
2.35.1

