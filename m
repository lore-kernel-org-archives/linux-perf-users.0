Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95B6C64EC4
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Mar 2023 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCFVF1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFVF0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 16:05:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD87431F
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Mar 2023 13:04:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ky4so11935803plb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Mar 2023 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678136689;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1W0t2QxwC6JI1D5afE14BJw1zu1iLu1dtXyhWC7lh9Q=;
        b=PqKVnLuVnB9K4DozqcT01qX1GWE6y8H+2Tn4foeZymgpxbcVEGeHoAB4D0uwPas5OZ
         hSPrwLT2SrSqlKC3oG51Nvk62oPoDYiSm2ia//RlJbKC/A3p74DyOPIYx/X/WxMaO91K
         3x5yq/ytjAeG7nTZ23rLwoSJ+k8f+kbrjhcVeoS5uUcALEK5fCu8xY/5cIOLfa6MEm8w
         6GiPGz4afEMUBSMWRO/BuKONYpZgqh+TCtgZhGtwx+eY+TECuagsyPb+8jNY+cY3BKkn
         +KS3Bh+BBtQ5W7+NVvBkBS2abmOLM6pZxgQcnly6sSRxDt/1LoyBc033FxItFxkj+s9x
         hllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678136689;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1W0t2QxwC6JI1D5afE14BJw1zu1iLu1dtXyhWC7lh9Q=;
        b=ntUBLFeXE+FxLdwGY+K7SCSpvGJST5mzQETebxb8qJ6uacDUaJwrLYnx3g2ScnrqBF
         ADpL6zfd/bkxVEelkoYsC0431ZHe229WtuGEJBctsN1f8dUNCBSHoaS3IVSez223H0QK
         qJlKojDTFI+EAV3pHFFmWR5EXtguSRcU69ow6UuUqt0ItYA8E107NZu1Eg6uS91Ya7gL
         WnYFckDFZkWkYqW6WlcYVsrTJn1cBJuYYrhY0wrCpKRYC1KsBHrbe3avbYUaTy0dhpSE
         qiH6KjH1kRSyQ+bX/+dIIb8btB7ayGATXOiiNFXsKKtGRYxBxw2lC0j+OzI29Uydn7GB
         TzGA==
X-Gm-Message-State: AO0yUKWZdygNvRyA5S4xLb49zYye7LHawRd9g2jdCYm3rfkUf3aDEkf5
        zdHBcLUZN9riGPYEme9S9eG3YMEAHGPMqwXp
X-Google-Smtp-Source: AK7set+WBjI71bw8VoLrTvjw5vqUBm9OATtHWpKkbzfUFz56EPvyd4k48eQN6+SUq7UMu9AI1/UDcg==
X-Received: by 2002:a05:6a21:6da5:b0:bc:bf86:660 with SMTP id wl37-20020a056a216da500b000bcbf860660mr13023058pzb.45.1678136689331;
        Mon, 06 Mar 2023 13:04:49 -0800 (PST)
Received: from yoga ([2400:1f00:13:15ae:65e0:9312:d450:136a])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79208000000b005ccbe5346ebsm6675068pfo.163.2023.03.06.13.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 13:04:49 -0800 (PST)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 7 Mar 2023 02:34:43 +0530
To:     linux-perf-users@vger.kernel.org
Cc:     irogers@google.com, acme@kernel.org, namhyung@kernel.org,
        irogers+gsoc22@google.com, anupnewsmail@gmail.com
Subject: [RFC] Open Source Contribution | GSoC Perf
Message-ID: <ZAZVazubl60xYaO8@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, Perf!
I'm interested in joining the perf community and learning more about how to start contributing because of my desire to learn more about the Linux kernel and performance.
I've only recently started using Perf Tool, but I'm really enjoying seeing the metrics and outcomes. I want to resolve a few inconsistencies I found on a wiki page while learning, so if you have any suggestions, please let me know.
1. LINK BROKEN under Tutorial-> Linux Sourcecode: /tools/perf (hyperlink: ) correct (
2. LINK BROKEN under Hardware Reference -> Performance Counters for Linux: hyperlink for PCL core kernel data structures, PCL core kernel internals, perf tool internals are not available. Can anyone help me to know why this contents are not available on wiki?
3. ALLIGNMENT : Under Glossary -> BPF counter, Off-CPU, Multiplexing is not alliged properly.
4. INFO MISSING: Under Glossary -> offcore is TODO.

I've also invested some time going though Brendan Gregg conference talk and wiki page,  I'd be delighted to contribute to any of the open tasks!
Thank you all for your time.

With regards,
Anup Sharma
