Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26506C54EAA
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjAZXj2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 18:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjAZXj1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2023 18:39:27 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20630564B1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 15:38:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4cddba76f55so37674787b3.23
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=snCBxLwh7jm6krd4EQPzPcciOFAFt0fWD1CpQDw1t+8=;
        b=e6ohvklUxI4ipjwUCogc5GWZzMwgpvonuMqEFAldtcrN5gwr7vxUrcVT0vO30kWL/u
         UTKdHnDRG6MmsGo21+eZky1ijnGvGJykYoL/kbFW9ydXTr28qfBvoBzw4x0iBjSVI/qy
         VTCRwVi0mxUxy0SzS4w3U/CgWKzSOIkd80PZW3EXNp2goqcaJGRQYStILOiyjyH57toU
         Ov2TmXZBqoiT6exgPN6QdRQYDvkEyTP7AI0uIu/zVKmHN2V4qhHd+ihEH4gbDypEXF5s
         B7IQpf7Q7r5YYT3Gs4h8bzZo9lqB4lzNuM0ur+i/xVRYO3M91t6R/XihIzHynFsRrdw4
         oOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snCBxLwh7jm6krd4EQPzPcciOFAFt0fWD1CpQDw1t+8=;
        b=HT9OOBaHNKDnEpGrqw4aZSpUpPdpY0LDPU2UY/nWnaDFI2eU+OVH/rGqVFVVhpKHQn
         jNcV743Tw1lQDEd+Ye4ygAJJi53rHQ7+75CqwW47H2hy4SntID2OvnR1p8R9bBZvUNag
         e+b24PiC87u7ktPyt3I/sS6bcq/Ux7eziJ+GNnEVXQnhW5set7JoyqrD1nsK2udUIkIe
         gDmKFJ5bkF1ZnyZRlcq/5A1WUQSz2JW02H4vFoKhHvM8HZnme1O5GZscWN9xJbqb/nxQ
         sctEdeDaLENw5pFFJgW2lpOpWPmt3RfZTHL1Oa4i8by5A6zfjJO23M95U/vEoRNXtP0W
         EHMw==
X-Gm-Message-State: AO0yUKWbjMSWJpyKOFARE64VRVvROeFK4Jn6bGRnRRRe6CleLORBVGsj
        vN3JL1yY1hWEBbIfOYkR97CgPeoWBhb5
X-Google-Smtp-Source: AK7set/8zwjdXupmXxmE3nxBHcDXM+9r4moQ67xxfCC3ARU9uYuzrlHsQS14Uo2BYtJ6Y5jtB3/pbR3UBgqM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a0d:fb43:0:b0:506:5a29:80ce with SMTP id
 l64-20020a0dfb43000000b005065a2980cemr1081160ywf.254.1674776321949; Thu, 26
 Jan 2023 15:38:41 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:44 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-15-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 14/15] tools build: Add test echo-cmd
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add quiet_cmd_test so that:
$(Q)$(call echo-cmd,test)

will print:
TEST   <path>

This is useful for executing compile-time tests similar to what
happens for fortify tests in the kernel's lib directory.
---
 tools/build/Makefile.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 715092fc6a23..89430338a3d9 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -53,6 +53,7 @@ build-file := $(dir)/Build
 
 quiet_cmd_flex  = FLEX    $@
 quiet_cmd_bison = BISON   $@
+quiet_cmd_test  = TEST    $@
 
 # Create directory unless it exists
 quiet_cmd_mkdir = MKDIR   $(dir $@)
-- 
2.39.1.456.gfc5497dd1b-goog

