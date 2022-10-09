Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB4C433FE
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Oct 2022 08:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJII2V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Oct 2022 04:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJII2U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Oct 2022 04:28:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6677F2CDE6
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Oct 2022 01:28:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so19325683eja.6
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Oct 2022 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TLxbzrmBkaZklpaDWPRBEAXSfSbmfmREWZ1I8j4WANU=;
        b=BlzWd7bl7i7/JayigtklWoMDHNcnhekvIfuRGdkvHMKdtAsqMiEhB0kJmXM/C6AIXl
         8VwQeNKthfrLWcgHUGTDNDCnyZw+YB8X+BtskiY0dscbVCKhRhws+FymKfAIzKjHt1xk
         zvbP2RcEbGBmGFaQT3hawSTFqejwjmrAlZ8uJ51z67erYpKJo3bcymVWgXIt0/qyOmR5
         huoDBgVg3l29BgcPoR8I7Jbny+mgcT/URxX89lfCH5L+wZQTYBX6SxY28xYm7OSxJo4t
         V396+NF+I+Kg3N8dDgwIbI+VYHXhA/ufCAnCJTeASM9/mPiVfi8GUxndCyQUcDXs4z4t
         M6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLxbzrmBkaZklpaDWPRBEAXSfSbmfmREWZ1I8j4WANU=;
        b=I1U4Q3pxI/PX9klqZxGIO4COZRXs3J8PFZjybp7nSveCjLXJUwH08keZ607vekCVxV
         9/0MtOONDV+Lp2M9gfg2hcw/fwim4MRoQGKCUkBHOl01sjybXPxHZI1DifX20JczFMuA
         Rib46lC6kQmtx/zdWslBnrM4jC57HajgHXKprA+r10IgpK8l1DO2t+gn8YHpslMIfejn
         1S0yY3DagjV2wxM4nC9oUFKeST0PqgQw/mUqETQElaayyJDpBCAyuyY6SE1ePF4933+c
         UGP0Cit3n8GvqAdgoUIoetsT70lfLTWAOnS94oxlnCAByJS14WsQhmGMyASVCzysPiSK
         E8VQ==
X-Gm-Message-State: ACrzQf17AqkhcQTgfF/Sfx2sqdJHBUGdKDI9R6ptqydBvxK5+rNm+7ML
        YtxzMCaMCvUzBAWm7m9rHgfPA5qq/A95N8UYZ8IF/HRPGmI=
X-Google-Smtp-Source: AMsMyM4gYmqbNCgbx/XAcO4/lKS55nYmnjOGGhOLZyxnmNsE6LGk3HvRaAd0sdq6GyTekAngAEStJbMlV75a/lMVepE=
X-Received: by 2002:a17:907:da4:b0:78d:4bc9:2497 with SMTP id
 go36-20020a1709070da400b0078d4bc92497mr10798847ejc.183.1665304095337; Sun, 09
 Oct 2022 01:28:15 -0700 (PDT)
MIME-Version: 1.0
From:   Stephan Dollberg <stephan.dollberg@gmail.com>
Date:   Sun, 9 Oct 2022 09:28:04 +0100
Message-ID: <CAE4R7x2JMHroRyPNMsy5_wnOnsRE9c+UCsmXRJrODhT3PjVUxg@mail.gmail.com>
Subject: perf stat --smi-cost not working on hybrid/alder lake
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

perf stat --smi-cost does not work on AlderLake/hybrid-arches:

```
$ perf stat --smi-cost -C 1 -- sleep 1
freeze_on_smi is not supported.
```

Caused by FREEZE_ON_SMI_PATH being hardcoded to "devices/cpu/freeze_on_smi"

https://github.com/torvalds/linux/blob/3002b7a31894cfa0e57080f7e0961b5fee788aa3/tools/perf/builtin-stat.c#L98

However, on hybrid the devices subtree looks like:

```
$ ls -h /sys/devices/ | grep cpu_
cpu_atom
cpu_core
```

I tried a hacked build by changing that path to
"devices/cpu_core/freeze_on_smi" but even then didn't get any output
even on the "core" cores.

Happy to help with further debugging.

Cheers,
Stephan
