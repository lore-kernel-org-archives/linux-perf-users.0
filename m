Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B34BC07E9B
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 02:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2361007
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 02:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhGUBpC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhGUBpB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 21:45:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF1C061574;
        Tue, 20 Jul 2021 19:25:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so735631otf.9;
        Tue, 20 Jul 2021 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQbKiPljTN+dTTqnrZPdPRJjVjeBdFaZnk4JQaGq1zQ=;
        b=JCEat75fKEzfQ7CKyaKAXEfCmZRdm+vRtxG+t54attinN4iAncmlEdjZxH7hVChZLC
         bZEWElIQgO57idUoj0rkD40KwvsD/4ttSfpA4GHWXkFwvndWUDyHrndclo+PvC633JIO
         JhDIh58J4Q6kKq44JXPPs2J4xVBiHXlDLpv+FSNC7dHEuGpjNgCnnCsLtGcDVI4rbwO8
         k1JJ9sCeOVx08zmjRYYiUWqT+g1JAX6gXsj/aYhAfmca2kC1NqSrvopqr6rhlXCGW6zd
         AqzzmdE9aOx1dpnYYOO6aM7PrH3ZsYyDun2P4VFg4UuPkKADpNvYH8v5JYtiAdbGc/Ho
         jLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQbKiPljTN+dTTqnrZPdPRJjVjeBdFaZnk4JQaGq1zQ=;
        b=B5r2aRcxGTS3IqOin49DjAN6SjUCh1OQTjohPeT84Utwp+OZHzlWI9JhYR0zdV33u8
         8GYCGxs+CoBG7dQUtAsv3UHlSUIOheW9lOcGC8Y665kGH0xK/+C0BkECwcLgyOxPZGoN
         Ga315v65a3mlSs0spFuTBCI4Jk1RQC1rPcFN4kzZlio/6lKO9Z0Uf8w6QDtEAkHx2pnq
         ig7p5OKrWCcRRDVABo+emyKbQOxmbNin1I8U9Jdp5idYevq69MKija9umc45TwgKTnQy
         AJttQNlDleFnG906gO2d1s+xILWTRhr7vEBvRkWcpXCk159S2Yuhz/A+/Ta55HB6cToQ
         tsrg==
X-Gm-Message-State: AOAM5338EgxzfbN7hUxRTWuKFIZyjvc+LjMY12U8u6yD4ToRVQ90Sn8q
        kufOyA7bgzwbCf9NeDTrOt4Hk/MwJAB9Gyms5WU=
X-Google-Smtp-Source: ABdhPJxqYqFY+81HyhGe4/n70beD2IZbljBQCgVjmf9vJoBbJHoEgfttiEsfCM246QFnUkO1YmP0TA==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr24620555ote.90.1626834337093;
        Tue, 20 Jul 2021 19:25:37 -0700 (PDT)
Received: from localhost.localdomain (c-98-249-124-70.hsd1.nm.comcast.net. [98.249.124.70])
        by smtp.googlemail.com with ESMTPSA id v5sm2542722oor.33.2021.07.20.19.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 19:25:36 -0700 (PDT)
From:   Brett Holman <bholman.devel@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf mem: Standardize \'perf mem\' arg parsing
Date:   Tue, 20 Jul 2021 20:24:41 -0600
Message-Id: <20210721022442.159436-1-bholman.devel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is my first time contributing here, please let me know if I
missed anything.

To compare the commands tested, use the following:

strace -f ./perf     record foo -pv bar 2>&1 | grep -a execve
strace -f ./perf mem record foo -pv bar 2>&1 | grep -a execve

Before this patch, note that '-pv' is stripped out of the command under
test for 'perf mem record', but not for 'perf record'. This patch makes
the behaviors match.


