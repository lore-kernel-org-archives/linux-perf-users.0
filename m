Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB24ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Sep 2022 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiIAS4S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiIAS4N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Sep 2022 14:56:13 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF395F10F;
        Thu,  1 Sep 2022 11:55:44 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11e9a7135easo31359922fac.6;
        Thu, 01 Sep 2022 11:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HpWmElkb3R8nLlh0+N2tUY+L3VStUb6ARl+EPTzp0N4=;
        b=YW42FbChuGrGb1pkeoWD3/7AQF0Hizr94VwlNqc9xOG7GOabCZPTf/jslLWIn7N4Om
         44mUmiGuOy54NuW3UQl6VqmOwDktDGvkzqMRJr51QlDqgovT+9/a8ezH1XQIRpOQR6lO
         +3TfDi8Vi/Iw4jL+16EMfjMTNOTri8OaZ88CkIc65gimSmiq/WigZMcRi5zNnliHNDpa
         NdM2MdgY+U58IrymZA1Fq01I06R/9cSsdJ9uuRB92I9izgicZlbDkw/j0NL5AEZbp/37
         kNgSyQyf0Qy3JMsokH2imJBdWUrBBQ3qwHWdAQuRP9vuUDQkl4AL5roeFK+YdL2WdpM6
         acAA==
X-Gm-Message-State: ACgBeo3n7nvOLGlRM0ml2MR6EXyyXOOGQwlxwNeHw1UovlzVcHQwnvjv
        UldJ/G8onbHP5f9pSH6xmg==
X-Google-Smtp-Source: AA6agR4D9pq4NyfWjraGzlzw87ULKE55HAZBZgcBs7+Ik3FYQNdM8Ow4WFUtGSA8GA16Z/Y81W6+mQ==
X-Received: by 2002:a05:6870:c350:b0:11c:cd92:3fdd with SMTP id e16-20020a056870c35000b0011ccd923fddmr297621oak.85.1662058543586;
        Thu, 01 Sep 2022 11:55:43 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id u5-20020a056830118500b0063ade5856f2sm930otq.64.2022.09.01.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:55:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Ignore format attributes with an unknown perf_event_attr field
Date:   Thu,  1 Sep 2022 13:47:10 -0500
Message-Id: <20220901184709.2179309-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the kernel exposes a new perf_event_attr field in a format attr, perf
will return an error stating the specified PMU can't be found. For
example, a format attr with 'config3:0-63' causes an error if config3 is
unknown to perf. This causes a compatibility issue between a newer
kernel and an older perf tool.

The addition here makes any attr string up to the ':' ignored, but
still checks the 'bits' portion.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This is the YACC mud I threw and seems to stick. Maybe there's a better 
way to handle this. It doesn't seem like there's a way to do wildcards 
(i.e. config.*) in YACC.

This is needed for this series[1]. Unfortunately the best we do to avoid 
the issue is applying this to stable. I think there's some time before 
v8.7 h/w is deployed, too.

Rob

[1] https://lore.kernel.org/all/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org/

 tools/perf/util/pmu.y | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index bfd7e8509869..3096864ec9b9 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -60,6 +60,9 @@ PP_CONFIG2 ':' bits
 				      PERF_PMU_FORMAT_VALUE_CONFIG2,
 				      $3));
 }
+|
+error ':' bits
+{}
 
 bits:
 bits ',' bit_term
-- 
2.34.1

