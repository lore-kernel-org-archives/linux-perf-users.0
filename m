Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B16C07E9D
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 21:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIZV4p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIZV4o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 17:56:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A91DA404F;
        Mon, 26 Sep 2022 14:56:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id iw17so7493805plb.0;
        Mon, 26 Sep 2022 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=572GorYLE019d559dVMv9AVnraHVnR09HbuFH0FA7is=;
        b=lW2k7mj+KeJMygxuAHZ79TwuyVmHgVvXmK+7e1orn6Accoqgbku1I+UNcBH4LmKrw+
         bFPYtmBdlUZYz1hI/ETOnLrutCSiHtyFxwna6zen0Dk0fmd9WLTnS+6XEbxMe40Dhr9g
         AjD7C2dX60Zq1zoOo6vwDxQKgGalnx2+sgNSqVm8jA/1g5oUu2X8wMwuMrgYOrW196W7
         PQkyboZyP0vFKG/fYeW7Fuk4gj26WtY4e6c0X8zoaOUK4k5hxNwL4AQsH5QUyI9M0rR5
         uDeInSLPfyW3P3r9FTNoCYYw+6pZkXU5t4ofmQwHKZNmTUE4rp4sS83Xd8bSRpkBZKZ4
         Nxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=572GorYLE019d559dVMv9AVnraHVnR09HbuFH0FA7is=;
        b=It3rKGWP8YInsvuk/O3aUEE1hZVVJsTPyyEGZzUrHS0TkAwQM/PIRRl44l8b5k+Xj2
         8blrX48WmFApKew+7V5c8aYNhY8JcaJ8cEr0noo9QgNUkXRaDH7CDy53uIjIg6DqjNia
         k/cimVu/X77x7euQS7mCQ4IZEhZmMtQ9bXcMmbQKmd1eQYj37c1x6rRQxCans9FzPR9V
         HHXmCjRz//xvhhjMcy9sdiG/vxMesKr/DnnM9e+pZMKtTRuNEzO1dTN2iip/MfmDjNx6
         nmtNeuHE4P9iu58rt7p6w23ps+23gBAM4pRvcJpEuQPs2w2ABMYK/d+pZXSFrHxUUI5t
         2gHA==
X-Gm-Message-State: ACrzQf2E/540zygzaQCeL49Iv25xFW+BDFLfA/TDhIGHkERX++Wj9a3z
        JpcLnbEYUkRjwILXRYTCKXk=
X-Google-Smtp-Source: AMsMyM5s8VcK1RLfXgmT7ORxvt7KP7GLXEXP1iHQiNIRR3L1gda1KOAav5WDXtxOLV74CBuhcuf2Pw==
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr11665598plb.7.1664229403022;
        Mon, 26 Sep 2022 14:56:43 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b4b9:6ef0:dfba:3f70])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12601509pfd.120.2022.09.26.14.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:56:42 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] perf lock contention: Fix a build error on 32-bit
Date:   Mon, 26 Sep 2022 14:56:38 -0700
Message-Id: <20220926215638.3931222-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It was reported that it failed to build the BPF lock contention skeleton
on 32 bit arch due to the size of long.  The lost count is used only for
reporting errors due to lack of stackmap space through bad_hist which type
is 'int'.  Let's use int type then.

Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
 tools/perf/util/lock-contention.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index e107d71f0f1a..1bb8628e7c9f 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -75,7 +75,7 @@ int has_task;
 int stack_skip;
 
 /* error stat */
-unsigned long lost;
+int lost;
 
 static inline int can_record(void)
 {
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 67db311fc9df..b8cb8830b7bc 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -114,7 +114,7 @@ struct lock_contention {
 	struct machine *machine;
 	struct hlist_head *result;
 	unsigned long map_nr_entries;
-	unsigned long lost;
+	int lost;
 	int max_stack;
 	int stack_skip;
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog

