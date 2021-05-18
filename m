Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53BC433B4
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B33611CA
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhERAG4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 May 2021 20:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhERAG4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 May 2021 20:06:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE28C061573
        for <linux-perf-users@vger.kernel.org>; Mon, 17 May 2021 17:05:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r5so11343431lfr.5
        for <linux-perf-users@vger.kernel.org>; Mon, 17 May 2021 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gsKLMiCUHri8NkfcKAfE8GWhdgEqnAihnSAE6GSvwKY=;
        b=THPfSUgNVoFuxzsK06WknAmgDTaHyVMx9GXU2xf48zsl64aT+F/Qn8a752rD4uGnFJ
         qSyGtzZb/5P8YYa93tcCY5tVrXATVatmgYJ2bRF07lWwZD+UA8TQ5s8ULeIxURqWfsf6
         pOSE/ScOI3eM706XeSB/Y7o7EaI7NkJ5UZ2mteokdKkFrWsR7o/PqqtJV6SXmUGBRX6H
         Ss1IAQdvFPRCssxB/ZGZsImowQzXAV8HmyrVRkcTPLEwgzM6Ryf5nsabdk4aWoK0xkWc
         st4ZfTCmEiTxOBGreF7JKTmfH6AqMmIDCuDTOSZrYBO4WyPndDjGvW/4tARi9XP5lOq2
         ZIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gsKLMiCUHri8NkfcKAfE8GWhdgEqnAihnSAE6GSvwKY=;
        b=bFgvFYHdD0WX+nM/Ni0m5FGmSWrBvTiIDLXlK0E/63cfjxMR2WuDTbzyOrvQ9CbcO+
         AD6X7yAluhafVTFSIy2kitK38ucypY4l9zc21y7CeQhh/KgUmFRBY8zI38UqDP+yn2Ow
         M1sJSVOoYXlOOG1k/7OOnMoMctW2eeomclWN5gJ057e1ADDD8Jtl4yY65xnuujrg/1FI
         v1M+16/wABKYuvOweCZl33gt3rKwFCmXNGgfBKee2vigJuevJVtn6lF8Uoj5boWocVMy
         h5mo6pw9zRIak7JI0BCTz7rtPxIBE3+11AHr+dQljmlxyf1KLQ4sQCfyt0Qci0t9q+yx
         BoKA==
X-Gm-Message-State: AOAM533B2BuR0H0tD2eXhqi4o52o1lJNN69Jv7y2PjIQNDQsRL30HYlu
        UP3il4xx8tlTtZykN9e54d5WfDyRKkkilw/PCMsTmCqWuXM5CA==
X-Google-Smtp-Source: ABdhPJx5Qf4UvEiW++g52sVZbHOOQQvGvE3l03hAmbdN9n08jisL59WmIGzFOVM6eqDeecPRCsM7KzznCJubPlMQvjs=
X-Received: by 2002:a05:6512:1027:: with SMTP id r7mr1851021lfr.153.1621296337133;
 Mon, 17 May 2021 17:05:37 -0700 (PDT)
MIME-Version: 1.0
From:   Ahmad Nouralizadeh <ahmad.mlists@gmail.com>
Date:   Tue, 18 May 2021 04:35:26 +0430
Message-ID: <CAMYFX7n6_ZC6kD_8uCJYjg2iTMhdyOEm=5hSN2U=O95qCtc0hA@mail.gmail.com>
Subject: Performance Counters and IMC Counter Not Matching
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
Could you have a look at this question? I don't know how I should
start solving the problem. It has made me crazy!
https://stackoverflow.com/questions/67513607/performance-counters-and-imc-counter-not-matching
Even a simple hint or guess is appreciated!
Regards.
