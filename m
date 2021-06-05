Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086EEC4743E
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 05:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0A2613E7
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 05:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFEFdN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 01:33:13 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:50863 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEFdN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 5 Jun 2021 01:33:13 -0400
Received: by mail-pj1-f44.google.com with SMTP id i22so6701380pju.0
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jun 2021 22:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEO+x6vBBqdP2GXyAGjmfIuQfAZkfCm84x8m+/E82go=;
        b=X1YlFNR+PNVzSzYabNe/Gw9QYGH4jrovVEkC7Ac5Rpb4yLOzURcf42x5762w+Qa3L9
         mrvzXEMiAVu30S3IZspee38ncBKBH7/ec0mtGLqqsGbV1b6/xbxEuR71OaJC6M7FwU7v
         o4InsRzh5ajKyCnlB6vsnEag5jTMKhA84cmw9v5cIUN1T6+8iYbR1gK6G+HiAUfQ/VY6
         FCMC+BVaG0p+aUNfSlZzY8Gm6PVQo6S/7PpZbcwa3Kxfa9/FPmxyB2jX/0SjfYmdhGWA
         kQ1i/9dY71t0Q7h8FZSPotaBN6v1mQ/lrH/ImEUZjYFQNz/q4TXNmk6RRC0H0WjNpUuY
         xSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEO+x6vBBqdP2GXyAGjmfIuQfAZkfCm84x8m+/E82go=;
        b=IhvTuWuWX8oPNlX3SR5At/2FmbsxjW7R2pTlSE3bKPPkxfof2zzuf99yVbKm/ZvOOn
         ka1i0PEbxOt1Brs6Y5QXZILFrHLhceR9+4L/e/IMfcwtaN82Dv6u8W8JD3K8If7D9njT
         CMLgwkaQ+FvFfVlhO2fvaCTDtH/tdX2DoGE44nqTxLGhdjwadP4O9b02TU9oZaPfSq69
         Ampw7g3w7ZXVSHYckjlWp7BVCsqKLoGRaxSl9wadRCk58OrGfEy1IkhfjG9eEJEy1wHN
         QUtOpHVL5j2bkKt0J6VdglfW/L6Nso0pZi07buaMew3BJdbRPIgqlccVNC+XhDeTYp4a
         3Y+A==
X-Gm-Message-State: AOAM532G0nlDyPCo5HLE4t416OzPX1sfUTvOo9VY75KhTGrtnH8nBNNC
        4vPAVsiFZSf3zgr7qpmgp6XTe82hV6Ce1dfD
X-Google-Smtp-Source: ABdhPJzF5let5ONamUDEHHdvvfExJiXL2z2R01r6n9esJvrHTl/qrjkw774LNA0Wr4X3x5SGiLFAig==
X-Received: by 2002:a17:902:bb8e:b029:f4:58d1:5170 with SMTP id m14-20020a170902bb8eb02900f458d15170mr7697725pls.84.1622871011016;
        Fri, 04 Jun 2021 22:30:11 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id t12sm3278697pfc.133.2021.06.04.22.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 22:30:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf session: Correct buffer copying when peek event
Date:   Sat,  5 Jun 2021 13:29:57 +0800
Message-Id: <20210605052957.1070720-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When peek an event, it has a short path and a long path.  The short path
uses the session pointer "one_mmap_addr" to directly fetch event; and
the long path needs to read out the event header and the followed event
data from file and fill into the buffer pointer passed through the
argument "buf".

The issue is in the long path that it copies the event header and event
data into the same destination address which pointer "buf", this means
the event header is overwritten.  We are just lucky to run into the
short path in most cases, so we don't hit the issue in the long path.

This patch adds the offset "hdr_sz" to the pointer "buf" when copying
the event data, so that it can reserve the event header which can be
used properly by its caller.

Fixes: 5a52f33adf02 ("perf session: Add perf_session__peek_event()")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/session.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 106b3d60881a..e59242c361ce 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1723,6 +1723,7 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	if (event->header.size < hdr_sz || event->header.size > buf_sz)
 		return -1;
 
+	buf += hdr_sz;
 	rest = event->header.size - hdr_sz;
 
 	if (readn(fd, buf, rest) != (ssize_t)rest)
-- 
2.25.1

