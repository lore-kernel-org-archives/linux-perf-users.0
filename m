Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE38C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 04:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC71B61A8A
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 04:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhKSE3v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 23:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKSE3u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 23:29:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3FC061574;
        Thu, 18 Nov 2021 20:26:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so15743911wrd.9;
        Thu, 18 Nov 2021 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvKedbEblsFvFz/lugA32GWFMXFY2GUZc/320XQiSXU=;
        b=mdId0OhSJMOY7iRTyp9+N/wXqaLYh4mFbXs38jXv13mLH1pb8/Hgb9PPFPupAWdM26
         4+dAG9VMcRMl5g/8xXjkWhmlTlZeO29xCQ3CuQ/kqXJsN9kJ5/8Bg2KIwe+yfc1Qz74s
         39SR12KLyxwkNZehgbHqm71Bkbx3csF2vyYIC7HwA9X2Wu+dTN48uoq41brcbxb5w/cm
         eO9AFZIVmYvq8R+BboltlJk4wF1q2gyprH9AsXAObzhELamJ6Rty+McFBq9IQnouE5Zt
         pUmSH7Qw7XwjSK4ozk850DAIyDwXgqleogqaqLw8z3D34nCAUkW30UPvHDOpqxnmPr/T
         HPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvKedbEblsFvFz/lugA32GWFMXFY2GUZc/320XQiSXU=;
        b=OaovIay2pwJeCs3h2ajG2bYiMa9ENpuWxZhbSjo84VVDYF9lU5//JIX8edY1U5Ii6O
         K6AmeM5Zx0L2lUxbN+g3ur48SzaGC8rjK+LcCPKJKx+s0y5gddjBenRCc/zGUZz1jxy5
         4MBBnLKG1giTPRg4iJXzY7sIalP0dDEJzjhFnFzD49CWeNdrviOKMicGp1f2MqPR1QR7
         qLeM1/VaxfHV2d1vRP70xSqzyyS/uprpdMrQxHHHoOaXzbZMd4DtUPM6ItDvzimVn3qT
         H5gwLuLi+Aoe3tKoZ76e4KgebyNLpho5RpyEfQmdRQ5/+cX5hzEZ05K9lej2MkQ//b/u
         OGwA==
X-Gm-Message-State: AOAM532kjjyfekNoMEQ2ufUPgleYxpa7k/RXn2/znADZlvEMnKh0wVig
        fWaEy+Fqw6pOV6LGkiq98uI=
X-Google-Smtp-Source: ABdhPJyvp7OD7XRv2+qqheWDVg1EJff7aJHgDRJz+WJfF1gOPETvqTCtt7EQxsDH5PTugiOxlTuFkw==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr3624844wrz.215.1637296008031;
        Thu, 18 Nov 2021 20:26:48 -0800 (PST)
Received: from localhost.localdomain ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id az4sm11030557wmb.20.2021.11.18.20.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 20:26:47 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf machine: Free machine__findnew_dso
Date:   Fri, 19 Nov 2021 06:26:04 +0200
Message-Id: <20211119042607.48924-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports memory leaks while running:

$ rm perf.data*
$ perf report

This patch adds the missing dso__put.

Fixes: 8c7f1bb37b29 ("perf machine: Move kernel mmap name into struct
machine")

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 tools/perf/util/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fb8496df8432..826be7a12da1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1742,6 +1742,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 			 */
 			dso__load(kernel, machine__kernel_map(machine));
 		}
+
+		dso__put(kernel);
 	} else if (perf_event__is_extra_kernel_mmap(machine, xm)) {
 		return machine__process_extra_kernel_map(machine, xm);
 	}
-- 
2.25.1

