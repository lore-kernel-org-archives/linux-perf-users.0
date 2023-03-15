Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFDFC61DA4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjCOOyY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjCOOxu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:53:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB916A2EA
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:53:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y2so19074276pjg.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1yEtOA/S7kgzfPudB0ZivwtY0/Ec+bbW+dtSNwunWQ=;
        b=fBRB+iqdB2lrxzxP/K6MLf4EVrdfE0pmldFOD/r94qjAPy1mKmIlnvNcBS3W/1QOdZ
         GB1Yr8uy1wE/+elFlEF+g8O3cQZMYKq46UlaeD4QOba7SeslEPUMYDWLAnQu5j1Is7Jp
         3m9F0TNKHkF/Hcr0Cl6aGH6Xg29iw/A5KtZBAuA9e8D6Ds6tig1mOs/+KA0OYA7TMD0E
         Iiqn4iHdoz9bxm5gXl3XrAqZEHNiXBcPOFFu99NUAczAW7OQNB8Z0Zj+ysgGnRNbuWpW
         LO4an+DRY+3aj3Y69HgvpZRxVwLx0ikauopI6KAUHGYAEaezIggdyg6uJadwj4n6nBMs
         U6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1yEtOA/S7kgzfPudB0ZivwtY0/Ec+bbW+dtSNwunWQ=;
        b=fg8u6sEGoX4Ka/L0xSOXr6Dyx5e5Use5kzD7gBeACrQt4yJYZxayZVZ/2ULZGaS9Bz
         CEF/FYAYuXwmUbW6fvA86zh3W2EtiS63cRQFjHCzHyIX1K2XBiKSqyvLhzmyN3iksaOu
         4o2nF/5ETjc0NFke8xvOiH0Pn9NTvDPTRYhsL0V9xyQKGU83Tym4zlHPaRTP1Jg65Wte
         sTbdXJq433y/FXRnBsCiwuLoI+z6h4TU1Pt49ggz7WIaH/H6yrFei+M8I2WLPXC4ISXq
         NdCz5jCPBjgSMI0qHg7G6V7IhBl5s2U+cpqtBUynSZfKVWNUwl/aruhAfmtSIP7lK+wu
         A1tg==
X-Gm-Message-State: AO0yUKUBK+8Opr0pLARhwym8EUR3/MFM4iKPd2r/LYtLPP6pLG7GRJhy
        oECKGzDJ372VsYObD8R2/wKy9A==
X-Google-Smtp-Source: AK7set+JCK/kO1YmQbSWHbUctvXH13LzI3Uf5TBpJAr0ALjblrtiTJbKCOgXTLT8x7A3gG/mulzd7Q==
X-Received: by 2002:a17:903:430b:b0:19c:171a:d346 with SMTP id jz11-20020a170903430b00b0019c171ad346mr2373750plb.44.1678891981306;
        Wed, 15 Mar 2023 07:53:01 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:53:01 -0700 (PDT)
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
Subject: [PATCH v5 16/16] perf kvm: Update documentation to reflect new changes
Date:   Wed, 15 Mar 2023 22:51:12 +0800
Message-Id: <20230315145112.186603-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
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

