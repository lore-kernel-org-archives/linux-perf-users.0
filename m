Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C653C38145
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 15:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIGPw7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIGPw6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 11:52:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285356CF76
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 08:52:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e16so1826534wrx.7
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Sep 2022 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=YREwwYu67CUzBm9KWJywNNZTcrAW2lD4CmOmrO9hVs4=;
        b=CzVmp404Y3DT213xqplLqeeC+PwyDAwVaddhm+lH35mGEHJkNRYUT5MfstrRSabukx
         PfR9ZXzqX3mTyJYS5QaMoSHZAaDjEEuLzYUPmhxcO32pJwu7BqQx+JrtZAV/iuShyBRL
         mLkjgyZfIUpd+rL6RURP6yhYXjGenUOp9qmF69Yy3SngsXdGzUqNmDuXatll1NX2/vLY
         1et5XRnhT7yZfdWjMQcYEKcCxzjP/+cEk6KP8w7dwUbkyekFyeruSzcb6f2mhG13VgZk
         KQ2vpAsm9JHwClVp8e4In8nrAXpCEnRbWIfdeYHTMWjCk82dTBSRSLJoIoFzZAVskzj/
         QEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YREwwYu67CUzBm9KWJywNNZTcrAW2lD4CmOmrO9hVs4=;
        b=68oSb3iGXwIIPz/ZQQZ5zTg4XMM6PqxU45eXPKq+v2zejmc1NIm8f/Mvz+BI+gmCrG
         kjLusIkN/yHx0T5Yw4ec+nZHF7vdvKKScrUf6AE8snsRZmnXJ7ZAZOcTj0KLt+6sSDoW
         6fZfw3vAvVg6MITLtdXFkgCOxclkLOln1A4L6z1AHqab9CaScdDCzYHVRsS15JfDGHSY
         UAHj0+GKTLmT1AWM3ggBmQdx1HAbgQYi952podpINuf3ZfiKFkYLoiD3i1rAayCLpE2G
         keQM/ShzYW0kZ9JNPW/odlbDokWO3eTFJ6MEGBbvguBwxAGWE00i81TdPrvklUQ/tiRC
         DUdQ==
X-Gm-Message-State: ACgBeo1Aogcwlrqsh7iYOEOaAYWM+bfqRE0ylSMTZRalgtJcQkIPd/fL
        T6dzsqd3XhUW6kUH8Nr++6wHsduHcHasKR3V7/5fb1M/0v4MzQ==
X-Google-Smtp-Source: AA6agR6bbU88WSpLrj0nOcahzOzzGWP4Y7RUBfjq+IjzqbEnJBhpsVpE+6LG0KpnzEfpZorZXAk01wGMPRWvvoUbQIk=
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr2471816wrm.300.1662565975143; Wed, 07
 Sep 2022 08:52:55 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Sep 2022 08:52:43 -0700
Message-ID: <CAP-5=fXpQqJsidXP8hfqPF1rPaCjBNGAdg2n6dp375Jre3FjMA@mail.gmail.com>
Subject: Sept 8th - no office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I think there are a few things to discuss but let's save it for LPC next week.

Thanks,
Ian

Link to the last "no office hours" e-mail:
https://lore.kernel.org/linux-perf-users/CAP-5=fUF2SyfTBfh=SugoCpN=7mUroZk85nKbuX3P6cNUkG2sQ@mail.gmail.com/
