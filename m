Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F1DC0015E
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Jul 2023 13:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjGKNyj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjGKNyh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jul 2023 09:54:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24710CB
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 06:54:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so5884707f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689083670; x=1691675670;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSPcjHhT/5N6nT8y7wV1S+8bHOcpcOu78CNmBPxWjPo=;
        b=B7PkqrZ2+bqYM6w00WxretUP5j1BmZ3LcNN3/ir2belrBOJs6baL2dCROITGhGVcsM
         wRR6CY+CCeONMJCbeq3KrYDvDUeCsT6nIfoqumEZ9TnLqE2zTPv3c590met9xGeLEFfc
         /YBSwPdl64VIM21G1QR9312Aj0/rDfl1rrLOnBbcJT0uK0JIiXDDIiVqYNc8OfGmZZMJ
         oRgOYgXvuYF6/7tsov8yIepU8jyDu5oQS0eegeXnqWjefAoj31WYyK/kvLVAq0fSJMR+
         mPIOCxwCCkgM3DoTG/BINDKIVjSKhliks1GJuE/jZWh4xFZB8tKpl366njUaA2/9DWXR
         G+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083670; x=1691675670;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSPcjHhT/5N6nT8y7wV1S+8bHOcpcOu78CNmBPxWjPo=;
        b=JLLCR9USNPdEcyeTqJZv32kxe4IoJklfShQTYJN30JtPK7oFPoa5YeMaMDZeUB7opG
         dyxXBKnsGAzDzUtRRL/W2HGQ1H9Xlqog3xsNofVFy+oNCgykcEoYMmHQS/xjTXXQqQIR
         swe0dje7luMRQLosZXUfBJEqQT388rzOZgqljqDlazHlpCC6fEyRrwZbPK1tFwHb/M9P
         NTh0Q0/7cUmDIifdTXbLRFxhEkzpdUViNjmkxJ1BVhAA17To1X0cArkt75wngKqOyq71
         0WIAP0asAnBqtAn46r6Kxnf1bhRO9GK/PJRk76BJxJCdS1GzgUydS/dnM6he1MNtJUpY
         SHDw==
X-Gm-Message-State: ABy/qLaeSiyGh5znFNSd6uRLXtR30TZEf4DxWGfD6VRxl0IHnCcxOU7G
        +vXWLY0ZECZtcmESy5PQDfM5cS8vM4UcmpbHTrmhN1hLiaz1fA==
X-Google-Smtp-Source: APBJJlFoeL0+FQRu10buQm++xCqXwtoCiExMfDT2FHcRUK/e4XMPMp9z78kHpkzO8Ykn2O8RLm5x1zFQLnijzA5MoAg=
X-Received: by 2002:adf:ee4a:0:b0:30f:af19:81f3 with SMTP id
 w10-20020adfee4a000000b0030faf1981f3mr14364572wro.41.1689083670152; Tue, 11
 Jul 2023 06:54:30 -0700 (PDT)
MIME-Version: 1.0
From:   Roman Lozko <lozko.roma@gmail.com>
Date:   Tue, 11 Jul 2023 16:54:19 +0300
Message-ID: <CAEhC_Bkc9gV72k1iLqGjpjmRGx8aMjS6n_6gmmdr=XTzNeFc=g@mail.gmail.com>
Subject: Using Intel PT with JIT
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, I tried to use `perf record` with Intel PT but afterwards I can't
inject JIT dump to trace, `perf inject` says:

error, jitted code must be sampled with perf record -k 1
0x59d8 [0xb0]: failed to process type: 10 [Operation not permitted]

On the other hand, `-k 1` cannot be passed to `perf record`:

Cannot use clockid (-k option) with intel_pt

Is there a way to use Intel PT with jitted code? I am using perf
5.13.8, maybe it is already implemented in later versions?
