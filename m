Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0871BC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 02:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77AE610C9
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 02:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhIZCcI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Sep 2021 22:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhIZCcI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Sep 2021 22:32:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3BC061570;
        Sat, 25 Sep 2021 19:30:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so14131853pgf.5;
        Sat, 25 Sep 2021 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UNinGt7TcWnbGmmdAZoGQxTYznnTlcEWz5rOMirJBE=;
        b=a2FeDfrB+LPwOlmvdzu7W8SBrTu8IwGREWDzi6kwpUnTYz5eEws9V8U17ELv7viGFj
         V2QyaPuEQIyaqrPMV4cPIDqnvCumX2yAW+kHCzE5t6sCjlhfPhonFEY7+01wJGyo6V9k
         3YsJRHecrjE+z189SN6E6o9m6OCNIzcZYaBCge4glAI8e9F4eCz8IGkhki6mlR2/oZcl
         T4zWTrRPMz190Mlax9jJZp34Tb7TSA58gYNRNv2KeUVlA4vEYb0kqtl1ELYW6puGs+CI
         I7uQMDNjIXWtX8VUqbKReMykililuvqFXEVPC3V0rNBf0G/SXMbAAM6eGmaM7at2Z6Ig
         +3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UNinGt7TcWnbGmmdAZoGQxTYznnTlcEWz5rOMirJBE=;
        b=irG8SlTarCqUYkjLCN2VNffQjbOqPjlK7vJLl06zhFAfyZ2PUgEaWBf0JLPdwzFA0V
         iMvEOZccVXDAMbVKXRn4YqYINukwv++ivNLl4ATCp4Fv6L0XgA5mrZIvCgtwni+Q/cGH
         rAxO77wknf66zeCUBGxT0K595hBLKOj6sKmES/qvwP6JPWdAKKnRtrQukPqq8NtdRe3W
         zS2FULqBV+/7w8Li/EtkFQlMoobMQAkuAz2Vz21x0GzSMNJ01Wlettvl9xKdcmZyPOE/
         znRxoRu5AERBt2DOuHTn/z9RFrQEDq+U5j2BiB9g6X300H/bzjyqt8R/br51koggE/Ag
         jvUg==
X-Gm-Message-State: AOAM532bXt5VXzdngFHu+C7gVx5QrYAxXbwvBBoTxVNzYq2MPzigJFti
        6WIYGjaAJepkSLy6r8u7GXA=
X-Google-Smtp-Source: ABdhPJwBBemqdoBXP7qtNPG6w1x4pysc+d0E7oOPzclgARA1/MTXJxAMUGdzRmf8lvE9CFUNuwb/uA==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr10138762pgu.278.1632623432000;
        Sat, 25 Sep 2021 19:30:32 -0700 (PDT)
Received: from titan.. ([2601:644:8300:136:a6bb:6dff:feb6:3500])
        by smtp.gmail.com with ESMTPSA id x8sm5542553pjf.43.2021.09.25.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 19:30:31 -0700 (PDT)
From:   Jinshan Xiong <jinshan.xiong@gmail.com>
To:     jolsa@redhat.com
Cc:     Jinshan Xiong <jinshan.xiong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/lib/perf: make the static libperf complete
Date:   Sat, 25 Sep 2021 19:30:24 -0700
Message-Id: <20210926023028.2338342-1-jinshan.xiong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch makes libperf.a complete. Initially it misses the symbols
fdarray_* that makes it unusable:
   $ nm tools/lib/perf/libperf.a | grep fdarray_
                    U fdarray__add
   0000000000002b3e t fdarray__available_entries
                    U fdarray__exit
                    U fdarray__filter
                    U fdarray__grow
                    U fdarray__init
                    U fdarray__poll

After this patch is applied:
    $ nm tools/lib/perf/libperf.a | grep fdarray_
    00000000000063f7 T fdarray__add
    ......
    00000000000065d4 T fdarray__poll

Signed-off-by: "Jinshan Xiong" <jinshan.xiong@gmail.com>
---
 tools/lib/perf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 08fe6e3c4089..840366584fc1 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -121,8 +121,8 @@ $(LIBAPI)-clean:
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
-$(LIBPERF_A): $(LIBPERF_IN)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
+$(LIBPERF_A): $(LIBPERF_IN) $(LIBAPI)
+	$(QUIET_AR)$(RM) $@ && $(LD) -r -o libperf-ar.o $^ && $(AR) rcs $@ libperf-ar.o
 
 $(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
-- 
2.30.2

