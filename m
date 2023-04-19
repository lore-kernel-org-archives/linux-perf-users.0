Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33679C77B73
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 22:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjDSW5w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjDSW5e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD12726
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so292680a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945039; x=1684537039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J3L1PRmmJQLOwITbbf3gVcO1wn/5q5E8+agGJxBWhk=;
        b=E5o6owHAi94AUxWQV23+WIE/5pp1O4WuHDRcksc7HsdzkCojeZYEW4oz7qxqAY/nkq
         9DI77u+isSPjvbt53VfxixNIV899AQ0S/99LKwj3MnpI1L8BLugiY+qmlKl1Vf1HKX2L
         cXmTN/MLMsxxiL4antF9TsJfg3q474IVB82yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945039; x=1684537039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J3L1PRmmJQLOwITbbf3gVcO1wn/5q5E8+agGJxBWhk=;
        b=X6wQ8PoCyTXWaqiBcpI7qgyCPoIFLIxV4s5mWwVEnbe7ao5ny58QP7UPQ8cQQe2LZn
         PKBkrs29vExzNql8GUZbH85xsDLE6GDUdDF1irKRdEpFyrTOfZNd6EHELBHTWdxfhsAt
         JgzRuv/Bh0gJ1QIqA9rv/JDtkFjI8DCBM3yvTNk9cLTky20qVRb9M4QZDK/qTvwn1ypW
         AvKnS5BoHh7a1UgojCS0hW1Z1F2Riq9hUZSPRuQiASUNDpU5XYKWrFbxSiQnfscFo58R
         pPBUGeHOo7YkRy74uE6VsfpaCv28iYQ5qhjQ8wXmValLyKs423dh2v8Qs5OXGqSRhs+B
         q6wQ==
X-Gm-Message-State: AAQBX9fAm6cxKWtWrGhBbrOpfSVCU723f1YL3JltB8rmTLd+4emyebcs
        Rg73EoR0/6A9aVncDmYD/QS2Dg==
X-Google-Smtp-Source: AKy350aTf9h91DYGrz7a7xsj4nRmoGOHDhj7cVzB4J++cRvnc6ZJ8BMzmOpWvBoOUwZC9tzPMbxlhA==
X-Received: by 2002:a17:90a:69e6:b0:247:2680:4090 with SMTP id s93-20020a17090a69e600b0024726804090mr4649880pjj.11.1681945039604;
        Wed, 19 Apr 2023 15:57:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/10] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
Date:   Wed, 19 Apr 2023 15:56:02 -0700
Message-ID: <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To save architectures from needing to wrap the call in #ifdefs, add a
stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
handle anything.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8

 include/linux/kgdb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 87713bd390f3..9ce628ee47cc 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -377,5 +377,6 @@ extern void kgdb_free_init_mem(void);
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
 static inline void kgdb_free_init_mem(void) { }
+static int kgdb_nmicallback(int cpu, void *regs) { return 1; }
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
-- 
2.40.0.634.g4ca3ef3211-goog

