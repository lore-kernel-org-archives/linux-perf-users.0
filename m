Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69990C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460CA61207
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 14:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhKMOiq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 09:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhKMOiq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 09:38:46 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD08AC061767
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Nov 2021 06:35:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h63so3651987pgc.12
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Nov 2021 06:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfwe9FP6qPb0M5pi6USL1mjcAtZ1A1CIUzpfR6+xGK8=;
        b=xLFfAmjtEzl6v6gQWLtpJKt32K3RMaVlILb9fvzfg+9AZwM2v111b792wNp6vewQE5
         J7tcKJAgPwM5GNJqFH3eVG54mztQoi3RjLyhmnuiQIzPPUfFOYJ0RUyG912UfcMlixgA
         2xmU2mDzHtSstZCbQ8wLGv8RwwsWFqWS8pVzq9OyFpCtc5RPC/LgPbhFIO6jvprxcdJg
         wVEAu3XO8eVyLU07vIs0lrsFPBw1H0yFGtZz67v4WcyAu6GJXSZifM5z5uAC1T/3iwzi
         fK9daFBxW1h3mJ3H0FoNotIH6Aq0fKEp7eIjrE/FI8sPgMuQrVXfyRe7y/k0Y+uI1FqQ
         83Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfwe9FP6qPb0M5pi6USL1mjcAtZ1A1CIUzpfR6+xGK8=;
        b=zyMRAsQVOez3yNhoQwuC9r/Fkv3c1guCRKSMUPap7aGQXEpSiWdxEaJEIH5a3T5oDR
         3IRU8OZDR4srTLrZcVBXpbIDHQODj2U9VV03ogCaxdel+urNNCMiT+LRliJ2qcxzhJTy
         cynFM9KvPTknVJX6FYOPlhR8di510lCm5/fBAcUnohskyXRCXA6KwBML0awIF6Ox43U0
         k5sv54gdmYBmSdhW5fi0I0v4F5OpBb+o3Hg4XUN3osQ8RVgMI9rloE5w9djhvIXglqJG
         zr5XxElHpxw1odQEJigloOJNFkPSbzW+PW1tGOr/qH00Z8vZD023gSc314QeUItiBAYS
         mlOg==
X-Gm-Message-State: AOAM53307DQWx3LrfUi4b32G29OxbQ/gpUNHougUeMhS6sjZAujwLcaK
        K5Ce48AHCJSwqjKlLr0clyuVDg==
X-Google-Smtp-Source: ABdhPJxKTIgm4qdaxKTOeNe4FZmbm6HFTBywwZZIFYTMbCqAZubpvgBPgn4uvNfqTO3A0XUB9QVQ8w==
X-Received: by 2002:a63:1617:: with SMTP id w23mr15293671pgl.380.1636814153051;
        Sat, 13 Nov 2021 06:35:53 -0800 (PST)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id a29sm9511576pfh.29.2021.11.13.06.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 06:35:52 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1] perf cs-etm: Pass -1 as pid value for machine__set_current_tid()
Date:   Sat, 13 Nov 2021 22:35:40 +0800
Message-Id: <20211113143540.53957-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently, cs-etm passes the tid value for both tid and pid parameters
when calling machine__set_current_tid(), this can lead to confusion for
thread handling.  E.g. we arbitrarily pass the same value for pid and
tid, perf tool will be misled to consider it is a main thread (see
thread__main_thread()).

On the other hand, Perf tool only can retrieve tid from Arm CoreSight
context packet, and we have no chance to know pid (it maps to kernel's
task_struct::tgid) from hardware tracing data.  For this reason, this
patch passes -1 as pid for function machine__set_current_tid().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f323adb1af85..eed1a5930072 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1118,7 +1118,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
 		return err;
 
-	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
+	err = machine__set_current_tid(etm->machine, cpu, -1, tid);
 	if (err)
 		return err;
 
-- 
2.25.1

