Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6BEC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhKVBpe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 21 Nov 2021 20:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhKVBpd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 21 Nov 2021 20:45:33 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD7EC061574;
        Sun, 21 Nov 2021 17:42:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l8so15172171qtk.6;
        Sun, 21 Nov 2021 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHhX9mRLFg+NIZQtcWR5hAWGG8rnJ/nSmaMwFzPyXvo=;
        b=ZeJBxBIntjTCL2KUjzUQwwULcRs5wsLGmL8wsvlyILNAGgZHAt0ovQUME3SdbyBxUJ
         RUUNM4oCr6UDeXsJgTfPNKq2JBhnyNHfLyFZXnFt6ASiSndfQ/tFdFH8wxvXpxFaSBiM
         e0xfsWYgM/pOlu9rgLEqUER0J8hdt03Z1tNYTse9KE2GPiwzBvcT/+cp6U3RYc15yWl8
         IOZLBWFCO68HDW6voh+PzgOdnqJFwv/pgg6R20hBnPpwtZ5wegYIAsbPutpWAGiHYiha
         6XN4LVDVuRSMlWbSPV9WNu8JpBhIszOI7wmVrQcFADXWaRuLYqDq0smdq/ke9hZx6prM
         3oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHhX9mRLFg+NIZQtcWR5hAWGG8rnJ/nSmaMwFzPyXvo=;
        b=qrT7879PACOhRyLA0FX7hOnp0uDckbKa3M4pMrW/4ramSIcGxotOpk3/BY6o1bmYLL
         IMeA/Mp7xO5tOl80WPIcnobvvJEspufZ37Li6MHdBmLEsfrQmT+Pxu5D1SgFcotDG1uR
         EpPQBdMrJv/to9uwjScqCzXHgkJhjbpErwvjdj01v75d48GvL7jYd60uYMG65QUlVWu6
         rBXyvIrPCw4s4nSjd5aueZKrHdutGKb4ElimCT163KvVNtuWKVe1lwq5FDsTIwOfExN6
         jPMJiEWvkt6k63jlKuAUwpAbsYE6QR+fuf9TZnIzraO/BCCuhXGQEwZw82Fl0OJ/tvpC
         rvlw==
X-Gm-Message-State: AOAM5308zjbfA2H2Y/0KnDdaZ2qBb0dhPNCXnQFW1d96i12c/sOEG+U5
        JmvxAsoPPnViNBbM+STT+mVYTzGmJjE=
X-Google-Smtp-Source: ABdhPJy0nVvLsQj2tLHWvOF/u8edeBg/d+NxTVryRBk6UZKV1fWq4585WPeY3Q80rBlSSHH8tha1/Q==
X-Received: by 2002:ac8:5f47:: with SMTP id y7mr27000452qta.342.1637545347485;
        Sun, 21 Nov 2021 17:42:27 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j22sm3914218qko.68.2021.11.21.17.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 17:42:26 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] perf tools: remove unneeded variable
Date:   Mon, 22 Nov 2021 01:41:59 +0000
Message-Id: <20211122014159.25317-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Fix the following coccicheck review:
./tools/perf/util/evlist.c:1303:5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 tools/perf/util/evlist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258..d64fe767f583 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1300,7 +1300,6 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
-	int err = -ENOMEM;
 
 	/*
 	 * Try reading /sys/devices/system/cpu/online to get
@@ -1325,7 +1324,7 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 out_put:
 	perf_cpu_map__put(cpus);
 out:
-	return err;
+	return -ENOMEM;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.25.1

