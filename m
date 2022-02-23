Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14542C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiBWNOX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiBWNOU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 08:14:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490CA9E1B
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:13:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z22so44082071edd.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpMhOPB4ZaEs42bxtDlwHV1Pi/FJg5MO6LgBGSlZhbU=;
        b=la0Rb1AMd4D50VpMIY6bcHgfX0fWyNeBDERmO9Xx5qx44qD/zjmkTppTSqoE0f4j51
         SPxhBexkskT8AuqjnAEDind8bQXnvYMr7xOldsC7dqNCIRlGaaFSegVjUVy2QDJ5egU6
         c9wIcGpW7q5p5GD6eUbEVYhfRcxAZtY2/RFnC6Ts91eoIPlN8th0TQj/Xxz6bjyOM4wI
         UBEtKLIaQbdsE5kSf47xg5VLCs3vSB4YAYBs6zHj1azWW1qMQQCzYtVhuOQalgveQLi0
         M0v4ZHTvS9WZhooYeJOZijXxAK6bbF1a/p6OVH9qXIwrNbcXwu4sXFALNMyi0fxbnas2
         x4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpMhOPB4ZaEs42bxtDlwHV1Pi/FJg5MO6LgBGSlZhbU=;
        b=EAYvnj2ZsmHT157tnchzeMVjRyz2vVe/DEGzUixtMCTZUPjVxC+UaFrZ2IoxvqV2sH
         cSX4HSHVxnU6cOVcBCCjhVL5SMiJyakvu4lgC5IvU3HTLpkwaqOyqEAqAO0+/K8lEFXC
         UVfHT5p2z6RLakKfqcYLLLRqH7sqeyQrC6Sam21O72RGsUYsf3JA7vdqQN/IEHrnqEJF
         sy6QFPCPGcJ4Rtfxp4+fiypTS3ZOEM2jF2Wbt8jyCe21Rcx7JDLeJzPgCNDUPIfGpd1d
         HxhPJWlCKyePjLocu5YSC/4NFLxXsW8QfuK91d4rOPxFZKkvyTVUsStlg9RsVnom2mZc
         HKdg==
X-Gm-Message-State: AOAM533H8vQ0QX2VmNlhcNAanK2x3ZIkqkGgK8AorHbxV6h27njN7j3a
        3wlKngJjFBjf0Y9IP44nBIEVoo09mIA=
X-Google-Smtp-Source: ABdhPJwYYPrMpuVyYLUWKPD5xTa5OOdjvCemDrgL94VL8HsKANuigTt2ykCvv1Qp0potl4BTzxqIjg==
X-Received: by 2002:a05:6402:528e:b0:407:80ff:6eed with SMTP id en14-20020a056402528e00b0040780ff6eedmr31329768edb.165.1645622031569;
        Wed, 23 Feb 2022 05:13:51 -0800 (PST)
Received: from oberon.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id j23sm7413876eja.204.2022.02.23.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:13:50 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     acme@kernel.org, olsajiri@gmail.com, irogers@google.com
Cc:     linux-perf-users@vger.kernel.org
Subject: [PATCH] libperf: Fix read_size calculations
Date:   Wed, 23 Feb 2022 15:13:49 +0200
Message-Id: <20220223131349.134897-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reading the counters from perf descriptor fails because of size
mismatch when PERF_FORMAT_GROUP is set. The group count must include the
parent and the count of siblings.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 tools/lib/perf/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 210ea7c06ce8..4597a53c0152 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -299,7 +299,7 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
 		entry += sizeof(u64);
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		nr = evsel->nr_members;
+		nr += evsel->nr_members;
 		size += sizeof(u64);
 	}
 
-- 
2.34.1

