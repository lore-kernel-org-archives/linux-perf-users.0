Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1654FC77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 01:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbjE0Bmw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbjE0Bmp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 21:42:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6393E74
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 18:42:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1187670b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 18:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151745; x=1687743745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrSnet5OHiffmIbqSfs7JuxPbvC81vL93khftEXYXiY=;
        b=BT+dRPt9LSQc3DlKLaKCfmyetEhgoJWmpfPImFeN4Zed3b/jcHaHA0DNeF4IWSNxJZ
         pQJPuH6IffGDZ6zcJvw+gKseGPHpDIJ1vf2pyqkdOHxYFk6spwySKVC18nfFTiPC4p1U
         vBzpXfaeufNjvxECgwzvl9XLbFJ2N0kpAe2ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151745; x=1687743745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrSnet5OHiffmIbqSfs7JuxPbvC81vL93khftEXYXiY=;
        b=VnpOCfZZidZcFcp3DVJuhQ10y2plIViopIyJ/5CaIZsNZ/vja5AKDrODESmLdciaW6
         9lPHkcnyI/PU7/8efsjTjIZzwXQJnJWTtsE5yNjEjTS/+bf9Z2T1o/j27jIRTwrizfPB
         QztwOqCkHjIsAIx2SWsVCN/MtHu7YyaJUr1Vnx6KR35Copt8Z2+LKybqh+/69JXYeEwc
         NvNimeZFTz07R2ZQl5BM8gZqkklh7fF2dcFkfYTegW6kqtQeJATBxyJ3afbmKxbrqMt+
         q8F0Y3T7NS+nQjjkgbRtgjBlN7JZFv8hrgf0J9H32aSGRQ0gJ31G28Ok3Z+YR/nGEE8E
         ybbw==
X-Gm-Message-State: AC+VfDzSslD1Ial401DI4/hhiCniev9YMqnOfsEZanFK8rvRTxdxVMeR
        KdPUqevtP9ZhaYFNoHlt9Bfg5A==
X-Google-Smtp-Source: ACHHUZ40Aya6L3K9wWALtZHzSbN8jGhO+EVfPlmtY3VStdyZv7cwbEJlQWNy+d0vp5EsQiqF5NEtCg==
X-Received: by 2002:a05:6a00:2386:b0:64d:1185:241a with SMTP id f6-20020a056a00238600b0064d1185241amr6871168pfc.5.1685151745069;
        Fri, 26 May 2023 18:42:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 05/10] watchdog/hardlockup: remove softlockup comment in touch_nmi_watchdog()
Date:   Fri, 26 May 2023 18:41:35 -0700
Message-ID: <20230526184139.5.Ia593afc9eb12082d55ea6681dc2c5a89677f20a8@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In the patch ("watchdog/hardlockup: add comments to
touch_nmi_watchdog()") we adjusted some comments for
touch_nmi_watchdog(). The comment about the softlockup had a typo and
were also felt to be too obvious. Remove it.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/nmi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 3a27169ec383..6c6a5ce77c66 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -140,10 +140,6 @@ static inline void touch_nmi_watchdog(void)
 	 */
 	arch_touch_nmi_watchdog();
 
-	/*
-	 * Touching the hardlock detector implcitily pets the
-	 * softlockup detector too
-	 */
 	touch_softlockup_watchdog();
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

