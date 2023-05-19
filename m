Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CADDC77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjESRsz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjESRsy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 13:48:54 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F8C1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:48:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f68a64f814so20650531cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684518532; x=1687110532;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5Lb/xzQ2JHQKZZV2uQ350RMFJt7Fre7cI2gqm8rADo=;
        b=FTN72xMq9UJc/LJo+3FLasw4UDYn2q/U6LXuS2P+Y8VVqTgyLSf3Ywofs2eEwwTyew
         83LCYK14I7cm7oLD67cHN6Qc4MkR8kK+iCTPUd/aYPOVamLXZNYlQ7sB3mlIkIV+2h14
         ZqHxXxrBXIlxu9AA2bWWaLr6FgEfGlF9tVNScjRwYeHO2Y6FR/33h0SD25eYuDT8oBG0
         L0Y2hwOzZ+Ry+8XoOsizroHv2bno1TeZtNslM5/Bwb5Fu+yvKbI8Ed2O9YciQ4q95UDl
         wqtBasQShtFstKrlgS+buklZNUdPsYD6WY1PUfcClcfnwzo9UvvbIG/bHmCVmWGcPue3
         El7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518532; x=1687110532;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5Lb/xzQ2JHQKZZV2uQ350RMFJt7Fre7cI2gqm8rADo=;
        b=JXXZZpZ1nzn3PjUQI8vkVuCfPL+22tLy7CINyc97VVNdr7GS0/phrKSictka02rhkx
         zoMH22kJfeF+BV5TVmCI1n5/H/LnP+WIFZGelPW5FFHUVmeJD2XxeF00Q6bLYV7QtV7+
         KH6KZoBH0IgI3j+1cJCboDsT/R118gOSpo3OyvK6Ap7z9i6Fk2bRRSsVarx5vfZwWw09
         Iis45XneknPRM9bhUjWs8Bz+YFnFq1pipRVL5PepdKDnCluSiSgi43LhQ6JlqIsyM+my
         E5nEDtnm2NpxEuCQjegw/To93aQzMPZiYH1EAYpJh2CzwGRxuTMib3A62u4u1yE6QkPz
         lNRA==
X-Gm-Message-State: AC+VfDxz4uZEJzw1N3hjndd3xuj53Qm0TkDhJDS0QF8sKeM7FtMklsXn
        CMzFe7vrBCeNom4lDt+hTvtBLKjPRMxR0DoIaDWdQUkpxIA=
X-Google-Smtp-Source: ACHHUZ5iJQZt1uBMvXCkR5o1YZ/gnUkwWthttmWcSHFeF5slUDu9oAdrx3p2wUedZ9AfqLxAsJHR7giQSlUa6pyrbGY=
X-Received: by 2002:a05:622a:646:b0:3f5:224d:6cd4 with SMTP id
 a6-20020a05622a064600b003f5224d6cd4mr4490440qtb.13.1684518531802; Fri, 19 May
 2023 10:48:51 -0700 (PDT)
MIME-Version: 1.0
From:   Rajasekhar Pulluru <pullururajasekhar@gmail.com>
Date:   Fri, 19 May 2023 23:18:12 +0530
Message-ID: <CAGA5_H6Ld9U0eTatJeExSGEynf41mvfcPZ34rtdO7rAVNuoXYQ@mail.gmail.com>
Subject: DSO_BINARY_TYPE__SYSTEM_PATH_DSO
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Team,
Could someone help me shed some light on this macro
DSO_BINARY_TYPE__SYSTEM_PATH_DSO ?

Case-1: I am trying to run perf top -p `pidof <app>` on ubuntu host
(based on ubuntu:jammy, outside the container) where the <app> runs
inside a container that's based on ubuntu bionic, and I don't see any
of <app> symbols (only hex-address and no function names) in perf top
output.

Case-2: When I try to run perf top -p `pidof <app>` on ubuntu host
(based on ubuntu:bionic, outside the container) where the <app> runs
inside a container that's also based on ubuntu bionic, and I can see
<app> symbols (function names) in perf top output.

On debugging both the cases, I find that, case-2 is able to display
symbol when dso__load of </opt/bin/<app> is successful for the type
DSO_BINARY_TYPE__SYSTEM_PATH_DSO, where-as the same fails for case-1
(is_regular_file check fails), and perf top reports "Failed to open
/opt/bin/<app>, continuing without symbols".

In both the cases, the file /opt/bin/<app> is not available on the
host, and its only available inside the container.
What could be causing the above failure?

Appreciate any help/inputs.

Thanks & Regards,
Rajasekhar
