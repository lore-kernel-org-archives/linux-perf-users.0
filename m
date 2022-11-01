Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C9FA373D
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 09:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKAJPG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKAJPF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 05:15:05 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3E10E2
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 02:15:04 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id t16so9875197qvm.9
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 02:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmJJgqvBpyrMUSHZDbpYR1KLY/ylEZoQf2la41iyXts=;
        b=d88eApNIH19z9iXPcjiv4Rh/B4WfnwK5M9g3swiclOo1DhdeSHdQU8Z3gkuvzYEkzC
         RGX9mG+PLeE/4bXjZPej8VHXX0pmkWSD6FIJ2O1GRcZKlq8c7vWax+LejDEYR5wmTsgS
         x/HXclmmTKe9b3/IEOjOIaB77IZX2hfP3/E+y90QX4ottpGO31nloihUB6Az4J9ZG+wh
         4pZ2X8AdicJNbGnc2+aIgjXNPDf/C2TgTpp2sBomL7ewbthZZpcG/0zVJLMymo6ShEeI
         MOsho0blGnw8pnGju0WJ+6m9loGSL6puZ43OzsIZ/wvJg1UbnTZdjx5UmiCBn3unwvB8
         BoeQ==
X-Gm-Message-State: ACrzQf3KccysnrWJdfnSHTZym/9k/GBidc2pdW3eKUJzzf347yfdugND
        fro9a7b7WlnzFBD2+42wShnN5q7mO30cRA==
X-Google-Smtp-Source: AMsMyM470jpetxRPw8sCJDwTTlJkOhVWxKF/3Ek0J0QXlH1+niwC3Xqvdxwff56B7Se3FF22KzOg5w==
X-Received: by 2002:a05:6214:2501:b0:4bb:ac4c:466 with SMTP id gf1-20020a056214250100b004bbac4c0466mr15073874qvb.93.1667294103689;
        Tue, 01 Nov 2022 02:15:03 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id c9-20020a05620a11a900b006b949afa980sm2372130qkk.56.2022.11.01.02.15.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 02:15:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g127so8065200ybg.8
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 02:15:03 -0700 (PDT)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr390524ybs.380.1667294103174; Tue, 01 Nov
 2022 02:15:03 -0700 (PDT)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Nov 2022 10:14:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsfc-NNHswtS8jjhWFwk4fX2yvynKh4q0x_u01bnUQBA@mail.gmail.com>
Message-ID: <CAMuHMdUsfc-NNHswtS8jjhWFwk4fX2yvynKh4q0x_u01bnUQBA@mail.gmail.com>
Subject: b4 ignoring Reviewed-by: in quoted-printable email
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     tools@linux.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Konstantin,

$ b4 am OS0PR01MB5571A141EC9159DB281867C8DF379@OS0PR01MB5571.jpnprd01.prod.outlook.com
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2] clk: renesas: r9a06g032: Repair grave increment error
  ---
  ✓ Signed: DKIM/denx.de
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20221028113834.7496-1-marex@denx.de
 Base: not specified
       git am ./v2_20221028_marex_clk_renesas_r9a06g032_repair_grave_increment_error.mbx

The Reviewed-by tag given by Gareth is not picked up by b4.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
