Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD6C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625F260EE3
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 22:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhKBWWL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhKBWWL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Nov 2021 18:22:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA09C061714
        for <linux-perf-users@vger.kernel.org>; Tue,  2 Nov 2021 15:19:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o14so643395wra.12
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Nov 2021 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=k8K0tlAzk/9wc7R0Yqh1ac/sjp0ZLNq5ax7ro1GDS3c=;
        b=VuJKwS4A0VMPiPNuok2ocrlfzjHAJ+2gr67k71NEFck1ZP2LONkxyWQT0vmyB8NRIN
         C2SolxMSDnwWYp8fsPlflEolMJuxy6Wf/l1sT0yvEps7HKOJXwbQoKCNyKyrUKEe7qNu
         1fuYQS7XXEvaCmgvJL7bJ0poVUceclWZ09ApdJh0Vz63YXgM8E1YD2Bh5DGUlF+cr0l3
         KeveeMR67n8f07uQSw4ecir/WO375d87SO0hzHbD1gU9KmVNMHg0CAekVD+XNmNycLrB
         Tgtv7P42o+/UIfDhosEbsfiZ7Alwx8cqtLRDXDcnxMiLeBMxQOCQP9V3PkYoUWRNoN9v
         ljDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=k8K0tlAzk/9wc7R0Yqh1ac/sjp0ZLNq5ax7ro1GDS3c=;
        b=3u0rPCVUXH5H/IYSNaLj3LFBF1HYxh58P0XoBD0idxp/DC9F0OfNVydAYnAHF2WLgw
         FXrKOIN9PQBrpQ/n35tlkwxoEs1QRgLKw/Tq7ORrtbBAM/E5FhiV+afB6FAg5CWHhRpy
         pTTp9jE4J7bdL/DzK5Qs7a0U6b8FXFdwtwy4blo1MUwU1iHRsG59dT8g+87k2uo241LD
         e0Zpv+TtyvHEHYQgUU4AiaPnD5weV3nGI2UcU6Qw5MmDIGcxMfkN1GUgeR5YYXbJdLoI
         kRsuU6GgEjQHsvMRT+m+dB/kaetybIBD9JDWI6jhEA2HKfU2SclprdzDM4Q8Pooy4AAo
         5iYw==
X-Gm-Message-State: AOAM533vp/AYh0gAc8x53GulO5qfkfnmCTznTHdG71AYRakECwPjI4zA
        s9z6UoVY3FfAmPrhXzq08lC8UwLkgClPkw==
X-Google-Smtp-Source: ABdhPJymGqEW6j/wbUNPAjGoMzOCsEwQfuTqdF/aMIvVhfAkQjrNZ7PTEYymH63NF3BW6BSR/LgM4A==
X-Received: by 2002:adf:d091:: with SMTP id y17mr38931917wrh.418.1635891574355;
        Tue, 02 Nov 2021 15:19:34 -0700 (PDT)
Received: from pc ([197.49.143.142])
        by smtp.gmail.com with ESMTPSA id p12sm312445wrr.10.2021.11.02.15.19.33
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 15:19:34 -0700 (PDT)
Date:   Wed, 3 Nov 2021 00:19:32 +0200
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     linux-perf-users@vger.kernel.org
Subject: Hi, I want to contribute to Perf
Message-ID: <20211102221932.yv6xfkb6jaal6o72@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, great people,

I'm Sohaib, an undergrad student living in Cairo, EG
Last few months I worked (and am still) on supporting Htop & Performance
co-pilot:
- https://github.com/htop-dev/htop/commits?author=smalinux
- https://github.com/performancecopilot/pcp/commits?author=smalinux
Nowadays I want to go deep than that, to Perf :-) I'm so interested in Perf and
I hope to make useful contributions to the community.

I already talked to Ian as I think he was a GSoC mentor this year and he was
generous with his time and his notes.

Please feel free to assign any task to me you think will help me to get involved
with the community.
Also, I probable will make beginners naive mistakes, please
correct me, I will appreciate that so much :-)

Thanks,
Sohaib
