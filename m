Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03351C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhKWVVl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhKWVVl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 16:21:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0BC061574;
        Tue, 23 Nov 2021 13:18:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b12so291688wrh.4;
        Tue, 23 Nov 2021 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZUs2vC7ZRPh27dIyecZ3t+L7wHWBBjnOzmOHyarrfc=;
        b=cUS+BDV36H6t2fS1XFmfWTP7h+G6p8vRb+xW8oQkKKxpN10xtfpqu4ZFseWJ4P2egE
         bjADhq4iBSKiIytRHTv+GUDLSXaUGtQYFlh3Rsxe74dvvHHE25bDeQD8Vugh8uGD8j/B
         bgwYl0/vWlm4Z82BBXvwdYMvmTuZSqCsPIB4r2QmZ9G8G1N+wH5mvxt7W0MAcHv8pGAf
         ukIwFN4bojTtk55UqBumNmmno79QR2hzs4QWVbwcd/0qSj1ZBlEaiIpeCvCsEvT/gQEH
         fdY5MO7ZPqG1ROS1qV9Bc5+Y+1qsw0M8GEGn29+kml3oeKLa35NzSzIOY92S4dWpYT4z
         Tglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vZUs2vC7ZRPh27dIyecZ3t+L7wHWBBjnOzmOHyarrfc=;
        b=676gHmNEUj+6YoVwjrblEl+VqNyMJ3Xk3ZUVRnZKCH61w6wPgVJGxTOliZdnWBWqnh
         XjUGHZMbXQWE/rA5Ddv2BM99MfJx3YXvWVgAPddTqmYnUH76AJmZYKUBDgHOsJKoYb5I
         oL3j4SYkzGUrAyqU0hk6+cXqKStXy0kUo01Fa5mbDtlNsSeP95tj1q+DABHbjodM9NDj
         YMRK7Xmcja8uWZWzXn5mHVZOlVkZ5OwljF8yRtbYvON2977mbGKj0C/JGle43XAWTOll
         xTIS8x+wW8WcRKsyMvDVkoA4wM7Gdi48BcmWahvvOCwJayxB8wc7FMVR7cPHQBN+p18e
         TyNw==
X-Gm-Message-State: AOAM531rnFNWgsApwJPvi8+MSc51NcB2pcWWQ08wSoNdyABoxirKFGaE
        MoMnQTrV42jQoDIPQlqUkHEYf0OZHoqYoA==
X-Google-Smtp-Source: ABdhPJygquqbURbvPKhoTw5AtrHf5r1tL1YHmU27mKwecTo7JXk1we+jDpPP8i5hLRHOHOF/bKYYRA==
X-Received: by 2002:adf:ef84:: with SMTP id d4mr11457442wro.175.1637702311176;
        Tue, 23 Nov 2021 13:18:31 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id j134sm2437246wmj.3.2021.11.23.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:18:30 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] perf dlfilter: Drop unused variable
Date:   Tue, 23 Nov 2021 22:18:21 +0100
Message-Id: <20211123211821.132924-1-carnil@debian.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Compiling tools/perf/dlfilters/dlfilter-test-api-v0.c result in:

	checking for stdlib.h... dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
	dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
	  311 |         struct filter_data *d = data;
	      |

So remove the  variable now.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index 7565a1852c74..b17eb52a0694 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -308,8 +308,6 @@ int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, vo
 
 int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
 {
-	struct filter_data *d = data;
-
 	pr_debug("%s API\n", __func__);
 
 	return do_checks(data, sample, ctx, false);
-- 
2.34.0

