Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D4C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCMLnl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjCMLme (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64276512C
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso11359892pjs.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1yEtOA/S7kgzfPudB0ZivwtY0/Ec+bbW+dtSNwunWQ=;
        b=PWzyhSH7DDp3iwYN3Te37MQ9JYhNVv0IyBMtCysoB+Q/lCmbMl9dUCChzy+LyzPolw
         JEtrqhXuoSgr4KHUHE7B1IiTCuDdGVmQubZtZPynd+U+gDWle9nRGhK+ZVYlkO1fDJTg
         aEKGg0F2n0NWcWtUdQhG1M2uUrb8BuempT554KwuimR0EdpziZhwy9RYCKcfxgDQORW1
         D1DWKJ5r8vcJYeGGrz/RIPMmjMc0XDM/gas3njQjhj9cQQRREk5DevndMWvjgYJWLdA5
         KeQsh13PJS7joZ+qEfa/baZHCx5ZBaL56qr5ATxHpKjDMUipZRf4tgQ0/+8KMReUtTvr
         BK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1yEtOA/S7kgzfPudB0ZivwtY0/Ec+bbW+dtSNwunWQ=;
        b=qqLGAsGjlQEJwqbVeNXFce4DMRHDaRfqqumwLqmFBdiJ4AUYLvJgRcKxxtWJSbmuDj
         HvNAeLOUsdKF8uQdUKTmP+vmk09sJeayKC3VIdT6mZfBeTfTxUNXo7s56QYKvX03YfYi
         ijlkmUxOtIN1065a3APkXG2wpmwV4AgPSkMLrRqhWOv0mSOabx+cfGbgGazPYX+R94jB
         wOToe10ZIm6P73yaiTi232E6tMaemJjTYq0work4ruRV4V4by6EQ+RdVWrKTeNo+zk2N
         QZJ8UaTPwLUUFxD+AkdAJKzNDeuUWYmcFKDLZOpKhZKIAVol4vfzpNHxf+nrK4pCVhY8
         c5+A==
X-Gm-Message-State: AO0yUKWN4nWmaTBGv+PSnTxUmz3m4YbKGquY48ApNJs8gt1c+wsCqg2B
        OEdubcxzR1eWb73/V6y7C44sIA==
X-Google-Smtp-Source: AK7set8ER/k+D4jtSDLuKMHuWPTPL48SSuXRYXmXmkyFS/46dYzVd9ITc/lT50214G26sg2nf9FORg==
X-Received: by 2002:a17:90b:3c49:b0:233:e1e6:33d4 with SMTP id pm9-20020a17090b3c4900b00233e1e633d4mr35154950pjb.47.1678707710206;
        Mon, 13 Mar 2023 04:41:50 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 16/16] perf kvm: Update documentation to reflect new changes
Date:   Mon, 13 Mar 2023 19:40:18 +0800
Message-Id: <20230313114018.543254-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update documentation for new sorting and option '--stdio'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-kvm.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 2ad3f5d9f72b..b66be66fe836 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -58,7 +58,7 @@ There are a couple of variants of perf kvm:
   events.
 
   'perf kvm stat report' reports statistical data which includes events
-  handled time, samples, and so on.
+  handled sample, percent_sample, time, percent_time, max_t, min_t, mean_t.
 
   'perf kvm stat live' reports statistical data in a live mode (similar to
   record + report but with statistical data updated live at a given display
@@ -82,6 +82,8 @@ OPTIONS
 :GMEXAMPLESUBCMD: top
 include::guest-files.txt[]
 
+--stdio:: Use the stdio interface.
+
 -v::
 --verbose::
 	Be more verbose (show counter open errors, etc).
@@ -97,7 +99,10 @@ STAT REPORT OPTIONS
 -k::
 --key=<value>::
        Sorting key. Possible values: sample (default, sort by samples
-       number), time (sort by average time).
+       number), percent_sample (sort by sample percentage), time
+       (sort by average time), precent_time (sort by time percentage),
+       max_t (sort by maximum time), min_t (sort by minimum time), mean_t
+       (sort by mean time).
 -p::
 --pid=::
     Analyze events only for given process ID(s) (comma separated list).
-- 
2.34.1

