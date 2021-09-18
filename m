Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A45C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 03:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1E4610A4
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 03:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbhIRDDD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 23:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbhIRDDC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 23:03:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201CC061574;
        Fri, 17 Sep 2021 20:01:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c4so7397093pls.6;
        Fri, 17 Sep 2021 20:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwUqXkH93bEGRVKzJp2Nv35OcjcWzah8V6Bmy0LMTmo=;
        b=juHdkxVo0CKZQWsanvObBOXNAxfo6eLYtfkGC+UTWPUb3bVbR8DzFlmgwJdp0Q/mvq
         7+N5mJ3ua0CSoPchcBwhSyY8r6ZYGDHi8crz9JvvzUeQBWxCdmV3AgnXmQFgmpmcOgu1
         jjVy8F7FE0LJZBgjbfqhPjQkTQomZ4jh7ijJWgJ8EV+LmdyZQfn6Mb1RWnhhSkLtsHmF
         4lhZV4NPH8JzXPmq4bW5iFqq0VFrCZyIn/qp4FC/JVpBEcE0ySw3g3HTdRdQeYZi7dEQ
         gzzydTdTsMNd4kCu+B+kIYEYhiQHWzT6OrneudfBGl+ryPjT7fwElllbramHWeGPlxox
         lWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwUqXkH93bEGRVKzJp2Nv35OcjcWzah8V6Bmy0LMTmo=;
        b=V7g/n4+8YAtmwlegIMuMnkTpdc+WPLREM1HwC0avSIB3K1khPs3dSqIieA6Y7pD30U
         JfM+FQrPO7htcIna2V2ug7eaHoZwWYoPSVDNQ3NiRnX0HPbGO6SCTg0HOG7JlmBLjN2+
         rTPtJ3yqYRtgQEpudCjJIiy5fqnhL1gYBdu4vpeccp1XjZmylZviuSOGw26x5tWj5yA2
         9q8JBuUv7+3Gl2n8OjUYj1yN+nDVLxeUlqyEiEhQ+Slqvafq8Ju73ZRaQqU4UnucgqP1
         ZsXs5LEIXo1U7kxOMqz6LgPwpxCodMzVWJwRqCCcTQj7VKWFDGle/PvXJnGNYzI+/Ov9
         L8/Q==
X-Gm-Message-State: AOAM530b2FuwQ3lahbpoBoXPEPeTildVD6B5QrP8jhVCdB99oSz0yeFw
        QDSz8y9tdZ5gew73QjlBBnwEArV/QPs=
X-Google-Smtp-Source: ABdhPJwZ375Esd0ihz8IfijshThreUAfPJCe17KcD168KN3vwwJyF8E/rm1OJhl3Im1qKC6xambfoA==
X-Received: by 2002:a17:903:230b:b0:13b:a0ec:1136 with SMTP id d11-20020a170903230b00b0013ba0ec1136mr12555670plh.63.1631934099187;
        Fri, 17 Sep 2021 20:01:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p10sm7794817pge.38.2021.09.17.20.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 20:01:38 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>
Subject: [PATCH] Add pointer check
Date:   Sat, 18 Sep 2021 03:01:31 +0000
Message-Id: <20210918030131.236378-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The buf->stop_te pointer may be NULL.
Accessing buf->stop_te->stop buf->stop_te->intr might occer segmentation
fault. Same as buf->intr_te.

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/x86/events/intel/pt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c14715f..ec1c644fc83f 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1118,9 +1118,12 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 		buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
 	}
 
-	buf->stop_te->stop = 1;
-	buf->stop_te->intr = 1;
-	buf->intr_te->intr = 1;
+	if (buf->stop_te) {
+		buf->stop_te->stop = 1;
+		buf->stop_te->intr = 1;
+	}
+	if (buf->intr_te)
+		buf->intr_te->intr = 1;
 
 	return 0;
 }
-- 
2.25.1

